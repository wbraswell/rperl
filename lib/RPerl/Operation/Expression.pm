# [[[ HEADER ]]]
package RPerl::Operation::Expression;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_010;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation);
use RPerl::Operation;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref::method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group
        = { PMC => q{} };
    my string_hashref $rperl_source_subgroup;

#    RPerl::diag( 'in Expression->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    if ( ( ref $self ) eq 'Operation_78' ) {    # Operation -> Expression ';'
        $rperl_source_subgroup
            = $self->{children}->[0]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= $self->{children}->[1] . "\n";  # semicolon
    }
    elsif ( ( ref $self ) eq 'SubExpression_132' ) {  # SubExpression -> Expression
        $rperl_source_subgroup
            = $self->{children}->[0]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . ( ref $self )
                . ' found where Operation_78 or SubExpression_132 expected, dying'
        ) . "\n";
    }

    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP => q{// <<< RP::O::E __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP => q{} };
    my string_hashref $cpp_source_subgroup;

#    RPerl::diag( 'in Expression->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    if ( ( ref $self ) eq 'Operation_78' ) {    # Operation -> Expression ';'
        $cpp_source_subgroup
            = $self->{children}->[0]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
#        RPerl::diag( 'in Expression->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $cpp_source_subgroup = ' . "\n" . RPerl::Parser::rperl_ast__dump($cpp_source_subgroup) . "\n" );
        RPerl::Generator::source_group_append( $cpp_source_group,
            $cpp_source_subgroup );
        $cpp_source_group->{CPP} .= $self->{children}->[1] . "\n";  # semicolon
    }
    elsif ( ( ref $self ) eq 'SubExpression_132' ) {  # SubExpression -> Expression
        $cpp_source_subgroup
            = $self->{children}->[0]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
#        RPerl::diag( 'in Expression->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $cpp_source_subgroup = ' . "\n" . RPerl::Parser::rperl_ast__dump($cpp_source_subgroup) . "\n" );
        RPerl::Generator::source_group_append( $cpp_source_group,
            $cpp_source_subgroup );
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: grammar rule '
                . ( ref $self )
                . ' found where Operation_78 or SubExpression_132 expected, dying'
        ) . "\n";
    }

    return $cpp_source_group;
};

1;    # end of class
