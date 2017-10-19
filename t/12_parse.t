#!/usr/bin/perl  ## no critic qw(ProhibitExcessMainComplexity)  # SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1

# [[[ PRE-HEADER ]]]
# suppress 'WEXRP00: Found multiple rperl executables' due to blib/ & pre-existing installation(s),
# also 'WARNING WCOCODE00, COMPILER, FIND DEPENDENCIES: Failed to eval-use package' due to RPerl/Test/*/*Bad*.pm & RPerl/Test/*/*bad*.pl
BEGIN { $ENV{RPERL_WARNINGS} = 0; }

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.013_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireBriefOpen)  # USER DEFAULT 5: allow open() in perltidy-expanded code
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitDeepNests)  # SYSTEM SPECIAL 7: allow deeply-nested code

# [[[ INCLUDES ]]]
use RPerl::Parser;
use RPerl::Generator;
use RPerl::Compiler;
use Test::More;
use Test::Exception;
use File::Find qw(find);
use English;  # $EVAL_ERROR not defined after moving RPerl::* into lives_and() tests in BEGIN block below
use Cwd;
use File::Spec;

# [[[ CONSTANTS ]]]
use constant PATH_TESTS => my string $TYPED_PATH_TESTS = $RPerl::INCLUDE_PATH . '/RPerl/Test';

# [[[ OPERATIONS ]]]
our $verbose_newline = q{};
if ( $ENV{RPERL_VERBOSE} or $RPerl::VERBOSE ) {
    $verbose_newline = "\n";
}

