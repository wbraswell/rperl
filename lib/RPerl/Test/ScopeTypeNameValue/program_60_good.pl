#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'have $foo = howdy' >>>
# <<< EXECUTE_SUCCESS: 'have type($foo) = string' >>>
# <<< EXECUTE_SUCCESS: 'have name($foo) = $foo' >>>
# <<< EXECUTE_SUCCESS: 'have scope_type_name_value($foo) = ' >>>
# <<< EXECUTE_SUCCESS: "my string $foo = 'howdy';" >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my string $foo = 'howdy';
print 'have $foo = ', $foo, "\n";
print 'have type($foo) = ', type($foo), "\n";
print 'have name($foo) = ', name($foo), "\n";
print 'have scope_type_name_value($foo) = ', "\n", scope_type_name_value($foo), "\n\n";

#$::bar = 'dowdy';
#print $::bar, "\n";
#print scope_type_name_value($::bar), "\n";
#print name($::bar), "\n\n";

#$bax = 'dowdy';
#print $bax, "\n";
#print scope_type_name_value($bax), "\n";
#print name($bax), "\n\n";

#our $baz = 'dowdy';
#print $baz, "\n";
#print scope_type_name_value($baz), "\n";
#print name($baz), "\n\n";


