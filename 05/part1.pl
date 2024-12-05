#!/usr/bin/env perl

use feature 'say';
use strict;
use warnings;
use Data::Dumper;

my $rules;
my $updates;
open my $fh, 'input' or die $!;
while(<$fh>) {
    chomp;
    /^(\d+)\|(\d+)$/ and push @{ $rules->{$1} }, $2;
    /^\d+,\d+/ and push( @$updates, [ split(/,/) ] );
}
close($fh);

# print Dumper($rules);
# print Dumper($data);

my $total = 0;
UPDATE:
foreach my $update ( @$updates ) {
    
    # print Dumper($update);
    my @printed;

    foreach my $current ( @$update ) {
        # say "checking $current";

        foreach my $p ( @printed ) {
            # say "comparing already printed $p";
            next UPDATE if scalar grep { $p == $_ } @{ $rules->{$current} };
        }

        push @printed, $current;
    }

    # say "ok";
    $total += $update->[ $#{$update} / 2 ];

}

say $total;

