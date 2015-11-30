#ifndef __CPP__INCLUDED__rperlgmp_h
#define __CPP__INCLUDED__rperlgmp_h 0.003_000

//typedef mpz_t                 gmp_integer;

// INITIALIZATION FUNCTIONS
// https://gmplib.org/manual/Initializing-Integers.html

//#define gmp_init                 mpz_init
//#define gmp_inits                mpz_inits
//#define gmp_init_bitcount        mpz_init2
//#define gmp_clear                mpz_clear
//#define gmp_clears               mpz_clears
//#define gmp_reallocate_bitcount  mpz_realloc2

// ASSIGNMENT FUNCTIONS
// https://gmplib.org/manual/Assigning-Integers.html

//#define gmp_set                   mpz_set
//#define gmp_set_unsigned_integer  mpz_set_ui
//#define gmp_set_signed_integer    mpz_set_si
//#define gmp_set_number            mpz_set_d
//#define gmp_set_string            mpz_set_str
//#define gmp_set_gmp_rational      mpz_set_q
//#define gmp_set_gmp_float         mpz_set_f
//#define gmp_swap                  mpz_swap

// COMBINED INITIALIZATION AND ASSIGNMENT FUNCTIONS
// https://gmplib.org/manual/Simultaneous-Integer-Init-_0026-Assign.html

//#define gmp_init_set                   mpz_init_set
//#define gmp_init_set_unsigned_integer  mpz_init_set_ui
//#define gmp_init_set_signed_integer    mpz_init_set_si
//#define gmp_init_set_number            mpz_init_set_d
//#define gmp_init_set_string            mpz_init_set_str

// CONVERSION FUNCTIONS
// https://gmplib.org/manual/Converting-Integers.html

//#define gmp_get_unsigned_integer   mpz_get_ui
//#define gmp_get_signed_integer     mpz_get_si
//#define gmp_get_number             mpz_get_d
//#define gmp_get_number_power_of_2  mpz_get_d_2exp
//#define gmp_get_string             mpz_get_str

// ARITHMETIC FUNCTIONS
// https://gmplib.org/manual/Integer-Arithmetic.html

//#define gmp_add                       mpz_add
//#define gmp_add_unsigned_integer      mpz_add_ui
//#define gmp_sub                       mpz_sub
//#define gmp_sub_unsigned_integer      mpz_sub_ui
//#define gmp_unsigned_integer_sub      mpz_ui_sub
//#define gmp_mul                       mpz_mul
//#define gmp_mul_signed_integer        mpz_mul_si
//#define gmp_mul_unsigned_integer      mpz_mul_ui
//#define gmp_add_mul                   mpz_addmul
//#define gmp_add_mul_unsigned_integer  mpz_addmul_ui
//#define gmp_sub_mul                   mpz_submul
//#define gmp_sub_mul_unsigned_integer  mpz_submul_ui
//#define gmp_mul_power_of_2            mpz_mul_2exp
//#define gmp_neg                       mpz_neg
//#define gmp_abs                       mpz_abs

// DIVISION FUNCTIONS
// https://gmplib.org/manual/Integer-Division.html

