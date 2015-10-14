# [[[ HEADER ]]]
package RPerl::Operation::Expression::SubroutineCall;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_100;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression);
use RPerl::Operation::Expression;

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

#    RPerl::diag( 'in SubroutineCall->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    if ( ( ref $self ) ne 'Expression_129' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . ( ref $self )
                . ' found where Expression_129 expected, dying' )
            . "\n";
    }

    # Expression -> WordScoped LPAREN OPTIONAL-33 ')'
    my object $name               = $self->{children}->[0];
    my string $left_paren         = $self->{children}->[1];
    my object $arguments_optional = $self->{children}->[2];
    my string $right_paren        = $self->{children}->[3];
    $rperl_source_group->{PMC}
        .= $name->{children}->[0] . $left_paren;

    if ( exists $arguments_optional->{children}->[0] ) {
        $rperl_source_subgroup = $arguments_optional->{children}->[0]
            ->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
    }

    $rperl_source_group->{PMC} .= $right_paren;
    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = {
        CPP => q{// <<< RP::O::E::SC __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n"
        };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{} };
    my string_hashref $cpp_source_subgroup;

#    RPerl::diag( 'in SubroutineCall->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    if ( ( ref $self ) ne 'Expression_129' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: grammar rule '
                . ( ref $self )
                . ' found where Expression_129 expected, dying' )
            . "\n";
    }

    # Expression -> WordScoped LPAREN OPTIONAL-33 ')'
    my object $name               = $self->{children}->[0];
    my string $left_paren         = $self->{children}->[1];
    my object $arguments_optional = $self->{children}->[2];
    my string $right_paren        = $self->{children}->[3];
    
    # remove leading double-colon scope operator '::'
    my string $name_string = $name->{children}->[0];
    if ((substr $name_string, 0, 2) eq '::') {
        substr $name_string, 0, 2, '';
    }
    
    # replace RPerl system builtin functions with proper C++ name alternatives
    if (exists $rperloperations::BUILTINS->{$name_string}) {
        $name_string = $rperloperations::BUILTINS->{$name_string};
    }

    # replace all semicolons with underscores
    $name_string =~ s/:/_/gxms;

    $cpp_source_group->{CPP} .= $name_string . $left_paren;

    if ( exists $arguments_optional->{children}->[0] ) {
        $cpp_source_subgroup = $arguments_optional->{children}->[0]
            ->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group,
            $cpp_source_subgroup );
    }

    $cpp_source_group->{CPP} .= $right_paren;
    return $cpp_source_group;
};

1;    # end of class
