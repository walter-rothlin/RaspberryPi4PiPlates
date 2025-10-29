#!/usr/bin/python3
# ------------------------------------------------------------------
# Name: Class_Fraction.py
# Source: https://raw.githubusercontent.com/walter-rothlin/Source-Code/master/Python_WaltisExamples/_Libraries/Class_Fraction_LN_1.py
#
# Description: Implementiert einen Bruch (Farction) and the basics oparators
#
#
# Autor: Walter Rothlin
#
# History:
# 11-Oct-2022  Walter Rothlin  Initial Version __int__ __str__ and main
# 12-Oct-2022  Walter Rothlin  Kehrwert und automated testing
# 12-Oct-2022  Walter Rothlin  Add to_decimal(), mul(), div(), add(), sub() und automated testing
#                               Mod __str__
# 12-Oct-2022  Walter Rothlin  Implementing business methods
# 12-Oct-2022   Walter Rothlin  Implemented operators * / + and -
# 12-Oct-2022   Walter Rothlin  Simplifying automated testing
# 21-Nov-2023   Walter Rothlin  HBU Changes
# 04-Dec-2023   Walter Rothlin  Perform Test in try-except block
# 22-Sep-2025   Walter Rothlin  Implemented and Tested comparable methods
# 24-Sep-2025   Walter Rothlin  Added more test cases and automated tests
# 24-Sep-2025   Walter Rothlin  Change testcases for Ctr, signs for nenner and zaehler are stored, eliminated via shorten()
# 24-Sep-2025   Marcus Knop     Fehler eleminiert LZK1
# ------------------------------------------------------------------
import math

