#!/usr/bin/env perl

use feature 'say';
use strict;
use warnings;
use Data::Dumper;

my $data;
open my $fh, 'input' or die $!;
while(<$fh>) {
    s/[\r\n]//g;
    $data .= $_;
}
close($fh);

my $total = 0;
$data =~ s/don't\(\).*?(do\(\)|$)//g;
$data =~ s/mul\((\d+),(\d+)\)/$total+=$1*$2/ge;

say $total;

