#!/usr/bin/perl -w

use strict;                                                                     
use Cwd;

my $dir = getcwd();

while (defined($dir) && length($dir) > 0) {
  if (-d "$dir/.hg") {
    print "$dir";

    last;
  }
  ($dir) = ($dir =~ m#(.*)/.+?#);
}
