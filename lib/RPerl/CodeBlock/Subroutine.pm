# [[[ HEADER ]]]
package RPerl::CodeBlock::Subroutine;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.002_000;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names
BEGIN {

    package object_method;
    1;

    package hashref_method;
    1;

    package string_method;
    1;

    # DEV NOTE, CORRELATION #03: method types reside in Subroutine.pm, which is a sub-type of Subroutine.pm, causing the need to have this special BEGIN block
    # to enable the *_method types, and Class.pm's INIT block symbol table entry generator needs us to switch back into the primary package so we have
    # that happen in the following line, which furthermore triggers the need to avoid re-defining class accessor/mutator methods; how to fix?
    package RPerl::CodeBlock::Subroutine;
    1;
}

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CodeBlock);
use RPerl::CodeBlock;

# [[[ INCLUDES ]]]
use Storable qw(dclone);

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };
    my string_hashref $rperl_source_subgroup;

    #    RPerl::diag( 'in Subroutine->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    # unwrap Subroutine_46 from MethodOrSubroutine_75
    if ( ( ref $self ) eq 'MethodOrSubroutine_75' ) {
        $self = $self->{children}->[0];
    }

    if ( ( ref $self ) ne 'Subroutine_46' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule ' . ( ref $self ) . ' found where Subroutine_46 expected, dying' )
            . "\n";
    }

    #    RPerl::diag( 'in Subroutine->ast_to_rperl__generate(), have possibly-unwrapped $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $our                = $self->{children}->[0];
    my string $return_type        = $self->{children}->[1];
    my string $name               = $self->{children}->[2];
    my string $equal_sub          = $self->{children}->[3];
    my object $arguments_optional = $self->{children}->[4];
    my object $operations_star    = $self->{children}->[5];
    my string $right_brace        = $self->{children}->[6];
    my string $semicolon          = $self->{children}->[7];

    $rperl_source_group->{PMC}
        .= $our . q{ } . $return_type->{children}->[0] . q{ } . $name . q{ } . $equal_sub . "\n";

    if ( exists $arguments_optional->{children}->[0] ) {
        $rperl_source_subgroup = $arguments_optional->{children}->[0]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }

    foreach my object $operation ( @{ $operations_star->{children} } ) {
        $rperl_source_subgroup = $operation->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }

    $rperl_source_group->{PMC} .= $right_brace . $semicolon . "\n\n";
    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::CB::S __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
};

# START HERE: move args-generating code from below into Subroutine::Arguments, then implement ast_to_cpp__generate__CPPOPS_CPPTYPES() below
# START HERE: move args-generating code from below into Subroutine::Arguments, then implement ast_to_cpp__generate__CPPOPS_CPPTYPES() below
# START HERE: move args-generating code from below into Subroutine::Arguments, then implement ast_to_cpp__generate__CPPOPS_CPPTYPES() below

our string_hashref_method $ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { H => q{} };

    my object $subroutine             = $self->{children}->[0];                          # unwrap Subroutine_46 from MethodOrSubroutine_75
    my string $subroutine_return_type = $subroutine->{children}->[1]->{children}->[0];
    my string $subroutine_name        = $subroutine->{children}->[2];
    substr $subroutine_name, 0, 1, '';                                                   # remove leading $ sigil
    my object $subroutine_arguments_optional = $subroutine->{children}->[4];
    my string_arrayref $subroutine_arguments = [];

#RPerl::diag( 'in Subroutine->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $subroutine_arguments_optional = ' . "\n" . RPerl::Parser::rperl_ast__dump($subroutine_arguments_optional) . "\n" );
#RPerl::diag( 'in Subroutine->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $subroutine_return_type = ' . "\n" . RPerl::Parser::rperl_ast__dump($subroutine_return_type) . "\n" );

    if ( exists $subroutine_arguments_optional->{children}->[0] ) {
        my object $subroutine_arguments_type = $subroutine_arguments_optional->{children}->[0]->{children}->[1];
        my object $subroutine_arguments_name = $subroutine_arguments_optional->{children}->[0]->{children}->[2];

#RPerl::diag( 'in Subroutine->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $subroutine_arguments_type = ' . "\n" . RPerl::Parser::rperl_ast__dump($subroutine_arguments_type) . "\n" );
#RPerl::diag( 'in Subroutine->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $subroutine_arguments_name = ' . "\n" . RPerl::Parser::rperl_ast__dump($subroutine_arguments_name) . "\n" );

        push @{$subroutine_arguments}, ( $subroutine_arguments_type->{children}->[0] . q{ } . ( substr $subroutine_arguments_name, 1 ) );

        my object $subroutine_arguments_star = $subroutine_arguments_optional->{children}->[0]->{children}->[3];

#RPerl::diag( 'in Subroutine->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $subroutine_arguments_star = ' . "\n" . RPerl::Parser::rperl_ast__dump($subroutine_arguments_star) . "\n" );

        # (OP21_LIST_COMMA MY Type VARIABLE_SYMBOL)*
        my object $subroutine_arguments_star_dclone = dclone($subroutine_arguments_star);
        while ( exists $subroutine_arguments_star_dclone->{children}->[0] ) {
            shift @{ $subroutine_arguments_star_dclone->{children} };    # discard $comma
            shift @{ $subroutine_arguments_star_dclone->{children} };    # discard $my
            $subroutine_arguments_type = shift @{ $subroutine_arguments_star_dclone->{children} };
            $subroutine_arguments_name = shift @{ $subroutine_arguments_star_dclone->{children} };

#                    RPerl::diag( 'in Subroutine->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $subroutine_arguments_name = ' . "\n" . RPerl::Parser::rperl_ast__dump($subroutine_arguments_name) . "\n" );
            push @{$subroutine_arguments}, ( $subroutine_arguments_type->{children}->[0] . q{ } . ( substr $subroutine_arguments_name->{attr}, 1 ) );
        }

    }

    $cpp_source_group->{H} .= $subroutine_return_type . q{ } . $subroutine_name . '(' . ( join ', ', @{$subroutine_arguments} ) . ');';

    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::CB::S __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
};

1;    # end of class
