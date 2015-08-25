# [[[ HEADER ]]]
package RPerl::Operation::Statement::Conditional;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Statement);

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref::method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Conditional->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    # unwrap Conditional_161 from Statement_150
    if ( $self_class eq 'Statement_150' ) {    # Statement -> Conditional
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

#    RPerl::diag( 'in Conditional->ast_to_rperl__generate(), have possibly-unwrapped $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

  # Conditional -> 'if' LPAREN SubExpression ')' CodeBlock STAR-38 OPTIONAL-40
    if ( $self_class eq 'Conditional_161' ) {
        my string $if            = $self->{children}->[0];
        my string $left_paren    = $self->{children}->[1];
        my object $subexpression = $self->{children}->[2];
        my string $right_paren   = $self->{children}->[3];
        my object $codeblock     = $self->{children}->[4];
        my object $elsif_star    = $self->{children}->[5];
        my object $else_optional = $self->{children}->[6];

#        RPerl::diag( 'in Conditional->ast_to_rperl__generate(), have $if = ' . $if . "\n" );
#        RPerl::diag( 'in Conditional->ast_to_rperl__generate(), have $left_paren = ' . $left_paren . "\n" );
#        RPerl::diag( 'in Conditional->ast_to_rperl__generate(), have ( ref $subexpression ) = ' . ( ref $subexpression ) . "\n" );
#        RPerl::diag( 'in Conditional->ast_to_rperl__generate(), have $right_paren = ' . $right_paren . "\n" );
#        RPerl::diag( 'in Conditional->ast_to_rperl__generate(), have ( ref $codeblock ) = ' . ( ref $codeblock ) . "\n" );
#        RPerl::diag( 'in Conditional->ast_to_rperl__generate(), have ( ref $elsif_star ) = ' . ( ref $elsif_star ) . "\n" );
#        RPerl::diag( 'in Conditional->ast_to_rperl__generate(), have $elsif_star = ' . "\n" . RPerl::Parser::rperl_ast__dump($elsif_star) . "\n" );
#        RPerl::diag( 'in Conditional->ast_to_rperl__generate(), have ( ref $else_optional ) = ' . ( ref $else_optional ) . "\n" );

        $rperl_source_group->{PMC} .= $if . q{ } . $left_paren . q{ };
        my object $rperl_source_subgroup
            = $subexpression->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $right_paren . q{ };
        $rperl_source_subgroup = $codeblock->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );

        # ('elsif' LPAREN SubExpression ')' CodeBlock)*
        # NEED FIX: destructive to AST!!!
        while ( exists $elsif_star->{children}->[0] ) {

# DEV NOTE: 'elsif' and ')' are automatically dropped by EYAPP, presumably because they are hard-coded strings inside EYAPP parenthesis, possibly EYAPP bug?
#            my object $elsif = shift @{ $elsif_star->{children} };
            my string $elsif            = 'elsif';
            my string $elsif_left_paren = shift @{ $elsif_star->{children} };
            my object $elsif_subexpression
                = shift @{ $elsif_star->{children} };

#            my object $elsif_right_paren  = shift @{ $elsif_star->{children} };
            my string $elsif_right_paren = ')';
            my object $elsif_codeblock   = shift @{ $elsif_star->{children} };

#            RPerl::diag( 'in Conditional->ast_to_rperl__generate(), have $elsif = ' . "\n" . RPerl::Parser::rperl_ast__dump($elsif) . "\n" );
#            RPerl::diag( 'in Conditional->ast_to_rperl__generate(), have $elsif_left_paren = ' . "\n" . RPerl::Parser::rperl_ast__dump($elsif_left_paren) . "\n" );

            $rperl_source_group->{PMC}
                .= $elsif . q{ } . $elsif_left_paren->{attr} . q{ };
            $rperl_source_subgroup
                = $elsif_subexpression->ast_to_rperl__generate($modes);
            RPerl::Generator::source_group_append( $rperl_source_group,
                $rperl_source_subgroup );
            $rperl_source_group->{PMC} .= q{ } . $elsif_right_paren . q{ };
            $rperl_source_subgroup
                = $elsif_codeblock->ast_to_rperl__generate($modes);
            RPerl::Generator::source_group_append( $rperl_source_group,
                $rperl_source_subgroup );
        }

        # ('else' CodeBlock)?
        if ( exists $else_optional->{children}->[0] ) {

            #            my string $else = $else_optional->{children}->[0];
            my string $else           = 'else';
            my object $else_codeblock = $else_optional->{children}->[0];

            $rperl_source_group->{PMC} .= $else . q{ };
            $rperl_source_subgroup
                = $else_codeblock->ast_to_rperl__generate($modes);
            RPerl::Generator::source_group_append( $rperl_source_group,
                $rperl_source_subgroup );
        }
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . $self_class
                . ' found where Conditional_161 expected, dying' )
            . "\n";
    }
    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = {
        CPP => q{// <<< RP::O::S::C __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n"
        };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{} };