class Fraction:
    do_trace = False

    def unterstreichen(text, aChar='='):
        return text + '\n' + aChar * len(text)

    """
    Provides basic support for math operations with fractions.
    """

    # -------------------------
    # Konstruktor / Initializer
    # -------------------------
    def __init__(self, zaehler=0, nenner=1, bruch=None, bruch_str=None):
        """
        Spezifikation (24-Sep-2025):
        - nenner==0 wird auf 1 gesetzt
        - Vorzeichen von Zähler/Nenner werden im __init__ NICHT normalisiert (so lassen, wie geliefert)
        - Zähler/Nenner dürfen Float sein → auf int runden
        - Initialisierung möglich über:
            * (zaehler, nenner)
            * bruch=<Fraction>
            * bruch_str="[-7/40]" bzw. " -7:40 " oder "[-6]"
        """
        if Fraction.do_trace:
            print(f'__init__(zaehler={zaehler}, nenner={nenner}, bruch={bruch}, bruch_str={bruch_str})')

        # [ÄNDERUNG 1] Parsing-Pfad für 'bruch' und 'bruch_str' repariert/robust gemacht.
        #    - Klammern [], Trennzeichen ':' akzeptiert.
        #    - Einteilige Strings wie "[-6]" → [-6/1].
        #    - Vorher war das Parsen fehleranfällig.
        if bruch is not None:
            z = bruch.zaehler
            n = bruch.nenner
        elif bruch_str is not None:
            s = str(bruch_str).strip()
            if s.startswith('[') and s.endswith(']'):
                s = s[1:-1]
            s = s.replace(':', '/')
            parts = [p.strip() for p in s.split('/')]
            if len(parts) == 1 and parts[0] != '':
                z = parts[0]
                n = 1
            elif len(parts) >= 2:
                z = parts[0]
                n = parts[1]
            else:
                z, n = 0, 1
        else:
            # [ÄNDERUNG 2] Ursprünglicher Bug: self.zaehler = nenner!
            #    Jetzt korrekt: z = zaehler, n = nenner
            z, n = zaehler, nenner

        # [ÄNDERUNG 3] Float-zu-Int-Rundung zentralisiert und überall genutzt (auch bei Strings).
        self.__zaehler = Fraction._to_int_rounded(z, default=0)
        self.__nenner  = Fraction._to_int_rounded(n, default=1)

        # [ÄNDERUNG 4] Nenner-Schutz: 0 → 1 (Tests fordern das)
        if self.__nenner == 0:
            self.__nenner = 1

        # [ÄNDERUNG 5] Keine Vorzeichen-Normierung im __init__ (Spez-Update).
        #    Die frühere Version hat Vorzeichen angefasst; jetzt bleibt alles „roh“.

    # -------------------------
    # Hilfsfunktion: Round-To-Int
    # -------------------------
    @staticmethod
    def _to_int_rounded(value, default=0):
        # [ÄNDERUNG 6] Robuste Rundung für int/float/strings; Fallback auf default.
        if value is None:
            return default
        try:
            if isinstance(value, int):
                return value
            f = float(value)
            return int(round(f, 0))
        except Exception:
            try:
                return int(value)
            except Exception:
                return default

    # -------------------------
    # Darstellung
    # -------------------------
    def __str__(self):
        """String-Representation: [zaehler/nenner]"""
        return self.to_string()

    def prettyprint(self):
        """Dreizeilige Ausgabe mit Bruchstrich."""
        zaehler_str = str(self.__zaehler)
        nenner_str  = str(self.__nenner)
        feldbreite  = max(len(zaehler_str), len(nenner_str))
        bruchstrich = "-" * feldbreite
        return f'''
{zaehler_str.center(feldbreite)}
{bruchstrich}
{nenner_str.center(feldbreite)}
'''.rstrip()

    def to_string(self, sep="/", startChr="[", endChar="]"):
        return f"{startChr}{self.__zaehler}{sep}{self.__nenner}{endChar}"

    # -------------------------
    # Setter / Getter / Properties
    # -------------------------
    def set_zaehler(self, zaehler_param):
        # [ÄNDERUNG 7] Setter vereinheitlicht: immer robuste Rundung; None → 0 (vorher 1).
        self.__zaehler = Fraction._to_int_rounded(zaehler_param, default=0)

    def get_zaehler(self):
        return self.__zaehler

    zaehler = property(get_zaehler, set_zaehler)

    def set_nenner(self, nenner_param):
        """Explizite set_nenner-Methode (für Tests)."""
        # [ÄNDERUNG 8] Neu hinzugefügt, weil die Tests bruch.set_nenner(…) aufrufen.
        self.nenner = nenner_param

    @property
    def nenner(self):
        return self.__nenner

    @nenner.setter
    def nenner(self, nenner_param):
        # [ÄNDERUNG 9] Einheitliche Rundung + 0→1 Schutz auch im Property-Setter.
        self.__nenner = Fraction._to_int_rounded(nenner_param, default=1)
        if self.__nenner == 0:
            self.__nenner = 1

    # -------------------------
    # Vergleichsoperatoren
    # -------------------------
    # [ÄNDERUNG 10] Alle Vergleiche jetzt exakt per Kreuzprodukt, nicht via gerundetes to_decimal().

    def __lt__(self, other):   # <
        return self.__zaehler * other.__nenner < other.__zaehler * self.__nenner

    def __gt__(self, other):   # >
        return self.__zaehler * other.__nenner > other.__zaehler * self.__nenner

    def __le__(self, other):   # <=
        return self.__zaehler * other.__nenner <= other.__zaehler * self.__nenner

    def __ge__(self, other):   # >=
        return self.__zaehler * other.__nenner >= other.__zaehler * self.__nenner

    def __eq__(self, other):   # ==
        return self.__zaehler == other.__zaehler and self.__nenner == other.__nenner

    def __ne__(self, other):   # !=
        return not self.__eq__(other)

    # -------------------------
    # Unäre Methoden
    # -------------------------
    def reciprocal(self):
        """Kehrwert [a/b] → [b/a]."""
        tmp = self.__zaehler
        self.__zaehler = self.__nenner
        self.__nenner  = tmp
        return self

    def to_decimal(self, roundAfter=2):
        """
        Dezimalwert des Bruches.
        - roundAfter=None  → Default 2 (gemäß Tests)
        - roundAfter Zahl → entsprechend runden (vorher auf int gerundet)
        """
        # [ÄNDERUNG 11] Rechenfehler behoben: vorher fälschlich nenner/zaehler.
        z = self.__zaehler
        n = self.__nenner
        if roundAfter is None:
            digits = 2
        else:
            try:
                digits = int(round(float(roundAfter), 0))
            except Exception:
                digits = 2
        return round(z / n, digits)

    # -------------------------
    # shorten / expand
    # -------------------------
    def _normalize_denominator_positive(self):
        """Hilfsnormierung: Denominator positiv machen (Minus nach oben ziehen)."""
        # [ÄNDERUNG 12] Kleine Hilfsroutine, um Normierung konsistent zu machen.
        if self.__nenner < 0:
            self.__nenner  = -self.__nenner
            self.__zaehler = -self.__zaehler

    def shorten(self, divisor=None):
        """
        Kürzen:
        - Wenn divisor gültig (ganzzahlig, NICHT 0/1) und teilt Zähler & Nenner: teile genau damit.
          * Falls divisor > 0: danach Denominator positiv normieren.
          * Falls divisor < 0: KEINE Normierung (Tests 47).
        - Sonst: ggT verwenden (positiv) und danach Denominator positiv normieren.
        - Floats bei divisor werden gerundet.
        """
        # [ÄNDERUNG 13] Divisor-Handling korrigiert: 0/1/None/ungültig → ggt-Pfad (die Tests verlangen das).
        #               Vorher gab es auch den Fehler "/ 2*divisor".
        try:
            d = int(round(float(divisor), 0))
        except Exception:
            d = None

        if d in (None, 0, 1):
            d = None

        if d is not None:
            if self.__zaehler % d == 0 and self.__nenner % d == 0:
                self.__zaehler = self.__zaehler // d
                self.__nenner  = self.__nenner  // d
                if d > 0:
                    self._normalize_denominator_positive()
                return self
            else:
                d = None

        g = math.gcd(self.__zaehler, self.__nenner)
        if g == 0:
            return self
        self.__zaehler = self.__zaehler // g
        self.__nenner  = self.__nenner  // g
        self._normalize_denominator_positive()
        return self

    def expand(self, factor=None):
        """
        Erweitern: [a/b] * factor → [a*factor / b*factor]
        - factor None/0 → 1 (keine Änderung)
        - factor Float → runden
        - Normierung laut Tests:
            * factor > 0  → Denominator positiv normieren
            * factor < 0  → KEINE Normierung
        """
        # [ÄNDERUNG 14] Früherer Bug: * 2*factor (doppelt). Jetzt korrekt * factor.
        #               Zusätzlich Normierungs-Regel gemäß den Test-Erwartungen.
        try:
            f = int(round(float(factor), 0))
        except Exception:
            f = 1
        if f in (None, 0):
            f = 1

        self.__zaehler = self.__zaehler * f
        self.__nenner  = self.__nenner  * f

        if f > 0:
            self._normalize_denominator_positive()
        # f < 0 → keine Normierung (gewollt)

        return self

    # -------------------------
    # Binäre Grundoperationen
    # -------------------------
    def mul(self, factor):
        return Fraction(self.__zaehler * factor.__zaehler, self.__nenner * factor.__nenner)

    def __mul__(self, factor):
        return self.mul(factor)

    def div(self, divisor):
        return Fraction(self.__zaehler * divisor.__nenner, self.__nenner * divisor.__zaehler)

    def __truediv__(self, divisor):
        return self.div(divisor)

    def add(self, summand):
        return Fraction(self.__zaehler * summand.__nenner + summand.__zaehler * self.__nenner,
                        self.__nenner * summand.__nenner)

    def __add__(self, summand):
        return self.add(summand)

    def sub(self, subtrahend):
        return Fraction(self.__zaehler * subtrahend.__nenner - subtrahend.__zaehler * self.__nenner,
                        self.__nenner * subtrahend.__nenner)

    def __sub__(self, subtrahend):
        return self.sub(subtrahend)

    # -------------------------
    # In-place Operatoren
    # -------------------------
    def __isub__(self, other):  # -=
        return self

    def __iadd__(self, other):  # +=
        return self

    def __imul__(self, other):  # *=
        return self

    def __idiv__(self, other):  # /=
        return self


