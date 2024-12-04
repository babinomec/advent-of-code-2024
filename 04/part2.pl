#!/usr/bin/env perl

use feature 'say';
use strict;
use warnings;
use Data::Dumper;

my $data;
my $length;
open my $fh, 'input' or die $!;
while(<$fh>) {
    $length = length $_ unless $length;
    $data .= $_;
}
close($fh);

my $ls = '.' x ( $length - 2 );
my $l  = '.' x ( $length - 1 );
my $ll = '.' x ( $length );

my @patterns = (
    "m(?=.m${ls}a${ls}s.s)",
    "m(?=.s${ls}a${ls}m.s)",
    "s(?=.m${ls}a${ls}s.m)",
    "s(?=.s${ls}a${ls}m.m)",
);

my $total = 0;
foreach ( @patterns ) {
    my $count =()= $data =~ /$_/gis;
    say "pattern $_ : $count";
    $total += $count;
}

say $total;

