# [[[ HEADER ]]]
package RPerl::Operation::Statement::Loop::ForEach;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Statement::Loop);
use RPerl::Operation::Statement::Loop;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

our string_hashref::method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

    #    RPerl::diag( 'in Loop::ForEach->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    # unwrap LoopForEach_170 from Loop_166
    if ( $self_class eq 'Loop_166' ) {    # Loop -> LoopForEach
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

    # LoopForEach -> 'foreach' MY Type VARIABLE_SYMBOL LPAREN ListElements ')' CodeBlock
    if ( $self_class eq 'LoopForEach_170' ) {
        my string $foreach         = $self->{children}->[0];
        my string $my              = $self->{children}->[1];
        my string $type            = $self->{children}->[2]->{children}->[0];
        my string $variable_symbol = $self->{children}->[3];
        my string $left_paren      = $self->{children}->[4];
        my object $list_elements   = $self->{children}->[5];
        my string $right_paren     = $self->{children}->[6];
        my object $codeblock       = $self->{children}->[7];

        # START HERE: add error checking for PERLOPS_PERLTYPES, then utilize for CPPOPS_CPPTYPES
        # START HERE: add error checking for PERLOPS_PERLTYPES, then utilize for CPPOPS_CPPTYPES
        # START HERE: add error checking for PERLOPS_PERLTYPES, then utilize for CPPOPS_CPPTYPES
 
#        RPerl::diag( 'in Loop::ForEach->ast_to_rperl__generate(), have $list_elements = ' . "\n" . RPerl::Parser::rperl_ast__dump($list_elements) . "\n" );
#        die 'TMP DEBUG';
#        if ((scalar @{$list_elements->{children}->[1]->{children}}) > 0) {  # non-empty _STAR_LIST, meaning 2 or more total elements in ListElements
#        }

        $rperl_source_group->{PMC} .= $foreach . q{ } . $my . q{ } . $type . q{ } . $variable_symbol . q{ } . $left_paren . q{ };
        my object $rperl_source_subgroup = $list_elements->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $right_paren . q{ };
        $rperl_source_subgroup = $codeblock->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule ' . $self_class . ' found where LoopForEach_170 expected, dying' )
            . "\n";
    }
    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::O::S::L::FE __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;

    # START HERE: implement CPPOPS_CPPTYPES
    # START HERE: implement CPPOPS_CPPTYPES
    # START HERE: implement CPPOPS_CPPTYPES

    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::O::S::L::FE __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
};

1;    # end of class
