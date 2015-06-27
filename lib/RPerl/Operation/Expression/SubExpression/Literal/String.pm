# [[[ HEADER ]]]
package RPerl::Operation::Expression::SubExpression::Literal::String;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::SubExpression::Literal);
use RPerl::Operation::Expression::SubExpression::Literal;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Literal::String->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    if ( ( ref $self ) ne 'Literal_219' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . ( ref $self )
                . ' found where Literal_219 expected, dying' )
            . "\n";
    }
 
    # Literal -> LITERAL_STRING
    my string $value           = $self->{children}->[0];
    $rperl_source_group->{PMC} .= $value;

    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP => q{// <<< RP::O::E::SE::L::S __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group;

#    RPerl::diag( 'in Literal::String->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    if ( ( ref $self ) ne 'Literal_219' ) {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: grammar rule ' . ( ref $self ) . ' found where Literal_219 expected, dying' ) . "\n";
    }
    
    # replace single-quoted Perl string with double-quoted C++ string, both non-interpolated
    $cpp_source_group->{CPP} = $self->{children}->[0];
    if ((substr $cpp_source_group->{CPP}, 0, 1) eq q{'}) {
        if ((substr $cpp_source_group->{CPP}, -1, 1) eq q{'}) {
            substr $cpp_source_group->{CPP}, 0, 1, q{"};
            substr $cpp_source_group->{CPP}, -1, 1, q{"};
        }
        else {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECVGEASCP04, CODE GENERATOR, ABSTRACT SYNTAX TO C++: string literal started with single-quote but not terminated with single-quote, dying' ) . "\n";
        }
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECVGEASCP03, CODE GENERATOR, ABSTRACT SYNTAX TO C++: string literal not started with single-quote, dying' ) . "\n";
    }

    return $cpp_source_group;
};

1;