#    RPerl::diag( 'in Conditional->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    # unwrap Conditional_161 from Statement_150
    if ( $self_class eq 'Statement_150' ) {    # Statement -> Conditional
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

#    RPerl::diag( 'in Conditional->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have possibly-unwrapped $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

  # Conditional -> 'if' LPAREN SubExpression ')' CodeBlock STAR-38 OPTIONAL-40
    if ( $self_class eq 'Conditional_161' ) {
        my string $if            = $self->{children}->[0];
        my string $left_paren    = $self->{children}->[1];
        my object $subexpression = $self->{children}->[2];
        my string $right_paren   = $self->{children}->[3];
        my object $codeblock     = $self->{children}->[4];
        my object $elsif_star    = $self->{children}->[5];
        my object $else_optional = $self->{children}->[6];

#        RPerl::diag( 'in Conditional->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $if = ' . $if . "\n" );
#        RPerl::diag( 'in Conditional->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $left_paren = ' . $left_paren . "\n" );
#        RPerl::diag( 'in Conditional->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have ( ref $subexpression ) = ' . ( ref $subexpression ) . "\n" );
#        RPerl::diag( 'in Conditional->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $right_paren = ' . $right_paren . "\n" );
#        RPerl::diag( 'in Conditional->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have ( ref $codeblock ) = ' . ( ref $codeblock ) . "\n" );
#        RPerl::diag( 'in Conditional->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have ( ref $elsif_star ) = ' . ( ref $elsif_star ) . "\n" );
#        RPerl::diag( 'in Conditional->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $elsif_star = ' . "\n" . RPerl::Parser::rperl_ast__dump($elsif_star) . "\n" );
#        RPerl::diag( 'in Conditional->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have ( ref $else_optional ) = ' . ( ref $else_optional ) . "\n" );

        $cpp_source_group->{CPP} .= $if . q{ } . $left_paren . q{ };
        my object $cpp_source_subgroup
            = $subexpression->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group,
            $cpp_source_subgroup );
        $cpp_source_group->{CPP} .= q{ } . $right_paren . q{ };
        $cpp_source_subgroup = $codeblock->ast_to_cpp__generate__CPPOPS_CPPTYPES(undef, $modes);  # undef $loop_label
        RPerl::Generator::source_group_append( $cpp_source_group,
            $cpp_source_subgroup );

        # ('elsif' LPAREN SubExpression ')' CodeBlock)*
        # NEED FIX: destructive to AST!!!
        while ( exists $elsif_star->{children}->[0] ) {

# DEV NOTE: 'elsif' and ')' are automatically dropped by EYAPP, presumably because they are hard-coded strings inside EYAPP parenthesis, possibly EYAPP bug?
#            my object $elsif = shift @{ $elsif_star->{children} };
            my string $elsif            = 'else if';
            my string $elsif_left_paren = shift @{ $elsif_star->{children} };
            my object $elsif_subexpression
                = shift @{ $elsif_star->{children} };

#            my object $elsif_right_paren  = shift @{ $elsif_star->{children} };
            my string $elsif_right_paren = ')';
            my object $elsif_codeblock   = shift @{ $elsif_star->{children} };

#            RPerl::diag( 'in Conditional->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $elsif = ' . "\n" . RPerl::Parser::rperl_ast__dump($elsif) . "\n" );
#            RPerl::diag( 'in Conditional->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $elsif_left_paren = ' . "\n" . RPerl::Parser::rperl_ast__dump($elsif_left_paren) . "\n" );

            $cpp_source_group->{CPP}
                .= $elsif . q{ } . $elsif_left_paren->{attr} . q{ };
            $cpp_source_subgroup
                = $elsif_subexpression->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            RPerl::Generator::source_group_append( $cpp_source_group,
                $cpp_source_subgroup );
            $cpp_source_group->{CPP} .= q{ } . $elsif_right_paren . q{ };
            $cpp_source_subgroup
                = $elsif_codeblock->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            RPerl::Generator::source_group_append( $cpp_source_group,
                $cpp_source_subgroup );
        }

        # ('else' CodeBlock)?
        if ( exists $else_optional->{children}->[0] ) {

            #            my string $else = $else_optional->{children}->[0];
            my string $else           = 'else';
            my object $else_codeblock = $else_optional->{children}->[0];

            $cpp_source_group->{CPP} .= $else . q{ };
            $cpp_source_subgroup
                = $else_codeblock->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            RPerl::Generator::source_group_append( $cpp_source_group,
                $cpp_source_subgroup );
        }
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: grammar rule '
                . $self_class
                . ' found where Conditional_161 expected, dying' )
            . "\n";
    }
    return $cpp_source_group;
};

1;    # end of class
