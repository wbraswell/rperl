# [[[ HEADER ]]]
package RPerl::Operation::Expression::Operator::GMPFunctions;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.004_000;

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
our @EXPORT = qw(
    gmp_init gmp_init_set_unsigned_integer gmp_init_set_signed_integer
    gmp_set gmp_set_unsigned_integer gmp_set_signed_integer gmp_set_number gmp_set_string
    gmp_get_unsigned_integer gmp_get_signed_integer gmp_get_number gmp_get_string
    gmp_add gmp_sub gmp_mul gmp_mul_unsigned_integer gmp_mul_signed_integer gmp_sub_mul_unsigned_integer gmp_add_mul_unsigned_integer gmp_neg
    gmp_div_truncate_quotient
    gmp_cmp
);

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

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

# void mpz_init_set_si (mpz_t rop, signed long int op)
#our void $gmp_init_set_signed_integer = sub {
sub gmp_init_set_signed_integer {
    ( my gmp_integer $rop, my integer $op ) = @_;
    $rop->bzero();
    $rop->badd($op);
}

# [[[ ASSIGNMENT FUNCTIONS ]]]

# void mpz_set (mpz_t rop, const mpz_t op)
#our void $gmp_set = sub {
sub gmp_set {
    ( my gmp_integer $rop, my gmp_integer $op ) = @_;
    $rop->bzero();
    $rop->badd($op);
}

# void mpz_set_ui (mpz_t rop, unsigned long int op)
#our void $gmp_set_unsigned_integer = sub {
sub gmp_set_unsigned_integer {
    ( my gmp_integer $rop, my unsigned_integer $op ) = @_;
    $rop->bzero();
    $rop->badd($op);
}

# void mpz_set_si (mpz_t rop, signed long int op)
#our void $gmp_set_signed_integer = sub {
sub gmp_set_signed_integer {
    ( my gmp_integer $rop, my integer $op ) = @_;
    $rop->bzero();
    $rop->badd($op);
}

# void mpz_set_d (mpz_t rop, double op)
#our void $gmp_set_number = sub {
sub gmp_set_number {
    ( my gmp_integer $rop, my number $op ) = @_;
    $rop->bzero();
    $rop->badd($op);
}

# int mpz_set_str (mpz_t rop, const char *str, int base)
#our integer $gmp_set_string = sub {
sub gmp_set_string {
    ( my gmp_integer $rop, my string $str ) = @_;
    my Math::BigInt $tmp = Math::BigInt->new($str); 
    $rop->bzero();
    $rop->badd($tmp);
}

# [[[ CONVERSION FUNCTIONS ]]]

# unsigned long int mpz_get_ui (const mpz_t op)
#our unsigned_integer $gmp_get_unsigned_integer = sub {
sub gmp_get_unsigned_integer {
    ( my gmp_integer $op ) = @_;
    return $op->numify();
}

# signed long int mpz_get_si (const mpz_t op)
#our integer $gmp_get_signed_integer = sub {
sub gmp_get_signed_integer {
    ( my gmp_integer $op ) = @_;
    return $op->numify();
}

# double mpz_get_d (const mpz_t op)
#our integer $gmp_get_number = sub {
sub gmp_get_number {
    ( my gmp_integer $op ) = @_;
    return $op->numify();
}

# char * mpz_get_str (char *str, int base, const mpz_t op)
#our string $gmp_get_string = sub {
sub gmp_get_string {
    ( my gmp_integer $op ) = @_;
    return $op->bstr();
}

# [[[ ARITHMETIC FUNCTIONS ]]]

# void mpz_add (mpz_t rop, const mpz_t op1, const mpz_t op2)
#our gmp_integer $gmp_add = sub {
sub gmp_add {
    ( my gmp_integer $rop, my gmp_integer $op1, my gmp_integer $op2 ) = @_;
    # in case $op1 and/or $op2 are the same variables as $rop, make copies so you don't zero them out before reading them
    my gmp_integer $op1_copy = $op1->copy();
    my gmp_integer $op2_copy = $op2->copy();
    $rop->bzero();
    $rop->badd($op1_copy);
    $rop->badd($op2_copy);
}

# void mpz_sub (mpz_t rop, const mpz_t op1, const mpz_t op2)
#our gmp_integer $gmp_sub = sub {
sub gmp_sub {
    ( my gmp_integer $rop, my gmp_integer $op1, my gmp_integer $op2 ) = @_;
    my gmp_integer $op1_copy = $op1->copy();
    my gmp_integer $op2_copy = $op2->copy();
    $rop->bzero();
    $rop->badd($op1_copy);
    $rop->bsub($op2_copy);
}

# void mpz_mul (mpz_t rop, const mpz_t op1, const mpz_t op2)
#our void $gmp_mul = sub {
sub gmp_mul {
    ( my gmp_integer $rop, my gmp_integer $op1, my gmp_integer $op2 ) = @_;
    my gmp_integer $op1_copy = $op1->copy();
    $rop->bzero();
    $rop->badd($op1_copy);
    $rop->bmul($op2);
}

# void mpz_mul_ui (mpz_t rop, const mpz_t op1, unsigned long int op2)
#our void $gmp_mul_unsigned_integer = sub {
sub gmp_mul_unsigned_integer {
    ( my gmp_integer $rop, my gmp_integer $op1, my unsigned_integer $op2 ) = @_;
    my gmp_integer $op1_copy = $op1->copy();
    $rop->bzero();
    $rop->badd($op1_copy);
    $rop->bmul($op2);
}

# void mpz_mul_si (mpz_t rop, const mpz_t op1, long int op2)
#our void $gmp_mul_signed_integer = sub {
sub gmp_mul_signed_integer {
    ( my gmp_integer $rop, my gmp_integer $op1, my integer $op2 ) = @_;
    my gmp_integer $op1_copy = $op1->copy();
    $rop->bzero();
    $rop->badd($op1_copy);
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

# void mpz_neg (mpz_t rop, const mpz_t op)
#our void $gmp_neg = sub {
sub gmp_neg {
    ( my gmp_integer $rop, my gmp_integer $op1 ) = @_;
    my gmp_integer $op1_copy = $op1->copy();
    $rop->bzero();
    $rop->badd($op1_copy);
    $rop->bmul(Math::BigInt->bone('-'));
}

# [[[ DIVISION FUNCTIONS ]]]

# void mpz_tdiv_q (mpz_t q, const mpz_t n, const mpz_t d)
#our void $gmp_div_truncate_quotient = sub {
sub gmp_div_truncate_quotient {
    ( my gmp_integer $q, my gmp_integer $n, my gmp_integer $d ) = @_;
    my gmp_integer $n_copy = $n->copy();
    my gmp_integer $d_copy = $d->copy();
    $q->bzero();
    $q->badd($n_copy);
    $q->bdiv($d_copy);
}

# [[[ COMPARISON FUNCTIONS ]]]

# int mpz_cmp (const mpz_t op1, const mpz_t op2)
#our integer $gmp_cmp = sub {
sub gmp_cmp {
    ( my gmp_integer $op1, my gmp_integer $op2 ) = @_;
    return $op1->bcmp($op2);
}

1;    # end of class
