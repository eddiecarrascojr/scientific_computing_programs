#!/usr/bin/perl -w
#Nth Fibonacci number
use strict;

my $N = shift; # or $ARGV[0]
my @F = (0,1);

# the next 5 lines are equivalent
for (my $n=2;$n<=$N;$n++) { $F[$n]=$F[$n-1]+$F[$n-2]; }
#foreach (2..$N) {@F = ($F[1],$F[0]+$F[1]);}
#@F = ($F[1],$F[0]+$F[1]) foreach (2..$N); 
#foreach (2..$N) {my @F = push(@F,$F[-1]+$F[-2]); shift;} # i.e. shift(@F)
#use List::Util qw(sum); foreach (2..$N) {@F = ($F[1],sum(@F));}

printf("F%i = %i\n",$N,$F[-1]);
print "$F[-1]\n";
system("echo $F[-1]\n");
