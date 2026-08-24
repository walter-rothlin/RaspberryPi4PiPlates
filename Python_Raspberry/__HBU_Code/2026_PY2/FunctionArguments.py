#!/usr/bin/python

# ------------------------------------------------------------------
# Name  : FunctionArguments.py
# Source: https://raw.githubusercontent.com/walter-rothlin/RaspberryPi4PiPlates/master/Python_Raspberry/_HBU_Code/2026_PY2/FunctionArguments.py
#
#
# Autor: Walter Rothlin
#
# History:
# 24-Aug_2026   Walter Rothlin    Initial Version
#
# ------------------------------------------------------------------
def get_trenner(length=80, a_char='-'):
    return a_char * length

print('1) Regular Function Calls')
print('=========================')
def func1(a):
    print(f"func1({a}) type(a)={type(a)}")

func1(5)
func1(a='Hallo')
func1([10, True, 9.5])
func1(a=(10, True, 9.5))
func1({'Anrede': 'Hallo', 'b': 5})
func1(a={'Anrede': 'Hallo', 'b': 5})
print(get_trenner(a_char='='), "\n")

print('2) Function Calls with variable number of arguments')
print('===================================================')
def func2(*values):
    print(f"func2(*values) ==> func2{values}   ==> type(values)={type(values)}")
    for v in values:
        if isinstance(v, int):
            print(f"   Value: {v}")
    print(f'   {values[-1]} is the last value')

def func2_as_comprehension(*values):
    print(f"func2_as_comprehension(*values) ==> func2_as_comprehension{values}   ==> type(values)={type(values)}")
    formatted = [f"{v}" for v in values if isinstance(v, int)]
    print(formatted)

func2(5, 7, 8)
func2(5, 7, 8, 9.0, 10, "Uster", 12)
func2_as_comprehension(5, 7, 8, 9.0, 10, "Uster", 12)
print('\n')

def summe(*values):
    sum_value = 0
    for v in values:
        sum_value += v
    return sum_value

print(f"summe(5, 7 , 8) = {summe(5, 7 , 8)}")
print(get_trenner(a_char='='), "\n")

def average(*values, precision=None):
    sum_value = 0
    for v in values:
        sum_value += v
    if precision is not None:
        return round(sum_value/len(values), precision)
    else:
        return sum_value/len(values)

print(f"2) average(5, 7 , 8) = {average(5, 7 , 8):0.4f}   ==> expexted: 6.6667")
print(f"2) average(5, 7 , 8) = {average(5, 7 , 8, precision=2)}   ==> expexted: 6.67")
print(get_trenner(a_char='='), "\n")

print('3) Function calls with variable number of named arguments')
print('=========================================================')
def func3(**keyValues):
    print(f"3) func3(**keyValues)  ==> func3{keyValues}  ==> type(keyValues)={type(keyValues)}")
    for k, v in keyValues.items():
        print(f"   Key: {k}   Value: {v}")

func3(pi=3.1415, e=2.78)
func3(m=3.1415, c=2.788888)
print(get_trenner(a_char='='), "\n")


print('4) Function Calls with variable number of named arguments and normal arguments')
print('==============================================================================')
def func4(*values, first_name, last_name):
    print(f"""
        4) func4(*values, first_name, last_name)  ===> values={values}, first_name={first_name}, last_name={last_name}
    """)

func4( 1, 2, 3, 4, 5, 6, first_name='Uster', last_name='Walter')
func4( 1, 2, 3, 4, 5, first_name='HBU', last_name='Max ')

print(get_trenner(a_char='='), "\n")

print('5) Function Calls with variable number of named arguments and normal arguments')
print('==============================================================================')

def func5(first_name, last_name, **keyValues):
    print(f"5) func5(first_name, **keyValues)  ===> first_name={first_name}, first_name={last_name}, keyValues={keyValues}")

func5('Walter', 'Rothlin', pi=3.1415, e=2.78)
func5('Max', 'Meier', a=1, b=2, c=3, d=4, e=5)
print(get_trenner(a_char='='), "\n")

print('6) Function Calls with normal arguments, variable number of named arguments and normal arguments')
print('==============================================================================')
def func6(a, *values, **keyValues):
    print(f"6) func6(a, *values, **keyValues) ===> a={a}, values={values}, keyValues={keyValues}")

func6('Peter', 1, 2, 3, 4, 5, pi=3.1415, e=2.78)
print(get_trenner(a_char='='), "\n")

def clear(color=(0,0,0), *values, **keyValues):
    """
    Clear or set a color.

    The function can be called without arguments to use black as
    the default color, or with an RGB color specified in different
    formats.

    Examples:
        clear()
            Use black: (0, 0, 0).

        clear((255, 128, 0))
            Set the color using an RGB tuple.

        clear(color=(255, 128, 0))
            Set the color using the named `color` argument.

        clear(r=255, g=255, b=0)
            Set the color using named RGB components.

        clear(128, 255, 255)
            Set the color using three positional RGB components.

    Args:
        color:
            An RGB tuple or the first RGB component. Defaults to
            (0, 0, 0).

        Alternatively, the RGB values can be passed individually:

        r: 0-255 integer representing the red component.
        g: 0-255 integer representing the green component.
        b: 0-255 integer representing the blue component.

    Returns:
        None.
    """
    print(f"""
       clear(color, *values), **keyValues) ===> clear(color={color}, *values={values}, **keyValues={keyValues})
            type(color)={type(color)}
            type(*values)={type(values)}
            type(**keyValues)={type(keyValues)}
        """)

    if isinstance(color, tuple):
        print(f"1) Color: {color}")

    elif 'color' in keyValues:
        print(f"2) Color: {keyValues['color']}")

    elif all(k in keyValues for k in ('r', 'g', 'b')):
        print(f"3) Color: ({keyValues['r']}, {keyValues['g']}, {keyValues['b']})")

    elif color is not None and len(values) == 2:
        print(f"4) Color: ({color}, {values[0]}, {values[1]})")

    else:
        print("Keine gültige Farbe angegeben")

    print()

clear(color=(255, 128, 0))
clear(r=255, g=255, b=0)
clear((255, 0, 128))
clear(128, 255, 255)
clear()
