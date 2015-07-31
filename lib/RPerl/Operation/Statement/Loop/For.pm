# [[[ HEADER ]]]
package RPerl::Operation::Statement::Loop::For;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_000;

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

#    RPerl::diag( 'in Loop::For->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    # unwrap LoopFor_163 from Loop_160
    if ( $self_class eq 'Loop_160' ) {    # Loop -> LoopFor
        $self = $self->{children}->[0];
        $self_class = ref $self;
    }

    # LoopFor -> 'for' MY TYPE_INTEGER VARIABLE_SYMBOL LPAREN SubExpression OP17_LIST_RANGE SubExpression ')' CodeBlock
    if ( $self_class eq 'LoopFor_163' ) {
        my string $for             = $self->{children}->[0];
        my string $my              = $self->{children}->[1];
        my string $type_integer    = $self->{children}->[2];
        my string $variable_symbol = $self->{children}->[3];
        my string $left_paren      = $self->{children}->[4];
        my object $subexpression0  = $self->{children}->[5];
        my string $list_range      = $self->{children}->[6];
        my object $subexpression1  = $self->{children}->[7];
        my string $right_paren     = $self->{children}->[8];
        my object $codeblock       = $self->{children}->[9];

        $rperl_source_group->{PMC} .= $for . q{ } . $my . q{ } . $type_integer . q{ } . $variable_symbol . q{ } . $left_paren . q{ };
        my object $rperl_source_subgroup = $subexpression0->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $list_range . q{ };
        $rperl_source_subgroup = $subexpression1->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $right_paren . q{ };
        $rperl_source_subgroup = $codeblock->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . $self_class
                . ' found where LoopFor_163 expected, dying' )
            . "\n";
    }
    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP =>
            q{// <<< RP::O::S::L::F __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{} };

#    RPerl::diag( 'in Loop::For->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    # unwrap LoopFor_163 from Loop_160
    if ( $self_class eq 'Loop_160' ) {    # Loop -> LoopFor
        $self = $self->{children}->[0];
        $self_class = ref $self;
    }

    # LoopFor -> 'for' MY TYPE_INTEGER VARIABLE_SYMBOL LPAREN SubExpression OP17_LIST_RANGE SubExpression ')' CodeBlock
    if ( $self_class eq 'LoopFor_163' ) {
        my string $for             = $self->{children}->[0];
        my string $type_integer    = $self->{children}->[2];
        my string $variable_symbol = $self->{children}->[3];
        my string $left_paren      = $self->{children}->[4];
        my object $subexpression0  = $self->{children}->[5];
        my object $subexpression1  = $self->{children}->[7];
        my string $right_paren     = $self->{children}->[8];
        my object $codeblock       = $self->{children}->[9];

        substr $variable_symbol, 0, 1, '';  # remove leading $ sigil

        $cpp_source_group->{CPP} .= $for . q{ } . $left_paren . q{ } . $type_integer . q{ } . $variable_symbol . q{ = };
        my object $cpp_source_subgroup = $subexpression0->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
        $cpp_source_group->{CPP} .= q{; } . $variable_symbol . ' <= ';
        $cpp_source_subgroup = $subexpression1->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
        $cpp_source_group->{CPP} .= q{; } . $variable_symbol . '++ ' . $right_paren . q{ };
        $cpp_source_subgroup = $codeblock->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: grammar rule '
                . $self_class
                . ' found where LoopFor_163 expected, dying' )
            . "\n";
    }
    return $cpp_source_group;
};

1;    # end of class