//#define gmp_div_ceiling_quotient                              mpz_cdiv_q
//#define gmp_div_ceiling_remainder                             mpz_cdiv_r
//#define gmp_div_ceiling_quotient_remainder                    mpz_cdiv_qr
//#define gmp_div_ceiling_quotient_unsigned_integer             mpz_cdiv_q_ui
//#define gmp_div_ceiling_remainder_unsigned_integer            mpz_cdiv_r_ui
//#define gmp_div_ceiling_quotient_remainder_unsigned_integer   mpz_cdiv_qr_ui
//#define gmp_div_ceiling_unsigned_integer                      mpz_cdiv_ui
//#define gmp_div_ceiling_quotient_power_of_2                   mpz_cdiv_q_2exp
//#define gmp_div_ceiling_remainder_power_of_2                  mpz_cdiv_r_2exp
//#define gmp_div_floor_quotient                                mpz_fdiv_q
//#define gmp_div_floor_remainder                               mpz_fdiv_r
//#define gmp_div_floor_quotient_remainder                      mpz_fdiv_qr
//#define gmp_div_floor_quotient_unsigned_integer               mpz_fdiv_q_ui
//#define gmp_div_floor_remainder_unsigned_integer              mpz_fdiv_r_ui
//#define gmp_div_floor_quotient_remainder_unsigned_integer     mpz_fdiv_qr_ui
//#define gmp_div_floor_unsigned_integer                        mpz_fdiv_ui
//#define gmp_div_floor_quotient_power_of_2                     mpz_fdiv_q_2exp
//#define gmp_div_floor_remainder_power_of_2                    mpz_fdiv_r_2exp
//#define gmp_div_truncate_quotient                             mpz_tdiv_q
//#define gmp_div_truncate_remainder                            mpz_tdiv_r
//#define gmp_div_truncate_quotient_remainder                   mpz_tdiv_qr
//#define gmp_div_truncate_quotient_unsigned_integer            mpz_tdiv_q_ui
//#define gmp_div_truncate_remainder_unsigned_integer           mpz_tdiv_r_ui
//#define gmp_div_truncate_quotient_remainder_unsigned_integer  mpz_tdiv_qr_ui
//#define gmp_div_truncate_unsigned_integer                     mpz_tdiv_ui
//#define gmp_div_truncate_quotient_power_of_2                  mpz_tdiv_q_2exp
//#define gmp_div_truncate_remainder_power_of_2                 mpz_tdiv_r_2exp
//#define gmp_mod                                               mpz_mod
//#define gmp_mod_unsigned_integer                              mpz_mod_ui
//#define gmp_div_exact                                         mpz_divexact
//#define gmp_div_exact_unsigned_integer                        mpz_divexact_ui
//#define gmp_divisible                                         mpz_divisible_p
//#define gmp_divisible_unsigned_integer                        mpz_divisible_ui_p
//#define gmp_divisible_power_of_2                              mpz_divisible_2exp_p
//#define gmp_congruent                                         mpz_congruent_p
//#define gmp_congruent_unsigned_integer                        mpz_congruent_ui_p
//#define gmp_congruent_power_of_2                              mpz_congruent_2exp_p

// EXPONENTIATION FUNCTIONS
// https://gmplib.org/manual/Integer-Exponentiation.html

//#define gmp_pow_mod                                mpz_powm
//#define gmp_pow_mod_unsigned_integer               mpz_powm_ui
//#define gmp_pow_mod_secure                         mpz_powm_sec
//#define gmp_pow_unsigned_integer                   mpz_pow_ui
//#define gmp_unsigned_integer_pow_unsigned_integer  mpz_ui_pow_ui

// ROOT EXTRACTION FUNCTIONS
// https://gmplib.org/manual/Integer-Roots.html

//#define gmp_root            mpz_root
//#define gmp_root_remainder  mpz_rootrem
//#define gmp_sqrt            mpz_sqrt
//#define gmp_sqrt_remainder  mpz_sqrtrem
//#define gmp_perfect_power   mpz_perfect_power_p
//#define gmp_perfect_square  mpz_perfect_square_p

// NUMBER THEORETIC FUNCTIONS
// https://gmplib.org/manual/Number-Theoretic-Functions.html

