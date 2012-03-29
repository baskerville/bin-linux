#!/usr/bin/env perl

use strict;
use utf8;

binmode( STDOUT, ":utf8" );

my $UD_PATH = "$ENV{'XDG_DATA_HOME'}/unicode-data.txt";

open my $FILE, $UD_PATH;
my @lines = <$FILE>;
close $FILE;

my $look_for = join " ", @ARGV;

if ($look_for) {
    foreach (@lines) {
        if (/$look_for/i) {
            if (/^([^\t]+)\t([^\t]+)\t([^\t\n]*)$/) {
                my $char_value = chr( hex($1) );
                my $char_name = $3 || $2;
                print " $char_value   \L$char_name\E\n";
            }
        }
    }
}
