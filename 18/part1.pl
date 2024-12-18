#!/usr/bin/env perl

use Data::Dumper;
use feature 'say';
use strict;
use warnings;

my $size = 71;
my $bytes = 1024;
my $data = {};
while(<>) {
    chomp;
    $data->{$2}->{$1} = '#' if ( /^(\d+),(\d+)$/ );
    last unless --$bytes;
}
# print Dumper($data);
# display($data);

$data->{0}->{0} = 0;
my $points = [ [0,0] ];


while( scalar @$points ) {

    my $point = shift @$points;
    my $y = $point->[0];
    my $x = $point->[1];
    my $value = $data->{$y}->{$x};
    # display($data);
    # say "process $y,$x value=$value";

    if ( $y > 0 && !defined $data->{$y-1}->{$x} ) {
        # say 1;
        $data->{$y-1}->{$x} = $value+1;
        push @$points, [$y-1,$x];
    }
    if ( $y < $size-1 && !defined $data->{$y+1}->{$x} ) {
        # say 2;
        $data->{$y+1}->{$x} = $value+1;
        push @$points, [$y+1,$x];
    }
    if ( $x > 0 && !defined $data->{$y}->{$x-1} ) {
        # say 3;
        $data->{$y}->{$x-1} = $value+1;
        push @$points, [$y,$x-1];
    }
    if ( $x < $size-1 && !defined $data->{$y}->{$x+1} ) {
        # say 4;
        $data->{$y}->{$x+1} = $value+1;
        push @$points, [$y,$x+1];
    }

    last if defined $data->{$size-1} && defined $data->{$size-1}->{$size-1};
}

display($data);
say $data->{$size-1}->{$size-1};


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

