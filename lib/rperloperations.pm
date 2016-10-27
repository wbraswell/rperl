# [[[ HEADER ]]]
package  # hide from PAUSE indexing
    rperloperations; ## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names
use strict;
use warnings;
our $VERSION = 0.001_700;
use Carp;

# NEED UPGRADE: make Grammars first-class citizens for full Perl 6 compatibility, we should have it done by Christmas  XD
#use parent qw(RPerl::GrammarComponent)

# RPerl system builtin functions, RPerl to C++ name mapping, used in SubroutineCall.pm
our $BUILTINS = {
    'blessed' => 'classname',
    'class' => 'classname',
    'to_string' => 'To_string',  # DEV NOTE, CORRELATION #rp028: renamed from Perl to_string() to C++ To_string() to avoid error redefining std::to_string()
    # NEED REFACTOR: move SSE builtins to rperlsse.pm, create second $BUILTINS to be used in SubroutineCall.pm?
    'sse_number_pair::new_from_singleton_duplicate' => 'sse_number_pair__new_from_singleton_duplicate',
    'sse_number_pair::new_from_pair' => 'sse_number_pair__new_from_pair',
    'constant_sse_number_pair::new_from_singleton_duplicate' => 'constant_sse_number_pair__new_from_singleton_duplicate',
    'constant_sse_number_pair::new_from_pair' => 'constant_sse_number_pair__new_from_pair'
};

# [[[ EXPRESSIONS ]]]
use RPerl::Operation::Expression::Operator::Bitwise::And;
use RPerl::Operation::Expression::Operator::Bitwise::OrXor;
use RPerl::Operation::Expression::Operator::Bitwise::Shift;
use RPerl::Operation::Expression::Operator::Bitwise::Negation;
use RPerl::Operation::Expression::Operator::Close;
use RPerl::Operation::Expression::Operator::Compare::EqualNotEqual;
use RPerl::Operation::Expression::Operator::Compare::LessThanGreaterThan;
use RPerl::Operation::Expression::Operator::List::Range;
use RPerl::Operation::Expression::Operator::Logical::And;
use RPerl::Operation::Expression::Operator::Logical::Negation;
use RPerl::Operation::Expression::Operator::Logical::OrXor;
use RPerl::Operation::Expression::Operator::Arithmetic::AddSubtract;
use RPerl::Operation::Expression::Operator::IncrementDecrement;
use RPerl::Operation::Expression::Operator::Arithmetic::MultiplyDivideModulo;
use RPerl::Operation::Expression::Operator::Arithmetic::Negative;
use RPerl::Operation::Expression::Operator::Arithmetic::Power;
# DEV NOTE, CORRELATION #rp020: upon adding new named op file lib/RPerl/Operation/Expression/Operator/Named*/* also add in Named*.pm and rperloperations.*
use RPerl::Operation::Expression::Operator::Named;
use RPerl::Operation::Expression::Operator::Named::AbsoluteValue;
use RPerl::Operation::Expression::Operator::Named::Atan2;
use RPerl::Operation::Expression::Operator::Named::Chomp;
use RPerl::Operation::Expression::Operator::Named::Exp;
use RPerl::Operation::Expression::Operator::Named::Keys;
use RPerl::Operation::Expression::Operator::Named::Join;
use RPerl::Operation::Expression::Operator::Named::Pop;
use RPerl::Operation::Expression::Operator::Named::Push;
use RPerl::Operation::Expression::Operator::Named::Shift;
use RPerl::Operation::Expression::Operator::Named::Sort;
use RPerl::Operation::Expression::Operator::Named::Split;
use RPerl::Operation::Expression::Operator::Named::Reverse;
use RPerl::Operation::Expression::Operator::Named::Unshift;
use RPerl::Operation::Expression::Operator::Named::Values;
use RPerl::Operation::Expression::Operator::Named::Wait;
use RPerl::Operation::Expression::Operator::NamedUnary;
use RPerl::Operation::Expression::Operator::NamedUnary::ChangeDirectory;
use RPerl::Operation::Expression::Operator::NamedUnary::Cosine;
use RPerl::Operation::Expression::Operator::NamedUnary::Defined;
use RPerl::Operation::Expression::Operator::NamedUnary::Exists;
use RPerl::Operation::Expression::Operator::NamedUnary::FileExists;
use RPerl::Operation::Expression::Operator::NamedUnary::FileReadable;
use RPerl::Operation::Expression::Operator::NamedUnary::FileRegular;
use RPerl::Operation::Expression::Operator::NamedUnary::FileText;
use RPerl::Operation::Expression::Operator::NamedUnary::Length;
use RPerl::Operation::Expression::Operator::NamedUnary::Log;
use RPerl::Operation::Expression::Operator::NamedUnary::Random;
use RPerl::Operation::Expression::Operator::NamedUnary::Scalar;
use RPerl::Operation::Expression::Operator::NamedUnary::Sine;
use RPerl::Operation::Expression::Operator::NamedUnary::SquareRoot;
use RPerl::Operation::Expression::Operator::Open;
use RPerl::Operation::Expression::Operator::Print;
use RPerl::Operation::Expression::Operator::RegularExpression;
use RPerl::Operation::Expression::Operator::String::Concatenate;
use RPerl::Operation::Expression::Operator::String::Repeat;
use RPerl::Operation::Expression::Operator::Ternary;

use RPerl::Operation::Expression::ConstantCall;                                 # grammar rule & operation
use RPerl::Operation::Expression::SubroutineCall;                               # grammar rule & operation
use RPerl::Operation::Expression::SubroutineCall::MethodCall;                   # grammar rule & operation
use RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall;  # grammar rule & operation

# [[[ STATEMENTS ]]]

use RPerl::Operation::Statement::Conditional;           # grammar rule & operation
use RPerl::Operation::Statement::Loop;                  # grammar rule & operation
use RPerl::Operation::Statement::Loop::For;             # grammar rule & operation
use RPerl::Operation::Statement::Loop::ForEach;         # grammar rule & operation
use RPerl::Operation::Statement::Loop::While;           # grammar rule & operation
use RPerl::Operation::Statement::OperatorVoid::LoopControl;
use RPerl::Operation::Statement::OperatorVoid::Named::Return;
use RPerl::Operation::Statement::OperatorVoid::Named::Exit;
use RPerl::Operation::Statement::OperatorVoid::Named::Die;
use RPerl::Operation::Statement::OperatorVoid::Named::Croak;
use RPerl::Operation::Statement::OperatorVoid::Print;

1;
