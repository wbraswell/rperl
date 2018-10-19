#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< TYPE_CHECKING: ON >>>

# <<< EXECUTE_SUCCESS: "have string_arrayref_hashref_to_string_compact($foo) = " >>>
# <<< EXECUTE_SUCCESS: "{'key_0'=>['0','1','2','3.456','4.678_901'],'key_1'=>['a','b','c','def','ghijkl'],'key_2'=>['hi','hello','howdy','hola','hey'],'key_3'=>['h ','h i','.','    ','" >>>
# <<< EXECUTE_SUCCESS: "']}" >>>
# <<< EXECUTE_SUCCESS: "have string_arrayref_hashref_to_string($foo) = " >>>
# <<< EXECUTE_SUCCESS: "{ 'key_0' => [ '0', '1', '2', '3.456', '4.678_901' ], 'key_1' => [ 'a', 'b', 'c', 'def', 'ghijkl' ], 'key_2' => [ 'hi', 'hello', 'howdy', 'hola', 'hey' ], 'key_3' => [ 'h ', 'h i', '.', '    ', '" >>>
# <<< EXECUTE_SUCCESS: "' ] }" >>>
# <<< EXECUTE_SUCCESS: "have string_arrayref_hashref_to_string_pretty($foo) = " >>>
# <<< EXECUTE_SUCCESS: "{" >>>
# <<< EXECUTE_SUCCESS: "    'key_0' => [ '0', '1', '2', '3.456', '4.678_901' ]," >>>
# <<< EXECUTE_SUCCESS: "    'key_1' => [ 'a', 'b', 'c', 'def', 'ghijkl' ]," >>>
# <<< EXECUTE_SUCCESS: "    'key_2' => [ 'hi', 'hello', 'howdy', 'hola', 'hey' ]," >>>
# <<< EXECUTE_SUCCESS: "    'key_3' => [ 'h ', 'h i', '.', '    ', '" >>>
# <<< EXECUTE_SUCCESS: "' ]" >>>
# <<< EXECUTE_SUCCESS: "}" >>>
# <<< EXECUTE_SUCCESS: "have string_arrayref_hashref_to_string_expand($foo) = " >>>
# <<< EXECUTE_SUCCESS: "{" >>>
# <<< EXECUTE_SUCCESS: "    'key_0' => " >>>
# <<< EXECUTE_SUCCESS: "    [" >>>
# <<< EXECUTE_SUCCESS: "        '0'," >>>
# <<< EXECUTE_SUCCESS: "        '1'," >>>
# <<< EXECUTE_SUCCESS: "        '2'," >>>
# <<< EXECUTE_SUCCESS: "        '3.456'," >>>
# <<< EXECUTE_SUCCESS: "        '4.678_901'" >>>
# <<< EXECUTE_SUCCESS: "    ]," >>>
# <<< EXECUTE_SUCCESS: "    'key_1' => " >>>
# <<< EXECUTE_SUCCESS: "    [" >>>
# <<< EXECUTE_SUCCESS: "        'a'," >>>
# <<< EXECUTE_SUCCESS: "        'b'," >>>
# <<< EXECUTE_SUCCESS: "        'c'," >>>
# <<< EXECUTE_SUCCESS: "        'def'," >>>
# <<< EXECUTE_SUCCESS: "        'ghijkl'" >>>
# <<< EXECUTE_SUCCESS: "    ]," >>>
# <<< EXECUTE_SUCCESS: "    'key_2' => " >>>
# <<< EXECUTE_SUCCESS: "    [" >>>
# <<< EXECUTE_SUCCESS: "        'hi'," >>>
# <<< EXECUTE_SUCCESS: "        'hello'," >>>
# <<< EXECUTE_SUCCESS: "        'howdy'," >>>
# <<< EXECUTE_SUCCESS: "        'hola'," >>>
# <<< EXECUTE_SUCCESS: "        'hey'" >>>
# <<< EXECUTE_SUCCESS: "    ]," >>>
# <<< EXECUTE_SUCCESS: "    'key_3' => " >>>
# <<< EXECUTE_SUCCESS: "    [" >>>
# <<< EXECUTE_SUCCESS: "        'h '," >>>
# <<< EXECUTE_SUCCESS: "        'h i'," >>>
# <<< EXECUTE_SUCCESS: "        '.'," >>>
# <<< EXECUTE_SUCCESS: "        '    '," >>>
# <<< EXECUTE_SUCCESS: "        '" >>>
# <<< EXECUTE_SUCCESS: "'" >>>
# <<< EXECUTE_SUCCESS: "    ]" >>>
# <<< EXECUTE_SUCCESS: "}" >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

# homogeneous 2-dimensional hash of arrays of strings
# DEV NOTE: must be on single one to match auto-generated Perl::Tidy output code
my string_arrayref_hashref $foo = { key_0 => [  '0',  '1',  '2',  '3.456',  '4.678_901' ], key_1 => [ 'a', 'b', 'c', 'def', 'ghijkl' ], key_2 => [ 'hi', 'hello', 'howdy', 'hola', 'hey' ], key_3 => [ 'h ', q{h i}, q{.}, q{    }, "\n" ] };

print 'have string_arrayref_hashref_to_string_compact($foo) = ', "\n", string_arrayref_hashref_to_string_compact($foo), "\n";

print 'have string_arrayref_hashref_to_string($foo) = ', "\n", string_arrayref_hashref_to_string($foo), "\n";

print 'have string_arrayref_hashref_to_string_pretty($foo) = ', "\n", string_arrayref_hashref_to_string_pretty($foo), "\n";

print 'have string_arrayref_hashref_to_string_expand($foo) = ', "\n", string_arrayref_hashref_to_string_expand($foo), "\n";

