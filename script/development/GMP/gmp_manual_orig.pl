#!/usr/bin/env perl

use Math::BigInt lib => 'GMP';

use Inline C => Config =>
    LIBS => '-lgmp',
    USING => 'ParseRegExp',
    BUILD_NOISY => 1;


use Inline C => <<'EOC';

#include <gmp.h>

mpz_t * mpz_from_sv_nofail (SV *sv)
{
  MAGIC *mg;

  if (!sv_derived_from(sv, "Math::BigInt::GMP"))
    croak("not of type Math::BigInt::GMP");

  mg = SvMAGIC(SvRV(sv));

  return (mpz_t *)mg->mg_ptr;
}

void _my_mul(SV * bi_rop, SV * bi_op, SV * si, SV * rop_sign, SV * op_sign) {
     mpz_t *t1, *t2;

     sv_setpv(rop_sign, SvPV_nolen(op_sign));

     t1 = mpz_from_sv_nofail(bi_rop);
     t2 = mpz_from_sv_nofail(bi_op);

     mpz_abs(*t2, *t2);
     mpz_mul_si(*t1, *t2, abs(SvIV(si)));

     if(SvIV(si) < 0) {
       if(strEQ(SvPV_nolen(op_sign), "-")) sv_setpv(rop_sign, "+");
       else sv_setpv(rop_sign, "-");
     }
}

EOC

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
