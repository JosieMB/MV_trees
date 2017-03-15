#!/usr/bin/perl

use strict;

my $des_file = shift;
#my $region_file = shift;
my @pos_split = ();
my $count = 1;
my $percent = 0;
my $total = 1;
my @remove= ();
my @c = ();
my @s = ();
my $start = '';
my $end = '';

open( STARTFILE, "<$des_file" ) or die "$!";
my @des = <STARTFILE>;
close (STARTFILE);


#open( STARTFILE, "<$region_file" ) or die "$!";
#my @region = <STARTFILE>;
#close (STARTFILE);

chomp(@des);
#chomp(@region);

for my $i ( 0 .. $#des ){


    ($c[$i], $s[$i]) = split( / /, $des[$i] );
       
        
  }   

for my $i ( 1 .. $#des ){

	if ($c[$i] eq "c0"){
		if (($s[$i] - $s[$i-1]) < 150) { print "$s[$i-1]\n$s[$i]\n"; }
	}


	if (($c[$i] ne "c0") and ($c[$i] eq $c[$i-1])){
		$total++;
	
		if (($s[$i] - $s[$i-1]) < 150) {$count++;}
	}

	if (($c[$i-1] ne "c0") and ($c[$i] ne $c[$i-1])){
	$end = ($count/$total);
		if ($end > 0.2){
	print "$c[$i-1]\n";
		}
	$total =0.000001;
	$count = 0;
	}

	if ($i == $#des){
	$end = ($count/$total);
                if ($end > 0.2){
        print "$c[$i-1]\n";
		}
}
  
}