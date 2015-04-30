package RPerl::Operation::Statement::Loop::While;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_012;

# [[[ SETUP ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
use Scalar::Util 'blessed';

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Statement::Loop);

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    label     => my string $TYPED_label     = undef,
    condition => my object $TYPED_condition = undef,
    body      => my object $TYPED_body      = undef,
};

# [[[ OO METHODS ]]]

# TRANSLATE
our object_method $ppi_to_rperl__translate = sub {
    ( my string $class, my object $node) = @_;    # class method
    my object $node_translated;
    $node_translated = { STUB_AST_OBJECT =>
            'CREATED BY RPerl::Operation::Statement::Loop::While' };
    return ($node_translated);
};

# GENERATE CPPOPS_PERLTYPES
our string_method $rperl_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self ) = @_;                     # object method
    my string $self_generated = q{};
    $self_generated
        .= 'STUB PERL CODE STRING, CREATED BY RPerl::Operation::Statement::Loop::While';
    return ($self_generated);
};

# GENERATE CPPOPS_CPPTYPES
our string_method $rperl_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self ) = @_;                     # object method
    my string $self_generated = q{};
    $self_generated
        .= 'STUB CPP CODE STRING, CREATED BY RPerl::Operation::Statement::Loop::While';
    return ($self_generated);
};

1;
