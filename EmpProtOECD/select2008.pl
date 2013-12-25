#!/usr/bin/env perl

use strict;
use warnings;


use Text::CSV;
use utf8;
use JSON;
use Data::Dumper;
binmode STDOUT, ':utf8';

my $csv = Text::CSV->new();

open my $fh, '<', "wholeyear.csv";

my $head = $csv->getline($fh);

my $data = { header => $head,  data => [] };
while( my $elem = $csv->getline($fh) ){
	next unless $elem->[2] eq '2008';
	my $y08;
	$y08 = $elem if $elem->[2] eq '2008';
	push @{$data->{data}}, $y08;
	#print join ', ', @{ $y08 };
	#print "\n";
}
close $fh;

my $d2 = {};

for(@{$data->{data}}){
	$d2->{ $_->[1] } = $_;
}

my @cnt = qw/AUS
AUT
BEL
CAN
CHL
CZE
DNK
EST
FIN
FRA
DEU
GRC
HUN
ISL
IRL
ISR
ITA
JPN
KOR
LUX
MEX
NLD
NZL
NOR
POL
PRT
SVK
SVN
ESP
SWE
CHE
TUR
GBR
USA
/;



my @out = grep{ $_ = $d2->{$_} } @cnt;


#print Dumper(\@out);
#__END__
#my @out = values %$d2;

unshift @out, $head;

open my $out, '>', 'oecd2008.csv';
for(@out){
	$csv->print($out, $_ );
	print {$out} "\n";
}
close $out;


#print scalar keys %$d3

#print Dumper($d3);