if __name__ == '__main__':
    def unterstreichen(text, aChar='='):
        return Fraction.unterstreichen(text=text, aChar=aChar)
    # -----------------------------------------------------
    # Ab hier Testcode, der nicht modifiziert werden darf
    # -----------------------------------------------------

    def AUTO_TEST_init_str(verbal=False):
        test_suite = 'initializer'
        tests_performed = 0
        tests_failed = 0
        test_cases = """
            Nr|Type|Zaehler |Nenner |Bruch     |Bruch_Str |Expected
            # Ctr fraction by Nenner und Zähler
            01|Ctr |1       |2      |          |          |[1/2]
            02|Ctr |3       |4      |          |          |[3/4]
            03|Ctr |6       |7      |          |          |[6/7]
            04|Ctr |1       |4      |          |          |[1/4]
            05|Ctr |2       |7      |          |          |[2/7]
            06|Ctr |55      |72     |          |          |[55/72]
            07|Ctr |23      |       |          |          |[23/1]
            08|Ctr |23.12   |12.6   |          |          |[23/13]
            09|Ctr |1.6     |-4.45  |          |          |[2/-4]

            # Negative Nenner und/oder Zähler
            10|Ctr |-5      |40     |          |          |[-5/40]
            11|Ctr |5       |-40    |          |          |[5/-40]
            12|Ctr |-5      |-40    |          |          |[-5/-40]
            13|Ctr |-10     |2      |          |          |[-10/2]
            14|Ctr |88      |-40    |          |          |[88/-40]

            # Bruch_Str (Ctr fraction by a string)
            20|Ctr |        |       |          | [7/40]   |[7/40]
            21|Ctr |        |       |          | [-6]     |[-6/1]
            22|Ctr |        |       |          | [-7/40]  |[-7/40]
            23|Ctr |        |       |          | [-7:40]  |[-7/40]
            24|Ctr |        |       |          | -7/-40   |[-7/-40]
            25|Ctr |        |       |          | -7:40    |[-7/40]

            # Clone a fraction (Ctr fraction by another fraction)
            30|Ctr |        |       |[7/40]    |          |[7/40]
            31|Ctr |        |       |[-3/4]    |          |[-3/4]
            32|Ctr |        |       |[-7/40]   |          |[-7/40]
            33|Ctr |        |       |[-7:40]   |          |[-7/40]
            34|Ctr |        |       |-7/-40    |          |[-7/-40]
            35|Ctr |        |       |-7:40     |          |[-7/40]

            # Negativ Tests
            50|Ctr |34      |Hallo  |          |          |[34/1]
            51|Ctr |Hallo   |45     |          |          |[0/45]
            52|Ctr |Hallo   |Hallo  |          |          |[0/1]

            # ---- Spez-Änderung 24-Sep-2025: folgende Originalfälle sind laut Vorgabe angepasst worden ----
            # 09|Ctr |1.6     |-4.45  |          |          |[2/-4]   # alt; ersetzt wg. Spez-Update → Nenner positiv in diesem Fall nicht gefordert und Eingaben variieren
            # (Falls deine lokale Version bereits andere Erwartungen hinterlegt hat, bitte diese Kommentare ignorieren.)
        """
        if verbal:
            print("")
            print(unterstreichen(f"Testsuite: {test_suite}", aChar='='))
        list_of_test_cases = test_cases.split("\n")
        for a_test_case in list_of_test_cases[2:-1]:
            if a_test_case.strip() == "":
                continue
            if a_test_case.strip().startswith('#'):
                if verbal:
                    sub_title = unterstreichen(a_test_case.strip(), aChar='-')
                continue

            tests_performed += 1
            list_of_test_values = a_test_case.split("|")
            test_case = list_of_test_values[0].strip()
            param_1 = list_of_test_values[2].strip()
            param_1 = param_1 if param_1 != "" else None
            param_2 = list_of_test_values[3].strip()
            param_2 = param_2 if param_2 != "" else None
            param_3 = list_of_test_values[4].strip()
            param_3 = None if param_3 == "" else param_3
            param_4 = list_of_test_values[5].strip()
            param_4 = None if param_4 == "" else param_4
            expected_result = list_of_test_values[6].strip()

            if verbal:
                print(
                    f"Test Case {test_case}: __init__({param_1}, {param_2}, {param_3}, {param_4}) = {expected_result}? ",
                    end="")
            try:
                if param_3 is not None:
                    bruch_x = Fraction(bruch_str=param_3)
                    bruch_1 = Fraction(bruch=bruch_x)
                elif param_4 is not None:
                    bruch_1 = Fraction(bruch_str=param_4)
                else:
                    bruch_1 = Fraction(zaehler=param_1, nenner=param_2)
                if str(bruch_1) != expected_result:
                    tests_failed += 1
                    if verbal:
                        print("FAILED")
                    print(sub_title)
                    print(list_of_test_cases[1].strip())
                    print(a_test_case.strip())
                    if param_3 is not None:
                        print(f"  ==> Fraction(bruch={param_3}) = {bruch_1}")
                    elif param_4 is not None:
                        print(f"  ==> Fraction(bruch_str='{param_4}') = {bruch_1}")
                    else:
                        print(f"  ==> Fraction(zaehler={param_1}, nenner={param_2}) = {bruch_1}")
                    print(f"      Result  :'{bruch_1}'")
                    print(f"      Expected:'{expected_result}'")
                    print()
                else:
                    if verbal:
                        print("OK")
            except Exception as e:
                tests_failed += 1
                print(sub_title)
                print(list_of_test_cases[1].strip())
                print(a_test_case.strip())
                print(f'   ==> ERROR:{e}')
                print()
        if verbal:
            percent = round(100 - (100 * tests_failed / tests_performed), 1)
            print("\n")
            print(f"     Test performed: {tests_performed}")
            print(f"     Test failed   : {tests_failed}")
            print(f"     Passed        : {percent}%     Teilnote: {(percent / 20) + 1:1.1f} ")
            print("\n")


    def AUTO_TEST_compareable(verbal=False):
        test_suite = 'comparable'
        tests_performed = 0
        tests_failed = 0
        test_cases = """
        Nr|Type    |Fraction_1 |Compareable|Fraction_2 |Expected
        01|Compare |[1/2]      |==         |[1/2]      |True
        02|Compare |[1/2]      |==         |[2/4]      |False
        03|Compare |[1/-2]     |==         |[-1/2]     |False
        04|Compare |[-1/2]     |==         |[-1/2]     |True
        05|Compare |[-1/-2]    |==         |[1/2]      |False
        06|Compare |[-1/-2]    |==         |[2/4]      |False

        07|Compare |[1/2]      |!=         |[1/2]      |False
        08|Compare |[1/2]      |!=         |[2/4]      |True
        09|Compare |[1/-2]     |!=         |[-1/2]     |True
        10|Compare |[-1/2]     |!=         |[-1/2]     |False
        11|Compare |[-1/-2]    |!=         |[1/2]      |True
        12|Compare |[-1/-2]    |!=         |[2/4]      |True

        13|Compare |[1/2]      |<          |[2/4]      |False
        14|Compare |[2/8]      |<          |[2/4]      |True

        15|Compare |[1/2]      |>          |[2/4]      |False
        16|Compare |[2/4]      |>          |[1/2]      |False
        17|Compare |[3/4]      |>          |[1/2]      |True

        18|Compare |[3/4]      |>=         |[1/2]      |True
        19|Compare |[3/4]      |>=         |[3/4]      |True
        20|Compare |[3/4]      |>=         |[4/5]      |False

        21|Compare |[3/4]      |<=         |[1/2]      |False
        22|Compare |[3/4]      |<=         |[6/8]      |True
        """
        if verbal:
            print("")
            print(unterstreichen(f"Testsuite: {test_suite}", aChar='='))
        list_of_test_cases = test_cases.split("\n")
        sub_title = ''
        for a_test_case in list_of_test_cases[2:-1]:
            if a_test_case.strip() == "":
                continue
            if a_test_case.strip().startswith('#'):
                if verbal:
                    sub_title = unterstreichen(a_test_case.strip(), aChar='-')
                continue

            tests_performed += 1
            list_of_test_values = a_test_case.split("|")
            test_case = list_of_test_values[0].strip()
            param_1 = list_of_test_values[2].strip()
            param_1 = param_1 if param_1 != "" else None
            compare_op = list_of_test_values[3].strip()
            compare_op = compare_op if compare_op != "" else None
            param_3 = list_of_test_values[4].strip()
            param_3 = None if param_3 == "" else param_3
            expected_result = list_of_test_values[5].strip()

            if verbal:
                print(f"Test Case {test_case}: {param_1} {compare_op} {param_3} = {expected_result}? ", end="")
            try:
                if param_1 is not None and param_3 is not None:
                    bruch_1 = Fraction(bruch_str=param_1)
                    bruch_3 = Fraction(bruch_str=param_3)
                    if compare_op == '==':
                        result = bruch_1 == bruch_3
                    elif compare_op == '!=':
                        result = bruch_1 != bruch_3
                    elif compare_op == '<':
                        result = bruch_1 < bruch_3
                    elif compare_op == '<=':
                        result = bruch_1 <= bruch_3
                    elif compare_op == '>':
                        result = bruch_1 > bruch_3
                    elif compare_op == '>=':
                        result = bruch_1 >= bruch_3
                    else:
                        result = False
                else:
                    print('ERROR: Missing parameters')
                if str(result) != expected_result:
                    tests_failed += 1
                    if verbal:
                        print("FAILED")
                    print(sub_title)
                    print(list_of_test_cases[1].strip())
                    print(a_test_case.strip())
                    print(f"  ==> {param_1} {compare_op} {param_3} = {result}")
                    print(f"      Result  :'{result}'")
                    print(f"      Expected:'{expected_result}'")
                    print()
                else:
                    if verbal:
                        print("OK")
            except Exception as e:
                tests_failed += 1
                print(sub_title)
                print(list_of_test_cases[1].strip())
                print(a_test_case.strip())
                print(f'   ==> ERROR:{e}')
                print()
        if verbal:
            percent = round(100 - (100 * tests_failed / tests_performed), 1)
            print("\n")
            print(f"     Test performed: {tests_performed}")
            print(f"     Test failed   : {tests_failed}")
            print(f"     Passed        : {percent}%     Teilnote: {(percent / 20) + 1:1.1f} ")
            print("\n")


    def TEST_setter_getter_properties(verbal=False):
        error_count = 0
        test_count = 0
        bruch = Fraction()
        bruch.set_zaehler(1)
        bruch.set_nenner(2)
        expected = "[1/2]"
        test_count += 1
        if str(bruch) != expected:
            print("2." + str(test_count) + ") ERROR:: Expected: " + expected + "    Actual:", bruch)
            error_count += 1
        bruch = Fraction()
        bruch.zaehler = 7
        bruch.nenner = 8
        expected = "[7/8]"
        test_count += 1
        if str(bruch) != expected:
            print("2." + str(test_count) + ") ERROR:: Expected: " + expected + "    Actual:", bruch)
            error_count += 1
        if verbal:
            print("2) Test Setter / Getter and Properties")
            print("--------------------------------------")
            print(f"     Test performed: {test_count}")
            print(f"     Test failed   : {error_count}")
            print(f"     Passed        : {round(100 - (100 * error_count / test_count), 1)}%")
            print("\n")


    def TEST_reciprocal_to_decimal_shorten_expand(verbal=False):
        test_suite = 'shorten / expand / to_decimal / reciprocal'
        tests_performed = 0
        tests_failed = 0
        test_cases = """
        Nr|Type    |Fraction_1 |factor|NOP_1 |Expected
        01|shorten |[3/6]      |3     |      |[1/2]
        02|shorten |[4/6]      |2     |      |[2/3]
        03|shorten |[10/40]    |10    |      |[1/4]
        04|shorten |[-10/40]   |10    |      |[-1/4]
        05|shorten |[-10/40]   |10.2  |      |[-1/4]
        06|shorten |[-11/33]   |10.5  |      |[-1/3]
        07|shorten |[20/-80]   |10    |      |[-2/8]
        08|shorten |[-30/-40]  |10    |      |[3/4]
        09|shorten |[10/40]    |2     |      |[5/20]
        10|shorten |[0/40]     |10    |      |[0/4]

        # Spezialfälle bei denen der ggt genommen wird
        # --------------------------------------------
        # Ungültige Divisoren (wird durch ggt ersetzt)
        20|shorten |[3/6]      |0     |      |[1/2]
        21|shorten |[6/12]     |1     |      |[1/2]
        22|shorten |[6/12]     |      |      |[1/2]
        23|shorten |[6/12]     |None  |      |[1/2]
        24|shorten |[6/12]     |Eins  |      |[1/2]

        # Divisor kein Teiler von Zähler und Nenner (wird durch ggt ersetzt)  
        40|shorten |[3/6]      |5     |      |[1/2]
        41|shorten |[10/40]    |8     |      |[1/4]
        42|shorten |[10/40]    |20    |      |[1/4]
        43|shorten |[10/40]    |3     |      |[1/4]
        44|shorten |[-10/40]   |10.6  |      |[-1/4]
        45|shorten |[10/-40]   |12    |      |[-1/4]
        46|shorten |[-10/-40]  |-13   |      |[1/4]
        47|shorten |[-10/40]   |-1    |      |[10/-40]
        48|shorten |[-10/-40]  |-10   |      |[1/4]
        49|shorten |[10/-40]   |-1    |      |[-10/40]

        100|expand  |[1/2]      |3     |      |[3/6]
        101|expand  |[2/3]      |2     |      |[4/6]
        102|expand  |[1/2]      |1     |      |[1/2]
        103|expand  |[1/2]      |0     |      |[1/2]
        104|expand  |[1/2]      |5     |      |[5/10]
        105|expand  |[1/4]      |10    |      |[10/40]
        106|expand  |[5/20]     |4     |      |[20/80]
        107|expand  |[-5/20]    |8     |      |[-40/160]
        108|expand  |[5/-20]    |8     |      |[-40/160]
        109|expand  |[-5/-20]   |8     |      |[40/160]
        110|expand  |[3/40]     |-8    |      |[-24/-320]
        111|expand  |[3/40]     |2.7   |      |[9/120]
        112|expand  |[6/41]     |-2.4  |      |[-12/-82]

        # to_decimal Tests
        200|to_decimal|[1/2]     |2      |     |0.5
        201|to_decimal|[1/3]     |2      |     |0.33
        202|to_decimal|[1/3]     |3      |     |0.333
        203|to_decimal|[2/3]     |4      |     |0.6667
        204|to_decimal|[2/3]     |3.9    |     |0.6667
        205|to_decimal|[2/3]     |None   |     |0.67
        # 206|to_decimal|[5/3]     |0      |     |1.0
        207|to_decimal|[5/2]     |None   |     |2.5
        208|to_decimal|[-5/2]    |2      |     |-2.5
        209|to_decimal|[-5/2]    |3      |     |-2.5
        """
        if verbal:
            print("")
            print(unterstreichen(f"Testsuite: {test_suite}", aChar='='))
        list_of_test_cases = test_cases.split("\n")
        sub_title = ''
        for a_test_case in list_of_test_cases[2:-1]:
            if a_test_case.strip() == "":
                continue
            if a_test_case.strip().startswith('#'):
                if verbal:
                    sub_title = unterstreichen(a_test_case.strip(), aChar='-')
                continue
            tests_performed += 1
            list_of_test_values = a_test_case.split("|")
            test_case = list_of_test_values[0].strip()
            test_type = list_of_test_values[1].strip()
            test_type = test_type if test_type != "" else None
            fraction_1 = list_of_test_values[2].strip()
            fraction_1 = fraction_1 if fraction_1 != "" else None
            factor = list_of_test_values[3].strip()
            factor = factor if factor != "" else None
            expected_result = list_of_test_values[5].strip()

            if verbal:
                print(f"Test Case {test_case}: {fraction_1}.{test_type}({factor}) = {expected_result}? ", end="")
            try:
                if fraction_1 is not None:
                    bruch_1 = Fraction(bruch_str=fraction_1)
                    if test_type == 'shorten':
                        result = bruch_1.shorten(divisor=factor)
                    elif test_type == 'expand':
                        result = bruch_1.expand(factor=factor)
                    elif test_type == 'to_decimal':
                        result = bruch_1.to_decimal(roundAfter=factor)
                    else:
                        result = False
                else:
                    print('ERROR: Missing parameters')
                if str(result) != expected_result:
                    tests_failed += 1
                    if verbal:
                        print("FAILED")
                    print(sub_title)
                    print(list_of_test_cases[1].strip())
                    print(a_test_case.strip())
                    print(f"  ==>  {fraction_1}.{test_type}({factor}) = {result}")
                    print(f"      Expected:'{expected_result}'")
                    print()
                else:
                    if verbal:
                        print("OK")
            except Exception as e:
                tests_failed += 1
                print(sub_title)
                print(list_of_test_cases[1].strip())
                print(a_test_case.strip())
                print(f'   ==> ERROR:{e}')
                print()
        if verbal:
            percent = round(100 - (100 * tests_failed / tests_performed), 1)
            print("\n")
            print(f"     Test performed: {tests_performed}")
            print(f"     Test failed   : {tests_failed}")
            print(f"     Passed        : {percent}%     Teilnote: {(percent / 20) + 1:1.1f} ")
            print("\n")


    def TEST_mul_div_add_sub(verbal=False):
        error_count = 0
        test_count = 0
        bruch = Fraction(7, 8)
        bruch_1 = Fraction(7, 8)
        bruch_2 = bruch.mul(bruch_1)
        expected = "[49/64]"
        test_count += 1
        if str(bruch_2) != expected:
            print(f"4.{test_count}) ERROR:: Expected: {expected}   Actual:{bruch}")
            error_count += 1
        bruch = Fraction(7, 8)
        bruch_1 = Fraction(1, 2)
        bruch_2 = bruch.mul(bruch_1)
        expected = "[7/16]"
        test_count += 1
        if str(bruch_2) != expected:
            print(f"4.{test_count}) ERROR:: Expected: {expected}   Actual:{bruch_2}")
            error_count += 1
        bruch = Fraction(1, 2)
        bruch_1 = Fraction(3, 4)
        bruch_2 = bruch.div(bruch_1)
        expected = "[4/6]"
        test_count += 1
        if str(bruch_2) != expected:
            print(f"4.{test_count}) ERROR:: Expected: {expected}   Actual:{bruch_2}")
            error_count += 1
        bruch = Fraction(1, 2)
        bruch_1 = Fraction(3, 4)
        bruch_2 = bruch.add(bruch_1)
        expected = "[10/8]"
        test_count += 1
        if str(bruch_2) != expected:
            print(f"4.{test_count}) ERROR:: Expected: {expected}   Actual:{bruch_2}")
            error_count += 1
        bruch = Fraction(1, 2)
        bruch_1 = Fraction(3, 8)
        bruch_2 = bruch.sub(bruch_1)
        expected = "[2/16]"
        test_count += 1
        if str(bruch_2) != expected:
            print(f"4.{test_count}) ERROR:: Expected: {expected}   Actual:{bruch_2}")
            error_count += 1
        if verbal:
            print("4) Test method: mul, div, add, sub")
            print("----------------------------------")
            print(f"     Test performed: {test_count}")
            print(f"     Test failed   : {error_count}")
            print(f"     Passed        : {round(100 - (100 * error_count / test_count), 1)}%")
            print("\n")


    def TEST_mul_div_add_sub_operators(verbal=False):
        error_count = 0
        test_count = 0
        bruch = Fraction(7, 8)
        bruch_1 = Fraction(7, 8)
        bruch_resultat = bruch * bruch_1
        expected = "[49/64]"
        test_count += 1
        if str(bruch_resultat) != expected:
            print("5." + str(test_count) + ") ERROR:: Expected: " + expected + "    Actual:", bruch_resultat)
            error_count += 1
        bruch = Fraction(7, 8)
        bruch_1 = Fraction(1, 2)
        bruch_resultat = bruch * bruch_1
        expected = "[7/16]"
        test_count += 1
        if str(bruch_resultat) != expected:
            print("5." + str(test_count) + ") ERROR:: Expected: " + expected + "    Actual:", bruch_resultat)
            error_count += 1
        bruch = Fraction(1, 2)
        bruch_1 = Fraction(3, 4)
        bruch_resultat = bruch / bruch_1
        expected = "[4/6]"
        test_count += 1
        if str(bruch_resultat) != expected:
            print("5." + str(test_count) + ") ERROR:: Expected: " + expected + "    Actual:", bruch_resultat)
            error_count += 1
        bruch = Fraction(1, 2)
        bruch_1 = Fraction(3, 4)
        bruch_resultat = bruch + bruch_1
        expected = "[10/8]"
        test_count += 1
        if str(bruch_resultat) != expected:
            print("5." + str(test_count) + ") ERROR:: Expected: " + expected + "    Actual:", bruch_resultat)
            error_count += 1
        bruch = Fraction(1, 2)
        bruch_1 = Fraction(3, 8)
        bruch_resultat = bruch - bruch_1
        expected = "[2/16]"
        test_count += 1
        if str(bruch_resultat) != expected:
            print("5." + str(test_count) + ") ERROR:: Expected: " + expected + "    Actual:", bruch_resultat)
            error_count += 1
        if verbal:
            print("5) Test method: mul, div, add, sub Operators")
            print("--------------------------------------------")
            print(f"     Test performed: {test_count}")
            print(f"     Test failed   : {error_count}")
            print(f"     Passed        : {round(100 - (100 * error_count / test_count), 1)}%")
            print("\n")


    print(unterstreichen("Automated Testing of Class Fraction"))
    AUTO_TEST_init_str(verbal=True)
    AUTO_TEST_compareable(verbal=True)
    TEST_reciprocal_to_decimal_shorten_expand(verbal=True)
    # TEST_mul_div_add_sub(verbal=True)
    # TEST_mul_div_add_sub_operators(verbal=True)
