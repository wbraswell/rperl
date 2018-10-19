#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: "have string_hashref_to_string_compact($hash_1D) = {'dont_panic'=>'forty-two','enterprise'=>'NCC-1701','fnord'=>'timelord','least_random'=>'seventeen','starman'=>'megadon'}" >>>
# <<< EXECUTE_SUCCESS: "have string_hashref_to_string($hash_1D)         = { 'dont_panic' => 'forty-two', 'enterprise' => 'NCC-1701', 'fnord' => 'timelord', 'least_random' => 'seventeen', 'starman' => 'megadon' }" >>>
# <<< EXECUTE_SUCCESS: "have string_hashref_to_string_pretty($hash_1D)  = { 'dont_panic' => 'forty-two', 'enterprise' => 'NCC-1701', 'fnord' => 'timelord', 'least_random' => 'seventeen', 'starman' => 'megadon' }" >>>
# <<< EXECUTE_SUCCESS: "have string_hashref_to_string_expand($hash_1D)  =" >>>
# <<< EXECUTE_SUCCESS: "{" >>>
# <<< EXECUTE_SUCCESS: "    'dont_panic' => 'forty-two'," >>>
# <<< EXECUTE_SUCCESS: "    'enterprise' => 'NCC-1701'," >>>
# <<< EXECUTE_SUCCESS: "    'fnord' => 'timelord'," >>>
# <<< EXECUTE_SUCCESS: "    'least_random' => 'seventeen'," >>>
# <<< EXECUTE_SUCCESS: "    'starman' => 'megadon'" >>>
# <<< EXECUTE_SUCCESS: "}" >>>
# <<< EXECUTE_SUCCESS: "have string_hashref_to_string_format($hash_1D, -2, 0) = {'dont_panic'=>'forty-two','enterprise'=>'NCC-1701','fnord'=>'timelord','least_random'=>'seventeen','starman'=>'megadon'}" >>>
# <<< EXECUTE_SUCCESS: "have string_hashref_to_string_format($hash_1D, -1, 0) = { 'dont_panic' => 'forty-two', 'enterprise' => 'NCC-1701', 'fnord' => 'timelord', 'least_random' => 'seventeen', 'starman' => 'megadon' }" >>>
# <<< EXECUTE_SUCCESS: "have string_hashref_to_string_format($hash_1D,  0, 0) = { 'dont_panic' => 'forty-two', 'enterprise' => 'NCC-1701', 'fnord' => 'timelord', 'least_random' => 'seventeen', 'starman' => 'megadon' }" >>>
# <<< EXECUTE_SUCCESS: "have string_hashref_to_string_format($hash_1D,  1, 0) =" >>>
# <<< EXECUTE_SUCCESS: "{" >>>
# <<< EXECUTE_SUCCESS: "    'dont_panic' => 'forty-two'," >>>
# <<< EXECUTE_SUCCESS: "    'enterprise' => 'NCC-1701'," >>>
# <<< EXECUTE_SUCCESS: "    'fnord' => 'timelord'," >>>
# <<< EXECUTE_SUCCESS: "    'least_random' => 'seventeen'," >>>
# <<< EXECUTE_SUCCESS: "    'starman' => 'megadon'" >>>
# <<< EXECUTE_SUCCESS: "}" >>>
# <<< EXECUTE_SUCCESS: "have string_hashref_to_string_format($hash_1D, -2, 1) = {'dont_panic'=>'forty-two','enterprise'=>'NCC-1701','fnord'=>'timelord','least_random'=>'seventeen','starman'=>'megadon'}" >>>
# <<< EXECUTE_SUCCESS: "have string_hashref_to_string_format($hash_1D, -1, 1) = { 'dont_panic' => 'forty-two', 'enterprise' => 'NCC-1701', 'fnord' => 'timelord', 'least_random' => 'seventeen', 'starman' => 'megadon' }" >>>
# <<< EXECUTE_SUCCESS: "have string_hashref_to_string_format($hash_1D,  0, 1) = { 'dont_panic' => 'forty-two', 'enterprise' => 'NCC-1701', 'fnord' => 'timelord', 'least_random' => 'seventeen', 'starman' => 'megadon' }" >>>
# <<< EXECUTE_SUCCESS: "have string_hashref_to_string_format($hash_1D,  1, 1) =" >>>
# <<< EXECUTE_SUCCESS: "    {" >>>
# <<< EXECUTE_SUCCESS: "        'dont_panic' => 'forty-two'," >>>
# <<< EXECUTE_SUCCESS: "        'enterprise' => 'NCC-1701'," >>>
# <<< EXECUTE_SUCCESS: "        'fnord' => 'timelord'," >>>
# <<< EXECUTE_SUCCESS: "        'least_random' => 'seventeen'," >>>
# <<< EXECUTE_SUCCESS: "        'starman' => 'megadon'" >>>
# <<< EXECUTE_SUCCESS: "    }" >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my string_hashref $hash_1D = { least_random => 'seventeen', fnord => 'timelord', dont_panic => 'forty-two', enterprise => 'NCC-1701', starman => 'megadon' };


print 'have string_hashref_to_string_compact($hash_1D) = ', string_hashref_to_string_compact($hash_1D), "\n";
print 'have string_hashref_to_string($hash_1D)         = ', string_hashref_to_string($hash_1D), "\n";
print 'have string_hashref_to_string_pretty($hash_1D)  = ', string_hashref_to_string_pretty($hash_1D), "\n";
print 'have string_hashref_to_string_expand($hash_1D)  = ', "\n", string_hashref_to_string_expand($hash_1D), "\n";

print 'have string_hashref_to_string_format($hash_1D, -2, 0) = ', string_hashref_to_string_format($hash_1D, -2, 0), "\n";
print 'have string_hashref_to_string_format($hash_1D, -1, 0) = ', string_hashref_to_string_format($hash_1D, -1, 0), "\n";
print 'have string_hashref_to_string_format($hash_1D,  0, 0) = ', string_hashref_to_string_format($hash_1D, 0, 0), "\n";
print 'have string_hashref_to_string_format($hash_1D,  1, 0) = ', "\n", string_hashref_to_string_format($hash_1D, 1, 0), "\n";

print 'have string_hashref_to_string_format($hash_1D, -2, 1) = ', string_hashref_to_string_format($hash_1D, -2, 1), "\n";
print 'have string_hashref_to_string_format($hash_1D, -1, 1) = ', string_hashref_to_string_format($hash_1D, -1, 1), "\n";
print 'have string_hashref_to_string_format($hash_1D,  0, 1) = ', string_hashref_to_string_format($hash_1D, 0, 1), "\n";
print 'have string_hashref_to_string_format($hash_1D,  1, 1) = ', "\n", string_hashref_to_string_format($hash_1D, 1, 1), "\n";
