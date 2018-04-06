#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: "have string_arrayref_to_string_compact($row_1D) = ['hi','hello','howdy','how do you do','hey']" >>>
# <<< EXECUTE_SUCCESS: "have string_arrayref_to_string($row_1D)         = [ 'hi', 'hello', 'howdy', 'how do you do', 'hey' ]" >>>
# <<< EXECUTE_SUCCESS: "have string_arrayref_to_string_pretty($row_1D)  = [ 'hi', 'hello', 'howdy', 'how do you do', 'hey' ]" >>>
# <<< EXECUTE_SUCCESS: "have string_arrayref_to_string_expand($row_1D)  =" >>>
# <<< EXECUTE_SUCCESS: "["
# <<< EXECUTE_SUCCESS: "    'hi',"
# <<< EXECUTE_SUCCESS: "    'hello',"
# <<< EXECUTE_SUCCESS: "    'howdy',"
# <<< EXECUTE_SUCCESS: "    'how do you do',"
# <<< EXECUTE_SUCCESS: "    'hey'"
# <<< EXECUTE_SUCCESS: "]"
# <<< EXECUTE_SUCCESS: "have string_arrayref_to_string_format($row_1D, -2, 0) = ['hi','hello','howdy','how do you do','hey']" >>>
# <<< EXECUTE_SUCCESS: "have string_arrayref_to_string_format($row_1D, -1, 0) = [ 'hi', 'hello', 'howdy', 'how do you do', 'hey' ]" >>>
# <<< EXECUTE_SUCCESS: "have string_arrayref_to_string_format($row_1D,  0, 0) = [ 'hi', 'hello', 'howdy', 'how do you do', 'hey' ]" >>>
# <<< EXECUTE_SUCCESS: "have string_arrayref_to_string_format($row_1D,  1, 0) =" >>>
# <<< EXECUTE_SUCCESS: "["
# <<< EXECUTE_SUCCESS: "    'hi',"
# <<< EXECUTE_SUCCESS: "    'hello',"
# <<< EXECUTE_SUCCESS: "    'howdy',"
# <<< EXECUTE_SUCCESS: "    'how do you do',"
# <<< EXECUTE_SUCCESS: "    'hey'"
# <<< EXECUTE_SUCCESS: "]"
# <<< EXECUTE_SUCCESS: "have string_arrayref_to_string_format($row_1D, -2, 1) = ['hi','hello','howdy','how do you do','hey']" >>>
# <<< EXECUTE_SUCCESS: "have string_arrayref_to_string_format($row_1D, -1, 1) = [ 'hi', 'hello', 'howdy', 'how do you do', 'hey' ]" >>>
# <<< EXECUTE_SUCCESS: "have string_arrayref_to_string_format($row_1D,  0, 1) = [ 'hi', 'hello', 'howdy', 'how do you do', 'hey' ]" >>>
# <<< EXECUTE_SUCCESS: "have string_arrayref_to_string_format($row_1D,  1, 1) =" >>>
# <<< EXECUTE_SUCCESS: "    ["
# <<< EXECUTE_SUCCESS: "        'hi',"
# <<< EXECUTE_SUCCESS: "        'hello',"
# <<< EXECUTE_SUCCESS: "        'howdy',"
# <<< EXECUTE_SUCCESS: "        'how do you do',"
# <<< EXECUTE_SUCCESS: "        'hey'"
# <<< EXECUTE_SUCCESS: "    ]"

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my string_arrayref $row_1D = [ 'hi', 'hello', 'howdy', 'how do you do', 'hey' ];

print 'have string_arrayref_to_string_compact($row_1D) = ', string_arrayref_to_string_compact($row_1D), "\n";
print 'have string_arrayref_to_string($row_1D)         = ', string_arrayref_to_string($row_1D), "\n";
print 'have string_arrayref_to_string_pretty($row_1D)  = ', string_arrayref_to_string_pretty($row_1D), "\n";
print 'have string_arrayref_to_string_expand($row_1D)  = ', "\n", string_arrayref_to_string_expand($row_1D), "\n";

print 'have string_arrayref_to_string_format($row_1D, -2, 0) = ', string_arrayref_to_string_format($row_1D, -2, 0), "\n";
print 'have string_arrayref_to_string_format($row_1D, -1, 0) = ', string_arrayref_to_string_format($row_1D, -1, 0), "\n";
print 'have string_arrayref_to_string_format($row_1D,  0, 0) = ', string_arrayref_to_string_format($row_1D, 0, 0), "\n";
print 'have string_arrayref_to_string_format($row_1D,  1, 0) = ', "\n", string_arrayref_to_string_format($row_1D, 1, 0), "\n";

print 'have string_arrayref_to_string_format($row_1D, -2, 1) = ', string_arrayref_to_string_format($row_1D, -2, 1), "\n";
print 'have string_arrayref_to_string_format($row_1D, -1, 1) = ', string_arrayref_to_string_format($row_1D, -1, 1), "\n";
print 'have string_arrayref_to_string_format($row_1D,  0, 1) = ', string_arrayref_to_string_format($row_1D, 0, 1), "\n";
print 'have string_arrayref_to_string_format($row_1D,  1, 1) = ', "\n", string_arrayref_to_string_format($row_1D, 1, 1), "\n";
