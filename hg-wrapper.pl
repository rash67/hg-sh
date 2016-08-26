#!/usr/bin/perl -w

use Time::HiRes qw/ time sleep /;
use POSIX qw/strftime/;

my $date = strftime("%Y-%m-%d", localtime);
my $datetime = strftime("%Y-%m-%dT%H:%M:%S", localtime);
my $log = "/Users/srash/hg-time-log/$date.out";
my $st = time();
my $hg = "/opt/facebook/bin/hg";
my $cmd = "$hg @ARGV";
system("$hg @ARGV");  
my $ed = time();   
my $d = $ed - $st;
open(F, ">> $log");
print F "$d, $datetime, $cmd\n";
close(F);
