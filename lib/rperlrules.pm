## no critic qw(Capitalization)  ## RPERL SYSTEM types, allow lowercase packages
package rperlrules;    # yes, yes it does
use strict;
use warnings;
our $VERSION = 0.000_010;
use Carp;

#use RPerl;

# NEED UPGRADE: make Grammars first-class citizens for full Perl 6 compatibility, we should have it done by Christmas  XD
#use parent qw(RPerl::GrammarComponent)
#our %properties = (); ## no critic qw(ProhibitPackageVars)  ## RPERL SYSTEM, allow OO properties

# all following rules lists highest-to-lowest level

# [[[ COMPILE UNITS ]]]

use RPerl::CompileUnit;
use RPerl::CompileUnit::Program;
use RPerl::CompileUnit::Module;
use RPerl::CompileUnit::Module::Package;
use RPerl::CodeBlock::Subroutine;

# [[[ OPERATIONS ]]]

use RPerl::Operation;
use RPerl::Operation::Expression;
use RPerl::Operation::Expression::Operator;
use RPerl::Operation::Statement;
use RPerl::Operation::Statement::OperatorVoid;
use RPerl::Operation::Statement::Conditional;
use RPerl::Operation::Statement::Loop;
use RPerl::Operation::Statement::Loop::For;
use RPerl::Operation::Statement::Loop::ForEach;
use RPerl::Operation::Statement::Loop::While;
use RPerl::CodeBlock;

# [[[ VARIABLES ]]]

use RPerl::Operation::Expression::Variable;
use RPerl::Operation::Expression::Literal;  # NEED ANSWER: not a full Grammar Rule, just a Production???
use RPerl::Operation::Statement::VariableDeclaration;
use RPerl::Operation::Statement::VariableModification;
use RPerl::DataStructure::Array::ListElements;

# [[[ OBJECT-ORIENTED ]]]
use RPerl::CompileUnit::Module::Class;
use RPerl::DataStructure::Hash::Properties;
use RPerl::CodeBlock::Subroutine::Method; # Method is the only item that is both a Data Type & a Grammar Rule

1;
