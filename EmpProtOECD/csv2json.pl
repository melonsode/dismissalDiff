#!/usr/bin/env perl

use strict;
use warnings;


use Text::CSV;
use utf8;
use JSON;
use Data::Dumper;
binmode STDOUT, ':utf8';

my $csv = Text::CSV->new();

die 'specify csv file' unless @ARGV;
my $file = shift @ARGV;

open my $fh, '<', $file;

my $head = $csv->getline($fh);

my $data = { header => $head,  data => [] };
while( my $elem = $csv->getline($fh) ){
 	push @{$data->{data}}, $elem;
 	#print join ' - ', @$elem;
 	#print "\n";
}
close $fh;

#print Dumper($data);

print encode_json($data);