package RPerl::GrammarRule;
use strict;
use warnings;
our $VERSION = 0.000_001;
use Carp;
use RPerl;

use parent qw(RPerl::CompileUnit::Module::Class); # inherit directly from base class
our %properties = (); ## no critic qw(ProhibitPackageVars)  ## RPERL SYSTEM, allow OO properties

1;
