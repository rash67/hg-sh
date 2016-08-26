#!/usr/bin/perl -w

use Time::HiRes qw/ time sleep /;
use POSIX qw/strftime/;
my $logDir;

if (-e "/etc/fbwhoami") {
  $logDir = "/home/srash/hg-time-log";
} else {
  $logDir = "/Users/srash/hg-time-log";
}

my $date = strftime("%Y-%m-%d", localtime);
my $datetime = strftime("%Y-%m-%dT%H:%M:%S", localtime);
my $log = "$logDir/$date.out";
my $st = time();
my $hg = "/opt/facebook/bin/hg";
my $cmd = "$hg @ARGV";
system("$hg @ARGV");  
my $ed = time();   
my $d = $ed - $st;
open(F, ">> $log");
print F "$d, $datetime, $cmd\n";
close(F);
