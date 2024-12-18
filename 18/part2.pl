#!/usr/bin/env perl

use Data::Dumper;
use feature 'say';
use strict;
use warnings;

my $size = 71;
my $data = {};
my $x;
my $y;
while(<>) {
    chomp;
    say $.;
    /^(\d+),(\d+)$/ or next;
    $x = $1;
    $y = $2;
    $data->{$y}->{$x} = '#';
    last if !reachable($data);
}
# print Dumper($data);
# display($data);
say "line $.: $x,$y";
display($data);
# say $data->{$size-1}->{$size-1};


sub reachable {

    my $orig = shift;
    my $data = {};

    foreach my $y ( keys %$orig ) {
        foreach my $x ( keys %{ $orig->{$y} } ) {
            $data->{$y}->{$x} = $orig->{$y}->{$x};
        }
    }

    $data->{0}->{0} = 0;
    my $points = [ [0,0] ];

    while( scalar @$points ) {

        my $point = shift @$points;
        my $y = $point->[0];
        my $x = $point->[1];
        my $value = $data->{$y}->{$x};

        if ( $y > 0 && !defined $data->{$y-1}->{$x} ) {
            $data->{$y-1}->{$x} = $value+1;
            push @$points, [$y-1,$x];
        }
        if ( $y < $size-1 && !defined $data->{$y+1}->{$x} ) {
            $data->{$y+1}->{$x} = $value+1;
            push @$points, [$y+1,$x];
        }
        if ( $x > 0 && !defined $data->{$y}->{$x-1} ) {
            $data->{$y}->{$x-1} = $value+1;
            push @$points, [$y,$x-1];
        }
        if ( $x < $size-1 && !defined $data->{$y}->{$x+1} ) {
            $data->{$y}->{$x+1} = $value+1;
            push @$points, [$y,$x+1];
        }

        return 1 if defined $data->{$size-1} && defined $data->{$size-1}->{$size-1};
    }

    return 0;
}



sub display {
    my $data = shift;

    foreach my $y ( 0..$size-1 ) {
        my $line = "";
        foreach my $x ( 0..$size-1 ) {
            my $value = '.';
            if ( defined $data->{$y} && defined $data->{$y}->{$x} ) {
                if ( $data->{$y}->{$x} eq '#' ) {
                    $value = '#';
                } else {
                    $value = $data->{$y}->{$x} % 10;
                }
            }
            $line .= $value;
        }
        say $line;
    }
}

