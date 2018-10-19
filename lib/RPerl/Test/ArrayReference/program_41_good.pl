#!/usr/bin/env perl

# Learning RPerl, Section 3.5: 2-D Array Data Types & Nested Arrays

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: "have $column_3 = [ 6, 7, 1, 6, 5 ]" >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

# fine in RPerl, multiple rows and columns on multiple lines
my integer_arrayref_arrayref $rows_and_columns_2D = [
    [ 0, 2, 4, 6, 8 ],
    [ 1, 3, 5, 7, 9 ],
    [ 4, 3, 2, 1, 0 ],
    [ 9, 8, 7, 6, 5 ],
    [ 5, 5, 5, 5, 5 ],
    [ 0, 2, 4, 6, 8 ],
    [ 1, 3, 5, 7, 9 ],
    [ 4, 3, 2, 1, 0 ],
    [ 9, 8, 7, 6, 5 ],
    [ 5, 5, 5, 5, 5 ]
];

my integer_arrayref $column_3 = [];
$column_3->[0] = $rows_and_columns_2D->[0]->[3];
$column_3->[1] = $rows_and_columns_2D->[1]->[3];
$column_3->[2] = $rows_and_columns_2D->[2]->[3];
$column_3->[3] = $rows_and_columns_2D->[3]->[3];
$column_3->[4] = $rows_and_columns_2D->[4]->[3];
print 'have $column_3 = ', integer_arrayref_to_string($column_3), "\n";
