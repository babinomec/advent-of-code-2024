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



my $step = 1;
while(1) {
    say $step;

    my %newpoints;
    foreach my $point ( @points ) {
        my $nx = ( $point->{'x'} + $step * $point->{'vx'} ) % $width;
        my $ny = ( $point->{'y'} + $step * $point->{'vy'} ) % $height;
        $newpoints{$ny}{$nx}++;
    }

    my $output = '';
    my $found = 0;
    foreach my $y ( 0..$height ) {
        my $line = '';
        my $consecutive = 0;
        foreach my $x ( 0..$width ) {
            if ( $newpoints{$y}{$x} ) {
                $line .= '*';
                $consecutive++;
            } else {
                $line .= '.';
                $consecutive = 0;
            }

            $found = 1 if $consecutive > 10;
        }
        $output .= "$line\n";
    }

    if ( $found ) {
        say $output;
        last;
    }

    $step++;
}

