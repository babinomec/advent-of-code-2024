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
    next if check($update);
    # print Dumper($update);
    fix($update);
    # print Dumper($update);
    $total += $update->[ $#{$update} / 2 ];
}

say $total;



sub check {
    my $update = shift;
    my @printed;

    foreach my $current ( @$update ) {
        foreach my $p ( @printed ) {
            return 0 if scalar grep { $p == $_ } @{ $rules->{$current} };
        }
        push @printed, $current;
    }

    return 1;
}

sub fix {
    my $update = shift;
    my $before = {};

    # foreach page
    foreach my $current ( @$update ) {
        $before->{$current} = undef;

        # check all other pages
        foreach my $u ( @$update ) {
            next if $current == $u;

            # add in $prec if another printed page is needed for current
            $before->{$current}->{$_} = 1 foreach grep { $u == $_ } @{ $rules->{$current} };
        }
    }
    # print Dumper($before);

    # ugly: there should be only one order so assume we can sort by decreasing number of dependencies
    @$update = sort { scalar keys %{ $before->{$b} } <=> scalar keys %{ $before->{$a} } } keys %$before;

    return 1;
}

