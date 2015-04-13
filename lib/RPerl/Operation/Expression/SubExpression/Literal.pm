package RPerl::Operation::Expression::SubExpression::Literal;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_011;

# [[[ SETUP ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
use Scalar::Util 'blessed';

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression);

# [[[ OO PROPERTIES ]]]
our hash_ref $properties = {
    type             => my string $TYPED_type             = undef,
    string_separator => my string $TYPED_string_separator = undef,
    value            => my string $TYPED_value            = undef
};

# [[[ OO METHODS ]]]

# TRANSLATE
our object__method $ppi_to_rperl__translate = sub {
    ( my string $class, my object $node) = @_;    # class method
    my object $node_translated;
    $node_translated = { STUB_AST_OBJECT =>
            'CREATED BY RPerl::Operation::Expression::SubExpression::Literal' };
    return ($node_translated);
};

# GENERATE CPPOPS_PERLTYPES
our string__method $rperl_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self ) = @_;                     # object method
    my string $self_generated = q{};
    $self_generated
        .= 'STUB PERL CODE STRING, CREATED BY RPerl::Operation::Expression::SubExpression::Literal';
    return ($self_generated);
};

# GENERATE CPPOPS_CPPTYPES
our string__method $rperl_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self ) = @_;                     # object method
    my string $self_generated = q{};

    if ( $self->{type} eq 'number' ) {
        $self_generated .= $self->{value};
    }
    elsif ( $self->{type} eq 'string' ) {

# NEED FIX: remove hard-coded double-quotes, handle pre-existing double-quotes separator and LMPC ban on interpolation
        substr $self->{value}, 0,  1, q{"};
        substr $self->{value}, -1, 1, q{"};

        # DEV NOTE: special OPS_TYPES tag replacement regex
        $self->{value} =~ s/PERLOPS_PERLTYPES/CPPOPS_CPPTYPES/gxms;
        $self_generated .= $self->{value};
    }
    else {
        croak(
            "\nERROR ECVGESY01, C++ GENERATOR, RPERL SYNTAX:\nin Literal, expected type 'number' or 'string', but non-matching type '"
                . $self->{type}
                . "' found,\ncroaking" );
    }

    return ($self_generated);
};

1;
