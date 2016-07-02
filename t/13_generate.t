#!/usr/bin/perl  ## no critic qw(ProhibitExcessMainComplexity)  # SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1

# [[[ PRE-HEADER ]]]
# suppress 'WEXRP00: Found multiple rperl executables' due to blib/ & pre-existing installation(s),
# also 'WARNING WCOCODE00, COMPILER, FIND DEPENDENCIES: Failed to eval-use package' due to RPerl/Test/*/*Bad*.pm & RPerl/Test/*/*bad*.pl,
# also other warnings generated in this file due to partially-incomplete generator code
BEGIN { $ENV{RPERL_WARNINGS} = 0; }

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.008_200;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireBriefOpen)  # USER DEFAULT 5: allow open() in perltidy-expanded code
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
## no critic qw(ProhibitDeepNests)  # SYSTEM SPECIAL 7: allow deeply-nested code

# [[[ INCLUDES ]]]
use RPerl::Test;
use Test::More;
use Test::Exception;
use File::Find qw(find);
use Perl::Tidy;

# [[[ OPERATIONS ]]]

BEGIN {
    if ( $ENV{RPERL_VERBOSE} ) {
        Test::More::diag('[[[ Beginning Generator Pre-Test Loading, RPerl Compilation System ]]]');
    }
    lives_and( sub { use_ok('RPerl::AfterSubclass'); }, q{use_ok('RPerl::AfterSubclass') lives} );
    lives_and( sub { use_ok('RPerl::Parser'); }, q{use_ok('RPerl::Parser') lives} );
    lives_and( sub { use_ok('RPerl::Generator'); }, q{use_ok('RPerl::Generator') lives} );
    lives_and( sub { use_ok('RPerl::Compiler'); }, q{use_ok('RPerl::Compiler') lives} );
}

# TEMP DEBUGGING, ONLY LOAD SPECIFIC FILES
#my $test_files = { './lib/RPerl/Test/VariableRetrieval/program_04_good.pl' => undef };

#=DEBUG_DISABLE
# NEED UPDATE: add string_arrayref_hashref_hashref type
#my string_arrayref_hashref_hashref $test_files = {};
my $test_files = {};

# locate all *Good* *good* *Bad* *bad* test files in RPerl/Test/ directory
find(
    sub {
#        return;  # TMP DEBUG
 
        my $file = $File::Find::name;

#        RPerl::diag('in 13_generate.t, have $file = ' . $file . "\n");

#        if ( $file !~ m/[.]pm$/xms ) { # TEMP DEBUGGING, ONLY FIND *.pm, NOT *.pl
#        if ( $file !~ m/.*Module\/.*$/xms ) { # TEMP DEBUGGING, ONLY FIND CERTAIN FILES
        if ( $file !~ m/[.]p[ml]$/xms ) {    # find all *.pm & *.pl files
            return;
        }

        if ( ( $file =~ m/Good/ms ) or ( $file =~ m/good/ms ) ) {
            $test_files->{$file} = undef;
        }
        elsif ( ( $file =~ m/Bad/ms ) or ( $file =~ m/bad/ms ) ) {

            # NEED FIX: remove use of $_ magic variable
            open my filehandleref $FILE_HANDLE, '<', $_
                or croak 'ERROR ETE13GE00: Cannot open file ' . $file . ' for reading,' . $OS_ERROR . ', croaking';
            while (<$FILE_HANDLE>) {
                if (m/^\#\s*\<\<\<\s*GENERATE_ERROR\s*\:\s*['"](.*)['"]\s*\>\>\>/xms) {
                    push @{ $test_files->{$file}->{errors} }, $1;
                }
            }
            close $FILE_HANDLE
                or croak 'ERROR ETE13GE01: Cannot close file ' . $file . ' after reading,' . $OS_ERROR . ', croaking';
        }
        else {
            return;
        }
    },
    $RPerl::INCLUDE_PATH . '/RPerl/Test'
);

