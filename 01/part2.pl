#!/usr/bin/env perl

use feature 'say';
use strict;
use warnings;

my @left;
my %right;

open my $fh, 'input' or die $!;
while(<$fh>) {
    /^(\d+)\s+(\d+)[\r\n]*$/ or die "strange line $.\n";
    push @left, $1;
    $right{$2}++;
}
close $fh;

my $sim = 0;
$sim += $_ * ( $right{$_} // 0 ) foreach @left;

say $sim;

