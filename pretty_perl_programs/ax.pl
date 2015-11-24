#!/usr/bin/perl -w
use strict;

print "full matrix multiplication\n";
my @A = ([2,-1,0],[-1,2,-1],[0,-1,2]);
my @x = ([1],[2],[3]);
#print "@A\n";
#for (@A) {print "@{$_}\n"};
my @y = matmul(\@A,\@x);
for my $row (@y) {print "@{$row}\n"};

# alternate matrix definition
my $B = [[2,-1,0],[-1,2,-1],[0,-1,2]];
for (@{$B}) {print "@{$_}\n"};

print "sparse matrix multiplication\n";
my %A = (0=>2,1=>-1,3=>-1,4=>2,5=>-1,7=>-1,8=>2);
my $ldimA = 3;
my %x = (0=>1,1=>2,2=>3);
my $ldimx = 3;
my %y = smatmul(\%A,\$ldimA,\%x,\$ldimx); # column-oriented
for (keys(%y)) {print "$_,$y{$_}\n";};

sub matdim { my $m = @_; my $n = @{$_[0]}; return ($m,$n); }

sub matmul { 
    my ($A,$B) = @_;
    my @A = @{$A}; my @B = @{$B};
    my ($m,$n) = matdim(@A); my ($p,$q) = matdim(@B); 
    die "dimensions do not match\n" unless ($n==$p); 
    my @C; 
    for my $i (0..$m-1) {
        for my $j (0..$q-1) {
            my $sum = 0;
            for my $k (0..$n-1) {
                $sum += $A[$i][$k] * $B[$k][$j]; 
            }
            $C[$i][$j] = $sum; 
        }
    }
    return @C;            
} 

sub smatmul { # assumes matrices are column-oriented, indexing starts at 0
    my ($A,$mA,$B,$mB) = @_; # get references
    my %A = %{$A}; my %B = %{$B}; # dereferencing
    $mA = ${$mA}; $mB = ${$mB}; # no need of my, already local 
    my %C;
    foreach my $kA (keys(%A)) { 
        my $iA = $kA%$mA;
        my $jA = ($kA-$iA)/$mA;
        foreach (keys(%B)) { 
            my $iB = $_%$mB;
            if ($jA==$iB) {
                my $jB = ($_-$iB)/$mB;
                my $kC = $iA+$mB*$jB;
                $C{$kC} += $A{$kA}*$B{$_};
            }
        }
    }
    return %C;            
} 
