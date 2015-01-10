package RPerl::Operation::Statement::Conditional;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_011;

# [[[ SETUP ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
use Scalar::Util 'blessed';

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Statement);

# [[[ OO PROPERTIES ]]]
our hash_ref $properties = {
    if_condition     => my object $TYPED_condition                   = undef,
    if_body          => my object $TYPED_body                        = undef,
    elsif_conditions => my object__array_ref $TYPED_elsif_conditions = undef,
    elsif_bodies     => my object__array_ref $TYPED_elsif_bodies     = undef,
    else_condition   => my object $TYPED_else_condition              = undef,
    else_body        => my object $TYPED_else_body                   = undef,
};

# [[[ OO METHODS ]]]
# TRANSLATE
our object__method $ppi_to_rperl__translate = sub {
    ( my string $class, my object $node) = @_;    # class method
    my object $node_translated;
    $node_translated = { STUB_AST_OBJECT =>
            'CREATED BY RPerl::Operation::Statement::Conditional' };
    return ($node_translated);
};

# GENERATE CPPOPS_PERLTYPES
our string__method $rperl_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self ) = @_;                     # object method
    my string $self_generated = q{};
    $self_generated
        .= 'STUB PERL CODE STRING, CREATED BY RPerl::Operation::Statement::Conditional';
    return ($self_generated);
};

# GENERATE CPPOPS_CPPTYPES
our string__method $rperl_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self ) = @_;                     # object method
    my string $self_generated = q{};
    $self_generated
        .= 'STUB CPP CODE STRING, CREATED BY RPerl::Operation::Statement::Conditional';
    return ($self_generated);
};

1;
