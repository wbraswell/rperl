#!/usr/bin/perl
## no critic qw(ProhibitExcessMainComplexity)  # SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1

# suppress 'WEXRP00: Found multiple rperl executables' due to blib/ & pre-existing installation(s)
# also suppress other warnings generated in this file due to partially-incomplete generator code
BEGIN { $ENV{RPERL_WARNINGS} = 0; }

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_001;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireBriefOpen)  # USER DEFAULT 5: allow open() in perltidy-expanded code
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
## no critic qw(ProhibitDeepNests)  # SYSTEM SPECIAL 7: allow deeply-nested code

# [[[ INCLUDES ]]]
use RPerl::Test;
use RPerl::Parser;
use RPerl::Generator;
use RPerl::Compiler;
use Test::More;
use Test::Exception;
use Perl::Tidy;

# [[[ OPERATIONS ]]]

# TEMP DEBUGGING, ONLY LOAD SPECIFIC FILES
my $test_files = { './lib/RPerl/Algorithm/Sort/Bubble.pm' => undef };

#RPerl::diag('in 12_compile_sort.t, have $test_files = ' . "\n" . Dumper($test_files) . "\n");

my string_hashref $modes_argument;
my hashref_arrayref $output_file_name_groups;
my string $test_file_reference;
my bool $perform_diff_check;
my unknown $eval_return_value;
my integer $diff_line;
my integer $number_of_tests_run = 0;

