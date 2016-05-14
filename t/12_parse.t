#!/usr/bin/perl  ## no critic qw(ProhibitExcessMainComplexity)  # SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1

# suppress 'WEXRP00: Found multiple rperl executables' due to blib/ & pre-existing installation(s),
# also 'WARNING WCVCODE00, COMPILER, FIND DEPENDENCIES: Failed to eval-use package' due to RPerl/Test/*/*Bad*.pm & RPerl/Test/*/*bad*.pl
BEGIN { $ENV{RPERL_WARNINGS} = 0; }

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.005_300;

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
use File::Find qw(find);

# [[[ OPERATIONS ]]]

my $test_files = {};    # string_hashref
find(
    sub {
        my $file = $File::Find::name;

        #        RPerl::diag('in 12_parse.t, have $file = ' . $file . "\n");

#        if ( $file !~ m/.*LiteralString\/Package_SingleQuotes_00.*[.]p[lm]$/xms ) { # TEMP DEBUGGING, ONLY FIND CERTAIN FILES
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
    $RPerl::INCLUDE_PATH . '/RPerl/Test'
);

#RPerl::diag( 'in 12_parse.t, have $test_files = ' . "\n" . Dumper($test_files) . "\n" );
#RPerl::diag( 'in 12_parse.t, have sort keys %{$test_files} = ' . "\n" . Dumper(sort keys %{$test_files}) . "\n" );

plan tests => scalar keys %{$test_files};

for my $test_file ( sort keys %{$test_files} ) {

    #    RPerl::diag( 'in 12_parse.t, have $test_file = ' . $test_file . "\n" );
    ( my string $rperl_input_file_name, my string_hashref $cpp_output_file_name_group, my string_hashref $cpp_source_group, my string_hashref $modes ) = @_;

    # NEED UPGRADE: enable file dependencies as in script/rperl depends_parse_generate_save_subcompile_execute()
    my $eval_return_value = eval {
        rperl_to_xsbinary__parse_generate_compile(
            $test_file,
            undef,    # empty $cpp_output_file_name_group, no files will be saved in PARSE mode
            {},       # empty $cpp_source_group, starting compile process from scratch, not continued
            {   
                dependencies => 'ON',
                ops     => 'PERL',
                types   => 'PERL',
#                check        => 'TRACE',    # unnecessary
                uncompile    => 'OFF',
                compile => 'PARSE',
#                subcompile   => 'OFF',  # unnecessary
#                CXX          => 'g++',  # unnecessary
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
        }
        else {
            ok( 0, 'Program or module parses with errors:' . (q{ } x 13) . $test_file );
        }
    }
    else {                                                            # Perl eval return code undefined or false, error

        #        RPerl::diag( 'in 12_parse.t, have $EVAL_ERROR = ' . $EVAL_ERROR . "\n" );
        if ( ( $test_file =~ m/Bad/ms ) or ( $test_file =~ m/bad/ms ) ) {
            my $missing_errors = [];
            if ( defined $test_files->{$test_file}->{errors} ) {
                foreach my $error ( @{ $test_files->{$test_file}->{errors} } ) {
                    if ( $EVAL_ERROR !~ /\Q$error\E/xms ) {
                        push @{$missing_errors}, "Error message '$error' expected, but not found";
                    }
                }
            }
            ok( ( ( scalar @{$missing_errors} ) == 0 ), 'Program or module parses with expected error(s):' . (q{ } x 2) . $test_file );
        }
        else {
            ok( 0, 'Program or module parses without errors:' . (q{ } x 10) . $test_file );
        }
    }
}