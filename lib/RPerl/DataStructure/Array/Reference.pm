# [[[ HEADER ]]]
package RPerl::DataStructure::Array::Reference;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::DataType::Modifier::Reference);
use RPerl::DataType::Modifier::Reference;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ INCLUDES ]]]
# DEV NOTE: must pre-declare string_hashref_method and object types here, because this file appears on a lower line number in rperltypes.pm
#require RPerl::CodeBlock::Subroutine::Method;
package string_hashref_method;

#require RPerl::Object;
package object;

package RPerl::DataStructure::Array::Reference;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Array::Reference->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    # unwrap ArrayReference_186 from SubExpression_133
    if ( $self_class eq 'SubExpression_133' ) {
        $self = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( ( $self_class ) ne 'ArrayReference_186' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . ( $self_class )
                . ' found where ArrayReference_186 or SubExpression_133 expected, dying' )
            . "\n";
    }

    # ArrayReference -> LBRACKET OPTIONAL-45 ']'
    my string $left_bracket           = $self->{children}->[0];
    my object $list_elements_optional = $self->{children}->[1];
    my string $right_bracket          = $self->{children}->[2];

    $rperl_source_group->{PMC} .= $left_bracket;

    if ( exists $list_elements_optional->{children}->[0] ) {
        my string_hashref $rperl_source_subgroup
            = $list_elements_optional->{children}->[0]
            ->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
    }

    $rperl_source_group->{PMC} .= $right_bracket;

    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = {
        CPP => q{// <<< RP::DS::A::R __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n"
        };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{} };

#    RPerl::diag( 'in Array::Reference->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    # unwrap ArrayReference_186 from SubExpression_133
    if ( $self_class eq 'SubExpression_133' ) {
        $self = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( ( $self_class ) ne 'ArrayReference_186' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: grammar rule '
                . ( $self_class )
                . ' found where ArrayReference_186 or SubExpression_133 expected, dying' )
            . "\n";
    }

    # ArrayReference -> LBRACKET OPTIONAL-45 ']'
    my object $list_elements_optional = $self->{children}->[1];

    $cpp_source_group->{CPP} .= '{';

    if ( exists $list_elements_optional->{children}->[0] ) {
        my string_hashref $cpp_source_subgroup
            = $list_elements_optional->{children}->[0]
            ->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group,
            $cpp_source_subgroup );
    }

    $cpp_source_group->{CPP} .= '}';

    return $cpp_source_group;
};

1;    # end of class
