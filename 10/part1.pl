#!/usr/bin/env perl

use Data::Dumper;
use feature 'say';
use strict;
use warnings;

my %data;
my @starts;
my $x = 0;
my $y = 0;
open my $fh, 'input' or die $!;
while(<$fh>) {
    chomp;
    foreach ( split // ) {
        $_ = -1 if $_ !~ /^\d$/; # remove dots
        $data{$y}{$x} = { 'y' => $y, 'x' => $x, 'value' => $_ };
        push @starts, $data{$y}{$x} if $_ == 0;
        $x++;
    }
    $x = 0;
    $y++;
}
close($fh);
# print Dumper(\%data);
# print Dumper(\@starts);

my %peaks;

sub recurse {
    my $point = shift;
    my $peaks = shift;
    my $x = $point->{'x'};
    my $y = $point->{'y'};
    my $value = $point->{'value'};
    # my $space = '    ' x $value;
    # print Dumper($point);
    # say "$space y=$y x=$x value=$value";

    if ( $value == 9 ) {
        $peaks->{"$y,$x"} = 1;
        return 1;
    }

    my @neighbours = grep { defined($_) && $_->{'value'} == $value+1; } ( $data{$y-1}{$x}, $data{$y}{$x-1}, $data{$y}{$x+1}, $data{$y+1}{$x} );
    recurse($_,$peaks) foreach @neighbours;

    return 1;
}

my $total = 0;
foreach( @starts ) {
    my $peaks = {};
    recurse($_, $peaks);
    $total += scalar %$peaks;
}
say $total;