# locate all *.*OPS_*TYPES pre-compiled files in RPerl/ directory
find(
    sub {
        my $file = $File::Find::name;

#        RPerl::diag('in 13_generate.t, have $file = ' . $file . "\n");

#        if ( $file !~ m/[.]pm$/xms ) { # TEMP DEBUGGING, ONLY FIND *.pm, NOT *.pl
#        if ( $file !~ m/.*Module\/.*$/xms ) { # TEMP DEBUGGING, ONLY FIND FILES IN A CERTAIN DIRECTORY
#        if ( $file =~ m/^(.*foo_bar_arith.*)[.].*OPS.*$/xms ) { # TEMP DEBUGGING, ONLY FIND CERTAIN FILES
        if ( $file =~ m/^(.+)[.]\w+OPS_\w+TYPES$/gxms ) {    # find all pre-compiled files
            my string $file_base = $1;
#            RPerl::diag('in 13_generate.t, have pre-compiled $file        = ' . $file . "\n");
#            RPerl::diag('in 13_generate.t, have pre-compiled $file_base   = ' . $file_base . "\n");
            if (($file_base =~ m/^(.*)[.]cpp$/gxms) or ($file_base =~ m/^(.*)[.]h$/gxms) or ($file_base =~ m/^(.*)[.]pmc$/gxms)) {
                my string $file_prefix = $1;
#                RPerl::diag('in 13_generate.t, have pre-compiled $file_prefix = ' . $file_prefix . "\n");
                if ((-e ($file_prefix . '.pl')) and (-f ($file_prefix . '.pl')) and (-T ($file_prefix . '.pl'))) {
                    $test_files->{$file_prefix . '.pl'} = undef;
                }
                elsif ((-e ($file_prefix . '.pm')) and (-f ($file_prefix . '.pm')) and (-T ($file_prefix . '.pm'))) {
                    $test_files->{$file_prefix . '.pm'} = undef;
                }
                else {
                    RPerl::warning( 'WARNING WTE13GE01, TEST GROUP 13, CODE GENERATOR: Missing non-compiled source code reference file ' . q{'} . $file_prefix . '.pl' . q{'} . ' or '  . q{'} . $file_prefix . '.pm' . q{'} . ', not performing difference check' . "\n" );
                }
            }
            else {
                RPerl::warning( 'WARNING WTE13GE02, TEST GROUP 13, CODE GENERATOR: Unrecognized pre-compiled source code reference file base ' . q{'} . $file_base . q{'} . ', not performing difference check' . "\n" );
            }
        }
        else {  # not a pre-compiled file
#            RPerl::diag('in 13_generate.t, have NOT pre-compiled $file = ' . $file . "\n");
            return;
        }
    },
    $RPerl::INCLUDE_PATH . '/RPerl'
);

#=cut

#RPerl::diag( 'in 13_generate.t, have $test_files = ' . "\n" . Dumper($test_files) . "\n" );

my string_hashref $modes;
my hashref_arrayref $output_file_name_groups_tmp;
my string_hashref $output_file_name_group;
my string_hashref $reference_file_name_group;
my string $test_file_reference;
my boolean $perform_diff_check;
my unknown $eval_return_value;
my integer $diff_line;
my integer $number_of_tests_run = 4;  # initialize to 4 for use_ok() calls in BEGIN block above


# [[[ PRIMARY RUNLOOP ]]]
# [[[ PRIMARY RUNLOOP ]]]
# [[[ PRIMARY RUNLOOP ]]]

