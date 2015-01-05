#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< RUN_SUCCESS: 'OPS_TYPES_ID = 0' >>>
# <<< RUN_SUCCESS: "ops = 'PERL'" >>>
# <<< RUN_SUCCESS: "types = 'PERL'" >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_010;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::CompileUnit::Module::ClassTemplate;

# [[[ OPERATIONS ]]]

#print '%main:: = ', "\n", Dumper( \%main:: ), "\n";

print 'OPS_TYPES_ID = ', RPerl__CompileUnit__Module__ClassTemplate__OPS_TYPES_ID(), "\n";
print q{ops = '}, $RPerl::OPS_TYPES_IDS_DECODED->{RPerl__CompileUnit__Module__ClassTemplate__OPS_TYPES_ID()}->{ops}, q{'}, "\n";
print q{types = '}, $RPerl::OPS_TYPES_IDS_DECODED->{RPerl__CompileUnit__Module__ClassTemplate__OPS_TYPES_ID()}->{types}, q{'}, "\n";

# START HERE 0: replace all outdated usage of *_ops() and *_types()
# START HERE 0: replace all outdated usage of *_ops() and *_types()
# START HERE 0: replace all outdated usage of *_ops() and *_types()