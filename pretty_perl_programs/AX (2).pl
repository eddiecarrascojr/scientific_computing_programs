#!/usr/bin/perl -w
use strict;
use PDL;

my $A = pdl([2,-1,0],[-1,2,-1],[0,-1,2]);
my $x = pdl([[1],[2],[3]]);
my $b = $A x $x;
print "$b\n";

$A = pdl([[1,2,3],[4,5,6],[7,8,10]]); # more interesting for pivoting in LU
$b = pdl([[1],[2],[3]]);
my $detA = determinant($A);
print "det(A)=$detA\n";

my $Ainv = inv($A); # matrix inverse of A
$x = $Ainv x $b; # solves Ax= b, not the way to go!
print "$x\n";

my ($LU,$perm,$p) = lu_decomp($A); # PA = LU
print "$LU,$perm,$p\n";
my $bt = transpose($b);
my $xt = lu_backsub($LU,$perm,$bt);
$x = transpose($xt); # better!
print "$x\n";

