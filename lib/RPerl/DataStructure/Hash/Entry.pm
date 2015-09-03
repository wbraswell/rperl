# [[[ HEADER ]]]
package RPerl::DataStructure::Hash::Entry;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_100;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::GrammarRule);
use RPerl::GrammarRule;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref::method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };
    my string_hashref $rperl_source_subgroup;

#    RPerl::diag( 'in Hash::Entry->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $key                 = $self->{children}->[0];
    my string $key_class           = ref $key;
    my string $fat_arrow           = $self->{children}->[1];
    my object $type_inner_optional = $self->{children}->[2];
    my string $key_name            = undef;

    if (   ( $key_class eq 'VariableOrLiteralOrWord_226' )
        or ( $key_class eq 'VariableOrLiteralOrWord_227' ) )
    {    # Variable or Literal
        $rperl_source_subgroup = $key->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
    }
    elsif ( $key_class eq 'VariableOrLiteralOrWord_228' ) {    # WORD
        $key_name = $key->{children}->[0];
        $rperl_source_group->{PMC} .= $key->{children}->[0] . q{ };
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            q{ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '}
                . ($key_class)
                . q{' found where VariableOrLiteralOrWord_226, VariableOrLiteralOrWord_227, or VariableOrLiteralOrWord_228 expected, dying}
        ) . "\n";
    }

    if (( exists $type_inner_optional->{children}->[0] ) and (defined $key_name)) {
        my string $type_inner_name = $type_inner_optional->{children}->[0]->{children}->[3];
        if ($type_inner_name !~ /$key_name$/xms) {
            die 'ERROR ECVGEASRP17, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: redundant name mismatch, inner type name ' . q{'}
                . $type_inner_name . q{'} . ' does not end with OO properties or hash key ' . q{'} . $key_name . q{'} . ', dying' . "\n";
        }
    }

    $rperl_source_group->{PMC} .= $fat_arrow . q{ };

    if ( exists $type_inner_optional->{children}->[0] ) {
        $rperl_source_subgroup = $type_inner_optional->{children}->[0]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }

    my object $subexpression = $self->{children}->[3];

    $rperl_source_subgroup = $subexpression->ast_to_rperl__generate($modes);
    RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );

    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP =>
              q{// <<< RP::DS::H::ET __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{} };
    my string_hashref $cpp_source_subgroup;

#    RPerl::diag( 'in Hash::Entry->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $key                 = $self->{children}->[0];
    my string $key_class           = ref $key;
    my object $type_inner_optional = $self->{children}->[2];
    my string $key_name            = undef;

    $cpp_source_group->{CPP} .= '{';

    if (   ( $key_class eq 'VariableOrLiteralOrWord_226' )
        or ( $key_class eq 'VariableOrLiteralOrWord_227' ) )
    {    # Variable or Literal
        $cpp_source_subgroup = $key->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group,
            $cpp_source_subgroup );
    }
    elsif ( $key_class eq 'VariableOrLiteralOrWord_228' ) {    # WORD
        $key_name = $key->{children}->[0];
        $cpp_source_group->{CPP} .= q{"} . $key_name . q{" };
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            q{ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: grammar rule '}
                . ($key_class)
                . q{' found where VariableOrLiteralOrWord_226, VariableOrLiteralOrWord_227, or VariableOrLiteralOrWord_228 expected, dying}
        ) . "\n";
    }

    if (( exists $type_inner_optional->{children}->[0] ) and (defined $key_name)) {
        my string $type_inner_name = $type_inner_optional->{children}->[0]->{children}->[3];
        if ($type_inner_name !~ /$key_name$/xms) {
            die 'ERROR ECVGEASCP17, CODE GENERATOR, ABSTRACT SYNTAX TO C++: redundant name mismatch, inner type name ' . q{'}
                . $type_inner_name . q{'} . ' does not end with OO properties or hash key ' . q{'} . $key_name . q{'} . ', dying' . "\n";
        }
    }

    $cpp_source_group->{CPP} .= q{, };

    my object $subexpression = $self->{children}->[3];

    $cpp_source_subgroup = $subexpression->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
    RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
 
    $cpp_source_group->{CPP} .= '}';

    return $cpp_source_group;
};

1;    # end of class
