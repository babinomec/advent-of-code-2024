#!/usr/bin/env perl

use Data::Dumper;
use feature 'say';
use strict;
use warnings;

my $steps = 100;

my $width = 101;
my $height = 103;

my @points;
my $x = 0;
my $y = 0;
while(<>) {
    chomp;
    /^p=(.+?),(.+?) v=(.+),(.+?)$/ or next;
    push @points, { 'x' => $1, 'y' => $2, 'vx' => $3, 'vy' => $4 };
}
# print Dumper(\@points);



my %newpoints;
my @quadrants;
foreach my $point ( @points ) {
    my $nx = ( $point->{'x'} + $steps * $point->{'vx'} ) % $width;
    my $ny = ( $point->{'y'} + $steps * $point->{'vy'} ) % $height;
    $newpoints{$nx}{$ny}++;
    my $qx = $nx <=> ($width-1)/2;
    my $qy = $ny <=> ($height-1)/2;
    next if $qx == 0 || $qy == 0;
    $quadrants[ ($qx>0)*2 + ($qy>0) ]++;
}
# print Dumper(\%newpoints);
# print Dumper(\@quadrants);

my $total = 1;
$total *= $_ foreach @quadrants;
say $total;

