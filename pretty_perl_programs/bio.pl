#!/usr/bin/perl -w
use strict;

my $dna = random_dna(30);
print "random DNA strand  : $dna\n";

my $rna = $dna;
$rna =~ tr/T/U/;
print "DNA transcription  : $rna\n";

my $cdna = $dna;
$cdna =~ tr/ACGT/TGCA/;
print "complement DNA     : $cdna\n";
my $rcdna = reverse $cdna;
print "reverse complement : $rcdna\n";

my $protein1 = translation($dna);
print "protein translation: $protein1\n";

$dna = mutation($dna,10);
print "mutated DNA        : $dna\n";

my $protein2 = translation($dna);
print "protein translation: $protein2\n";

sub random_dna {
    my($length) = @_;
    my $dna = ();
    my @bases = 
      ('A', # Adenine
       'C', # Cytosine
       'G', # Guanine
       'T' # Thymine
      );
    for (my $n=1;$n<=$length;$n++) {
        $dna .= $bases[rand(@bases)];
    }
    return $dna;
}

sub mutation {
    my($dna,$mutations) = @_;
    my @bases = ('A','C','G','T');
    for (my $m=1;$m<=$mutations;$m++) {
        my $location = int(rand(length($dna)));
        my $oldbase = substr($dna,$location,1);
        my $newbase = $oldbase;
        while ($newbase eq $oldbase) {
            $newbase = $bases[rand(@bases)];
        }
        substr($dna,$location,1,$newbase);
    }
    return $dna;
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
