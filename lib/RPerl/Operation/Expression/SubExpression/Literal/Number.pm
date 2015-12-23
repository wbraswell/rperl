# [[[ HEADER ]]]
package RPerl::Operation::Expression::SubExpression::Literal::Number;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::SubExpression::Literal);
use RPerl::Operation::Expression::SubExpression::Literal;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref::method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Literal::Number->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    if ( ( ref $self ) ne 'Literal_233' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . ( ref $self )
                . ' found where Literal_233 expected, dying' )
            . "\n";
    }
 
    # Literal -> LITERAL_NUMBER
    my string $value           = $self->{children}->[0];
    my string $value_type = main::type($value);
    if ($value_type eq 'integer') {
        $rperl_source_group->{PMC} .= integer_to_string($value);
    }
    elsif ($value_type eq 'number') {
        $rperl_source_group->{PMC} .= number_to_string($value);
    }
    else {
        $rperl_source_group->{PMC} .= $value;
    }

    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP => q{// <<< RP::O::E::SE::L::N __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
     my string_hashref $cpp_source_group = { CPP => q{} };

#    RPerl::diag( 'in Literal::Number->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    if ( ( ref $self ) ne 'Literal_233' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: grammar rule '
                . ( ref $self )
                . ' found where Literal_233 expected, dying' )
            . "\n";
    }
 
    # Literal -> LITERAL_NUMBER
    my string $value           = $self->{children}->[0];
    # DEV NOTE: don't use RPerl-style underscores in C++ literal numbers
    $value =~ s/_//gxms;  # strip underscores
    $cpp_source_group->{CPP} .= $value;
    return $cpp_source_group;
};

1;  # end of class
