#!/usr/bin/perl

#use rperlgmp;

use Math::BigInt lib => 'GMP';

use RPerl::DataType::GMPInteger_cpp;
RPerl::DataType::GMPInteger_cpp::cpp_load();

use Data::Dumper;
print Dumper( \%main:: );
die 'TMP DEBUG';

#print 'in gmp_symtab_dump.pl, have gmp_integer__typetest0() = ' . gmp_integer__typetest0() . "\n";
my gmp_integer $typetested = gmp_integer__typetest0();
#my gmp_integer $typetested = gmp_integer__typetest0(2112);
print 'in gmp_symtab_dump.pl, have Dumper($typetested) = ' . Dumper($typetested) . "\n";
print 'in gmp_symtab_dump.pl, have gmp_get_signed_integer($typetested) = ' . gmp_get_signed_integer($typetested) . "\n";

my integer $foo = 1234567890;

# METHOD D
#my gmp_integer $tmp3 = gmp_integer->new();
#gmp_set_signed_integer($tmp3, $foo);
#print 'in gmp_symtab_dump.pl, have METHOD D gmp_integer_to_integer($tmp3) = ' . gmp_integer_to_integer($tmp3) . "\n";

# METHOD C
#my RPerl::DataType::GMPInteger $tmp2 = RPerl::DataType::GMPInteger->new();
#gmp_set_signed_integer($tmp2, $foo);
#print 'in gmp_symtab_dump.pl, have METHOD C gmp_integer_to_integer($tmp2) = ' . gmp_integer_to_integer($tmp2) . "\n";

# METHOD B
my Math::BigInt $tmp1 = Math::BigInt->new();
$tmp1->bzero();
$tmp1->badd($foo);
print 'in gmp_symtab_dump.pl, have METHOD B gmp_integer_to_integer($tmp1) = ' . gmp_integer_to_integer($tmp1) . "\n";

# METHOD A
my Math::BigInt $tmp0 = Math::BigInt->new($foo);
print 'in gmp_symtab_dump.pl, have METHOD A gmp_integer_to_integer($tmp0) = ' . gmp_integer_to_integer($tmp0) . "\n";

# ERROR EMPV01
#print 'in gmp_symtab_dump.pl, have ERROR gmp_integer_to_integer(23) = ' . gmp_integer_to_integer(23) . "\n";

print "<<<============================>>>\n" x 1;

print 'in gmp_symtab_dump.pl, have Dumper($tmp3) = ' . Dumper($tmp3) . "\n";
print 'in gmp_symtab_dump.pl, have Dumper(integer_to_gmp_integer($foo)) = ' . Dumper(integer_to_gmp_integer($foo)) . "\n";
print 'in gmp_symtab_dump.pl, have gmp_get_signed_integer(integer_to_gmp_integer($foo)) = ' . gmp_get_signed_integer(integer_to_gmp_integer($foo)) . "\n";
print 'in gmp_symtab_dump.pl, have gmp_integer_to_integer(integer_to_gmp_integer($foo)) = ' . gmp_integer_to_integer(integer_to_gmp_integer($foo)) . "\n";

#print "<<<============================>>>\n" x 3;

#my $rop = Math::BigInt->new(0);
#my $op  = Math::BigInt->new(-123456);
#my $x   = 1103;

#gmp_mul_unsigned_integer($rop, $op, $x);
#print "\n" . $rop . "\n";
#print (-123456 * 1103);

#gmp_mul_unsigned_integer($op, $op, 5);
#print "\n" . $op . "\n";
#print (-123456 * 5);