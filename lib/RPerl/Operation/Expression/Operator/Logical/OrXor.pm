# [[[ HEADER ]]]
package RPerl::Operation::Expression::Operator::Logical::OrXor;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::Operator::Logical);
use RPerl::Operation::Expression::Operator::Logical;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ CONSTANTS ]]]
# DEV NOTE, CORRELATION #rp071: "logical or" || operator behaves differently in Perl vs C++, accepts strings so must use double-negation trick to convert to boolean, returns operand on left if operator evaluates to true; use ORl instead of || in C++
# DEV NOTE, CORRELATION #rp079: do not copy constant subroutines, avoid error "Not a subroutine reference"
use constant NAME_CPPOPS_CPPTYPES_OR => my string $TYPED_NAME = 'ORl';



# START HERE: implement lib/RPerl/Test/Operator24LogicalOrXor/*
# START HERE: implement lib/RPerl/Test/Operator24LogicalOrXor/*
# START HERE: implement lib/RPerl/Test/Operator24LogicalOrXor/*



# DEV NOTE, CORRELATION #rp072: "logical xor" operator behaves differently in Perl vs C++, accepts strings so must FOOOOOO
use constant NAME_CPPOPS_CPPTYPES_XOR => my string $TYPED_NAME = 'XORl';

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub ast_to_rperl__generate {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $rperl_source_group = { PMC => q{} };

    #    RPerl::diag( 'in Operator::Logical::OrXor->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;
    if (( $self_class eq 'Operator_123' )       # Operator -> SubExpression OP16_LOGICAL_OR SubExpression
        or ( $self_class eq 'Operator_129' )    # Operator -> SubExpression OP24_LOGICAL_OR_XOR SubExpression
        )
    {
        my string_hashref $rperl_source_subgroup = $self->{children}->[0]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $self->{children}->[1] . q{ };
        $rperl_source_subgroup = $self->{children}->[2]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP000, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule ' . $self_class . ' found where Operator_123 or Operator_129 expected, dying' ) . "\n";
    }
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::O::E::O::L::OX __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{} };

#    RPerl::diag( 'in Operator::Logical::OrXor->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    # NEED FIX: in Perl, '||' and 'or' are equivalent except 'or' has a lower precedence; in C++, '||' and 'or' are exactly equivalent;
    # therefore I assume we need to add parenthesis around the operands to the left and right of Perl's 'or' when it is compiled to C++,
    # in order to replicate the precedence behavior?

    my string $self_class = ref $self;
    if (( $self_class eq 'Operator_123' )       # Operator -> SubExpression OP16_LOGICAL_OR SubExpression
        or ( $self_class eq 'Operator_129' )    # Operator -> SubExpression OP24_LOGICAL_OR_XOR SubExpression
        )
    {
        if (($self->{children}->[1] eq '||') or
            ($self->{children}->[1] eq 'or')) {
            # DEV NOTE, CORRELATION #rp071: "logical or" || operator behaves differently in Perl vs C++, accepts strings so must use double-negation trick to convert to boolean, returns operand on left if operator evaluates to true; use ORl instead of || in C++
            $cpp_source_group->{CPP} .= NAME_CPPOPS_CPPTYPES_OR() . '(';
        }
        elsif ($self->{children}->[1] eq 'xor') {
            # DEV NOTE, CORRELATION #rp071: "logical xor" operator behaves differently in Perl vs C++, accepts strings so FOOOO
            $cpp_source_group->{CPP} .= NAME_CPPOPS_CPPTYPES_XOR() . '(';
        }
        else {
            die RPerl::Parser::rperl_rule__replace( q{ERROR ECOGEASCP070, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar token '} . $self->{children}->[1] . q{' found where '||' or 'or' or 'xor' expected, dying} ) . "\n";
        }
 
        my string_hashref $cpp_source_subgroup = $self->{children}->[0]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );

        # NEED OPTIMIZE: normal C++ || operator can be used for boolean-only operands and will be faster, check here if booleans and use || instead of ORl
#        $cpp_source_group->{CPP} .= q{ } . $self->{children}->[1] . q{ };
        $cpp_source_group->{CPP} .= ', ';

        $cpp_source_subgroup = $self->{children}->[2]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
 
        $cpp_source_group->{CPP} .= ')';
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP000, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule ' . $self_class . ' found where Operator_123 or Operator_129 expected, dying' ) . "\n";
    }
    return $cpp_source_group;
}

1;    # end of class
