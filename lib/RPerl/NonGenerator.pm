# [[[ HEADER ]]]
package RPerl::NonGenerator;
use strict;
use warnings;
our $VERSION = 0.000_001;
use RPerl;

# [[[ OO INHERITANCE ]]]
# <<< CHANGE_ME: leave as base class for no inheritance, or replace with real parent package name >>>
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ INCLUDES ]]]
use RPerl::Grammar;
use RPerl::Parser;

# [[[ OO PROPERTIES ]]]
our hash_ref $properties = {};

# [[[ OO METHODS ]]]

our string__hash_ref__method $ast_to_rperl__generate = sub {
    ( my object $self, my string__hash_ref $modes) = @_;
    RPerl::diag('in NonGenerator->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n");
#    RPerl::diag('in NonGenerator->ast_to_rperl__generate(), received $modes = ' . "\n" . Dumper($modes) . "\n");

    croak 'ERROR ECVGENG00 Attempt to generate output source code from non-generating class ' . (ref $self) . ', croaking';
};

our string__hash_ref__method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string__hash_ref $modes) = @_;
    croak 'ERROR ECVGENG01 Attempt to generate output source code from non-generating class ' . (ref $self) . ', croaking';
};

our string__hash_ref__method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string__hash_ref $modes) = @_;
    croak 'ERROR ECVGENG02 Attempt to generate output source code from non-generating class ' . (ref $self) . ', croaking';
};

1;
