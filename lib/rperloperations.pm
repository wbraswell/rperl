package rperloperations; ## no critic qw(Capitalization ProhibitMultiplePackages)  # SYSTEM DEFAULT 3: allow multiple lower case package names
use strict;
use warnings;
our $VERSION = 0.000_011;
use Carp;

#use RPerl;

# NEED UPGRADE: make Grammars first-class citizens for full Perl 6 compatibility, we should have it done by Christmas  XD
#use parent qw(RPerl::GrammarComponent)

# [[[ EXPRESSIONS ]]]
#use RPerl::Operation::Expression::Operator::FOO;

# [[[ STATEMENTS ]]]

use RPerl::Operation::Statement::OperatorVoid::Print;
use RPerl::Operation::Statement::OperatorVoid::Return;
use RPerl::Operation::Statement::OperatorVoid::Croak;
use RPerl::Operation::Statement::Conditional; # both an Operation & a Grammar Rule
use RPerl::Operation::Statement::Loop;    # both an Operation & a Grammar Rule
use RPerl::Operation::Statement::Loop::For; # both an Operation & a Grammar Rule
use RPerl::Operation::Statement::Loop::ForEach; # both an Operation & a Grammar Rule
use RPerl::Operation::Statement::Loop::While; # both an Operation & a Grammar Rule
use RPerl::CodeBlock;

1;
