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

my $round = 25;

while ( $round-- ) {

    my @newdata;

    foreach my $current ( @data ) {
        if ( $current == 0 ) {
            push @newdata, 1;
        } elsif ( (length $current) % 2 == 0 ) {
            my $middle = (length $current) / 2;
            push @newdata, int( substr( $current, 0, $middle ) );
            push @newdata, int( substr( $current, $middle ) );
        } else {
            push @newdata, $current * 2024;
        }

    }

    @data = @newdata;
    # say join ' ', @data;
}

say scalar @data;

