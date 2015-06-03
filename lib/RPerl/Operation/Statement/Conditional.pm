# [[[ HEADER ]]]
package RPerl::Operation::Statement::Conditional;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Statement);

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Conditional->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    # unwrap Conditional_154 from Statement_143
    if ( $self_class eq 'Statement_143' ) {    # Statement -> Conditional
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

  # Conditional -> 'if' LPAREN SubExpression ')' CodeBlock STAR-38 OPTIONAL-40
    if ( $self_class eq 'Conditional_154' ) {
        my string $if            = $self->{children}->[0];
        my string $left_paren    = $self->{children}->[1];
        my object $subexpression = $self->{children}->[2];
        my string $right_paren   = $self->{children}->[3];
        my object $codeblock     = $self->{children}->[4];
        my object $elsif_star    = $self->{children}->[5];
        my object $else_optional = $self->{children}->[6];

        $rperl_source_group->{PMC} .= $if . q{ } . $left_paren . q{ };
        my object $rperl_source_subgroup
            = $subexpression->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $right_paren . q{ };
        $rperl_source_subgroup = $codeblock->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );

        # ('elsif' LPAREN SubExpression ')' CodeBlock)*
        # DEV NOTE: destructive to AST!!!
        while ( exists $elsif_star->{children}->[0] ) {
            my string $elsif = shift @{ $elsif_star->{children} };
            my string $elsif_left_paren    = shift @{ $elsif_star->{children} };
            my object $elsif_subexpression  = shift @{ $elsif_star->{children} };
            my string $elsif_right_paren  = shift @{ $elsif_star->{children} };
            my object $elsif_codeblock  = shift @{ $elsif_star->{children} };
 
            $rperl_source_group->{PMC} .= $elsif->{attr} . q{ } . $elsif_left_paren->{attr} . q{ };
            $rperl_source_subgroup = $elsif_subexpression->ast_to_rperl__generate($modes);
            RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
            $rperl_source_group->{PMC} .= q{ } . $elsif_right_paren->{attr} . q{ };
            $rperl_source_subgroup = $elsif_codeblock->ast_to_rperl__generate($modes);
            RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        }

        # ('else' CodeBlock)?
        if ( exists $else_optional->{children}->[0] ) {
            my string $else = $else_optional->{children}->[0];
            my object $else_codeblock  = shift @{ $elsif_star->{children} };
 
            $rperl_source_group->{PMC} .= $else->{attr} . q{ };
            $rperl_source_subgroup = $else_codeblock->ast_to_rperl__generate($modes);
            RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        }
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . $self_class
                . ' found where Conditional_154 expected, dying' )
            . "\n";
    }
    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = {
        CPP => q{// <<< RP::O::S::C __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n"
        };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = {
        CPP => q{// <<< RP::O::S::C __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>}
            . "\n"
        };

    #...
    return $cpp_source_group;
};

1;    # end of class
