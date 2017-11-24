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
our $VERSION = 0.030_000;

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
use File::Find qw(find);
use Perl::Tidy;
use Cwd;
use File::Spec;

# [[[ CONSTANTS ]]]
use constant PATH_TESTS => my string $TYPED_PATH_TESTS = $RPerl::INCLUDE_PATH . '/RPerl/Test';
use constant PATH_PRECOMPILED => my string $TYPED_PATH_PRECOMPILED = $RPerl::INCLUDE_PATH . '/RPerl';

# [[[ OPERATIONS ]]]
our $verbose_newline = q{};
if ( $ENV{RPERL_VERBOSE} or $RPerl::VERBOSE ) {
    $verbose_newline = "\n";
}

# DEV NOTE: if set to true, will speed up tests where no pre-compiled reference files are found
my boolean $cpp_skip_parse_gen_if_no_ref_files = 1;

BEGIN {
    if ( $ENV{RPERL_VERBOSE} ) {
        Test::More::diag('[[[ Beginning Generator Pre-Test Loading, RPerl Compilation System ]]]');
    }
    # DEV NOTE: can't do use_ok() or require_ok() because it will place them before all other BEGIN blocks,
    # which means we wil have 4 tests passing before we call 'plan tests',
    # which means we will fail to have 'plan tests' first OR done_testing() last, which causes a TAP failure;
    # must be included w/ regular 'use' operators above
#    lives_and( sub { use_ok('RPerl::AfterSubclass'); },            q{use_ok('RPerl::AfterSubclass') lives} );
#    lives_and( sub { use_ok('RPerl::Parser'); }, q{use_ok('RPerl::Parser') lives} );
#    lives_and( sub { use_ok('RPerl::Generator'); }, q{use_ok('RPerl::Generator') lives} );
#    lives_and( sub { use_ok('RPerl::Compiler'); }, q{use_ok('RPerl::Compiler') lives} );
}

# TEMP DEBUGGING, ONLY LOAD SPECIFIC FILES
#my $test_files = { './lib/RPerl/FOO/BAR.pm' => undef };

#=DEBUG_DISABLE
# NEED UPDATE: add string_arrayref_hashref_hashref type
#my string_arrayref_hashref_hashref $test_files = {};
my $test_files = {};

# save current directory for file checks, because File::Find changes directory;
# use File::Spec for MS Windows support, etc.
my $current_working_directory = getcwd;
(my $volume, my $directories, my $dummy_file) = File::Spec->splitpath( $current_working_directory, 1 );  # no_file = 1