//#define gmp_probably_prime                              mpz_probab_prime_p
//#define gmp_next_prime                                  mpz_nextprime
//#define gmp_gcd                                         mpz_gcd
//#define gmp_gcd_unsigned_integer                        mpz_gcd_ui
//#define gmp_gcd_coefficients                            mpz_gcdext
//#define gmp_lcm                                         mpz_lcm
//#define gmp_lcm_unsigned_integer                        mpz_lcm_ui
//#define gmp_modulo_invert                               mpz_invert
//#define gmp_jacobi                                      mpz_jacobi
//#define gmp_legendre                                    mpz_legendre
//#define gmp_kronecker                                   mpz_kronecker
//#define gmp_kronecker_signed_integer                    mpz_kronecker_si
//#define gmp_kronecker_unsigned_integer                  mpz_kronecker_ui
//#define gmp_signed_integer_kronecker                    mpz_si_kronecker
//#define gmp_unsigned_integer_kronecker                  mpz_ui_kronecker
//#define gmp_remove_factor                               mpz_remove
//#define gmp_factorial_unsigned_integer                  mpz_fac_ui
//#define gmp_double_factorial_unsigned_integer           mpz_2fac_ui
//#define gmp_multiple_factorial_unsigned_integer         mpz_mfac_uiui
//#define gmp_primordial_unsigned_integer                 mpz_primorial_ui
//#define gmp_binomial_unsigned_integer                   mpz_bin_ui
//#define gmp_binomial_unsigned_integer_unsigned_integer  mpz_bin_uiui
//#define gmp_fibonacci_unsigned_integer                  mpz_fib_ui
//#define gmp_fibonacci_fibonacci_unsigned_integer        mpz_fib2_ui
//#define gmp_lucas_unsigned_integer                      mpz_lucnum_ui
//#define gmp_lucas_lucas_unsigned_integer                mpz_lucnum2_ui

// COMPARISON FUNCTIONS
// https://gmplib.org/manual/Integer-Comparisons.html

//#define gmp_cmp                            mpz_cmp
//#define gmp_cmp_number                     mpz_cmp_d
//#define gmp_cmp_signed_integer             mpz_cmp_si
//#define gmp_cmp_unsigned_integer           mpz_cmp_ui
//#define gmp_cmp_absolute                   mpz_cmpabs
//#define gmp_cmp_absolute_number            mpz_cmpabs_d
//#define gmp_cmp_absolute_unsigned_integer  mpz_cmpabs_ui
//#define gmp_sign                           mpz_sgn

// LOGICAL AND BIT MANIPULATION FUNCTIONS
// https://gmplib.org/manual/Integer-Logic-and-Bit-Fiddling.html

//#define gmp_bitwise_and       mpz_and
//#define gmp_bitwise_ior       mpz_ior
//#define gmp_bitwise_xor       mpz_xor
//#define gmp_ones_complement   mpz_com
//#define gmp_population_count  mpz_popcount
//#define gmp_hamming_distance  mpz_hamdist
//#define gmp_scan0             mpz_scan0
//#define gmp_scan1             mpz_scan1
//#define gmp_set_bit           mpz_setbit
//#define gmp_clear_bit         mpz_clrbit
//#define gmp_complement_bit    mpz_combit
//#define gmp_test_bit          mpz_tstbit

// INPUT AND OUTPUT FUNCTIONS
// https://gmplib.org/manual/I_002fO-of-Integers.html

//#define gmp_output_file_string  mpz_out_str
//#define gmp_input_file_string   mpz_inp_str
//#define gmp_output_file_raw     mpz_out_raw
//#define gmp_input_file_raw      mpz_inp_raw

// RANDOM NUMBER FUNCTIONS
// https://gmplib.org/manual/Integer-Random-Numbers.html

//#define gmp_random_uniform_bitcount  mpz_urandomb
//#define gmp_random_uniform           mpz_urandomm
//#define gmp_random_bitcount          mpz_rrandomb

// INTEGER IMPORTA AND EXPORT FUNCTIONS
// https://gmplib.org/manual/Integer-Import-and-Export.html

//#define gmp_import  mpz_import
//#define gmp_export  mpz_export

// MISCELLANEOUS FUNCTIONS
// https://gmplib.org/manual/Miscellaneous-Integer-Functions.html

//#define gmp_fits_unsigned_integer         mpz_fits_ulong_p
//#define gmp_fits_signed_integer           mpz_fits_slong_p
//#define gmp_fits_unsigned_normal_integer  mpz_fits_uint_p
//#define gmp_fits_signed_normal_integer    mpz_fits_sint_p
//#define gmp_fits_unsigned_short_integer   mpz_fits_ushort_p
//#define gmp_fits_signed_short_integer     mpz_fits_sshort_p
//#define gmp_odd                           mpz_odd_p
//#define gmp_even                          mpz_even_p
//#define gmp_size_in_base                  mpz_sizeinbase

#endif
