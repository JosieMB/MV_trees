#!/usr/bin/perl

use strict;

my $des_file = shift;
my $clustered_file = shift;
my @pos_split = ();
my @clus = ();
my @new_clus = ();
my $count = 1;
my $percent = 0;
my $total = 1;
my @remove= ('c10000');
my @c = ();
my @s = ();
my $start = '';
my $end = '';

open( STARTFILE, "<$des_file" ) or die "$!";
my @des = <STARTFILE>;
close (STARTFILE);
chomp(@des);

open( STARTFILE, "<$clustered_file" ) or die "$!";
my @clus = <STARTFILE>;
close (STARTFILE);
chomp(@clus);


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
	print "remove $c[$i-1]\n";
	push (@remove, $c[$i-1]);
		}
	$total =0.000001;
	$count = 0;
	}

	if ($i == $#des){
	$end = ($count/$total);
                if ($end > 0.2){
        print "remove $c[$i-1]\n";
        push (@remove, $c[$i-1]);
		}
	}
  
}

for my $i ( 0 .. $#remove ){
	@new_clus = grep !/\b$remove[$i]\b/, @clus;
	@clus = @new_clus;
}	

print "$_\n" for @new_clus;


