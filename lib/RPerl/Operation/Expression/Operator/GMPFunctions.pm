# [[[ HEADER ]]]
package RPerl::Operation::Expression::Operator::GMPFunctions;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::Operator);
use RPerl::Operation::Expression::Operator;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::DataType::GMPInteger;
use Math::BigInt lib => 'GMP';  # we still actually use GMP in PERLOPS_PERLTYPES mode, albeit indirectly via Math::BigInt::GMP
use Exporter 'import';
our @EXPORT = qw(gmp_init gmp_init_set_unsigned_integer gmp_get_unsigned_integer gmp_add gmp_mul_unsigned_integer gmp_sub_mul_unsigned_integer gmp_add_mul_unsigned_integer gmp_div_truncate_quotient gmp_cmp);

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# START HERE: get this PERLOPS_PERLTYPES code working, implement gmp_integer type conversion subs
# START HERE: get this PERLOPS_PERLTYPES code working, implement gmp_integer type conversion subs
# START HERE: get this PERLOPS_PERLTYPES code working, implement gmp_integer type conversion subs

# [[[ OO METHODS & SUBROUTINES ]]]

# [[[ INITIALIZATION FUNCTIONS ]]]

# void mpz_init (mpz_t x)
#our void $gmp_init = sub {
sub gmp_init {
#    ( my gmp_integer $x ) = @_;
}

# [[[ COMBINED INITIALIZATION AND ASSIGNMENT FUNCTIONS ]]]

# void mpz_init_set_ui (mpz_t rop, unsigned long int op)
#our void $gmp_init_set_unsigned_integer = sub {
sub gmp_init_set_unsigned_integer {
    ( my gmp_integer $rop, my unsigned_integer $op ) = @_;
    $rop->bzero();
    $rop->badd($op);
}

# [[[ CONVERSION FUNCTIONS ]]]

# unsigned long int mpz_get_ui (const mpz_t op)
#our unsigned_integer $gmp_get_unsigned_integer = sub {
sub gmp_get_unsigned_integer {
    ( my gmp_integer $op ) = @_;
    return $op->numify();
}

# [[[ ARITHMETIC FUNCTIONS ]]]

# void mpz_add (mpz_t rop, const mpz_t op1, const mpz_t op2)
#our gmp_integer $gmp_add = sub {
sub gmp_add {
    ( my gmp_integer $rop, my gmp_integer $op1, my gmp_integer $op2 ) = @_;
    $rop = $op1->copy();
    $rop->badd($op2);
}

# void mpz_mul_ui (mpz_t rop, const mpz_t op1, unsigned long int op2)
#our void $gmp_mul_unsigned_integer = sub {
sub gmp_mul_unsigned_integer {
    ( my gmp_integer $rop, my gmp_integer $op1, my unsigned_integer $op2 ) = @_;
    $rop = $op1->copy();
    $rop->bmul($op2);
}

# void mpz_submul_ui (mpz_t rop, const mpz_t op1, unsigned long int op2)
#our gmp_integer $gmp_sub_mul_unsigned_integer = sub {
sub gmp_sub_mul_unsigned_integer {
    ( my gmp_integer $rop, my gmp_integer $op1, my unsigned_integer $op2 ) = @_;
    my gmp_integer $op1_copy = $op1->copy();
    $op1_copy->bmul($op2);
    $rop->bsub($op1_copy);
}

# void mpz_addmul_ui (mpz_t rop, const mpz_t op1, unsigned long int op2)
#our void $gmp_add_mul_unsigned_integer = sub {
sub gmp_add_mul_unsigned_integer {
    ( my gmp_integer $rop, my gmp_integer $op1, my unsigned_integer $op2 ) = @_;
    my gmp_integer $op1_copy = $op1->copy();
    $op1_copy->bmul($op2);
    $rop->badd($op1_copy);
}

# [[[ DIVISION FUNCTIONS ]]]

# void mpz_tdiv_q (mpz_t q, const mpz_t n, const mpz_t d)
#our void $gmp_div_truncate_quotient = sub {
sub gmp_div_truncate_quotient {
    ( my gmp_integer $q, my gmp_integer $n, my gmp_integer $d ) = @_;
    $q = $n->copy();
    $q->bdiv($d);
}

# [[[ COMPARISON FUNCTIONS ]]]

# int mpz_cmp (const mpz_t op1, const mpz_t op2)
#our integer $gmp_cmp = sub {
sub gmp_cmp {
    ( my gmp_integer $op1, my gmp_integer $op2 ) = @_;
    return $op1->bcmp($op2);
}

1;    # end of class
