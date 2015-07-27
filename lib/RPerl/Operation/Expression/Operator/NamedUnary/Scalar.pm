# [[[ DOCUMENTATION ]]]
# http://perldoc.perl.org/functions/scalar.html
#     SUPPORTED:  scalar EXPR

# [[[ HEADER ]]]
package RPerl::Operation::Expression::Operator::NamedUnary::Scalar;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.002_010;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::Operator::NamedUnary);
use RPerl::Operation::Expression::Operator::NamedUnary;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants

# [[[ CONSTANTS ]]]
use constant NAME_PERLOPS_PERLTYPES => my string $TYPED_NAME_PERLOPS_PERLTYPES = 'scalar';
use constant NAME_CPPOPS_PERLTYPES  => my string $TYPED_NAME_CPPOPS_PERLTYPES  = 'DUMMY_OP_SCALAR';
use constant NAME_CPPOPS_CPPTYPES   => my string $TYPED_NAME_CPPOPS_CPPTYPES   = 'size';
use constant ARGUMENTS_MIN          => my integer $TYPED_ARGUMENTS_MIN         = 1;
use constant ARGUMENTS_MAX          => my integer $TYPED_ARGUMENTS_MAX         = 1;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my object $operator_named, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = {};

#    RPerl::diag( 'in NamedUnary::Scalar->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag( 'in NamedUnary::Scalar->ast_to_rperl__generate(), received $operator_named = ' . "\n" . RPerl::Parser::rperl_ast__dump($operator_named) . "\n" );

    # unless Operator_94 below, then Operator_95: Operator -> OP10_NAMED_UNARY
    #    $rperl_source_group->{PMC} = $operator_named->{children}->[0];
    # take op name from the output specifications in this file, not the input specifications in the grammar
    $rperl_source_group->{PMC} = NAME_PERLOPS_PERLTYPES();

    # Operator_94: Operator -> OP10_NAMED_UNARY SubExpression
    if ( exists $operator_named->{children}->[1] ) {
        my string_hashref $rperl_source_subgroup = $operator_named->{children}->[1]->ast_to_rperl__generate( $self, $modes );
        $rperl_source_group->{PMC} .= q{ } . $rperl_source_subgroup->{PMC};
    }

    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::O::E::O::NU::S __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my object $operator_named, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{} };

#    RPerl::diag( 'in NamedUnary::Scalar->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag( 'in NamedUnary::Scalar->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $operator_named = ' . "\n" . RPerl::Parser::rperl_ast__dump($operator_named) . "\n" );

    # must have ArrayDereference as only argument
    my object $subexpression       = $operator_named->{children}->[1];
    my string $subexpression_class = ref $subexpression;
    if (    ( $subexpression_class ne 'SubExpression_135' )
        and ( $subexpression_class ne 'ArrayDereference_190' )
        and ( $subexpression_class ne 'ArrayDereference_191' ) )
    {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: grammar rule '
                . $subexpression_class
                . ' found where SubExpression_135, ArrayDereference_190 or ArrayDereference_191 expected, dying' )
            . "\n";
    }

    # unwrap ArrayDereference_190 and ArrayDereference_191 from SubExpression_135
    if ( $subexpression_class eq 'SubExpression_135' ) {    # SubExpression -> ArrayDereference
        $subexpression = $subexpression->{children}->[0];
    }

    $subexpression_class = ref $subexpression;
    my string_hashref $cpp_source_subgroup;
    if ( $subexpression_class eq 'ArrayDereference_190' ) {    # ArrayDereference -> '@{' Variable '}'
        $cpp_source_subgroup = $subexpression->{children}->[1]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
    }
    elsif ( $subexpression_class eq 'ArrayDereference_191' ) {    # ArrayDereference -> '@{' OPTIONAL-47 ArrayReference '}'
        my object $type_inner_optional = $subexpression->{children}->[1];
        my object $array_reference     = $subexpression->{children}->[2];

        if ( exists $type_inner_optional->{children}->[0] ) {
            $cpp_source_group->{CPP} .= '((';
            $cpp_source_subgroup = $type_inner_optional->{children}->[0]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
#            RPerl::diag( 'in NamedUnary::Scalar->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $cpp_source_subgroup = ' . "\n" . RPerl::Parser::rperl_ast__dump($cpp_source_subgroup) . "\n" );
            RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
            $cpp_source_group->{CPP} .= ') ';
            $cpp_source_subgroup = $array_reference->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
            $cpp_source_group->{CPP} .= ')';
        }

        # DEV NOTE: I think we don't have to die here in CPPOPS_PERLTYPES mode???
        else {
            die RPerl::Parser::rperl_rule__replace(
                'ERROR ECVGEASCP11, CODE GENERATOR, ABSTRACT SYNTAX TO C++: array dereference of array reference must provide data type for array reference in CPPOPS_CPPTYPES mode, but no data type provide, dying'
            ) . "\n";
        }
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: grammar rule '
                . $subexpression_class
                . ' found where ArrayDereference_190 or ArrayDereference_191 expected, dying' )
            . "\n";
    }

    $cpp_source_group->{CPP} .= '.' . NAME_CPPOPS_CPPTYPES() . '()';
    return $cpp_source_group;
};

1;    # end of class
