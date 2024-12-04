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

my $l = '.' x ( $length - 1 );
my $ll = '.' x ( $length );
my $ls = '.' x ( $length - 2 );

my @patterns = (
    "xmas",
    "samx",
    "x(?=${l}m${l}a${l}s)",
    "s(?=${l}a${l}m${l}x)",
    "(x)(?=${ll}m${ll}a${ll}s)",
    "(s)(?=${ll}a${ll}m${ll}x)",
    "(x)(?=${ls}m${ls}a${ls}s)",
    "(s)(?=${ls}a${ls}m${ls}x)",
);

my $total = 0;
foreach ( @patterns ) {
    my $count =()= $data =~ /$_/gis;
    say "pattern $_ : $count";
    $total += $count;
}

say $total;

