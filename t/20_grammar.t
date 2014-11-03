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

our $VERSION = 0.003_004;

my %tests;
find(
    sub {
        my $file = $File::Find::name;
        if (m/Good/ms) {
            $tests{$file} = undef;
        }
        elsif (m/Bad/ms) {
            open my $fh, '<', $_ or die "Cannot open $file:$ERRNO\n";
            while (<$fh>) {
                if (m/^\#\s*\[\[\[\s*TEST\s*\:\s*['"](.*)['"]\s*\]\]\]/smx) {
                    push @{ $tests{$file} }, $1;
                }
            }
            if ( close $fh ) { }
        }
        else {
            return;
        }
    },
    'lib/RPerl/Test'
);

plan tests => scalar keys %tests;

my $tempfile = tempfile;
for my $file ( sort keys %tests ) {
    my $errors  = $tests{$file};
    my $success = eval {
        rperl_to_xsbinary__compile( $file, $tempfile,
            { ops => 'CPP', types => 'CPP' } );
    };
    if ( not defined $errors ) {
        ok( $success, "$file compiles ok" );
        if ( not $success ) {
            if ( print {*STDERR} "$EVAL_ERROR\n" ) { }
        }
    }
    elsif ($success) {
        ok( 0, "$file compiles without errors while it shouldn't" );
    }
    else {
        my @warnings;
        for my $s ( @{$errors} ) {
            if ( $EVAL_ERROR !~ /\Q$s\E/msx ) {
                push @warnings, "error message '$s' not found";
            }
        }
        ok( scalar(@warnings) == 0, "$file fails to compile with the expected error" );
        for my $s (@warnings) {
            if ( print {*STDERR} "$s\n" ) { }
        }
    }
}

unlink $tempfile;
