#!/usr/bin/perl
use CGI;

my $q = CGI->new;

my %headers = map { $_ => $q->http($_) } $q->http();

print $q->header('text/html');
print("<H1>RaspberryPi CGI-App</H1>via <B>Perl</B> (<B><font face=\"Courier\">use CGI-Module</font></B>)<BR/>");
print("<H2>HTTP-Header Details:</H2>\n");
print("<TABLE border=\"1\" cellpadding=1 cellspacing=1\n");
for my $header (keys %headers) {
	print("<TR><TD>${header}</TD><TD>".$headers{$header}."</TD></TR>\n");
}
print("</TABLE>\n");


print("<BR/>\n");
print("<H2>Wichtige Links:</H2>");
print("<UL>\n");
print("    <LI><A href=https://hosting.1und1.de/digitalguide/server/konfiguration/einen-raspberry-pi-webserver-mit-lamp-einrichten/>https://hosting.1und1.de/digitalguide/server/konfiguration/einen-raspberry-pi-webserver-mit-lamp-einrichten/</A></LI>\n");
print("</UL><BR/>\n");


print("<H2>ls -al:</H2>\n");
my $msg   = `ls -al  2>&1`;  $msg=~ s/\n/\n\<BR\>/g;
print("<font face=\"Courier\">${msg}</font><BR/>\n");

print("<H2>IP-Adresse: hostname -I:</H2>\n");
my $msg     = `hostname -I  2>&1`;
my $msg_1   = `hostname 2>&1`;
print("<font face=\"Courier\">Hostname:${msg_1} (IP:${msg})</font><BR/>\n");

print("<H2>UserId:</H2>\n");
my $msg   = `id 2>&1`;
print("id:<font face=\"Courier\">${msg}</font><BR/>\n");

print("<H2>Content of Data-Logger file</H2>\n");
my $msg   = `cat /home/pi/Documents/PythonExamples/Code_05_DataLogger/DataFile.txt  2>&1`; $msg=~ s/\n/\n\<BR\>/g;
print("<font face=\"Courier\">${msg}</font><BR/>\n");

print("<H2>Calling /home/pi/Documents/MyScripts/HAT_PixelTest.py</H2>\n");
my $msg   = `/home/pi/Documents/MyScripts/HAT_PixelTest.py 2>&1`;
print("<font face=\"Courier\">${msg}</font><BR/>\n");
print("<font face=\"Courier\">Writing a ? to the LED-Matrix and delets it after 5s</font><BR/>\n");

