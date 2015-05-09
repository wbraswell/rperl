## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names
package rperlrules;    # yes, yes it does
use strict;
use warnings;
our $VERSION = 0.000_011;

#use RPerl;

# NEED UPGRADE: make Grammars first-class citizens for full Perl 6 compatibility, we should have it done by Christmas  XD
#use parent qw(RPerl::GrammarComponent)

# all following rules lists highest-to-lowest level

# [[[ COMPILE UNITS ]]]

use RPerl::CompileUnit;
use RPerl::CompileUnit::Program;
use RPerl::CompileUnit::Module;
use RPerl::CompileUnit::Module::Class::Generator;
use RPerl::CompileUnit::Module::Header;
use RPerl::CompileUnit::Module::Package;
use RPerl::CompileUnit::Include;
use RPerl::CompileUnit::Critic;
use RPerl::CompileUnit::Constant;
use RPerl::CodeBlock::Subroutine;
use RPerl::NonGenerator;

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

# [[[ VARIABLES & TYPES ]]]

use RPerl::Operation::Expression::SubExpression::Variable;
use RPerl::Operation::Expression::SubExpression::Literal; # NEED ANSWER: not a full Grammar Rule, just a Production???
use RPerl::Operation::Statement::VariableDeclaration;
use RPerl::Operation::Statement::VariableModification;
use RPerl::DataStructure::Array::ListElements;
use RPerl::DataStructure::Array::ListElement;
use RPerl::DataStructure::Hash::Entry;
use RPerl::DataStructure::Hash::EntryTyped;
use RPerl::Operation::Expression::SubExpression::Literal::Number;
use RPerl::Operation::Expression::SubExpression::Literal::String;

# [[[ OBJECT-ORIENTED ]]]
use RPerl::CompileUnit::Module::Class;
use RPerl::DataStructure::Hash::Properties;
use RPerl::CodeBlock::Subroutine::Method; # Method is the only item that is both a Data Type & a Grammar Rule

1;
