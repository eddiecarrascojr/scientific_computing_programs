#!/usr/bin/perl -w
use strict;

my($gene,$dna,$str);

open(BDW,"<protein_sequence.txt");
while(<BDW>) {
    chomp;
    $str = join("",split(" ",$_));
    $gene .= $str;
}
$gene .= '_';
close(BDW);
print length($gene),"\n";
#$gene =~ s/[ \n]//g;

open(BDW,"<dna_sequence.txt");
while(<BDW>) {
    chomp;
    $str = join("",split(" ",$_));
    $str =~ s/[0-9]//g;
    $dna .= $str;
}
close(BDW);
$dna =~ tr/acgt/ACGT/;
print length($dna),"\n";

for (my $frame=0;$frame<=2;$frame++) {
    my $fdna = substr($dna,$frame);
    my $rna = $fdna; $rna =~ tr/T/U/;
    my $protein = translation($fdna);
    my @match = ();
    while( $protein =~ /$gene/g ) { 
        my $begin = 3*length($`)+1+$frame; 
        my $end = $begin+3*length($&)-1; 
        push(@match,"$begin..$end"); 
    }
    if (@match) 
        { print "frame $frame: match at @match\n"; } 
    else 
        { print "frame $frame: no match\n"; }
}
$dna =~ tr/ACGT/TGCA/;
$dna = reverse $dna;
for (my $frame=0;$frame<=2;$frame++) {
    my $fdna = substr($dna,$frame);
    my $rna = $fdna; $rna =~ tr/T/U/;
    my $protein = translation($fdna);
    my @match = ();
    while( $protein =~ /$gene/g ) { 
        my $end = length($dna)-3*length($`)-$frame; 
        my $begin = $end-3*length($&)+1; 
        push(@match,"$begin..$end"); 
    }
    if (@match) 
        { print "frame ",$frame+3,": match at @match\n"; } 
    else 
        { print "frame ",$frame+3,": no match\n"; }
}

sub translation {
    my($dna) = @_;
    my $rna = $dna; $rna =~ tr/T/U/;
    my $protein;
    my %code = genetic_code();
    for (my $c=0;$c<length($rna);$c+=3) {
        my $codon = substr($rna,$c,3);
        if (length($codon)==3) { $protein .= $code{$codon}; }
    }
    return $protein;
} 

sub genetic_code {
    my %code = (
        'GCA' => 'A', 'GCC' => 'A', 'GCG' => 'A', 'GCU' => 'A', # Alanine
        'UGC' => 'C', 'UGU' => 'C', # Cysteine
        'GAC' => 'D', 'GAU' => 'D', # Aspartic acid
        'GAA' => 'E', 'GAG' => 'E', # Glutamic acid
        'UUC' => 'F', 'UUU' => 'F', # Phenylalanine
        'GGA' => 'G', 'GGC' => 'G', 'GGG' => 'G', 'GGU' => 'G', # Glycine
        'CAC' => 'H', 'CAU' => 'H', # Histidine
        'AUA' => 'I', 'AUC' => 'I', 'AUU' => 'I', # Isoleucine
        'AAA' => 'K', 'AAG' => 'K', # Lysine
        'CUA' => 'L', 'CUC' => 'L', 'CUG' => 'L', 'CUU' => 'L', 
                                    'UUA' => 'L', 'UUG' => 'L', # Leucine
        'AUG' => 'M', # Methionine
        'AAC' => 'N', 'AAU' => 'N', # Asparagine
        'CCA' => 'P', 'CCC' => 'P', 'CCG' => 'P', 'CCU' => 'P', # Proline
        'CAA' => 'Q', 'CAG' => 'Q', # Glutamine
        'CGA' => 'R', 'CGC' => 'R', 'CGG' => 'R', 'CGU' => 'R',
                                    'AGA' => 'R', 'AGG' => 'R', # Arginine
        'UCA' => 'S', 'UCC' => 'S', 'UCG' => 'S', 'UCU' => 'S',
                                    'AGC' => 'S', 'AGU' => 'S', # Serine
        'ACA' => 'T', 'ACC' => 'T', 'ACG' => 'T', 'ACU' => 'T', # Threonine
        'GUA' => 'V', 'GUC' => 'V', 'GUG' => 'V', 'GUU' => 'V', # Valine
        'UGG' => 'W', # Tryptophan
        'UAC' => 'Y', 'UAU' => 'Y', # Tyrosine
        'UAA' => '_', 'UAG' => '_', 'UGA' => '_' # not encoded
    ); 
    return %code;
}
