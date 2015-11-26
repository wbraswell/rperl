#ifndef __CPP__INCLUDED__rperlgmp_h
#define __CPP__INCLUDED__rperlgmp_h 0.002_000

typedef mpz_t                 gmp_integer;
typedef unsigned_integer      long unsigned int;

// INITIALIZATION FUNCTIONS
// https://gmplib.org/manual/Initializing-Integers.html

#define mpz_init              gmp_init
#define mpz_inits             gmp_inits
#define mpz_init2             gmp_init_bitcount
#define mpz_clear             gmp_clear
#define mpz_clears            gmp_clear
#define mpz_realloc2          gmp_reallocate_bitcount

// ASSIGNMENT FUNCTIONS
// https://gmplib.org/manual/Assigning-Integers.html

#define mpz_set               gmp_set
#define mpz_set_ui            gmp_set_unsigned_integer
#define mpz_set_si            gmp_set_signed_integer
#define mpz_set_d             gmp_set_number
#define mpz_set_str           gmp_set_string
#define mpz_set_q             gmp_set_gmp_rational
#define mpz_set_f             gmp_set_gmp_float
#define mpz_swap              gmp_swap

// COMBINED INITIALIZATION AND ASSIGNMENT FUNCTIONS
// https://gmplib.org/manual/Simultaneous-Integer-Init-_0026-Assign.html

#define mpz_init_set          gmp_init_set
#define mpz_init_set_ui       gmp_init_set_unsigned_integer
#define mpz_init_set_si       gmp_init_set_signed_integer
#define mpz_init_set_d        gmp_init_set_number
#define mpz_init_set_str      gmp_init_set_string

// CONVERSION FUNCTIONS
// https://gmplib.org/manual/Converting-Integers.html

#define mpz_get_ui            gmp_get_unsigned_integer
#define mpz_get_si            gmp_get_signed_integer
#define mpz_get_d             gmp_get_number
#define mpz_get_d_2exp        gmp_get_number_power_of_2
#define mpz_get_str           gmp_get_string

// ARITHMETIC FUNCTIONS
// https://gmplib.org/manual/Integer-Arithmetic.html

#define mpz_add               gmp_add
#define mpz_add_ui            gmp_add_unsigned_integer
#define mpz_sub               gmp_sub
#define mpz_sub_ui            gmp_sub_unsigned_integer
#define mpz_ui_sub            gmp_unsigned_integer_sub
#define mpz_mul               gmp_mul
#define mpz_mul_si            gmp_mul_signed_integer
#define mpz_mul_ui            gmp_mul_unsigned_integer
#define mpz_addmul            gmp_add_mul
#define mpz_addmul_ui         gmp_add_mul_unsigned_integer
#define mpz_submul            gmp_sub_mul
#define mpz_submul_ui         gmp_sub_mul_unsigned_integer
#define mpz_mul_2exp          gmp_mul_power_of_2
#define mpz_neg               gmp_neg
#define mpz_abs               gmp_abs

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

// EXPONENTIATION FUNCTIONS
// https://gmplib.org/manual/Integer-Exponentiation.html

#define mpz_powm              gmp_pow_mod
#define mpz_powm_ui           gmp_pow_mod_unsigned_integer
#define mpz_powm_sec          gmp_pow_mod_secure
#define mpz_pow_ui            gmp_pow_unsigned_integer
#define mpz_ui_pow_ui         gmp_unsigned_integer_pow_unsigned_integer

// ROOT EXTRACTION FUNCTIONS
// https://gmplib.org/manual/Integer-Roots.html

#define mpz_root              gmp_root
#define mpz_rootrem           gmp_root_remainder
#define mpz_sqrt              gmp_sqrt
#define mpz_sqrtrem           gmp_sqrt_remainder
#define mpz_perfect_power_p   gmp_perfect_power
#define mpz_perfect_square_p  gmp_perfect_square

// NUMBER THEORETIC FUNCTIONS
// https://gmplib.org/manual/Number-Theoretic-Functions.html

