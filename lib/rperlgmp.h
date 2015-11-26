#ifndef __CPP__INCLUDED__rperlgmp_h
#define __CPP__INCLUDED__rperlgmp_h 0.001_000

typedef mpz_t gmp_integer;

// ARITHMETIC FUNCTIONS
// https://gmplib.org/manual/Integer-Arithmetic.html

#define mpz_add        gmp_add
#define mpz_add_ui     gmp_add_unsigned_integer
#define mpz_sub        gmp_sub
#define mpz_sub_ui     gmp_sub_unsigned_integer
#define mpz_ui_sub     gmp_unsigned_integer_sub
#define mpz_mul        gmp_mul
#define mpz_mul_si     gmp_mul_signed_integer
#define mpz_mul_ui     gmp_mul_unsigned_integer
#define mpz_addmul     gmp_add_mul
#define mpz_addmul_ui  gmp_add_mul_unsigned_integer
#define mpz_submul     gmp_sub_mul
#define mpz_submul_ui  gmp_sub_mul_unsigned_integer
#define mpz_mul_2exp   gmp_mul_power_of_2
#define mpz_neg        gmp_neg
#define mpz_abs        gmp_abs

// START HERE: comparison functions, getting, setting, init
// START HERE: comparison functions, getting, setting, init
// START HERE: comparison functions, getting, setting, init

// DIVISION FUNCTIONS
// https://gmplib.org/manual/Integer-Division.html

#define mpz_cdiv_q            gmp_div_ceiling_quotient
#define mpz_cdiv_r            gmp_div_ceiling_remainder
#define mpz_cdiv_qr           gmp_div_ceiling_quotient_remainder
#define mpz_cdiv_q_ui         gmp_div_ceiling_quotient_unsigned_integer
#define mpz_cdiv_r_ui         gmp_div_ceiling_remainder_unsigned_integer
#define mpz_cdiv_qr_ui        gmp_div_ceiling_quotient_remainder_unsigned_integer
#define mpz_cdiv_ui           gmp_div_ceiling_unsigned_integer
#define mpz_cdiv_q_2exp       gmp_div_ceiling_quotient_power_of_2
#define mpz_cdiv_r_2exp       gmp_div_ceiling_remainder_power_of_2
#define mpz_fdiv_q            gmp_div_floor_quotient
#define mpz_fdiv_r            gmp_div_floor_remainder
#define mpz_fdiv_qr           gmp_div_floor_quotient_remainder
#define mpz_fdiv_q_ui         gmp_div_floor_quotient_unsigned_integer
#define mpz_fdiv_r_ui         gmp_div_floor_remainder_unsigned_integer
#define mpz_fdiv_qr_ui        gmp_div_floor_quotient_remainder_unsigned_integer
#define mpz_fdiv_ui           gmp_div_floor_unsigned_integer
#define mpz_fdiv_q_2exp       gmp_div_floor_quotient_power_of_2
#define mpz_fdiv_r_2exp       gmp_div_floor_remainder_power_of_2
#define mpz_tdiv_q            gmp_div_truncate_quotient
#define mpz_tdiv_r            gmp_div_truncate_remainder
#define mpz_tdiv_qr           gmp_div_truncate_quotient_remainder
#define mpz_tdiv_q_ui         gmp_div_truncate_quotient_unsigned_integer
#define mpz_tdiv_r_ui         gmp_div_truncate_remainder_unsigned_integer
#define mpz_tdiv_qr_ui        gmp_div_truncate_quotient_remainder_unsigned_integer
#define mpz_tdiv_ui           gmp_div_truncate_unsigned_integer
#define mpz_tdiv_q_2exp       gmp_div_truncate_quotient_power_of_2
#define mpz_tdiv_r_2exp       gmp_div_truncate_remainder_power_of_2
#define mpz_mod               gmp_mod
#define mpz_mod_ui            gmp_mod_unsigned_integer
#define mpz_divexact          gmp_div_exact
#define mpz_divexact_ui       gmp_div_exact_unsigned_integer
#define mpz_divisible_p       gmp_divisible
#define mpz_divisible_ui_p    gmp_divisible_unsigned_integer
#define mpz_divisible_2exp_p  gmp_divisible_power_of_2
#define mpz_congruent_p       gmp_congruent
#define mpz_congruent_ui_p    gmp_congruent_unsigned_integer
#define mpz_congruent_2exp_p  gmp_congruent_power_of_2








#endif
