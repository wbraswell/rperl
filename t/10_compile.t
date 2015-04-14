#!/usr/bin/perl  ## no critic qw(ProhibitExcessMainComplexity)  # SYSTEM SPECIAL 5: allow complex code outside subroutines, must be on line 1

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.005_004;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireBriefOpen)  # USER DEFAULT 5: allow open() in perltidy-expanded code
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitDeepNests)  # SYSTEM SPECIAL 8: allow deeply-nested code

# [[[ INCLUDES ]]]
use RPerl::Parser;
use RPerl::Generator;
use RPerl::Compiler;
use Test::More;
use File::Find qw(find);
use File::Temp qw(tempfile);

# [[[ OPERATIONS ]]]

my $test_files = {};    # string__hash_ref
find(
    sub {
        my $file = $File::Find::name;

        #        RPerl::diag('in 10_compile.t, have $file = ' . $file . "\n");

        if ( ( $file !~ m/.pm$/xms ) and ( $file !~ m/.pl$/xms ) ) {
            return;
        }

        if ( ( $file =~ m/Good/ms ) or ( $file =~ m/good/ms ) ) {
            $test_files->{$file} = undef;
        }
        elsif ( ( $file =~ m/Bad/ms ) or ( $file =~ m/bad/ms ) ) {

            # NEED FIX: remove use of $_ magic variable
            open my $fh, '<', $_
                or croak 'ERROR, Cannot open file '
                . $file
                . ' for reading,'
                . $OS_ERROR
                . ', croaking';
            while (<$fh>) {
                if (m/^\#\s*\<\<\<\s*COMPILE_ERROR\s*\:\s*['"](.*)['"]\s*\>\>\>/xms
                    )
                {
                    push @{ $test_files->{$file}->{errors} }, $1;
                }
            }
            close $fh
                or croak 'ERROR, Cannot close file '
                . $file
                . ' after reading,'
                . $OS_ERROR
                . ', croaking';
        }
        else {
            return;
        }
    },
    $RPerl::INCLUDE_PATH . '/RPerl/Test'
);

#RPerl::diag( 'in 10_compile.t, have $test_files = ' . "\n" . Dumper($test_files) . "\n" );

plan tests => scalar keys %{$test_files};

my $temp_file = tempfile();

for my $test_file ( sort keys %{$test_files} ) {

#    RPerl::diag( 'in 10_compile.t, have $test_file = ' . $test_file . "\n" );

    my $eval_return_value = eval {
        rperl_to_xsbinary__parse_generate_compile(
            $test_file,
            $temp_file,
            {   ops     => 'CPP',
                types   => 'CPP',
                compile => 'PARSE',
                execute => 'OFF'
            }
        );  # returns void
        1;  # return true
    };
#    RPerl::diag( 'in 10_compile.t, have $eval_return_value = ' . $eval_return_value . "\n" );  # warning if undef retval

    if ((defined $eval_return_value) and $eval_return_value) {    # Perl eval return code defined & true, success
        if ( ( $test_file =~ m/Good/xms ) or ( $test_file =~ m/good/xms ) ) {
            ok( 1, "Program or module $test_file compiles without errors" );
        }
        else {
            ok( 0, "Program or module $test_file compiles with errors" );
        }
    }
    else {                       # Perl eval return code undefined or false, error

#        RPerl::diag( 'in 10_compile.t, have $EVAL_ERROR = ' . $EVAL_ERROR . "\n" );
        if ( ( $test_file =~ m/Bad/ms ) or ( $test_file =~ m/bad/ms ) ) {
            my $missing_errors = [];
            if ( defined $test_files->{$test_file}->{errors} ) {
                foreach my $error ( @{ $test_files->{$test_file}->{errors} } )
                {
                    if ( $EVAL_ERROR !~ /\Q$error\E/xms ) {
                        push @{$missing_errors},
                            "Error message '$error' expected, but not found";
                    }
                }
            }
            ok( ( ( scalar @{$missing_errors} ) == 0 ),
                "Program or module $test_file compiles with expected error(s)"
            );
        }
        else {
            ok( 0, "Program or module $test_file compiles without errors" );
        }
    }
}

unlink $temp_file;
