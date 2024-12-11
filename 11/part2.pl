#!/usr/bin/env perl

use Data::Dumper;
use feature 'say';
use strict;
use warnings;

open my $fh, 'input' or die $!;
my @data = split /[ \n]/, <$fh>;
close($fh);

# print Dumper(\@data);
# say join ' ', @data;

my %cache;

sub recurse {
    my ( $round, $value ) = @_;

    return 1 if $round-- == 0;

    return $cache{$round}{$value} if defined $cache{$round}{$value};

    my $r;
    if ( $value == 0 ) {
        $r = recurse($round, 1);
    } elsif ( (length $value) % 2 == 0 ) {
        my $middle = (length $value) / 2;
        my $a = int( substr( $value, 0, $middle ) );
        my $b = int( substr( $value, $middle ) );
        $r = recurse($round,$a) + recurse($round,$b);
    } else {
        $r = recurse($round, $value * 2024);
    }

    $cache{$round}{$value} = $r;
    return $r;
}

my $rounds = 75;
my $total = 0;
$total += recurse( $rounds, $_ ) foreach ( @data );
say $total;

