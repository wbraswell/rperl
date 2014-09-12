package RPerl::Config;
use strict;
use warnings;
our $VERSION = 0.000_004;

# DEV NOTE: this package exists to serve as the header file for RPerl.pm itself, 
# as well as for RPerl.pm dependencies such as Class.pm, HelperFunctions_cpp.pm, and rperltypes.pm

# $ERRNO == $OS_ERROR == $!, $EVAL_ERROR == $@

# export Dumper(), carp(), croak(), confess(), $ERRNO, and $EVAL_ERROR to all who call 'use RPerl::Config;'
use Data::Dumper;
use Carp;
use English qw(-no_match_vars);
use Exporter 'import';
our @EXPORT = qw(Dumper carp croak confess $ERRNO $EVAL_ERROR);

1; 1;

package RPerl;

# IMPORTANT SYSTEM-DEPENDENT CONFIGURATION VARIABLE!  drivers may optionally overwrite this to the path to RPerl
our $INCLUDE_PATH = 'blib/lib';

# export Dumper(), carp(), croak(), confess(), $ERRNO, and $EVAL_ERROR to all who call 'use RPerl;'
use Data::Dumper;
use Carp;
use English qw(-no_match_vars);
use Exporter 'import';
our @EXPORT = qw(Dumper carp croak confess $ERRNO $EVAL_ERROR);

1; 1;