BEGIN {
    if ( $ENV{RPERL_VERBOSE} or $RPerl::VERBOSE ) {
        Test::More::diag("[[[ Beginning Parser Pre-Test Loading, RPerl Compilation System ]]]");
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

# DEV NOTE: must specify number of tests in EITHER 'plan tests' or done_testing() below, not both
#my integer $number_of_tests_run = 4;  # initialize to 4 for use_ok() calls in BEGIN block above

my $test_files = {};    # string_hashref

# save current directory for file checks, because File::Find changes directory;
# use File::Spec for MS Windows support, etc.
my $current_working_directory = getcwd;
(my $volume, my $directories, my $dummy_file) = File::Spec->splitpath( $current_working_directory, 1 );  # no_file = 1

find(
    sub {
        my $file = $File::Find::name;

        #        RPerl::diag('in 12_parse.t, have $file = ' . $file . "\n");

        if (defined $ARGV[0]) {
            # restore saved path, because File::Find changes directories while searching for files
            my $file_full_path = File::Spec->catpath( $volume, $directories, $file );
            RPerl::diag('in 12_parse.t, have $file_full_path = ' . $file_full_path . "\n");
            $file = $file_full_path;
        }

#        if ( $file !~ m/.*Header\/program_00_bad_00.*[.]p[lm]$/xms ) { # TEMP DEBUGGING, ONLY FIND CERTAIN FILES
#        if ( $file !~ m/.*Operator12CompareEqualNotEqual\/\w+[.]p[lm]$/xms ) { # TEMP DEBUGGING, ONLY FIND CERTAIN DIRECTORY
        if ( $file !~ m/.p[lm]$/xms ) {  # FIND ALL TEST FILES
            return;
        }

        if ( ( $file =~ m/Good/ms ) or ( $file =~ m/good/ms ) ) {
            $test_files->{$file} = undef;
        }
        elsif ( ( $file =~ m/Bad/ms ) or ( $file =~ m/bad/ms ) ) {

            # NEED FIX: remove use of $_ magic variable
            open my filehandleref $FILE_HANDLE, '<', $_
                or croak 'ERROR, Cannot open file ' . $file . ' for reading,' . $OS_ERROR . ', croaking';
            while (<$FILE_HANDLE>) {
                if (m/^\#\s*\<\<\<\s*PARSE_ERROR\s*\:\s*['"](.*)['"]\s*\>\>\>/xms) {
                    push @{ $test_files->{$file}->{errors} }, $1;
                }
            }
            close $FILE_HANDLE
                or croak 'ERROR, Cannot close file ' . $file . ' after reading,' . $OS_ERROR . ', croaking';
        }
        else {
            return;
        }
    },
    (defined $ARGV[0]) ? $ARGV[0] : PATH_TESTS()  # accept optional command-line argument
);

my integer $number_of_test_files = scalar keys %{$test_files};

#RPerl::diag( 'in 12_parse.t, have $test_files = ' . "\n" . Dumper($test_files) . "\n" );
#RPerl::diag( 'in 12_parse.t, have sort keys %{$test_files} = ' . "\n" . Dumper(sort keys %{$test_files}) . "\n" );
#RPerl::diag( 'in 12_parse.t, have $number_of_test_files = ' . $number_of_test_files . "\n" );

plan tests => $number_of_test_files;

if ( $ENV{RPERL_VERBOSE} ) {
    Test::More::diag( '[[[ Beginning Parser Tests, RPerl Compilation System' . ' ]]]' );
}

# [[[ PRIMARY RUNLOOP ]]]
# [[[ PRIMARY RUNLOOP ]]]
# [[[ PRIMARY RUNLOOP ]]]

for my $test_file ( sort keys %{$test_files} ) {
    # trim unnecessary (and possibly problematic) absolute paths from input file names
    $test_file = RPerl::Compiler::post_processor__absolute_path_delete( $test_file );

    #    RPerl::diag( 'in 12_parse.t, have $test_file = ' . $test_file . "\n" );
    ( my string $rperl_input_file_name, my string_hashref $cpp_output_file_name_group, my string_hashref $cpp_source_group, my string_hashref $modes ) = @ARG;

    # NEED UPGRADE: enable file dependencies as in script/rperl depends_parse_generate_save_subcompile_execute()
    my $eval_return_value = eval {
        RPerl::Compiler::rperl_to_xsbinary__parse_generate_compile(
            $test_file,
            undef,    # empty $cpp_output_file_name_group, no files will be saved in PARSE mode
            {},       # empty $cpp_source_group, starting compile process from scratch, not continued
            {   
#                dependencies => 'OFF',  # unnecessary
                ops     => 'PERL',
                types   => 'PERL',
#                check        => 'TRACE',    # unnecessary
                uncompile    => 'OFF',
                compile => 'PARSE',
#                subcompile   => 'OFF',  # unnecessary
#                CXX          => 'g++',  # unnecessary
                parallel => 'OFF',
#                execute => 'OFF',  # unnecessary
#                label   => 'OFF'   # unnecessary
            }
        );    # returns void
        1;    # return true
    };

#    RPerl::diag( 'in 12_parse.t, have $eval_return_value = ' . $eval_return_value . "\n" );  # warning if undef retval

    if ( ( defined $eval_return_value ) and $eval_return_value ) {    # Perl eval return code defined & true, success
        if ( ( $test_file =~ m/Good/xms ) or ( $test_file =~ m/good/xms ) ) {
            ok( 1, 'Program or module parses without errors:' . (q{ } x 10) . $test_file );
#            $number_of_tests_run++;
        }
        else {
            ok( 0, 'Program or module parses with errors:' . (q{ } x 13) . $test_file );
#            $number_of_tests_run++;
        }
    }
    else {                                                            # Perl eval return code undefined or false, error
        print $verbose_newline;

#        RPerl::diag( "\n\n\n" . 'in 12_parse.t, have $EVAL_ERROR = ' . $EVAL_ERROR . "\n\n\n" );
        if ( ( $test_file =~ m/Bad/ms ) or ( $test_file =~ m/bad/ms ) ) {
            my $missing_errors = [];
            if ( defined $test_files->{$test_file}->{errors} ) {
                foreach my $error ( @{ $test_files->{$test_file}->{errors} } ) {
                    # DEV NOTE: debug to show which tests trigger a Helpful Hint
#                    if ( $EVAL_ERROR =~ /Helpful\ Hint/xms ) {
#                        print '[[[ YES HELPFUL HINT ' . $test_file . ' ]]]' . "\n\n";
#                    }
                    
                    if ( $EVAL_ERROR !~ /\Q$error\E/xms ) {
                        push @{$missing_errors}, "Error message '$error' expected, but not found";
                    }
                }
            }
            ok( ( ( scalar @{$missing_errors} ) == 0 ), 'Program or module parses with expected error(s):' . (q{ } x 2) . $test_file );
            if (( scalar @{$missing_errors} ) != 0) {
                diag((join "\n", @{$missing_errors}) . "\n");
            }
#            $number_of_tests_run++;
        }
        else {
            ok( 0, 'Program or module parses without errors:' . (q{ } x 10) . $test_file );
            diag('Error output captured:' . "\n" . $EVAL_ERROR);
#            $number_of_tests_run++;
        }
    }
}

#RPerl::diag( 'in 12_parse.t, have $number_of_tests_run =' . $number_of_tests_run . "\n" );

done_testing();
#done_testing($number_of_tests_run);
