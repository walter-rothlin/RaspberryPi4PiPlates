#!/usr/bin/perl

use CGI;
use littlePerlLib;


my $q = CGI->new;
my %headers = map { $_ => $q->http($_) } $q->http();

print $q->header('text/html');
print("<H1>RaspberryPi Environment</H1>via <B>Perl</B> (<B><font face=\"Courier\">use CGI-Module, littlePerlLib.pm</font></B>)<BR/>");
print("<H2>HTTP-Header Details:</H2>\n");
print("<TABLE border=\"1\" cellpadding=1 cellspacing=1\n");
for my $header (keys %headers) {
	print("<TR><TD>${header}</TD><TD>".$headers{$header}."</TD></TR>\n");
}
print("</TABLE>\n");

@anArray=("Walti","Claudia");
displayArrayHTML(@anArray);