#define mpz_probab_prime_p    gmp_probably_prime
#define mpz_nextprime         gmp_next_prime
#define mpz_gcd               gmp_gcd
#define mpz_gcd_ui            gmp_gcd_unsigned_integer
#define mpz_gcdext            gmp_gcd_coefficients
#define mpz_lcm               gmp_lcm
#define mpz_lcm_ui            gmp_lcm_unsigned_integer
#define mpz_invert            gmp_modulo_invert
#define mpz_jacobi            gmp_jacobi
#define mpz_legendre          gmp_legendre
#define mpz_kronecker         gmp_kronecker
#define mpz_kronecker_si      gmp_kronecker_signed_integer
#define mpz_kronecker_ui      gmp_kronecker_unsigned_integer
#define mpz_si_kronecker      gmp_signed_integer_kronecker
#define mpz_ui_kronecker      gmp_unsigned_integer_kronecker
#define mpz_remove            gmp_remove_factor
#define mpz_fac_ui            gmp_factorial_unsigned_integer
#define mpz_2fac_ui           gmp_double_factorial_unsigned_integer
#define mpz_mfac_uiui         gmp_multiple_factorial_unsigned_integer
#define mpz_primorial_ui      gmp_primordial_unsigned_integer
#define mpz_bin_ui            gmp_binomial_unsigned_integer
#define mpz_bin_uiui          gmp_binomial_unsigned_integer_unsigned_integer
#define mpz_fib_ui            gmp_fibonacci_unsigned_integer
#define mpz_fib2_ui           gmp_fibonacci_fibonacci_unsigned_integer
#define mpz_lucnum_ui         gmp_lucas_unsigned_integer
#define mpz_lucnum2_ui        gmp_lucas_lucas_unsigned_integer

// COMPARISON FUNCTIONS
// https://gmplib.org/manual/Integer-Comparisons.html

#define mpz_cmp               gmp_cmp
#define mpz_cmp_d             gmp_cmp_number
#define mpz_cmp_si            gmp_cmp_signed_integer
#define mpz_cmp_ui            gmp_cmp_unsigned_integer
#define mpz_cmpabs            gmp_cmp_absolute
#define mpz_cmpabs_d          gmp_cmp_absolute_number
#define mpz_cmpabs_ui         gmp_cmp_absolute_unsigned_integer
#define mpz_sgn               gmp_sign

// LOGICAL AND BIT MANIPULATION FUNCTIONS
// https://gmplib.org/manual/Integer-Logic-and-Bit-Fiddling.html

#define mpz_and               gmp_bitwise_and
#define mpz_ior               gmp_bitwise_ior
#define mpz_xor               gmp_bitwise_xor
#define mpz_com               gmp_ones_complement
#define mpz_popcount          gmp_population_count
#define mpz_hamdist           gmp_hamming_distance
#define mpz_scan0             gmp_scan0
#define mpz_scan1             gmp_scan1
#define mpz_setbit            gmp_set_bit
#define mpz_clrbit            gmp_clear_bit
#define mpz_combit            gmp_complement_bit
#define mpz_tstbit            gmp_test_bit

// INPUT AND OUTPUT FUNCTIONS
// https://gmplib.org/manual/I_002fO-of-Integers.html

#define mpz_out_str           gmp_output_file_string
#define mpz_inp_str           gmp_input_file_string
#define mpz_out_raw           gmp_output_file_raw
#define mpz_inp_raw           gmp_input_file_raw

// RANDOM NUMBER FUNCTIONS
// https://gmplib.org/manual/Integer-Random-Numbers.html

#define mpz_urandomb          gmp_random_uniform_bitcount
#define mpz_urandomm          gmp_random_uniform
#define mpz_rrandomb          gmp_random_bitcount

// INTEGER IMPORTA AND EXPORT FUNCTIONS
// https://gmplib.org/manual/Integer-Import-and-Export.html

#define mpz_import            gmp_import
#define mpz_export            gmp_export

// MISCELLANEOUS FUNCTIONS
// https://gmplib.org/manual/Miscellaneous-Integer-Functions.html

#define mpz_fits_ulong_p      gmp_fits_unsigned_integer
#define mpz_fits_slong_p      gmp_fits_signed_integer
#define mpz_fits_uint_p       gmp_fits_unsigned_normal_integer
#define mpz_fits_sint_p       gmp_fits_signed_normal_integer
#define mpz_fits_ushort_p     gmp_fits_unsigned_short_integer
#define mpz_fits_sshort_p     gmp_fits_signed_short_integer
#define mpz_odd_p             gmp_odd
#define mpz_even_p            gmp_even
#define mpz_sizeinbase        gmp_size_in_base

#endif
