#!/usr/bin/perl

# START HERE: get this file to pass critic, create CHECK tests, create more GA tests, fix 10_compile.t to pass critics etc, remove CHECK from grammar, add PREPROCESSOR where missing
# START HERE: get this file to pass critic, create CHECK tests, create more GA tests, fix 10_compile.t to pass critics etc, remove CHECK from grammar, add PREPROCESSOR where missing
# START HERE: get this file to pass critic, create CHECK tests, create more GA tests, fix 10_compile.t to pass critics etc, remove CHECK from grammar, add PREPROCESSOR where missing

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ INCLUDES ]]]
use RPerl::Parser;
use RPerl::Translator;
use RPerl::Generator;
use RPerl::Compiler;
use File::Find qw(find);
use Test::More;
use IPC::Open3;
use IO::Select;

# [[[ OPERATIONS ]]]

my $test_files = {};    # string__hash_ref
find(
    sub {
        my $file = $File::Find::name;

#        RPerl::diag('in 08_interpret_run_program.t, have $file = ' . $file . "\n");

        if ( $file !~ m/.pl$/xms ) {
            return;
        }

        if ( ( $file =~ m/Good/ms ) or ( $file =~ m/good/ms ) ) {
            open my $fh, '<', $_ or die "Cannot open $file:$!\n";
            while (<$fh>) {
                if (m/^\#\s*\<\<\<\s*RUN_SUCCESS\s*\:\s*['"](.*)['"]\s*\>\>\>/
                    )
                {
                    push @{ $test_files->{$file}->{successes} }, $1;
                }
            }
            close $fh;
        }
        elsif ( ( $file =~ m/Bad/ms ) or ( $file =~ m/bad/ms ) ) {
            open my $fh, '<', $_ or die "Cannot open $file:$!\n";
            while (<$fh>) {
                if (m/^\#\s*\<\<\<\s*RUN_ERROR\s*\:\s*['"](.*)['"]\s*\>\>\>/)
                {
                    push @{ $test_files->{$file}->{errors} }, $1;
                }
            }
            close $fh;
        }
        else {
            return;
        }
    },
    $RPerl::INCLUDE_PATH . '/RPerl/Test'
);

RPerl::diag('in 08_interpret_run_program.t, have $test_files = ' . "\n" . Dumper($test_files) . "\n");

plan tests => scalar keys %{$test_files};

for my $test_file ( sort keys %{$test_files} ) {
    my $pid           = open3( 0, \*STDOUT_TEST, \*STDERR_TEST, $test_file );
    my $stdout_select = new IO::Select();
    my $stderr_select = new IO::Select();
    $stdout_select->add( \*STDOUT_TEST );
    $stderr_select->add( \*STDERR_TEST );
    my $stdout_generated = q{};
    my $stderr_generated = q{};

    # DISABLED: no user input accepted
    #    while (1) {
    #        print "Enter input\n";
    #        chomp( my $stdin_received = <STDIN_TEST> );
    #        print STDIN_TEST "$stdin_received\n";

#    select( undef, undef, undef, 0.1 ); # allow time for output to be generated; not needed with waitpid() before sysread() calls below

#        if ( $stdout_select->can_read(0) )  { RPerl::diag('in 08_interpret_run_program.t, can read STDOUT_TEST for $test_file = ' . $test_file . "\n"); }
#        if ( $stderr_select->can_read(0) )  { RPerl::diag('in 08_interpret_run_program.t, can read STDERR_TEST for $test_file = ' . $test_file . "\n"); }

    waitpid( $pid, 0 );
    if ( $stdout_select->can_read(0) ) {
        sysread( STDOUT_TEST, $stdout_generated, 4096 );
    }
    if ( $stderr_select->can_read(0) ) {
        sysread( STDERR_TEST, $stderr_generated, 4096 );
    }

    # DISABLED: no user input accepted
    #        $stdout_generated = q{};
    #        $stderr_generated = q{};
    #    }

    my $test_exit_status = $CHILD_ERROR >> 8;

RPerl::diag('in 08_interpret_run_program.t, have $CHILD_ERROR = ' . $CHILD_ERROR . "\n");
RPerl::diag('in 08_interpret_run_program.t, have $test_exit_status = ' . $test_exit_status . "\n");

    if ($stdout_generated) { RPerl::diag( "===STDOUT=BEGIN====\n" . $stdout_generated . "===STDOUT=END======\n" ); }
    if ($stderr_generated) { RPerl::diag( "===STDERR=BEGIN====\n" . $stderr_generated . "===STDERR=END======\n" ); }

    if ( $test_exit_status == 0 ) {    # UNIX process return code 0, success
        if ( ( $test_file =~ m/Good/ms ) or ( $test_file =~ m/good/ms ) ) {
            my $missing_successes = [];
            if ( defined $test_files->{$test_file}->{successes} ) {
                foreach my $success (
                    @{ $test_files->{$test_file}->{successes} } )
                {
                    if ( $stdout_generated !~ /\Q$success\E/ ) {
                        push @{$missing_successes},
                            "Success message '$success' expected, but not found";
                    }
                }
            }

            RPerl::verbose('in 08_interpret_run_program.t, have $missing_successes =' . "\n" . Dumper($missing_successes) . "\n");
            ok( ( ( scalar @{$missing_successes} ) == 0 ),
                "Program $test_file interprets and runs without errors" );
        }
        else {
            ok( 0, "Program $test_file interprets and runs with errors" );
        }
    }
    else {    # UNIX process return code not 0, error
        if ( ( $test_file =~ m/Bad/ms ) or ( $test_file =~ m/bad/ms ) ) {
            my $missing_errors = [];
            if ( defined $test_files->{$test_file}->{errors} ) {
                foreach my $error ( @{ $test_files->{$test_file}->{errors} } )
                {
                    if (    ( $stdout_generated !~ /\Q$error\E/ )
                        and ( $stderr_generated !~ /\Q$error\E/ ) )
                    {
                        push @{$missing_errors},
                            "Error message '$error' expected, but not found";
                    }
                }
            }
            ok( ( ( scalar @{$missing_errors} ) == 0 ),
                "Program $test_file interprets and runs with expected error(s)"
            );
        }
        else {
            ok( 0, "Program $test_file interprets and runs without errors" );
        }
    }
}
