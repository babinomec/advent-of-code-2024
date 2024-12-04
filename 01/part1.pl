#!/usr/bin/env perl

use feature 'say';
use strict;
use warnings;

my @left;
my @right;

open my $fh, 'input' or die $!;
while(<$fh>) {
    /^(\d+)\s+(\d+)[\r\n]*$/ or die "strange line $.\n";
    push @left, $1;
    push @right, $2;
}
close $fh;

@left = sort @left;
@right = sort @right;

my $dist = 0;
while(@left) {
    $dist += abs((shift @left) - (shift @right));
}

say $dist;

