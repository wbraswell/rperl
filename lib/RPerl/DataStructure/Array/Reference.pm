# [[[ HEADER ]]]
package RPerl::DataStructure::Array::Reference;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.005_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::DataType::Modifier::Reference);
use RPerl::DataType::Modifier::Reference;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ INCLUDES ]]]
# DEV NOTE: must pre-declare string_hashref::method and object types here, because this file appears on a lower line number in rperltypes.pm
#require RPerl::CodeBlock::Subroutine::Method;
package    # hide from PAUSE indexing
    string_hashref::method;
use strict;
use warnings;

#require RPerl::Object;
package    # hide from PAUSE indexing
    object;
use strict;
use warnings;

package RPerl::DataStructure::Array::Reference;
use strict;
use warnings;

# [[[ OO PROPERTIES ]]]
# NEED FIX: type 'hashref' not yet defined here,
# makes it impossible to 'use RPerl::DataStructure::Array;' or 'use RPerl::DataStructure::Hash;',
# followed by more cascading errors
our hashref $properties = {};

#our $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub ast_to_rperl__generate {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $rperl_source_group = { PMC => q{} };

    #    RPerl::diag( 'in Array::Reference->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    # unwrap ArrayReference_218 from SubExpression_159
    if ( $self_class eq 'SubExpression_159' ) {
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( ($self_class) ne 'ArrayReference_218' ) {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP000, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . ($self_class)
                . ' found where ArrayReference_218 or SubExpression_159 expected, dying' )
            . "\n";
    }

    # ArrayReference -> LBRACKET OPTIONAL-45 ']'
    my string $left_bracket           = $self->{children}->[0];
    my object $list_elements_optional = $self->{children}->[1];
    my string $right_bracket          = $self->{children}->[2];

    $rperl_source_group->{PMC} .= $left_bracket;

    if ( exists $list_elements_optional->{children}->[0] ) {
        my string_hashref $rperl_source_subgroup = $list_elements_optional->{children}->[0]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }

    $rperl_source_group->{PMC} .= $right_bracket;
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::DS::A::R __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{} };

    #    RPerl::diag( 'in Array::Reference->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    # unwrap ArrayReference_218 from SubExpression_159
    if ( $self_class eq 'SubExpression_159' ) {
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( ($self_class) ne 'ArrayReference_218' ) {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP000, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                . ($self_class)
                . ' found where ArrayReference_218 or SubExpression_159 expected, dying' )
            . "\n";
    }

    # ArrayReference -> LBRACKET OPTIONAL-45 ']'
    my object $list_elements_optional = $self->{children}->[1];

    $cpp_source_group->{CPP} .= '{';

    if ( exists $list_elements_optional->{children}->[0] ) {
        my string_hashref $cpp_source_subgroup = $list_elements_optional->{children}->[0]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
    }

    $cpp_source_group->{CPP} .= '}';
    return $cpp_source_group;
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES__bson_build {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{} };

    #    RPerl::diag( 'in Array::Reference->ast_to_cpp__generate__CPPOPS_CPPTYPES__bson_build(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    # unwrap ArrayReference_218 from SubExpression_159
    if ( $self_class eq 'SubExpression_159' ) {
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( ($self_class) ne 'ArrayReference_218' ) {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP000, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                . ($self_class)
                . ' found where ArrayReference_218 or SubExpression_159 expected, dying' )
            . "\n";
    }

    # ArrayReference -> LBRACKET OPTIONAL-45 ']'
    my object $list_elements_optional = $self->{children}->[1];

#    $cpp_source_group->{CPP} .= '{';
    $cpp_source_group->{CPP} .= 'bson_arrayref_begin << ';

    if ( exists $list_elements_optional->{children}->[0] ) {
        my string_hashref $cpp_source_subgroup = $list_elements_optional->{children}->[0]->ast_to_cpp__generate__CPPOPS_CPPTYPES__bson_build($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
    }

#    $cpp_source_group->{CPP} .= '}';
    $cpp_source_group->{CPP} .= ' << bson_arrayref_end';
    return $cpp_source_group;
}

1;    # end of class