# loop up to 3 times, once for each mode: PERLOPS_PERLTYPES, PERLOPS_CPPTYPES, CPPOPS_CPPTYPES
#foreach my integer $mode_id ( sort keys %{$RPerl::MODES} ) {
for my $mode_id ( 0 ) {    # PERLOPS_PERLTYPES ONLY
#for my $mode_id ( 2 ) {    # CPPOPS_CPPTYPES ONLY
#for my $mode_id ( 0 , 2 ) {    # PERLOPS_PERLTYPES, CPPOPS_CPPTYPES
#    RPerl::diag("in 13_generate.t, top of for() loop, have \$mode_id = $mode_id\n");


# START HERE: get CPPOPS_CPPTYPES to properly skip all appropriate tests, carry on with START HERE in Bubble.pmc.CPPOPS_DUALTYPES
# START HERE: get CPPOPS_CPPTYPES to properly skip all appropriate tests, carry on with START HERE in Bubble.pmc.CPPOPS_DUALTYPES
# START HERE: get CPPOPS_CPPTYPES to properly skip all appropriate tests, carry on with START HERE in Bubble.pmc.CPPOPS_DUALTYPES

# ALSO: add Test::More::diag()s to t/21?
# ALSO: add Test::More::diag()s to t/21?
# ALSO: add Test::More::diag()s to t/21?

    # [[[ MODE SETUP ]]]
    my scalartype_hashref $mode = $RPerl::MODES->{$mode_id};
    my $ops                 = $mode->{ops};
    my $types               = $mode->{types};
    my string $mode_tagline = $ops . 'OPS_' . $types . 'TYPES';
    if ( $ENV{RPERL_VERBOSE} ) {
        Test::More::diag( '[[[ Beginning Generator Tests, RPerl Compilation System, ' . $ops . ' operations and ' . $types . ' data types' . ' ]]]' );
    }

    lives_ok( sub { rperltypes::types_enable($types) }, q{mode '} . $ops . ' operations and ' . $types . ' data types' . q{' enabled} );
    $number_of_tests_run++;

    # [[[ SECONDARY RUNLOOP ]]]
    # [[[ SECONDARY RUNLOOP ]]]
    # [[[ SECONDARY RUNLOOP ]]]

    TEST_FILE_LOOP: foreach my $test_file ( sort keys %{$test_files} ) {
        $reference_file_name_group = {};
#        RPerl::diag( 'in 13_generate.t, have $test_file = ' . $test_file . "\n" );

        $modes = {
            dependencies => 'ON',
            ops     => $ops,
            types   => $types,
#            check        => 'TRACE',  # unnecessary
#            uncompile    => 'OFF',  # unnecessary
            compile => 'GENERATE',    # don't save source code to disk, will diff check from memory
            subcompile   => 'DYNAMIC',  # must be DYNAMIC for Subroutine::ast_to_cpp__generate_shims__CPPOPS_CPPTYPES() to generate PMC output
#            CXX          => 'g++',  # unnecessary
            execute => 'OFF',
            label   => 'OFF'          # don't label source code, will strip comments before diff check
        };
        $output_file_name_groups_tmp = generate_output_file_names( [$test_file], [], 1, $modes );
        $output_file_name_group = $output_file_name_groups_tmp->[0];

        # trim unnecessary (and possibly problematic) absolute paths from input & output file names
        $test_file = RPerl::Compiler::post_processor__absolute_path_delete( $test_file );
        foreach my string $suffix_key (keys %{$output_file_name_group}) {
            if (defined $output_file_name_group->{$suffix_key}) {
                $output_file_name_group->{$suffix_key} = RPerl::Compiler::post_processor__absolute_path_delete( $output_file_name_group->{$suffix_key} );
            }
        }

#        RPerl::diag( 'in 13_generate.t, have sort keys %{ $reference_file_name_group } = ' . Dumper( [ sort keys %{ $reference_file_name_group } ] ) );
#        RPerl::diag( 'in 13_generate.t, have sort keys %{ $output_file_name_group } = ' . Dumper( [ sort keys %{ $output_file_name_group } ] ) );

        if ( $ops eq 'PERL' ) {
            $perform_diff_check = 1;    # Perl source code is it's own reference file, always perform diff check for PERLOPS_PERLTYPES
            foreach my string $suffix_key (keys %{$output_file_name_group}) {
                if (defined $output_file_name_group->{$suffix_key}) {
                    $reference_file_name_group->{$suffix_key} = $output_file_name_group->{$suffix_key};
                }
            }
        }
        else {                          # $ops eq 'CPP'
            $perform_diff_check = 1;    # begin by assuming diff check, all reference file(s) found
            # check if all reference files exist, update reference file names
            foreach my string $suffix_key ( sort keys %{ $output_file_name_group } ) {
#                RPerl::diag( 'in 13_generate.t, have $suffix_key = ' . $suffix_key . "\n" );
#                RPerl::diag( 'in 13_generate.t, have $output_file_name_group->{$suffix_key} = ' . $output_file_name_group->{$suffix_key} . "\n" );
                if ((substr $suffix_key, 0, 1) eq '_') {
                    next;
                }
                elsif ($suffix_key eq 'PMC') {
                    $test_file_reference = $output_file_name_group->{$suffix_key} . q{.} . $ops . 'OPS_DUALTYPES';
                }
                elsif ($suffix_key eq 'H') {
                    if ((substr $output_file_name_group->{$suffix_key}, -12, 12) eq ' (if needed)') {
                        $test_file_reference = (substr $output_file_name_group->{$suffix_key}, 0, ((length $output_file_name_group->{$suffix_key}) - 12)) . q{.} . $ops . 'OPS_' . $types . 'TYPES';
                    }
                    else {
                        $test_file_reference = $output_file_name_group->{$suffix_key} . q{.} . $ops . 'OPS_' . $types . 'TYPES';
                    }
                }
                elsif ($suffix_key eq 'CPP') {
                    $test_file_reference = $output_file_name_group->{$suffix_key} . q{.} . $ops . 'OPS_' . $types . 'TYPES';
                }
                elsif ($suffix_key eq 'EXE') {
#                    $test_file_reference = $output_file_name_group->{$suffix_key} . q{.cpp.} . $ops . 'OPS_' . $types . 'TYPES';
                    # in CPPOPS mode, EXE file should be an actual binary, don't try to compare
                    next;
                }
                else {
                    croak 'ERROR ETE13GE02: Unrecognized suffix key ' . $suffix_key . ', croaking';
                }
#                RPerl::diag( 'in 13_generate.t, have $test_file_reference = ' . $test_file_reference . "\n" );

                $reference_file_name_group->{$suffix_key} = $test_file_reference;  # update reference file name to include *OPS_*TYPES suffix
            }
        }

        # trim unnecessary (and possibly problematic) absolute paths from reference file names
        foreach my string $suffix_key (keys %{$reference_file_name_group}) {
            if (defined $reference_file_name_group->{$suffix_key}) {
                $reference_file_name_group->{$suffix_key} = RPerl::Compiler::post_processor__absolute_path_delete( $reference_file_name_group->{$suffix_key} );
            }
        }

        # NEED UPGRADE: remove this skip-if-no-diff-check once all CPPOPS_CPPTYPES code generation is complete
        if (not $perform_diff_check) {
            next;
        }

        # [[[ PARSE ]]]
        $eval_return_value = eval { RPerl::Parser::rperl_to_ast__parse($test_file); };
        if ( not( ( defined $eval_return_value ) and $eval_return_value ) ) {
            ok( 0, 'Program or module parses with errors, code generation not reached, test aborted:' . (q{ } x 2) . $test_file );
            $number_of_tests_run++;
            next;
        }
        my object $rperl_ast = $eval_return_value;

#        RPerl::diag( 'in 13_generate.t, have $ops = ' . $ops . "\n" );
#        RPerl::diag( 'in 13_generate.t, have $types = ' . $types . "\n" );

        $modes->{_input_file_name} = $test_file;
 
        # [[[ GENERATE ]]]
        if ( $ops eq 'PERL' ) {
            $eval_return_value = eval { RPerl::Generator::ast_to_rperl__generate( $rperl_ast, $modes ); };
        }
        else {    # $ops eq 'CPP'
            $eval_return_value = eval { RPerl::Generator::ast_to_cpp__generate( $rperl_ast, $modes ); };
        }

#        RPerl::diag( 'in 13_generate.t, have $eval_return_value = ' . Dumper($eval_return_value) . "\n" );    # warning if undef retval

        if ( ( defined $eval_return_value ) and $eval_return_value ) {    # Perl eval return code defined & true, success
#            RPerl::diag( 'in 13_generate.t, have defined and true $eval_return_value' . "\n" );
            my string_hashref $source_group = $eval_return_value;

#            RPerl::diag( 'in 13_generate.t, have $source_group = ' . Dumper($source_group ) . "\n\n" );
#            RPerl::diag( 'in 13_generate.t, have sort keys %{ $source_group } = ' . Dumper( [ sort keys %{$source_group} ] ) );

            if (( $ops eq 'CPP' ) and (exists $output_file_name_group->{PMC}) and (defined $output_file_name_group->{PMC})) {
                # generate PMC source code
                RPerl::Compiler::post_processor_cpp__pmc_generate( $source_group, $output_file_name_group, $modes );
            }

            if ( ( $test_file =~ m/Bad/xms ) or ( $test_file =~ m/bad/xms ) ) {    # file named *Bad* or *bad*
#                RPerl::diag( 'in 13_generate.t, have $test_file NOT named *Good* or *good*' . "\n" );

                # skip test if dummy source code found
                if ( not dummy_source_code_find($source_group) ) {
                    ok( 0, 'Program or module generates with errors:' . (q{ } x 21) . $test_file );
                    $number_of_tests_run++;
                }
                else {
#                    RPerl::diag( 'in 13_generate.t, DUMMY SOURCE CODE found, from $source_group:' . "\n" . Dumper($source_group) . "\n" );
                }
            }

            #            elsif ( ( $test_file =~ m/Good/xms ) or ( $test_file =~ m/good/xms ) )
            else    # default assuming files are good
            {
#                RPerl::diag( 'in 13_generate.t, have $test_file named *Good* or *good*' . "\n" );
                if ($perform_diff_check) {
#                    RPerl::diag( 'in 13_generate.t, need to perform diff check(s)' . "\n" );
#                    RPerl::diag( 'in 13_generate.t, have $reference_file_name_group = ' . Dumper( $reference_file_name_group ) . "\n" );
                    my string $suffix_key;
                    my string $suffix_key_saved;

                    # [[[ TERTIARY RUNLOOP ]]]
                    # [[[ TERTIARY RUNLOOP ]]]
                    # [[[ TERTIARY RUNLOOP ]]]

                    foreach $suffix_key ( sort keys %{ $reference_file_name_group } ) {
#                        RPerl::diag( 'in 13_generate.t, top of suffix loop, have $suffix_key = ' . $suffix_key . "\n" );
                        $suffix_key_saved = $suffix_key;
                        if ( $ops eq 'PERL' ) {    # single reference file; use original Perl source file as reference for diff check
                            $test_file_reference = $test_file;
                        }
                        else {                     # $ops eq 'CPP'
                                                   # multiple reference files; use pre-compiled CPP source files as references for diff check
                            $test_file_reference = $reference_file_name_group->{$suffix_key};
                        }

                        #                        RPerl::diag( 'in 13_generate.t, have $test_file_reference = ' . $test_file_reference . "\n" );

                        # reference file does not exist (okay for some cases, such as H suffix for some .pl EXE input files)
                        if (( not -e $test_file_reference ) or ( not -f $test_file_reference ) or ( not -T $test_file_reference )) {
                            # source code generated
                            if ((exists $source_group->{$suffix_key}) and (defined $source_group->{$suffix_key}) and ($source_group->{$suffix_key} ne q{})) {
                                ok( 1, 'Program or module is missing a pre-compiled reference file, no diff check, skipped:' . (q{ } x 2) . $test_file );
                                next TEST_FILE_LOOP;
                            }
                            
                            # source code not generated, ref file does not exist, okay to skip
                            next;
                        }

                        $diff_line = RPerl::Generator::diff_check_file_vs_string( $test_file_reference, $source_group, $suffix_key, $output_file_name_group, $modes );

                        #                        RPerl::diag( 'in 13_generate.t, have $diff_line = ' . $diff_line . "\n" );
                        if ( $diff_line != 0 ) {
#                            RPerl::diag( 'in 13_generate.t, near bottom of suffix loop, have $diff_line = ' . $diff_line . ', $suffix_key = ' . $suffix_key . "\n" );
                            last;
                        }
#                        RPerl::diag( 'in 13_generate.t, bottom of suffix loop, have $suffix_key = ' . $suffix_key . "\n" );
                    }
                    # NEED ANSWER: why is $suffix_key cleared when the loop is completed?
                    $suffix_key = $suffix_key_saved;
                    $suffix_key_saved = undef;
#                    RPerl::diag( 'in 13_generate.t, after suffix loop, have $suffix_key = ' . $suffix_key . "\n" );

                    if ( $diff_line == 0 ) {
                        ok( 1, 'Program or module generates without errors, yes diff check:' . (q{ } x 2) . $test_file );
                        $number_of_tests_run++;
                    }
                    elsif ( $diff_line > 0 ) {
                        ok( 0, 'Program or module generates without errors, yes diff check, output file ' . $output_file_name_group->{$suffix_key} . ' and reference file ' . $test_file_reference . ' differ at line ' . $diff_line );
                        $number_of_tests_run++;
                    }
                    else {    # $diff_line < 0
                              # ignore __DUMMY_SOURCE_CODE results, indicated by $diff_line < 0
#                        RPerl::diag( 'in 13_generate.t, DUMMY SOURCE CODE found in diff check' . "\n" );
                    }
                }
                else {
#                    RPerl::diag( 'in 13_generate.t, do NOT need to perform diff check(s)' . "\n" );

                    # skip test if dummy source code found
                    if ( not dummy_source_code_find($source_group) ) {
                        ok( 1, 'Program or module generates without errors, no diff check:' . (q{ } x 3) . $test_file );
                        $number_of_tests_run++;
                    }
#                    else { RPerl::diag( 'in 13_generate.t, DUMMY SOURCE CODE found, from $source_group:' . "\n" . Dumper($source_group) . "\n" ); }
                }
            }
        }
        else {    # Perl eval return code undefined or false, error
#            RPerl::diag( 'in 13_generate.t, have undefined or false $eval_return_value' . "\n" );
#            RPerl::diag( 'in 13_generate.t, have $EVAL_ERROR = ' . $EVAL_ERROR . "\n" );
            if (   ( $test_file =~ m/Bad/ms )
                or ( $test_file =~ m/bad/ms ) )
            {
#                RPerl::diag( 'in 13_generate.t, have $test_file named *Bad* or *bad*' . "\n" );
                my $missing_errors = [];
                if ( defined $test_files->{$test_file}->{errors} ) {
                    foreach my $error ( @{ $test_files->{$test_file}->{errors} } ) {
                        if ( $EVAL_ERROR !~ /\Q$error\E/xms ) {
                            push @{$missing_errors}, q{Error message '} . $error . q{' expected, but not found};
                        }
                    }
                }
                ok( ( ( scalar @{$missing_errors} ) == 0 ), 'Program or module generates with expected error(s):' . (q{ } x 10) . $test_file );
                $number_of_tests_run++;
            }
            else {
#                RPerl::diag( 'in 13_generate.t, have $test_file NOT named *Bad* or *bad*' . "\n" );
                if ( $EVAL_ERROR =~ /Can't\slocate\sobject\smethod\s"ast_to_\w*__generate"\svia\spackage/xms ) {
                    RPerl::warning( 'WARNING WTE13GE00, TEST GROUP 13, CODE GENERATOR: Missing code generation method, received error message...' . "\n"
                            . $EVAL_ERROR
                            . "\n" );
                }
                else {
                    ok( 0, 'Program or module generates without errors:' . (q{ } x 18) . $test_file );
                    $number_of_tests_run++;
                }
            }
        }
#        RPerl::diag( ( '-' x 100 ) . "\n" );
#        die 'TMP DEBUG';
    }
#    RPerl::diag( ( '=' x 100 ) . "\n" );
}

done_testing($number_of_tests_run);
