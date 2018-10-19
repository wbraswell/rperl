#!/usr/bin/env perl

use B::Deparse ();

my $deparse = B::Deparse->new;

use rperlgsl;

#my $code = \&gsl_matrix_rows;
my $code = \&RPerl::Operation::Expression::Operator::GSLFunctions::gsl_matrix_rows;

print 'sub ', $deparse->coderef2text($code), "\n";
