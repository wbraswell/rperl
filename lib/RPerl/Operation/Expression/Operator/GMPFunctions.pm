# [[[ HEADER ]]]
package RPerl::Operation::Expression::Operator::GMPFunctions;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::Operator);
use RPerl::Operation::Expression::Operator;

#use Exporter 'import';
#our @EXPORT = qw(NEED_FILL);  # NEED ADDRESS: should we be exporting anything?

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

# NEED FIX: create const_gmp_integer type or not???

# void mpz_mul_ui (mpz_t rop, const mpz_t op1, unsigned long int op2)
#our void $gmp_mul_unsigned_integer = sub {
sub gmp_mul_unsigned_integer {
    ( my gmp_integer $rop, my gmp_integer $op1, my unsigned_integer $op2 ) = @_;
    # ...
    return;
}

# void mpz_add (mpz_t rop, const mpz_t op1, const mpz_t op2)
#our gmp_integer $gmp_add = sub {
sub gmp_add {
    ( my gmp_integer $rop, my gmp_integer $op1, my gmp_integer $op2 ) = @_;
    # ...
    return -1;
}

# void mpz_tdiv_q (mpz_t q, const mpz_t n, const mpz_t d)
#our void $gmp_div_truncate_quotient = sub {
sub gmp_div_truncate_quotient {
    ( my gmp_integer $q, my gmp_integer $n, my gmp_integer $d ) = @_;
    # ...
    return -1;
}

# unsigned long int mpz_get_ui (const mpz_t op)
#our unsigned_integer $gmp_get_unsigned_integer = sub {
sub gmp_get_unsigned_integer {
    ( my gmp_integer $op ) = @_;
    # ...
    return -1;
}

# void mpz_submul_ui (mpz_t rop, const mpz_t op1, unsigned long int op2)
#our gmp_integer $gmp_sub_mul_unsigned_integer = sub {
sub gmp_sub_mul_unsigned_integer {
    ( my gmp_integer $rop, my gmp_integer $op1, my unsigned_integer $op2 ) = @_;
    # ...
    return -1;
}

# void mpz_addmul_ui (mpz_t rop, const mpz_t op1, unsigned long int op2)
#our void $gmp_add_mul_unsigned_integer = sub {
sub gmp_add_mul_unsigned_integer {
    ( my gmp_integer $rop, my gmp_integer $op1, my unsigned_integer $op2 ) = @_;
    # ...
    return -1;
}

# void mpz_init (mpz_t x)
#our void $gmp_init = sub {
sub gmp_init {
    ( my gmp_integer $x ) = @_;
    # ...
    return -1;
}

# void mpz_init_set_ui (mpz_t rop, unsigned long int op)
#our void $gmp_init_set_unsigned_integer = sub {
sub gmp_init_set_unsigned_integer {
    ( my gmp_integer $rop, my unsigned_integer $op ) = @_;
    # ...
    return -1;
}

# int mpz_cmp (const mpz_t op1, const mpz_t op2)
#our integer $gmp_cmp = sub {
sub gmp_cmp {
    ( my gmp_integer $op1, my gmp_integer $op2 ) = @_;
    # ...
    return -1;
}

1;    # end of class
