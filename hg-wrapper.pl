#!/usr/bin/perl -w

use Time::HiRes qw/ time sleep /;
use POSIX qw/strftime/;
my $logDir = "/Users/srash/hg-time-log";
my $hg = "/opt/facebook/bin/hg";
my $hgRootBin = "/Users/srash/bin/hg-root.pl";

if (-e "/etc/fbwhoami") {
  $hg = "hg";
  $logDir = "/home/srash/hg-time-log";
  $hgRootBin = "/home/srash/bin/hg-root.pl";
}


my $hgRoot = `$hgRootBin`;
chomp($hgRoot);
my $date = strftime("%Y-%m-%d", localtime);
my $datetime = strftime("%Y-%m-%dT%H:%M:%S", localtime);
my $log = "$logDir/$date.out";
my $st = time();
my $cmd = "$hg @ARGV";
my $exitCode = system("$hg @ARGV");  
my $ed = time();   
my $d = $ed - $st;
open(F, ">> $log");
print F "$d, $datetime, $hgRoot, $cmd\n";
close(F);         
$exitCode = $exitCode >> 8;
              
#print $exitCode, "\n";
exit($exitCode);