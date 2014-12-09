#!/usr/bin/perl
use strict;
use warnings;
use File::Find qw(find);
use File::Temp qw(tempfile);
use Test::More;
use RPerl;
use RPerl::Parser;
use RPerl::Translator;
use RPerl::Generator;
use RPerl::Compiler;

our $VERSION = 0.004_000;

my $tests = {};
find(
    sub {
        my $file = $File::Find::name;
        if ( ( !m/.pm$/ ) and ( !m/.pl$/ ) ) {
            return;
        }
        if ( (m/Good/ms) or (m/good/ms) ) {
            $tests->{$file} = undef;
        }
        elsif ( (m/Bad/ms) or (m/bad/ms) ) {
            open my $fh, '<', $_ or die "Cannot open $file:$!\n";
            while (<$fh>) {
                if (m/^\#\s*\<\<\<\s*COMPILE_ERROR\s*\:\s*['"](.*)['"]\s*\>\>\>/
                    )
                {
                    push @{ $tests->{$file} }, $1;
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

plan tests => scalar keys %{$tests};

my $tempfile = tempfile;
for my $file ( sort keys %{$tests} ) {
    my $errors            = $tests->{$file};
    my $eval_return_value = eval {
        rperl_to_xsbinary__compile( $file, $tempfile,
            { ops => 'CPP', types => 'CPP' } );
    };
    if ( not defined $errors ) {
        ok( $eval_return_value,
            "Program or module $file compiles without errors" );
        if ( not $eval_return_value ) {
            print "==============\n$EVAL_ERROR\n============\n";
        }
    }
    elsif ($eval_return_value) {
        ok( 0, "Program or module $file compiles with expected error(s)" );
    }
    else {
        my $warnings = [];
        foreach my $error ( @{$errors} ) {
            if ( $EVAL_ERROR !~ /\Q$error\E/ ) {
                push @{$warnings},
                    "Error message '$error' expected, but not found";
            }
        }
        ok( scalar( @{$warnings} ) == 0,
            "Program or module $file compiles with the expected error(s)" );
        foreach my $warning ( @{$warnings} ) {
            print "$warning\n";
        }
        if ( scalar( @{$warnings} ) > 0 ) {
            print "==============\n$EVAL_ERROR\n============\n";
        }
    }
}

unlink $tempfile;
