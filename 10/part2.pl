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
    my $x = $point->{'x'};
    my $y = $point->{'y'};
    my $value = $point->{'value'};
    # my $space = '    ' x $value;
    # print Dumper($point);
    # say "$space y=$y x=$x value=$value";

    return 1 if ( $value == 9 );

    my @neighbours = grep { defined($_) && $_->{'value'} == $value+1; } ( $data{$y-1}{$x}, $data{$y}{$x-1}, $data{$y}{$x+1}, $data{$y+1}{$x} );

    my $ret = 0;
    $ret += recurse($_) foreach @neighbours;

    return $ret;
}

my $total = 0;
$total += recurse($_) foreach( @starts );
say $total;

