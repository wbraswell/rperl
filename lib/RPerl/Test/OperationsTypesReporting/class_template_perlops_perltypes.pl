#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'MODE_ID = 0' >>>
# <<< EXECUTE_SUCCESS: "ops = 'PERL'" >>>
# <<< EXECUTE_SUCCESS: "types = 'PERL'" >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl::AfterFilter;
our $VERSION = 0.000_010;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::CompileUnit::Module::Class::Template;

# [[[ OPERATIONS ]]]

#print '%main:: = ', "\n", Dumper( \%main:: ), "\n";

print 'MODE_ID = ', RPerl__CompileUnit__Module__Class__Template__MODE_ID(), "\n";
print q{ops = '}, $RPerl::MODES->{RPerl__CompileUnit__Module__Class__Template__MODE_ID()}->{ops}, q{'}, "\n";
print q{types = '}, $RPerl::MODES->{RPerl__CompileUnit__Module__Class__Template__MODE_ID()}->{types}, q{'}, "\n";
