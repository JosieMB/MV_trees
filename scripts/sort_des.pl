#!/usr/bin/perl

use strict;

my $pos_file = shift;
#my $sd_file = shift;
my @pos_split = ();
my $count = 0;
my $percent = 0;
my $total = 0;
my @remove= ();

open( STARTFILE, "<$pos_file" ) or die "$!";
my @pos_des = <STARTFILE>;
close (STARTFILE);


#open( STARTFILE, "<$sd_file" ) or die "$!";
#my @sds = <STARTFILE>;
#close (STARTFILE);

chomp(@pos_des);
#chomp(@sds);

for my $i ( 0 .. $#pos_des ){

    @pos_split = split( /, /, $pos_des[$i] );
		for my $j (0..$#pos_split){
			print "c$i $pos_split[$j]\n";
		}  
 
  			
  			
         }
