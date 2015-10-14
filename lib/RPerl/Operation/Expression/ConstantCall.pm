# [[[ HEADER ]]]
package RPerl::Operation::Expression::ConstantCall;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.003_000;

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

#    RPerl::diag( 'in ConstantCall->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    if ( ( ref $self ) eq 'Expression_127' ) {
        # Expression -> WORD_UPPERCASE LPAREN ')'
        my string $name        = $self->{children}->[0];
        my string $left_paren  = $self->{children}->[1];
        my string $right_paren = $self->{children}->[2];

        $rperl_source_group->{PMC} .= $name . $left_paren . $right_paren;
    }
    elsif ( ( ref $self ) eq 'Expression_128' ) {
        # Expression -> WordScoped SCOPE WORD_UPPERCASE LPAREN ')' 
        my string_hashref $rperl_source_subgroup = $self->{children}->[0]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        my string $scope       = $self->{children}->[1];
        my string $name        = $self->{children}->[2];
        my string $left_paren  = $self->{children}->[3];
        my string $right_paren = $self->{children}->[4];

        $rperl_source_group->{PMC} .= $scope . $name . $left_paren . $right_paren;
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . ( ref $self )
                . ' found where Expression_127 or Expression_128 expected, dying' )
            . "\n";
    }

    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::O::E::CC __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{} };

#    RPerl::diag( 'in ConstantCall->ast_to_cpp__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    if ( ( ref $self ) eq 'Expression_127' ) {
        # Expression -> WORD_UPPERCASE LPAREN ')'
        my string $name        = $self->{children}->[0];
        $cpp_source_group->{CPP} .= $name;
    }
    elsif ( ( ref $self ) eq 'Expression_128' ) {
        # Expression -> Expression -> CONSTANT_CALL_SCOPED
        my string $call        = $self->{children}->[0];
        substr $call, -2, 2, q{};  # strip trailing parenthesis
        $call =~ s/:/_/gxms;
        $cpp_source_group->{CPP} .= $call;
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: grammar rule '
                . ( ref $self )
                . ' found where Expression_127 or Expression_128 expected, dying' )
            . "\n";
    }

    return $cpp_source_group;
};

1;    # end of class