# [[[ PRIMARY RUNLOOP ]]]
# loop 3 times, once for each mode: PERLOPS_PERLTYPES, PERLOPS_CPPTYPES, CPPOPS_CPPTYPES
#foreach my integer $mode_id ( sort keys %{$RPerl::MODES} ) {
for my $mode_id ( 0 .. 0 ) {    # TEMPORARY DEBUGGING PERLOPS_PERLTYPES ONLY

    # [[[ MODE SETUP ]]]
    #    RPerl::diag("in 12_compile_sort.t, top of for() loop, have \$mode_id = $mode_id\n");
    my scalartype_hashref $mode = $RPerl::MODES->{$mode_id};
    my $ops                 = $mode->{ops};
    my $types               = $mode->{types};
    my string $mode_tagline = $ops . 'OPS_' . $types . 'TYPES';
    if ( $ENV{RPERL_VERBOSE} ) {
        Test::More::diag( '[[[ Beginning RPerl Generator Tests, ' . $ops . ' operations and ' . $types . ' data types' . ' ]]]' );
    }

    lives_ok( sub { rperltypes::types_enable($types) }, q{mode '} . $ops . ' operations and ' . $types . ' data types' . q{' enabled} );
    $number_of_tests_run++;

    for my $test_file ( sort keys %{$test_files} ) {

        RPerl::diag( 'in 12_compile_sort.t, have $test_file = ' . $test_file . "\n" );

        $modes_argument = {
            ops     => $ops,
            types   => $types,
            check   => 'TRACE',
            compile => 'GENERATE',    # don't save source code to disk, will diff check from memory
            execute => 'OFF',
            label   => 'OFF'          # don't label source code, will strip comments before diff check
        };
        $output_file_name_groups = generate_output_file_names( [$test_file], [], $modes_argument, 1 );

        if ( $ops eq 'PERL' ) {
            $perform_diff_check = 1;    # Perl source code is it's own reference file, always perform diff check for PERLOPS_PERLTYPES
        }
        else {                          # $ops eq 'CPP'
            $perform_diff_check = 1;    # begin by assuming diff check, all reference file(s) found
            foreach my string $suffix_key ( sort keys %{ $output_file_name_groups->[0] } ) {
                $test_file_reference = $output_file_name_groups->[0]->{$suffix_key} . q{-} . $ops . 'OPS_' . $types . 'TYPES';
                if ( not -f $test_file_reference ) {
                    RPerl::warning( 'WARNING WTE11GE00: Test Group 11, Code Generator; Missing pre-compiled source code reference file ' . q{'}
                            . $test_file_reference . q{'}
                            . ', not performing difference check'
                            . "\n" );
                    $perform_diff_check = 0;    # no diff check, at least one reference file missing
                    last;
                }
            }
        }

        # [[[ PARSE ]]]
        $eval_return_value = eval { RPerl::Parser::rperl_to_ast__parse($test_file); };
        if ( not( ( defined $eval_return_value ) and $eval_return_value ) ) {
            ok( 0, 'Program or module parses with errors, code generation not reached, test aborted: ' . $test_file );
            $number_of_tests_run++;
            next;
        }
        my object $rperl_ast = $eval_return_value;

        # [[[ GENERATE ]]]
        if ( $ops eq 'PERL' ) {
            $eval_return_value = eval { RPerl::Generator::ast_to_rperl__generate( $rperl_ast, $modes_argument ); };
        }
        else {    # $ops eq 'CPP'
            $eval_return_value = eval { RPerl::Generator::ast_to_cpp__generate( $rperl_ast, $modes_argument ); };
        }

        #        RPerl::diag( 'in 12_compile_sort.t, have $eval_return_value = ' . Dumper($eval_return_value) . "\n" );    # warning if undef retval

        if ( ( defined $eval_return_value ) and $eval_return_value ) {    # Perl eval return code defined & true, success
            RPerl::diag( 'in 12_compile_sort.t, have defined and true $eval_return_value' . "\n" );
            my string_hashref $source_group = $eval_return_value;
            RPerl::diag( 'in 12_compile_sort.t, have $test_file named *Good* or *good*' . "\n" );
            if ($perform_diff_check) {
                RPerl::diag( 'in 12_compile_sort.t, need to perform diff check(s)' . "\n" );

             #                    RPerl::diag( 'in 12_compile_sort.t, have $output_file_name_groups->[0] = ' . Dumper( $output_file_name_groups->[0] ) . "\n" );
                foreach my string $suffix_key ( sort keys %{ $output_file_name_groups->[0] } ) {
                    RPerl::diag( 'in 12_compile_sort.t, have sort keys %{ $output_file_name_groups->[0] } = '
                            . Dumper( [ sort keys %{ $output_file_name_groups->[0] } ] ) );
                    RPerl::diag( 'in 12_compile_sort.t, have sort keys %{ $source_group } = ' . Dumper( [ sort keys %{$source_group} ] ) );
                    if ( $ops eq 'PERL' ) {                               # single reference file; use original Perl source file as reference for diff check
                        $test_file_reference = $test_file;
                    }
                    else {                                                # $ops eq 'CPP'
                            # multiple reference files; use pre-compiled CPP source files as references for diff check
                        $test_file_reference = $output_file_name_groups->[0]->{$suffix_key} . q{-} . $ops . 'OPS_' . $types . 'TYPES';
                    }

                    #                        RPerl::diag( 'in 12_compile_sort.t, have $test_file_reference = ' . $test_file_reference . "\n" );

                    $diff_line = RPerl::Generator::diff_check_file_vs_string( $test_file_reference, $source_group->{$suffix_key}, $ops );

                    #                        RPerl::diag( 'in 12_compile_sort.t, have $diff_line = ' . $diff_line . "\n" );
                    if ( $diff_line != 0 ) {
                        last;
                    }
                }

                if ( $diff_line == 0 ) {
                    ok( 1, 'Program or module generates without errors, yes diff check: ' . $test_file );
                    $number_of_tests_run++;
                }
                elsif ( $diff_line > 0 ) {
                    ok( 0, 'Program or module generates without errors, yes diff check, files differ beginning at line ' . $diff_line . ': ' . $test_file );
                    $number_of_tests_run++;
                }
                else {    # $diff_line < 0
                          # ignore __DUMMY_SOURCE_CODE results, indicated by $diff_line < 0
                    RPerl::diag( 'in 12_compile_sort.t, DUMMY SOURCE CODE found in diff check' . "\n" );
                }
            }
            else {
                RPerl::diag( 'in 12_compile_sort.t, do NOT need to perform diff check(s)' . "\n" );

                # skip test if dummy source code found
                if ( not dummy_source_code_find($source_group) ) {
                    ok( 1, 'Program or module generates without errors, no diff check: ' . $test_file );
                    $number_of_tests_run++;
                }
                else {
                    RPerl::diag( 'in 12_compile_sort.t, DUMMY SOURCE CODE found, from $source_group:' . "\n" . Dumper($source_group) . "\n" );
                }
            }
        }
        else {    # Perl eval return code undefined or false, error
            RPerl::diag( 'in 12_compile_sort.t, have undefined or false $eval_return_value' . "\n" );

            RPerl::diag( 'in 12_compile_sort.t, have $EVAL_ERROR = ' . $EVAL_ERROR . "\n" );
            if ( $EVAL_ERROR =~ /Can't\slocate\sobject\smethod\s"ast_to_\w*__generate"\svia\spackage/xms ) {
                RPerl::warning(
                    'WARNING WTE11GE01: Test Group 11, Code Generator; Missing code generation method, received error message...' . "\n" . $EVAL_ERROR . "\n" );
            }
            else {
                ok( 0, 'Program or module generates without errors: ' . $test_file );
                $number_of_tests_run++;
            }
        }
        RPerl::diag( ( q{-} x 100 ) . "\n" );
    }
    RPerl::diag( ( q{=} x 100 ) . "\n" );
}

done_testing($number_of_tests_run);
