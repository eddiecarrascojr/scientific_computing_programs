#!/usr/bin/perl -w
use strict;

my ($a,$b,$c) = (0.125,0.325,0.725); # a is CN, b and c are not and are rounded on computer
printf("%s is %.2f or %.30f\n",($_)x3) for $a,$b,$c;

