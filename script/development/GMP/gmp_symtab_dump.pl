#!/usr/bin/env perl
use RPerl;
use strict;
use warnings;

#use RPerl::DataType::GMPInteger;

use RPerl::DataType::GMPInteger_cpp;
RPerl::DataType::GMPInteger_cpp::cpp_load();

use Data::Dumper;
print Dumper( \%main:: );
#print Dumper(\%RPerl::DataType::GMPInteger_cpp::);  # BOILERPLATE
#print Dumper(\%RPerl::DataType::GMPInteger::);  # EMPTY
#print Dumper(\%RPerl__DataType__GMPInteger::);  # EMPTY

#use rperlgmp;
#my gmp_integer $tmp1 = gmp_integer->new();
#gmp_init_set_unsigned_integer( $tmp1->{value}, 1234567890 );


use Math::BigInt lib => 'GMP';
my $tmp1 = Math::BigInt->new(1234567890);
print 'in gmp_symtab_dump.pl, have gmp_integer_typetest0() = ' . "\n" . gmp_integer_typetest0() . "\n";
print 'in gmp_symtab_dump.pl, have gmp_integer_to_integer($tmp1->{value}) = ' . "\n" . gmp_integer_to_integer($tmp1->{value}) . "\n";