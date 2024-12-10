#!/usr/bin/env perl

use Data::Dumper;
use feature 'say';
use strict;
use warnings;

my $total = 0;

open my $fh, 'input' or die $!;
while(<$fh>) {
    /^(\d+): (.+)$/ or die;
    my $target = $1;
    my @values = split / /, $2;
    $total += $target if check( $target, undef, @values );
}
close($fh);

say $total;



sub check {
    my $target = shift;
    my $acc = shift;
    my @values = @_;

    # say "checking $target, $acc, [", join('.',@values),  "]";

    if ( !defined($acc) ) {
        $acc = shift @values;
        return check($target, $acc, @values);
    }

    return $acc == $target if scalar(@values) == 0;

    my $current = shift @values;

    return 1 if check($target,$acc+$current,@values) || check($target,$acc*$current,@values);

    return 0;

}


