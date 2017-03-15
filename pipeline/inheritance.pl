#!/usr/bin/perl

use strict;
my @names = ();
my @numbers = ();
my @current_numbers = ();
my @compare_numbers = ();
my $freq_test = 0;
my $sum_test = 0;
my $count = 0;
my $altfreq_test = 0;
my $to_print = '';

my $freq_file=shift;

open (MATCH, "<$freq_file");
my @freqs = <MATCH>;
close (MATCH);
chomp(@freqs);

my $score = 0; 

for my $i (0..$#freqs) {

        ($names[$i], $numbers[$i]) = split(/\t/, $freqs[$i]);
}

#print @numbers;


for my $i (0..$#freqs) {
	@current_numbers = split(/,/, $numbers[$i]);
#print "\n".'node(\''."$names[$i]";
#if ($count > 0) {print "\'})\n";}
$count = 0;
		for my $j(0..$#freqs){

			if ($i eq $j) { next;}
			@compare_numbers = split(/,/, $numbers[$j]);
				
				for my $k(0..$#current_numbers){
		
				
#need to fail freq test
						if (($compare_numbers[$k] - $current_numbers[$k]) >0.04) {$freq_test++;}
# need to pass sum test				
						if (($current_numbers[$k] - $compare_numbers[$k]) >0.04) {$altfreq_test++;}			
						if (($compare_numbers[$k] + $current_numbers[$k]) > 1.1) {$sum_test++;}	
					}
						if (($freq_test < 1) and ($sum_test > 0)){ $count++;}
						#if ($sum_test > 0) { $to_print .= "$names[$i] $names[$j] sum_test\n"; }
						if (($freq_test > 0) and ($altfreq_test > 0) and ($sum_test > 0)) { $to_print .= "$names[$i] $names[$j] dodgy\n"; }
						if (($freq_test < 1) and ($sum_test > 0)) { $to_print .= "$names[$i] $names[$j]\n"; }	
						#if (($freq_test < 1) and ($sum_test > 0) and ($count ==1)){ print 'node(\''."$names[$i]".'\',descendants={\''."$names[$j]";}
						#if (($freq_test < 1) and ($sum_test > 0) and ($count ==1)){ print '\',descendants={\''."$names[$j]";}
						#if (($freq_test < 1) and ($sum_test > 0) and ($count >1)){ print "\',\'$names[$j]";}

					$freq_test =0;
					$sum_test = 0;
					$altfreq_test =0;
}
}


print "\n$to_print";
