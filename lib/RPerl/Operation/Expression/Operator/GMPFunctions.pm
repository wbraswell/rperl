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
use RPerl::Exporter 'import';
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
sub gmp_init {
    { my void $RETURN_TYPE };
#    ( my gmp_integer $x ) = @ARG;
    return;
}

# [[[ COMBINED INITIALIZATION AND ASSIGNMENT FUNCTIONS ]]]

# void mpz_init_set_ui (mpz_t rop, unsigned long int op)
sub gmp_init_set_unsigned_integer {
    { my void $RETURN_TYPE };
    ( my gmp_integer $rop, my unsigned_integer $op ) = @ARG;
    $rop->bzero();
    $rop->badd($op);
    return;
}

# void mpz_init_set_si (mpz_t rop, signed long int op)
sub gmp_init_set_signed_integer {
    { my void $RETURN_TYPE };
    ( my gmp_integer $rop, my integer $op ) = @ARG;
    $rop->bzero();
    $rop->badd($op);
    return;
}

# [[[ ASSIGNMENT FUNCTIONS ]]]

# void mpz_set (mpz_t rop, const mpz_t op)
sub gmp_set {
    { my void $RETURN_TYPE };
    ( my gmp_integer $rop, my gmp_integer $op ) = @ARG;
    $rop->bzero();
    $rop->badd($op);
    return;
}

# void mpz_set_ui (mpz_t rop, unsigned long int op)
sub gmp_set_unsigned_integer {
    { my void $RETURN_TYPE };
    ( my gmp_integer $rop, my unsigned_integer $op ) = @ARG;
    $rop->bzero();
    $rop->badd($op);
    return;
}

# void mpz_set_si (mpz_t rop, signed long int op)
sub gmp_set_signed_integer {
    { my void $RETURN_TYPE };
    ( my gmp_integer $rop, my integer $op ) = @ARG;
    $rop->bzero();
    $rop->badd($op);
    return;
}

# void mpz_set_d (mpz_t rop, double op)
sub gmp_set_number {
    { my void $RETURN_TYPE };
    ( my gmp_integer $rop, my number $op ) = @ARG;
    $rop->bzero();
    $rop->badd($op);
    return;
}

# int mpz_set_str (mpz_t rop, const char *str, int base)
sub gmp_set_string {
    { my integer $RETURN_TYPE };
    ( my gmp_integer $rop, my string $str ) = @ARG;
    my Math::BigInt $tmp = Math::BigInt->new($str); 
    $rop->bzero();
    $rop->badd($tmp);
    return;
}

# [[[ CONVERSION FUNCTIONS ]]]

# unsigned long int mpz_get_ui (const mpz_t op)
sub gmp_get_unsigned_integer {
    { my unsigned_integer $RETURN_TYPE };
    ( my gmp_integer $op ) = @ARG;
    return $op->numify();
}

# signed long int mpz_get_si (const mpz_t op)
sub gmp_get_signed_integer {
    { my integer $RETURN_TYPE };
    ( my gmp_integer $op ) = @ARG;
    return $op->numify();
}

# double mpz_get_d (const mpz_t op)
sub gmp_get_number {
    { my integer $RETURN_TYPE };
    ( my gmp_integer $op ) = @ARG;
    return $op->numify();
}

# char * mpz_get_str (char *str, int base, const mpz_t op)
sub gmp_get_string {
    { my string $RETURN_TYPE };
    ( my gmp_integer $op ) = @ARG;
    return $op->bstr();
}

# [[[ ARITHMETIC FUNCTIONS ]]]

# void mpz_add (mpz_t rop, const mpz_t op1, const mpz_t op2)
sub gmp_add {
    { my gmp_integer $RETURN_TYPE };
    ( my gmp_integer $rop, my gmp_integer $op1, my gmp_integer $op2 ) = @ARG;
    # in case $op1 and/or $op2 are the same variables as $rop, make copies so you don't zero them out before reading them
    my gmp_integer $op1_copy = $op1->copy();
    my gmp_integer $op2_copy = $op2->copy();
    $rop->bzero();
    $rop->badd($op1_copy);
    $rop->badd($op2_copy);
    return;
}

