#!/usr/bin/perl

# Learning RPerl, Chapter 6, Exercise 3
# Print sorted environmental variables

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ SUBROUTINES ]]]

sub sort_env_vars {
    { my void $RETURN_TYPE };
    my string_hashref $env_vars = {%ENV};

    my integer $env_var_length;
    my integer $left_column_width = 0;
    foreach my string $env_var ( sort keys %{$env_vars} ) {
        $env_var_length = length $env_var;
        if ( $env_var_length > $left_column_width ) {
            $left_column_width = $env_var_length;
        }
    }

    $left_column_width += 2;

    print 'Environmental variables:', "\n";

    foreach my string $env_var ( sort keys %{$env_vars} ) {
        print $env_var;
        print q{ } x ( $left_column_width - ( length $env_var ) );
        print $env_vars->{$env_var}, "\n";
    }
    return;
}

# [[[ OPERATIONS ]]]

sort_env_vars();
