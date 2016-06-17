# [[[ HEADER ]]]
package RPerl::Operation::Expression::SubExpression::ArrayDereference;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_200;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::SubExpression);
use RPerl::Operation::Expression::SubExpression;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

our string_hashref::method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };
    my object $rperl_source_subgroup;

#    RPerl::diag( 'in ArrayDereference->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;
    # unwrap ArrayDereference_201 and ArrayDereference_202 from SubExpression_141
    if ( $self_class eq 'SubExpression_141' ) {  # SubExpression -> ArrayDereference
        $self = $self->{children}->[0];
    }

    $self_class = ref $self;
    if ( $self_class eq 'ArrayDereference_201' ) {  # ArrayDereference -> '@{' Variable '}'
        my string $at_left_brace = $self->{children}->[0];
        my object $variable = $self->{children}->[1];
        my string $right_brace = $self->{children}->[2];
 
        $rperl_source_group->{PMC} .= $at_left_brace . q{ };
        $rperl_source_subgroup = $variable->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $right_brace;
    }
    elsif ( $self_class eq 'ArrayDereference_202' ) {  # ArrayDereference -> '@{' OPTIONAL-47 ArrayReference '}'
        my string $at_left_brace = $self->{children}->[0];
        my object $type_inner_optional = $self->{children}->[1];
        my object $array_reference = $self->{children}->[2];
        my string $right_brace = $self->{children}->[3];
 
        $rperl_source_group->{PMC} .= $at_left_brace . q{ };
        if (exists $type_inner_optional->{children}->[0]) {
            $rperl_source_subgroup = $type_inner_optional->{children}->[0]->ast_to_rperl__generate($modes);
            RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
            $rperl_source_group->{PMC} .= q{ };
        }
        $rperl_source_subgroup = $array_reference->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $right_brace;
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . $self_class
                . ' found where ArrayDereference_201 or ArrayDereference_202 expected, dying'
        ) . "\n";
    }

    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::O::E::SE::AD __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::O::E::SE::AD __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>} . "\n" };

#    RPerl::diag( 'in ArrayDereference->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
    # DEV NOTE, CORRELATION #rp31: NEED ANSWER: are array dereferences allowed in CPPOPS or not???
#    die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCPxe, CODE GENERATOR, ABSTRACT SYNTAX TO C++: array dereference not supported in CPPOPS_CPPTYPES mode, dying' ) . "\n";

    return $cpp_source_group;
};

1;    # end of class
