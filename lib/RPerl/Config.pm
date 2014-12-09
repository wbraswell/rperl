package RPerl::Config;
use strict;
use warnings;
our $VERSION = 0.000_007;

# DEV NOTE: this package exists to serve as the header file for RPerl.pm itself, 
# as well as for RPerl.pm dependencies such as Class.pm, HelperFunctions_cpp.pm, and rperltypes.pm

# $OS_ERROR == $ERRNO == $!, $EVAL_ERROR == $@

# export Dumper(), carp(), croak(), confess(), $OS_ERROR, $EVAL_ERROR, and $CHILD_ERROR to all who call 'use RPerl::Config;'
use Data::Dumper;
use Carp;
use English qw(-no_match_vars);
use Exporter 'import';
our @EXPORT = qw(Dumper carp croak confess $OS_ERROR $EVAL_ERROR $CHILD_ERROR);

1; 1;

package RPerl;

# IMPORTANT SYSTEM-DEPENDENT CONFIGURATION VARIABLES!  
# drivers may optionally overwrite these to the path to RPerl binaries and libraries
our $BASE_PATH = 'blib';
our $INCLUDE_PATH = $BASE_PATH . '/lib';  # all RPerl system modules live here
#our $BIN_PATH = $BASE_PATH . '/bin';  # NEED UPGRADE: bootstrap compiled RPerl system programs live here
our $SCRIPT_PATH = $BASE_PATH . '/script';  # interpreted RPerl system programs live here

# export Dumper(), carp(), croak(), confess(), $OS_ERROR, $EVAL_ERROR, and $CHILD_ERROR to all who call 'use RPerl;'
use Data::Dumper;
use Carp;
use English qw(-no_match_vars);
use Exporter 'import';
our @EXPORT = qw(Dumper carp croak confess $OS_ERROR $EVAL_ERROR $CHILD_ERROR);

1; 1;