# void mpz_sub (mpz_t rop, const mpz_t op1, const mpz_t op2)
sub gmp_sub {
    { my gmp_integer $RETURN_TYPE };
    ( my gmp_integer $rop, my gmp_integer $op1, my gmp_integer $op2 ) = @ARG;
    my gmp_integer $op1_copy = $op1->copy();
    my gmp_integer $op2_copy = $op2->copy();
    $rop->bzero();
    $rop->badd($op1_copy);
    $rop->bsub($op2_copy);
    return;
}

# void mpz_mul (mpz_t rop, const mpz_t op1, const mpz_t op2)
sub gmp_mul {
    { my void $RETURN_TYPE };
    ( my gmp_integer $rop, my gmp_integer $op1, my gmp_integer $op2 ) = @ARG;
    my gmp_integer $op1_copy = $op1->copy();
    $rop->bzero();
    $rop->badd($op1_copy);
    $rop->bmul($op2);
    return;
}

# void mpz_mul_ui (mpz_t rop, const mpz_t op1, unsigned long int op2)
sub gmp_mul_unsigned_integer {
    { my void $RETURN_TYPE };
    ( my gmp_integer $rop, my gmp_integer $op1, my unsigned_integer $op2 ) = @ARG;
    my gmp_integer $op1_copy = $op1->copy();
    $rop->bzero();
    $rop->badd($op1_copy);
    $rop->bmul($op2);
    return;
}

# void mpz_mul_si (mpz_t rop, const mpz_t op1, long int op2)
sub gmp_mul_signed_integer {
    { my void $RETURN_TYPE };
    ( my gmp_integer $rop, my gmp_integer $op1, my integer $op2 ) = @ARG;
    my gmp_integer $op1_copy = $op1->copy();
    $rop->bzero();
    $rop->badd($op1_copy);
    $rop->bmul($op2);
    return;
}

# void mpz_submul_ui (mpz_t rop, const mpz_t op1, unsigned long int op2)
sub gmp_sub_mul_unsigned_integer {
    { my gmp_integer $RETURN_TYPE };
    ( my gmp_integer $rop, my gmp_integer $op1, my unsigned_integer $op2 ) = @ARG;
    my gmp_integer $op1_copy = $op1->copy();
    $op1_copy->bmul($op2);
    $rop->bsub($op1_copy);
    return;
}

# void mpz_addmul_ui (mpz_t rop, const mpz_t op1, unsigned long int op2)
sub gmp_add_mul_unsigned_integer {
    { my void $RETURN_TYPE };
    ( my gmp_integer $rop, my gmp_integer $op1, my unsigned_integer $op2 ) = @ARG;
    my gmp_integer $op1_copy = $op1->copy();
    $op1_copy->bmul($op2);
    $rop->badd($op1_copy);
    return;
}

# void mpz_neg (mpz_t rop, const mpz_t op)
sub gmp_neg {
    { my void $RETURN_TYPE };
    ( my gmp_integer $rop, my gmp_integer $op1 ) = @ARG;
    my gmp_integer $op1_copy = $op1->copy();
    $rop->bzero();
    $rop->badd($op1_copy);
    $rop->bmul(Math::BigInt->bone('-'));
    return;
}

# [[[ DIVISION FUNCTIONS ]]]

# void mpz_tdiv_q (mpz_t q, const mpz_t n, const mpz_t d)
sub gmp_div_truncate_quotient {
    { my void $RETURN_TYPE };
    ( my gmp_integer $q, my gmp_integer $n, my gmp_integer $d ) = @ARG;
    my gmp_integer $n_copy = $n->copy();
    my gmp_integer $d_copy = $d->copy();
    $q->bzero();
    $q->badd($n_copy);
    $q->bdiv($d_copy);
    return;
}

# [[[ COMPARISON FUNCTIONS ]]]

# int mpz_cmp (const mpz_t op1, const mpz_t op2)
sub gmp_cmp {
    { my integer $RETURN_TYPE };
    ( my gmp_integer $op1, my gmp_integer $op2 ) = @ARG;
    return $op1->bcmp($op2);
}

1;    # end of class
