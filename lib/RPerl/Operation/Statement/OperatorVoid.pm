# [[[ HEADER ]]]
package RPerl::Operation::Statement::OperatorVoid;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Statement);
use RPerl::Operation::Statement;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
#use RPerl::Test::Foo;  # NEED ANSWER: why are these here?  old debugging code to be deleted?
#use RPerl::Test::Bar;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub ast_to_rperl__generate {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $rperl_source_group = { PMC => q{} };
    my string_hashref $rperl_source_subgroup;

#    RPerl::diag( 'in OperatorVoid->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    # Print, OperatorNamedVoid, OperatorNamed, LoopControl
    my string $child0_class = ref $self->{children}->[0];
    if (   ( $child0_class eq 'OperatorVoid_135' )
        or ( $child0_class eq 'OperatorVoid_136' )
        or ( $child0_class eq 'OperatorVoid_137' )
        or ( $child0_class eq 'OperatorVoid_138' )
        or ( $child0_class eq 'OperatorVoid_139' )
        or ( $child0_class eq 'OperatorVoid_140' )
        or ( $child0_class eq 'OperatorVoid_141' )
        or ( $child0_class eq 'OperatorVoid_142' ) )
    {
        $rperl_source_subgroup
            = $self->{children}->[0]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . $child0_class
                . ' found where OperatorVoid_135, OperatorVoid_136, OperatorVoid_121, OperatorVoid_140, OperatorVoid_121, OperatorVoid_140, OperatorVoid_141, or OperatorVoid_142 expected, dying'
        ) . "\n";
    }
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group
        = {
        CPP => q{// <<< RP::O::S::OV __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n"
        };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{} };
    my string_hashref $cpp_source_subgroup;

#    RPerl::diag( 'in OperatorVoid->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    # Print, OperatorNamedVoid, OperatorNamed, LoopControl
    my string $child0_class = ref $self->{children}->[0];
    if (   ( $child0_class eq 'OperatorVoid_135' )
        or ( $child0_class eq 'OperatorVoid_136' )
        or ( $child0_class eq 'OperatorVoid_137' )
        or ( $child0_class eq 'OperatorVoid_138' )
        or ( $child0_class eq 'OperatorVoid_139' )
        or ( $child0_class eq 'OperatorVoid_140' )
        or ( $child0_class eq 'OperatorVoid_141' )
        or ( $child0_class eq 'OperatorVoid_142' ) )
    {
        $cpp_source_subgroup
            = $self->{children}->[0]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
#        RPerl::diag( 'in OperatorVoid->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $cpp_source_subgroup = ' . "\n" . RPerl::Parser::rperl_ast__dump($cpp_source_subgroup) . "\n" );
        RPerl::Generator::source_group_append( $cpp_source_group,
            $cpp_source_subgroup );
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                . $child0_class
                . ' found where OperatorVoid_135, OperatorVoid_136, OperatorVoid_121, OperatorVoid_140, OperatorVoid_121, OperatorVoid_140, OperatorVoid_141, or OperatorVoid_142 expected, dying'
        ) . "\n";
    }
    return $cpp_source_group;
}

1;    # end of class
