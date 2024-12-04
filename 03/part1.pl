#!/usr/bin/env perl

use feature 'say';
use strict;
use warnings;
use Data::Dumper;

my $total = 0;
open my $fh, 'input' or die $!;
while(<$fh>) {
    s/[\r\n]//g;
    s/mul\((\d+),(\d+)\)/$total+=$1*$2/ge;
}
close($fh);

say $total;

