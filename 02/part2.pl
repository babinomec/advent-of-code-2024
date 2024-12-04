#!/usr/bin/env perl

use feature 'say';
use strict;
use warnings;

my $safe = 0;
open my $fh, 'input' or die $!;
while(<$fh>) {
    s/[\r\n]//g;
    my @values = split /\s+/, $_;
    $safe += check_dampen(@values);
}
close($fh);

say $safe;


sub check_dampen {
    my @values = @_;

    return 1 if check(@values);

    for my $i (0..$#values) {
        my @copy = @values;
        splice @copy, $i, 1;
        return 1 if check(@copy);
    }

    return 0;
}

sub check {
    my @values = @_;

    my $trend = $values[0] <=> $values[1];
    return 0 if $trend == 0;

    my $prev = shift @values;
    foreach( @values ) {
        return 0 if $trend != ( $prev <=> $_ );
        return 0 if abs( $prev - $_ ) > 3;
        $prev = $_;
    }

    return 1;
}

