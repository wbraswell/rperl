package RPerl::GrammarRule;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_001;

use parent qw(RPerl::CompileUnit::Module::Class); # inherit directly from base class
our %properties = (); ## no critic qw(ProhibitPackageVars)  # USER DEFAULT 3: allow OO properties

1;
