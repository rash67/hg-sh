#!/usr/bin/perl -w

use strict;                               

my $fh;                   
#my $headsCmd = "hg heads -r 'head() & draft()'";
my $headsCmd = "hg heads";
open($fh, "$headsCmd|")
  or die "$!";
  
my $devServerRemote = "dev";

my @entryLines;
while (my $line = <$fh>) {
  chomp($line);
  next
    if $line =~ /^\s*$/;
  #print "push3: [$line]\n";
  push(@entryLines, $line);  
  
  while (defined(($line = <$fh>)) && $line !~ /changeset: /) {    
    chomp($line);
    next
      if $line =~ /^\s*$/;  
    #print "push1: [$line]\n";
    push(@entryLines, $line);
  }


  my $entry = parseEntry(\@entryLines);
  processEntry($entry);
  @entryLines = ();
  #print "push2: [$line]\n";
  if (defined($line) && ($line !~ /^\s*$/)) {
    chomp($line);    
    push(@entryLines, $line);
  }
}

if (@entryLines > 0) {
  my $entry = parseEntry(\@entryLines);
  processEntry($entry);
}
  
  
  ######
sub processEntry {
  my ($entry) = @_;

  if ((!defined($entry->{bookmark}) || $entry->{bookmark} =~ m#dev/#) && !defined($entry->{branch})) {   
    if($entry->{user} =~ m#s?rash\@fb.com#) {
      print "$entry->{changeset}\n";            
    }
  }
}   

sub parseEntry {
  my ($entryLines) = @_;
  
  my %h;
  #print "entry start\n";
  foreach my $line (@$entryLines) {
    next 
      if $line =~ /^\s*$/;
      
    my ($k, $v) = ($line =~ /^(\w+?):\s*(.*)$/);
    next
      unless defined($k) && defined($v);
    #print "adding $k -> $v\n";
                                          
    # handles the "(@)" on the changeset lines
    if ($k eq "changeset") {
      $v =~ s/\s*\(\@\)//;
    }
    
    $h{$k} = $v;
  }
  #print "entry end\n\n\n";
  return \%h;  
}