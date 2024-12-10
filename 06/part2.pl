#!/usr/bin/env perl

use Data::Dumper;
use Clone qw(clone);
use feature 'say';
use strict;
use warnings;

my $map = [];
open my $fh, 'input' or die $!;
while(<$fh>) {
    chomp;
    push @$map, [split //];
}
close($fh);

# die Dumper($map);

my $x;
my $y;
my $direction = 'up';
my %visited;
my $startx;
my $starty;

SEARCH:
for( $x=0 ; $x<=$#$map ; $x++ ) {
    my $line = $map->[$x];
    for( $y=0 ; $y<=$#$line ; $y++ ) {
        if ( $line->[$y] eq '^' ) {
            $line->[$y] = '.';
            $visited{"$x,$y"} = 1;
            $startx= $x;
            $starty= $y;
            last SEARCH;
        }
    }
}

my $maxx = $#$map;
my $maxy = $#{ $map->[0] };

# displaygrid($map,$x,$y,$direction);

MOVE:
while(1) {

    my $exited;
    my $nextx;
    my $nexty;
    my $nextdirection;

    ( $exited, $nextx, $nexty, $nextdirection ) = nextposition($map, $x, $y, $direction);

    last MOVE if $exited;

    $x = $nextx;
    $y = $nexty;
    $direction = $nextdirection;
    $visited{"$x,$y"} = 1;

    # displaygrid($map,$x,$y,$direction);
    # exit;
}

say scalar keys %visited;

my %loopspots;

foreach ( keys %visited ) {
    /^(\d+),(\d+)$/ or die;
    (my $x, my $y) = ($1,$2);

    next if ( $x == $startx && $y == $starty ); # skip start point

    # add an obstruction and check if we loop
    my $loopmap = clone($map);
    $loopmap->[$x]->[$y] = '#';

    my %loopvisited;
    my $loopx = $startx;
    my $loopy = $starty;
    my $loopdirection = 'up';

    CHECKLOOP:
    while(1) {
        my $loopexited;
        my $loopnextx;
        my $loopnexty;
        my $loopnextdirection;
        ( $loopexited, $loopnextx, $loopnexty, $loopnextdirection ) = nextposition($loopmap, $loopx, $loopy, $loopdirection);
        last CHECKLOOP if $loopexited;
        if ( $loopvisited{"$loopnextx,$loopnexty,$loopnextdirection"} ) {
            $loopspots{"$x,$y"} = 1;
            last CHECKLOOP;
        }
        $loopx = $loopnextx;
        $loopy = $loopnexty;
        $loopdirection = $loopnextdirection;
        $loopvisited{"$loopx,$loopy,$loopdirection"} = 1;
    }
}

say scalar keys %loopspots;
# print Dumper(\%loopspots);



sub nextposition {
    my $map = shift;
    my $x = shift;
    my $y = shift;
    my $direction = shift;

    my $nextx;
    my $nexty;

    if ( $direction eq 'up' ) { 
        return (1, undef, undef, undef ) if $x == 0;
        $nextx = $x - 1;
        $nexty = $y;
        return (0, $x, $y, 'right' ) if ( $map->[$nextx]->[$nexty] eq '#' );
    } elsif ( $direction eq 'down' ) { 
        return (1, undef, undef, undef ) if $x == $maxx;
        $nextx = $x + 1;
        $nexty = $y;
        return (0, $x, $y, 'left' ) if ( $map->[$nextx]->[$nexty] eq '#' );
    } elsif ( $direction eq 'left' ) { 
        return (1, undef, undef, undef ) if $y == 0;
        $nextx = $x;
        $nexty = $y - 1;
        return (0, $x, $y, 'up' ) if ( $map->[$nextx]->[$nexty] eq '#' );
    } elsif ( $direction eq 'right' ) { 
        return (1, undef, undef, undef ) if $y == $maxy;
        $nextx = $x;
        $nexty = $y + 1;
        return (0, $x, $y, 'down' ) if ( $map->[$nextx]->[$nexty] eq '#' );
    } else {
        die "WTF\n";
    }

    return (0, $nextx, $nexty, $direction);
}


sub displaygrid {
    my $map = shift;
    my $gx = shift;
    my $gy = shift;
    my $direction = shift;

    my $player;
    if ( $direction eq 'up' ) { 
        $player = '^';
    } elsif ( $direction eq 'down' ) { 
        $player = 'v';
    } elsif ( $direction eq 'left' ) { 
        $player = '<';
    } elsif ( $direction eq 'right' ) { 
        $player = '>';
    } else {
        die "WTF\n";
    }

    my $str;

    for( my $x=0 ; $x<=$#$map ; $x++ ) {
        my $line = $map->[$x];
        for( my $y=0 ; $y<=$#$line ; $y++ ) {
            $str .=  ( $x == $gx && $y == $gy ? $player : $line->[$y] );
        }
        $str .= "\n";
    }

    say $str;

}
