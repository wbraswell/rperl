#!/usr/bin/perl

use rperlgmp;

use Math::BigInt lib => 'GMP';

use RPerl::DataType::GMPInteger_cpp;
RPerl::DataType::GMPInteger_cpp::cpp_load();

use Data::Dumper;
print Dumper( \%main:: );

# METHOD A
#my $tmp1 = Math::BigInt->new(1234567890);

# METHOD B
#my $tmp1 = Math::BigInt->new();
#$tmp1->bzero();
#$tmp1->badd(1234567890);

# METHOD C
my RPerl::DataType::GMPInteger $tmp1 = RPerl::DataType::GMPInteger->new();
gmp_set_signed_integer($tmp1, 1234567890);

print 'in gmp_symtab_dump.pl, have gmp_integer__typetest0() = ' . "\n" . gmp_integer__typetest0() . "\n";
print 'in gmp_symtab_dump.pl, have gmp_integer_to_integer($tmp1) = ' . "\n" . gmp_integer_to_integer($tmp1) . "\n";

print "<<<============================>>>\n" x 5;

my $rop = Math::BigInt->new(0);
my $op  = Math::BigInt->new(-123456);
my $x   = 1103;

gmp_mul_unsigned_integer($rop, $op, $x);
print $rop, "\n";

gmp_mul_unsigned_integer($op, $op, 5);
print $op, "\n";