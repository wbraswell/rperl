# START HERE: upgrade this file to be RPerl organized, test if it actually works, create CHECK & CHECKTRACE & GA tests, upgrade 10_compile.t to match this one
# START HERE: upgrade this file to be RPerl organized, test if it actually works, create CHECK & CHECKTRACE & GA tests, upgrade 10_compile.t to match this one
# START HERE: upgrade this file to be RPerl organized, test if it actually works, create CHECK & CHECKTRACE & GA tests, upgrade 10_compile.t to match this one


#!/usr/bin/perl
use strict;
use warnings;
use File::Find qw(find);
use File::Temp qw(tempfile);
use Test::More;
use IPC::Open3;
use IO::Select;
use RPerl;
use RPerl::Parser;
use RPerl::Translator;
use RPerl::Generator;
use RPerl::Compiler;

our $VERSION = 0.000_001;

my $test_files = {};    # string__hash_ref
find(
    sub {
        my $file = $File::Find::name;
        if ( $file !~ m/.pl$/ ) {
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

plan tests => scalar keys %{$test_files};

for my $test_file ( sort keys %{$test_files} ) {
    my $pid = open3( \*STDIN_TEST, \*STDOUT_TEST, \*STDERR_TEST, $test_file );
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

    select( undef, undef, undef, .1 ); # allow time for output to be generated

#        if ( $stdout_select->can_read(0) )  { RPerl::diag('in 08_interpret_run_program.t, can read STDOUT_TEST for $test_file = ' . $test_file . "\n"); }
#        if ( $stderr_select->can_read(0) )  { RPerl::diag('in 08_interpret_run_program.t, can read STDERR_TEST for $test_file = ' . $test_file . "\n"); }

    if ( $stderr_select->can_read(0) ) {
        sysread( STDERR_TEST, $stderr_generated, 4096 );
    }
    if ( $stdout_select->can_read(0) ) {
        sysread( STDOUT_TEST, $stdout_generated, 4096 );
    }

    # DISABLED: no user input accepted
    #        $stdout_generated = q{};
    #        $stderr_generated = q{};
    #    }

    waitpid( $pid, 1 );
    my $test_exit_status = $CHILD_ERROR >> 8;

    if ($stdout_generated) {
        RPerl::diag( "===STDOUT=BEGIN====\n"
                . $stdout_generated
                . "\n===STDOUT=END======\n" );
    }
    if ($stderr_generated) {
        RPerl::diag( "===STDERR=BEGIN====\n"
                . $stderr_generated
                . "\n===STDERR=END======\n" );
    }

    if ( $test_exit_status == 0 ) {
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

#            RPerl::diag('in 08_interpret_run_program.t, have $missing_successes =' . "\n" . Dumper($missing_successes) . "\n");
            ok( ( ( scalar @{$missing_successes} ) == 0 ),
                "Program $test_file interprets and runs without errors" );
        }
        else {
            ok( 0,
                "Program $test_file interprets and runs without errors, but it should have errors"
            );
        }
    }
    else {
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
            ok( 0,
                "Program $test_file interprets and runs with errors, but it should not have errors"
            );
        }
    }
}
