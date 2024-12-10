#!/usr/bin/env perl

use Data::Dumper;
use feature 'say';
use strict;
use warnings;

my $input;
open my $fh, 'input' or die $!;
while(<$fh>) {
    chomp;
    $input .= $_;
}
close($fh);

my @data;
my $isdata = 1;
my $id = 0;
foreach ( split //, $input ) {
    push @data, ($isdata ? $id++ : '.') x $_;
    $isdata = !$isdata;
}
# say @data;


for( my $i=$#data ; $i>=0 ; $i-- ) {
    # say "checking $i";
    next if $data[$i] eq '.'; #; || $data[$i] != $currentid;

    my $currentid = $data[$i];
    my $end = $i;
    my $start = $i;
    $start-- while( $start-1 >= 0 and $data[$start-1] ne '.' && $data[$start-1] == $currentid );
    my $length = $end - $start + 1;
    # say "current id $currentid $start-$end l=$length";

    # find $length free space before $start
    my $found = 0;
    my $fstart = undef;
    my $count = 0;
    for ( my $j=0 ; $j < $start ; $j++ ) {
        # say "checking $j";
        if ( $data[$j] ne '.' ) {
            # say "nok, reset";
            $count = 0;
            $fstart = undef;
            next;
        }

        # say "ok";
        $fstart = $j unless defined($fstart);
        $count++;

        if ( $count == $length ) { # found a space
            $found = 1;
            last;
        }
    }

    if ( $found ) { # move stuff
        # say "move $currentid (l=$length) to $fstart";
        for ( my $j=0 ; $j<$length ; $j++ ) {
            $data[$start+$j] = '.';
            $data[$fstart+$j] = $currentid;
        }

    }

    # say @data;
    $i=$start;
}

my $checksum = 0;
for ( my $i=0 ; $i<$#data ; $i++ ) {
    next if $data[$i] eq '.';
    $checksum += $i * $data[$i];
}

say $checksum;

