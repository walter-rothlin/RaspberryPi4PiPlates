#!/usr/bin/perl

print("Content-Type: text/html\n\n");
print("<H1>RaspberryPi Environment</H1>via <B>Perl</B> (No <B><font face=\"Courier\">use Modules</font></B>)<BR/>");

my $msg   = "";

print("<HR/>\n");
print("<H2>Server-Details</H2>\n");
$msg   = `hostname 2>&1`;      chomp($msg);  print("Hostname  :<B>${msg}</B><BR/>\n");
$msg   = `hostname -I 2>&1`;   chomp($msg);  print("IP-Adresse:<B>${msg}</B><BR/>\n");
$msg   = `whoami 2>&1`;        chomp($msg);  print("Script executed by user:<B>${msg}</B> (defined in /etc/apache2/envvars)<BR/>\n");
$msg   = `pwd 2>&1`;           chomp($msg);  print("Current directory:<B>${msg}</B><BR/>\n");
$msg   = `echo \$DOCUMENT_ROOT 2>&1`;   chomp($msg);   print("DOCUMENT_ROOT:<B>${msg}</B> (defined in /etc/apache2/sites_enabled und sites_available)<BR/>\n<BR/>\n");


print("<HR/>\n");
print("<H2>Client-Details</H2>\n");
$msg   = `echo \$REMOTE_ADDR 2>&1`;   chomp($msg);   print("Client-IP:<B>${msg}</B><BR/>\n<BR/>\n");
$msg   = `env 2>&1`;                  chomp($msg);   $msg=~ s/\n/\<BR\>/g; print("Environment:<BR/>\n");
print("<font face=\"Courier\">${msg}</font><BR/>\n");

print("<HR/>\n");
print("<H2>Perl-Installation</H2>\n");
$msg   = `perl -v 2>&1`;   chomp($msg);   print("Perl-Version:<B>${msg}</B><BR/>\n<BR/>\n");
$msg   = `echo \$PERL5LIB 2>&1`;   chomp($msg);   print("PERL5LIB:<B>${msg}</B><BR/>\n<BR/>\n");
$msg   = `perl -MCGI -e "print \"CGI installed!!\\n\";" 2>&1`;   chomp($msg);   print("CGI-Module:<B>${msg}</B><BR/>\n<BR/>\n");

