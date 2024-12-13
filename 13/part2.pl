#!/usr/bin/env perl

use Data::Dumper;
use feature 'say';
use strict;
use warnings;

my $xa;
my $ya;
my $xb;
my $yb;
my $C;
my $D;
my $total;

while(<>) {
    chomp;
    if ( /Button A: X\+(\d+), Y\+(\d+)/ ) {
        $xa = $1;
        $ya = $2;
    } elsif ( /Button B: X\+(\d+), Y\+(\d+)/ ) {
        $xb = $1;
        $yb = $2;
    } elsif ( /Prize: X=(\d+), Y=(\d+)/ ) {
        $C = $1 + 10000000000000;
        $D = $2 + 10000000000000;

        # say ( $xa, $ya, $xb, $yb, $C, $D );
        $total += solve ( $xa, $ya, $xb, $yb, $C, $D );
    }
}
say $total;


sub solve {
    ( my $xa, my $ya, my $xb, my $yb, my $C, my $D ) = @_;
    my $B = ( $xa * $D - $ya * $C ) / ( $xa * $yb - $ya * $xb );
    my $A = ( $C - $B * $xb ) / $xa;
    # say $A;
    # say $B;

    # return 0 if ( $A > 100 || $B > 100 );
    return 0 if ( $A != int($A) || $B != int($B) );

    return 3 * $A + $B;
}
