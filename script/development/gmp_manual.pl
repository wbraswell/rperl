#!/usr/bin/perl

use Math::BigInt lib => 'GMP';


use RPerl::DataType::GMPInteger_cpp;
RPerl::DataType::GMPInteger_cpp::cpp_load();

use Data::Dumper;
print Dumper( \%main:: );

my $tmp1 = Math::BigInt->new(1234567890);
print 'in gmp_symtab_dump.pl, have gmp_integer__typetest0() = ' . "\n" . gmp_integer__typetest0() . "\n";

#print 'in gmp_symtab_dump.pl, have gi_to_i($tmp1->{value}) = ' . "\n" . gi_to_i($tmp1->{value}) . "\n";

#print 'in gmp_symtab_dump.pl, about to call gi_to_i($tmp1->{value})...' . "\n";
#print gi_to_i($tmp1->{value});
#print "\n";
#print 'in gmp_symtab_dump.pl, returned from call to gi_to_i($tmp1->{value})' . "\n";

#print 'in gmp_symtab_dump.pl, have gmp_integer_to_integer($tmp1->{value}) = ' . "\n" . gmp_integer_to_integer($tmp1->{value}) . "\n";

print "<<<============================>>>\n" x 5;

my $rop = Math::BigInt->new(0);
my $op  = Math::BigInt->new(-123456);
my $x   = 1103;

my_mul($rop, $op, $x);
print $rop, "\n";

my_mul($op, $op, 5);
print $op, "\n";

sub my_mul {
  _my_mul($_[0]->{value}, $_[1]->{value}, $_[2], $_[0]->{sign}, $_[1]->{sign});
}
