# [[[ HEADER ]]]
package RPerl::Operation::Statement::Loop::While;
use strict;
use warnings;
use RPerl::AfterFilter;
our $VERSION = 0.002_010;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Statement::Loop);
use RPerl::Operation::Statement::Loop;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref::method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Loop::While->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    # unwrap LoopWhile_161 from Loop_158
    if ( $self_class eq 'Loop_158' ) {    # Loop -> LoopWhile
        $self = $self->{children}->[0];
        $self_class = ref $self;
    }

    # LoopWhile -> 'while' LPAREN SubExpression ')' CodeBlock
    if ( $self_class eq 'LoopWhile_161' ) {
        my string $while         = $self->{children}->[0];
        my string $left_paren    = $self->{children}->[1];
        my object $subexpression = $self->{children}->[2];
        my string $right_paren   = $self->{children}->[3];
        my object $codeblock     = $self->{children}->[4];

        $rperl_source_group->{PMC} .= $while . q{ } . $left_paren . q{ };
        my object $rperl_source_subgroup = $subexpression->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $right_paren . q{ };
        $rperl_source_subgroup = $codeblock->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . $self_class
                . ' found where LoopWhile_161 expected, dying' )
            . "\n";
    }
    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP =>
            q{// <<< RP::O::S::L::W __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string $loop_label, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{} };

#    RPerl::diag( 'in Loop::While->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag( 'in Loop::While->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $loop_label = ' . $loop_label . "\n" );

    my string $self_class = ref $self;

    # unwrap LoopWhile_161 from Loop_158
    if ( $self_class eq 'Loop_158' ) {    # Loop -> LoopWhile
        $self = $self->{children}->[0];
        $self_class = ref $self;
    }

    # LoopWhile -> 'while' LPAREN SubExpression ')' CodeBlock
    if ( $self_class eq 'LoopWhile_161' ) {
        my string $while         = $self->{children}->[0];
        my string $left_paren    = $self->{children}->[1];
        my object $subexpression = $self->{children}->[2];
        my string $right_paren   = $self->{children}->[3];
        my object $codeblock     = $self->{children}->[4];

        $cpp_source_group->{CPP} .= $while . q{ } . $left_paren . q{ };
        my object $cpp_source_subgroup = $subexpression->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
        $cpp_source_group->{CPP} .= q{ } . $right_paren . q{ };
        $cpp_source_subgroup = $codeblock->ast_to_cpp__generate__CPPOPS_CPPTYPES($loop_label, $modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: grammar rule '
                . $self_class
                . ' found where LoopWhile_161 expected, dying' )
            . "\n";
    }
    return $cpp_source_group;
};

1;    # end of class
