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
    push @data, ($isdata ? $id++ : '') x $_;
    $isdata = !$isdata;
}
# die Dumper(\@data);
# say join '', map { $_ // '.' } @data;

my $checksum = 0;
my $i = 0;

while( scalar @data ) {
    my $d = shift @data;
    $d = pop(@data) while defined($d) && $d eq '';
    last unless defined($d);
    # say "$i $d";
    $checksum += $i * $d;
    $i++;

}

say $checksum;

