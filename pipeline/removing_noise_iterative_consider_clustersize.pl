#!/usr/bin/perl

use strict;


my $input = shift;
my $cluster_sizes=shift;
my $path=shift;
my $number = 10;
my $top_noise = '';
my $top_noise_cluster_size = '';
my $nexttop_noise_cluster_size = '';
my $nexttop_noise = '';
my $next = '';
my $top_noise_no = '';
my $nexttop_noise_no = '';

system("cp $input $input.0");

#run the inheritance script

for my $i (0..100) {


        if ($number < 1) {last;
}
        system(" $path/inheritance.pl $input.$i | grep dodgy > $input.$i.out");


#count the number of noise
        $number = `wc -l $input.$i.out | awk '{print \$1}'`;
        chomp $number;
        print "$number noisy relationships\n";
        if ($number < 1) {
               system("$path/inheritance.pl $input.$i | grep -v dodgy > $input.$i.out");
                system("cp  $input.$next $input.final; cp $input.$i.out $input.final.out");
                last;}

#work out the node with highest noise

#        $top_noise = `cat $input.$i.out | sed 's/,/ /'  | awk '{print \$1, \$2}' | sed 's/ /\\n/' | sort | uniq -c | sort -n | tail -n 1 | awk '{print \$2}'`;
#       chomp $top_noise;
#a        print "removing $top_noise\n";

#work out node(s) with highest noise. Identify one with least SNPs

		$top_noise = `cat $input.$i.out | sed 's/,/ /'  | awk '{print \$1, \$2}' | tr ' ' '\n' | sort | uniq -c | sort -n | tail -n 1 | awk '{print \$2}'`;
		chomp $top_noise;
		print "$top_noise\n";
		$top_noise_no = `cat $input.$i.out | sed 's/,/ /'  | awk '{print \$1, \$2}' | tr ' ' '\n' | sort | uniq -c | sort -n | tail -n 1 | awk '{print \$1}'`;
		chomp $top_noise_no;
		print "considering removing $top_noise with $top_noise_no noisy relationships\n";
		$top_noise_cluster_size = `cat $cluster_sizes | grep -w $top_noise | awk '{print \$2}'`;
		chomp $top_noise_cluster_size;

                for my $j (2) {

                        $nexttop_noise = `cat $input.$i.out | sed 's/,/ /'  | awk '{print \$1, \$2}' | tr ' ' '\n' | sort | uniq -c | sort -n | tail -n $j | head -n 1 | awk '{print \$2}'`;
                        chomp $nexttop_noise;

                        $nexttop_noise_no = `cat $input.$i.out | sed 's/,/ /'  | awk '{print \$1, \$2}' | tr ' ' '\n' | sort | uniq -c | sort -n | tail -n $j | head -n 1 | awk '{print \$1}'`;
                        chomp $nexttop_noise_no;
                        if ($nexttop_noise_no != $top_noise_no){
				print "removing $top_noise\n";
				last;}
                        else {$nexttop_noise_cluster_size = `cat $cluster_sizes | grep -w $nexttop_noise | awk '{print \$2}'`;
                                chomp $nexttop_noise_cluster_size;
                                if ($nexttop_noise_cluster_size < $top_noise_cluster_size){
                                        print "instead of removing $top_noise with $top_noise_cluster_size SNPs, removing $nexttop_noise with $nexttop_noise_cluster_size SNPs and $nexttop_noise_no noisy relationships\n";
					$top_noise =$nexttop_noise;}
				else {print "removing $top_noise\n";}

                        }

                }

#print "$top_noise $top_noise_cluster_size $nexttop_noise $nexttop_noise_cluster_size\n";
#remove the noise from input file

        $next = ($i+1);
        system("grep -v $top_noise $input.$i > $input.$next");
        $top_noise='';
        if ($number < 1) {last;}
#new input file to inheritance script

} 