# locate all *Good* *good* *Bad* *bad* test files in PATH_TESTS directory or ARGV command-line argument directory
find(
    sub {
#        return;  # TMP DEBUG
 
        my $file = $File::Find::name;

#        RPerl::diag('in 13_generate.t, find0, have $file = ' . $file . "\n");

#        if ( $file !~ m/[.]pm$/xms ) { # TEMP DEBUGGING, ONLY FIND *.pm, NOT *.pl
#        if ( $file !~ m/.*Module\/.*$/xms ) { # TEMP DEBUGGING, ONLY FIND CERTAIN FILES
        if ( $file !~ m/[.]p[ml]$/xms ) {    # find all *.pm & *.pl files
            return;
        }

        if ( ( $file =~ m/Good/ms ) or ( $file =~ m/good/ms ) ) {
#            RPerl::diag('in 13_generate.t, find0, have good $file = ' . $file . "\n");
            $test_files->{$file} = undef;

            # NEED UPDATE: remove use of $_ magic variable
            open my filehandleref $FILE_HANDLE, '<', $_
                or croak 'ERROR, Cannot open file ' . $file . ' for reading,' . $OS_ERROR . ', croaking';
            while (<$FILE_HANDLE>) {
                if (m/^\#\s*\<\<\<\s*GENERATE\s*\:\s*OFF\s*\>\>\>/xms) {
                    delete $test_files->{$file};
                    last;
                }
            }
            close $FILE_HANDLE
                or croak 'ERROR, Cannot close file ' . $file . ' after reading,' . $OS_ERROR . ', croaking';
        }
        elsif ( ( $file =~ m/Bad/ms ) or ( $file =~ m/bad/ms ) ) {
#            RPerl::diag('in 13_generate.t, find0, have bad  $file = ' . $file . "\n");

            # NEED UPDATE: remove use of $_ magic variable
            open my filehandleref $FILE_HANDLE, '<', $_
                or croak 'ERROR ETE13GE00: Cannot open file ' . $file . ' for reading,' . $OS_ERROR . ', croaking';
            while (<$FILE_HANDLE>) {
                if (m/^\#\s*\<\<\<\s*GENERATE\s*\:\s*OFF\s*\>\>\>/xms) {
                    delete $test_files->{$file};
                    last;
                }
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
    (defined $ARGV[0]) ? $ARGV[0] : PATH_TESTS()  # accept optional command-line argument
);

# locate all *.*OPS_*TYPES pre-compiled files in PATH_PRECOMPILED directory or ARGV command-line argument directory
find(
    sub {
        my $file = $File::Find::name;
#        RPerl::diag('in 13_generate.t, find1, have $file = ' . $file . "\n");
#        if ( $file !~ m/[.]pm$/xms ) { # TEMP DEBUGGING, ONLY FIND *.pm, NOT *.pl
#        if ( $file !~ m/.*Module\/.*$/xms ) { # TEMP DEBUGGING, ONLY FIND FILES IN A CERTAIN DIRECTORY
#        if ( $file =~ m/^(.*foo_bar_arith.*)[.].*OPS.*$/xms ) { # TEMP DEBUGGING, ONLY FIND CERTAIN FILES
        if ( $file =~ m/^(.+)[.]\w+OPS_\w+TYPES$/gxms ) {    # find all pre-compiled files
            my string $file_base = $1;
#            RPerl::diag('in 13_generate.t, have pre-compiled $file        = ' . $file . "\n");
#            RPerl::diag('in 13_generate.t, have pre-compiled $file_base   = ' . $file_base . "\n");
            if (($file_base =~ m/^(.*)[.]cpp$/gxms) or ($file_base =~ m/^(.*)[.]h$/gxms) or ($file_base =~ m/^(.*)[.]pmc$/gxms)) {
                my string $file_prefix = $1;
#                RPerl::diag('in 13_generate.t, find1, have pre-compiled $file_prefix = ' . $file_prefix . "\n");

                # restore saved path, because File::Find changes directories while searching for files
                my string $file_program = $file_prefix . '.pl';
                my string $file_module = $file_prefix . '.pm';
#                RPerl::diag('in 13_generate.t, find1, have $file_program = ' . $file_program . "\n");
#                RPerl::diag('in 13_generate.t, find1, have $file_module = ' . $file_module . "\n");
                my $file_program_full_path = File::Spec->catpath( $volume, $directories, $file_program );
                my $file_module_full_path = File::Spec->catpath( $volume, $directories, $file_module );
#                RPerl::diag('in 13_generate.t, find1, have $file_program_full_path = ' . $file_program_full_path . "\n");
#                RPerl::diag('in 13_generate.t, find1, have $file_module_full_path = ' . $file_module_full_path . "\n");

                if ((-e $file_program_full_path) and (-f $file_program_full_path) and (-T $file_program_full_path)) {
#                    RPerl::diag('in 13_generate.t, find1, have all reference code for *.pl file, pre-compiled $file_prefix = ' . $file_prefix . "\n");
                    $test_files->{$file_prefix . '.pl'} = undef;
                }
                elsif ((-e $file_module_full_path) and (-f $file_module_full_path) and (-T $file_module_full_path)) {
#                    RPerl::diag('in 13_generate.t, find1, have all reference code for *.pm file, pre-compiled $file_prefix = ' . $file_prefix . "\n");
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
    (defined $ARGV[0]) ? $ARGV[0] : PATH_PRECOMPILED()  # accept optional command-line argument
);

#=cut

# trim unnecessary (and possibly problematic) absolute paths from input file names
# must be done outside find() to properly utilize getcwd()
foreach my string $test_file_key (sort keys %{$test_files}) {
    my string $test_file_key_trimmed = RPerl::Compiler::post_processor__absolute_path_delete($test_file_key);
    if ($test_file_key_trimmed ne $test_file_key) {
        $test_files->{$test_file_key_trimmed} = $test_files->{$test_file_key};
        delete $test_files->{$test_file_key};
    }
}

my integer $number_of_test_files = scalar keys %{$test_files};

#RPerl::diag( 'in 13_generate.t, have $test_files = ' . "\n" . Dumper($test_files) . "\n" );
#RPerl::diag( 'in 13_generate.t, have sort keys %{$test_files} = ' . "\n" . Dumper(sort keys %{$test_files}) . "\n" );
#RPerl::diag( 'in 13_generate.t, before primary runloop, have $number_of_test_files = ' . $number_of_test_files . "\n" );

#plan tests => $number_of_test_files + 1;         # (PERLOPS_PERLTYPES or  CPPOPS_CPPTYPES) + lives_ok(rperltypes::types_enable())
plan tests => (($number_of_test_files + 1) * 2);  # (PERLOPS_PERLTYPES and CPPOPS_CPPTYPES tests) + lives_ok(rperltypes::types_enable())

my string_hashref $modes;
my hashref_arrayref $output_file_name_groups_tmp;
my string_hashref $output_file_name_group;
my string_hashref $reference_file_name_group;
my string $test_file_reference;
my boolean $perform_diff_check;
my unknown $eval_return_value;
my hashref $diff_check_retval;
#my integer $number_of_tests_run = 0;

# [[[ PRIMARY RUNLOOP ]]]
# [[[ PRIMARY RUNLOOP ]]]
# [[[ PRIMARY RUNLOOP ]]]

# loop up to 3 times, once for each mode: PERLOPS_PERLTYPES, PERLOPS_CPPTYPES, CPPOPS_CPPTYPES
#foreach my integer $mode_id ( sort keys %{$RPerl::MODES} ) {
#for my $mode_id ( 0 ) {    # PERLOPS_PERLTYPES ONLY
#for my $mode_id ( 2 ) {    # CPPOPS_CPPTYPES ONLY
#for my $mode_id ( 0 , 2 ) {    # PERLOPS_PERLTYPES, CPPOPS_CPPTYPES
for my $mode_id ( 2 , 0 ) {    # CPPOPS_CPPTYPES, PERLOPS_PERLTYPES; DEV NOTE: reverse order because many C++ tests are currently skipped, more accurate time-to-finish
#    RPerl::diag("in 13_generate.t, top of for() loop, have \$mode_id = $mode_id\n");
#    $number_of_test_files = scalar keys %{$test_files};
#    RPerl::diag( 'in 13_generate.t, top of primary runloop, have $number_of_test_files = ' . $number_of_test_files . "\n" );

    # [[[ MODE SETUP ]]]
    my scalartype_hashref $mode = $RPerl::MODES->{$mode_id};
    my $ops                 = $mode->{ops};
    my $types               = $mode->{types};
    my string $mode_tagline = $ops . 'OPS_' . $types . 'TYPES';
    if ( $ENV{RPERL_VERBOSE} ) {
        Test::More::diag( '[[[ Beginning Generator Tests, RPerl Compilation System, ' . $ops . ' Operations & ' . $types . ' Data Types' . ' ]]]' );
    }

    lives_ok( sub { rperltypes::types_enable($types) }, q{mode '} . $ops . ' Operations & ' . $types . ' Data Types' . q{' enabled} );
#    $number_of_tests_run++;

    # [[[ SECONDARY RUNLOOP ]]]
    # [[[ SECONDARY RUNLOOP ]]]
    # [[[ SECONDARY RUNLOOP ]]]

    TEST_FILE_LOOP: foreach my $test_file ( sort keys %{$test_files} ) {
        $reference_file_name_group = {};
#        RPerl::diag( 'in 13_generate.t, top of secondary runloop, have $test_file = ' . $test_file . "\n" );
#        $number_of_test_files = scalar keys %{$test_files};
#        RPerl::diag( 'in 13_generate.t, top of secondary runloop, have $number_of_test_files = ' . $number_of_test_files . "\n" );

        $modes = {
            dependencies => 'ON',
            ops     => $ops,
            types   => $types,
#            check        => 'TRACE',  # unnecessary
#            uncompile    => 'OFF',  # unnecessary
            compile => 'GENERATE',    # don't save source code to disk, will diff check from memory
            subcompile   => 'DYNAMIC',  # must be DYNAMIC for Subroutine::ast_to_cpp__generate_shims__CPPOPS_CPPTYPES() to generate PMC output
#            CXX          => 'g++',  # unnecessary
            parallel => 'OFF',
            execute => 'OFF',
            label   => 'OFF'          # don't label source code, will strip comments before diff check
        };

        # DEV NOTE: must recursively find & parse ((great)*grand)?parents to receive any inherited class $properties
        my string_arrayref $parent_files = RPerl::Compiler::find_parents( $test_file, 1, $modes );  # second argument set to 1 for true value of $find_grandparents_recurse

        # generate starting with furthest ancestor & ending with parent,
        # to avoid errors due to one parent not properly receiving their own inheritance from an older grandparent, etc.
        $parent_files = [reverse @{$parent_files}];

#        RPerl::diag( 'in 13_generate.t, have $parent_files = ' . Dumper($parent_files) );

        foreach my string $parent_file (@{$parent_files}) {
            # trim unnecessary (and possibly problematic) absolute paths from parent file names
            $parent_file = RPerl::Compiler::post_processor__absolute_path_delete( $parent_file );
    
            # [[[ PARSE PARENTS ]]]
            $eval_return_value = eval { RPerl::Parser::rperl_to_ast__parse($parent_file); };
            if ( not( ( defined $eval_return_value ) and $eval_return_value ) ) {
                ok( 0, q{Program or module's parent parses with errors, code generation not reached, test aborted:} . (q{ } x 2) . $parent_file );
                diag('Error output captured:' . "\n" . $EVAL_ERROR);
                next;
            }
            my object $rperl_ast_parent = $eval_return_value;

            $modes->{_input_file_name} = $parent_file;

            # [[[ GENERATE PARENTS ]]]
            # reset symbol table namespace & subroutine for each generate phase of each file,
            # do not delete entire symbol table because we need parsed parent files for inherited OO properties
            $modes->{_symbol_table}->{_namespace} = q{};
            $modes->{_symbol_table}->{_subroutine} = q{};

            if ( $ops eq 'PERL' ) {
                $eval_return_value = eval { RPerl::Generator::ast_to_rperl__generate( $rperl_ast_parent, $modes ); };
#                RPerl::diag( 'in 13_generate.t, have $ops = ' . $ops . ', $parent_file = ' . $parent_file . ', $eval_return_value = ' . Dumper($eval_return_value) );
            }
            else {    # $ops eq 'CPP'
                $eval_return_value = eval { RPerl::Generator::ast_to_cpp__generate( $rperl_ast_parent, $modes ); };
#                RPerl::diag( 'in 13_generate.t, have $ops = ' . $ops . ', $parent_file = ' . $parent_file . ', $eval_return_value = ' . Dumper($eval_return_value) );
            }
#            RPerl::diag( 'in 13_generate.t, have $ops = ' . $ops . ', $modes = ' . Dumper($modes) );
#            RPerl::diag( 'in 13_generate.t, have $ops = ' . $ops . ', $modes->{_symbol_table} = ' . Dumper($modes->{_symbol_table}) );
        }

        # DEV NOTE: do not actually follow or compile dependencies;
        # find RPerl system deps such as 'use rperlsse;', 'use rperlgmp;', 'use rperlgsl;', etc.;
        # ignore return value, here we only care about $modes->{_enable_sse}, $modes->{_enable_gmp}, $modes->{_enable_gsl}, etc.;
#        find_dependencies( $test_file, 0, $modes );  # second argument set to 0 for false value of $find_subdependencies_recurse

        $output_file_name_groups_tmp = RPerl::Compiler::generate_output_file_names( [$test_file], [], 1, $modes );
        $output_file_name_group = $output_file_name_groups_tmp->[0];

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

                    if (( not -e $test_file_reference ) or ( not -f $test_file_reference ) or ( not -T $test_file_reference )) {
                        # CPP ops mode will always require some CPP output file, regardless of H or PMC output file(s), skip before reaching parse or generate below
                        if ($cpp_skip_parse_gen_if_no_ref_files) { 
                            print $verbose_newline;
                            ok( 1, 'Program or module is missing a pre-compiled reference file, no diff check, skipped early:' . (q{ } x 2) . $test_file );
#                            $number_of_tests_run++;
                            next TEST_FILE_LOOP;
                        }
                        # CPP reference file is missing, but go forward with parse & generate anyway, just don't try to perform a diff check
                        $perform_diff_check = 0;
                    }
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

        # [[[ PARSE ]]]
        $eval_return_value = eval { RPerl::Parser::rperl_to_ast__parse($test_file); };
        if ( not( ( defined $eval_return_value ) and $eval_return_value ) ) {
            ok( 0, 'Program or module parses with errors, code generation not reached, test aborted:' . (q{ } x 2) . $test_file );
            diag('Error output captured:' . "\n" . $EVAL_ERROR);
#            $number_of_tests_run++;
            next;
        }
        my object $rperl_ast = $eval_return_value;

#        RPerl::diag( 'in 13_generate.t, have $ops = ' . $ops . "\n" );
#        RPerl::diag( 'in 13_generate.t, have $types = ' . $types . "\n" );

        $modes->{_input_file_name} = $test_file;
        $modes->{_input_file_name_current} = $test_file;
 
        # [[[ GENERATE ]]]
        # reset symbol table namespace & subroutine for each generate phase of each file,
        # do not delete entire symbol table because we need parsed parent files for inherited OO properties
        $modes->{_symbol_table}->{_namespace} = q{};
        $modes->{_symbol_table}->{_subroutine} = q{};

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
#            RPerl::diag( 'in 13_generate.t, have $source_group->{H} = ' . "\n" . $source_group->{H} . "\n\n" );
#            RPerl::diag( 'in 13_generate.t, have sort keys %{ $source_group } = ' . Dumper( [ sort keys %{$source_group} ] ) );

            if ( $ops eq 'CPP' ) {
                # CPPOPS POST-PROCESSING: set H paths in CPP files & finally create PMC file, as needed
                $source_group->{CPP} = RPerl::Compiler::post_processor_cpp__header_unneeded( $source_group );
                $source_group->{CPP} = RPerl::Compiler::post_processor_cpp__header_or_cpp_path( $source_group->{CPP}, $output_file_name_group->{H} );
            }

            if (( $ops eq 'CPP' ) and (exists $output_file_name_group->{PMC}) and (defined $output_file_name_group->{PMC})) {
                # generate PMC source code
                RPerl::Compiler::post_processor_cpp__pmc_generate( $source_group, $output_file_name_group, $modes );
            }

            if ( ( $test_file =~ m/Bad/xms ) or ( $test_file =~ m/bad/xms ) ) {    # file named *Bad* or *bad*
#                RPerl::diag( 'in 13_generate.t, have $test_file NOT named *Good* or *good*' . "\n" );

                # skip test if dummy source code found
                if ( not RPerl::Generator::dummy_source_code_find($source_group) ) {
                    ok( 0, 'Program or module generates with errors:' . (q{ } x 21) . $test_file );
#                    $number_of_tests_run++;
                }
                else { 
                    ok( 1, 'Program or module generates with errors, unfinished C++ generator called, test skipped:' . (q{ } x 3) . $test_file );
#                    RPerl::diag( 'in 13_generate.t, DUMMY SOURCE CODE found, from $source_group:' . "\n" . Dumper($source_group) . "\n" );
#                    $number_of_tests_run++;
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
#                        $number_of_test_files = scalar keys %{$test_files};
#                        RPerl::diag( 'in 13_generate.t, top of tertiary runloop, have $number_of_test_files = ' . $number_of_test_files . "\n" );

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

                        $diff_check_retval = RPerl::Generator::diff_check_file_vs_string( $test_file_reference, $source_group, $suffix_key, $output_file_name_group, $modes );

                        #                        RPerl::diag( 'in 13_generate.t, have $diff_check_retval->{diff_line} = ' . $diff_check_retval->{diff_line} . "\n" );
                        if ( $diff_check_retval->{diff_line} != 0 ) {
#                            RPerl::diag( 'in 13_generate.t, near bottom of suffix loop, have $diff_check_retval->{diff_line} = ' . $diff_check_retval->{diff_line} . ', $suffix_key = ' . $suffix_key . "\n" );
                            last;
                        }
#                        RPerl::diag( 'in 13_generate.t, bottom of tertiary runloop, have $suffix_key = ' . $suffix_key . "\n" );
#                        $number_of_test_files = scalar keys %{$test_files};
#                        RPerl::diag( 'in 13_generate.t, bottom of tertiary runloop, have $number_of_test_files = ' . $number_of_test_files . "\n" );
                    }
                    # NEED ANSWER: why is $suffix_key cleared when the loop is completed?
                    $suffix_key = $suffix_key_saved;
                    $suffix_key_saved = undef;
#                    RPerl::diag( 'in 13_generate.t, after suffix loop, have $suffix_key = ' . $suffix_key . "\n" );

                    if ( $diff_check_retval->{diff_line} == 0 ) {
                        ok( 1, 'Program or module generates without errors, yes diff check:' . (q{ } x 2) . $test_file );
#                        $number_of_tests_run++;
                    }
                    elsif ( $diff_check_retval->{diff_line} > 0 ) {
#                        ok( 0, 'Program or module generates without errors, yes diff check, output file ' . $output_file_name_group->{$suffix_key} . ' and reference file ' . $test_file_reference . ' differ at line ' . $diff_check_retval->{diff_line} );
                        ok( 0, 'Program or module generates without errors, yes diff check, output file ' . $output_file_name_group->{$suffix_key} . ' and reference file ' . $test_file_reference . ' differ at line ' . $diff_check_retval->{diff_line} . ', have $diff_check_retval->{line_reference} = ' . "\n" . $diff_check_retval->{line_reference} . "\n" . 'have $diff_check_retval->{line_generated} = ' . "\n" . $diff_check_retval->{line_generated} . "\n");
#                        $number_of_tests_run++;
                    }
                    else {    # $diff_check_retval->{diff_line} < 0
                              # skip __DUMMY_SOURCE_CODE results, indicated by $diff_check_retval->{diff_line} < 0
                        ok( 1, 'Program or module generates without errors, yes diff check, unfinished C++ generator called, test skipped:' . (q{ } x 3) . $test_file );
#                        $number_of_tests_run++;
#                        RPerl::diag( 'in 13_generate.t, DUMMY SOURCE CODE found in diff check' . "\n" );
                    }
                }
                else {
#                    RPerl::diag( 'in 13_generate.t, do NOT need to perform diff check(s)' . "\n" );

                    # skip test if dummy source code found
                    if ( not RPerl::Generator::dummy_source_code_find($source_group) ) {
                        ok( 1, 'Program or module generates without errors, no diff check:' . (q{ } x 3) . $test_file );
#                        $number_of_tests_run++;
                    }
                    else { 
                        ok( 1, 'Program or module generates without errors, no diff check, unfinished C++ generator called, test skipped:' . (q{ } x 3) . $test_file );
#                        $number_of_tests_run++;
#                        RPerl::diag( 'in 13_generate.t, DUMMY SOURCE CODE found, from $source_group:' . "\n" . Dumper($source_group) . "\n" );
                    }
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
                if ((exists $test_files->{$test_file}) and (defined $test_files->{$test_file}) and 
                    (exists $test_files->{$test_file}->{errors}) and (defined $test_files->{$test_file}->{errors})) {
                    foreach my $error ( @{ $test_files->{$test_file}->{errors} } ) {
#                    RPerl::diag( 'in 13_generate.t, have possible $error = ', $error, "\n" );
                        if ( $EVAL_ERROR !~ /\Q$error\E/xms ) {
                            push @{$missing_errors}, q{Error message '} . $error . q{' expected, but not found};
                        }
                    }
                }
                print $verbose_newline;
                ok( ( ( scalar @{$missing_errors} ) == 0 ), 'Program or module generates with expected error(s):' . (q{ } x 10) . $test_file );
                if (( scalar @{$missing_errors} ) != 0) {
                    diag((join "\n", @{$missing_errors}) . "\n");
                }
#                $number_of_tests_run++;
            }
            else {
#                RPerl::diag( 'in 13_generate.t, have $test_file NOT named *Bad* or *bad*' . "\n" );
                if ( $EVAL_ERROR =~ /Can't\slocate\sobject\smethod\s"ast_to_\w*__generate"\svia\spackage/xms ) {
                    ok( 0, 'Program or module generates without errors, missing code generator:' . (q{ } x 1) . $test_file );
                    diag('Error output captured:' . "\n" . $EVAL_ERROR);
#                    $number_of_tests_run++;
                }
                else {
                    ok( 0, 'Program or module generates without errors:' . (q{ } x 18) . $test_file );
                    diag('Error output captured:' . "\n" . $EVAL_ERROR);
#                    $number_of_tests_run++;
                }
            }
        }
#        RPerl::diag( ( '-' x 100 ) . "\n" );
#        die 'TMP DEBUG';
        $number_of_test_files = scalar keys %{$test_files};
#        RPerl::diag( 'in 13_generate.t, bottom of secondary runloop, have $number_of_test_files = ' . $number_of_test_files . "\n" );
    }
#    RPerl::diag( ( '=' x 100 ) . "\n" );

    $number_of_test_files = scalar keys %{$test_files};
#    RPerl::diag( 'in 13_generate.t, bottom of primary runloop, have $number_of_test_files = ' . $number_of_test_files . "\n" );
}

done_testing();
#done_testing($number_of_tests_run);
