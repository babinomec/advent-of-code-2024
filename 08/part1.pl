#!/usr/bin/env perl

use Data::Dumper;
use feature 'say';
use strict;
use warnings;

my $x = 0;
my $y = 0;
my $data;
my $nodes;
open my $fh, 'input' or die $!;
while(<$fh>) {
    chomp;
    foreach my $char ( split // ) {
        push @{ $data->[$y] }, $char;
        push @{ $nodes->{$char} }, [$x,$y] if ( $char ne '.' );
        $x++;
    }
    $x = 0;
    $y++;
}
my $maxx = scalar @{ $data->[0] };
my $maxy = scalar @$data;

# print Dumper($data);
# print Dumper($nodes);
# display();

my $antinodes;
foreach my $id ( keys %$nodes ) {
    my @positions = @{ $nodes->{$id} };

    foreach my $current ( @positions ) {
        my $cx = $current->[0];
        my $cy = $current->[1];
        foreach my $other ( @positions ) {
            my $ox = $other->[0];
            my $oy = $other->[1];
            next if $cx == $ox && $cy == $oy;
            my $diffx = $ox - $cx;
            my $diffy = $oy - $cy;
            my $ax = $cx - $diffx;
            my $ay = $cy - $diffy;
            next if $ax < 0 || $ax >= $maxx;
            next if $ay < 0 || $ay >= $maxy;
            $antinodes->{$ax}->{$ay} = 1;
        }
    }
}

print Dumper($nodes);
print Dumper($antinodes);
display();
my $count;
$count += scalar keys %{ $antinodes->{$_}} foreach keys %$antinodes;
say $count;


sub display {

    my $out = '';
    my $x = 0;
    my $y = 0;
    foreach my $line ( @$data ) {
        foreach my $char ( @$line ) {
            $char = '#' if $antinodes->{$x}->{$y};
            $out .= $char;
            $x++;
        }
        $out .= "\n";
        $x = 0;
        $y++;
    }

    say $out;
}

