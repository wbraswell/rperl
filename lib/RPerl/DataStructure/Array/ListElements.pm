# [[[ HEADER ]]]
package RPerl::DataStructure::Array::ListElements;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::GrammarRule);
use RPerl::GrammarRule;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our integer_method $length = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my integer $length = 0;

#    RPerl::diag( 'in Array::ListElements->length(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    if ( exists $self->{children}->[0] ) {
        $length++;
    }
    else {
        return $length;
    }
    my object $list_elements_star = $self->{children}->[1];

    foreach my object $list_element ( @{ $list_elements_star->{children} } ) {

#        RPerl::diag( 'in Array::ListElements->length(), top of foreach() loop, have $list_element = ' . "\n" . RPerl::Parser::rperl_ast__dump($list_element) . "\n" );
        if ( ref $list_element ne 'TERMINAL' ) {
            $length++;
        }
    }

    return $length;
};

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Array::ListElements->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    if ( ( ref $self ) ne 'ListElements_179' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . ( ref $self )
                . ' found where ListElements_179 expected, dying' )
            . "\n";
    }

    my object $list_element0      = $self->{children}->[0];
    my object $list_elements_star = $self->{children}->[1];

    my string_hashref $rperl_source_subgroup
        = $list_element0->ast_to_rperl__generate($modes);
    RPerl::Generator::source_group_append( $rperl_source_group,
        $rperl_source_subgroup );

    foreach my object $list_element ( @{ $list_elements_star->{children} } ) {

#        RPerl::diag( 'in Array::ListElements->ast_to_rperl__generate(), top of foreach() loop, have $list_element = ' . "\n" . RPerl::Parser::rperl_ast__dump($list_element) . "\n" );
        if ( ref $list_element eq 'TERMINAL' ) {
            if ( $list_element->{attr} ne q{,} ) {
                die RPerl::Parser::rperl_rule__replace(
                    q{ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '}
                        . $list_element->{attr}
                        . q{' found where OP21_LIST_COMMA ',' expected, dying}
                ) . "\n";
            }
            $rperl_source_group->{PMC} .= $list_element->{attr} . q{ }; # OP21_LIST_COMMA
        }
        else {
            my string_hashref $rperl_source_subgroup
                = $list_element->ast_to_rperl__generate($modes);
            RPerl::Generator::source_group_append( $rperl_source_group,
                $rperl_source_subgroup );
        }
    }

    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = {
        CPP => q{// <<< RP::DS::A::LEs __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n"
        };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{} };

#    RPerl::diag( 'in Array::ListElements->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    if ( ( ref $self ) ne 'ListElements_179' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: grammar rule '
                . ( ref $self )
                . ' found where ListElements_179 expected, dying' )
            . "\n";
    }

    my object $list_element0      = $self->{children}->[0];
    my object $list_elements_star = $self->{children}->[1];

    my string_hashref $cpp_source_subgroup
        = $list_element0->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
    RPerl::Generator::source_group_append( $cpp_source_group,
        $cpp_source_subgroup );

    foreach my object $list_element ( @{ $list_elements_star->{children} } ) {

#        RPerl::diag( 'in Array::ListElements->ast_to_cpp__generate__CPPOPS_CPPTYPES(), top of foreach() loop, have $list_element = ' . "\n" . RPerl::Parser::rperl_ast__dump($list_element) . "\n" );
        if ( ref $list_element eq 'TERMINAL' ) {
            if ( $list_element->{attr} ne q{,} ) {
                die RPerl::Parser::rperl_rule__replace(
                    q{ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '}
                        . $list_element->{attr}
                        . q{' found where OP21_LIST_COMMA ',' expected, dying}
                ) . "\n";
            }
            $cpp_source_group->{CPP} .= $list_element->{attr} . q{ }; # OP21_LIST_COMMA
        }
        else {
            my string_hashref $cpp_source_subgroup
                = $list_element->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            RPerl::Generator::source_group_append( $cpp_source_group,
                $cpp_source_subgroup );
        }
    }

    return $cpp_source_group;
};

1;    # end of class
