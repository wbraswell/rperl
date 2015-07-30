# [[[ HEADER ]]]
package RPerl::CodeBlock::Subroutine;
use strict;
use warnings;
use RPerl::AfterFilter;
our $VERSION = 0.003_000;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names
BEGIN {

        package    # hide from PAUSE indexing
        string_hashref::method;
    use strict;
    use warnings;
    1;

        package    # hide from PAUSE indexing
        string::method;
    use strict;
    use warnings;
    1;

    # DEV NOTE, CORRELATION #03: method types reside in Subroutine.pm, which is a sub-type of Subroutine.pm, causing the need to have this special BEGIN block
    # to enable the *::method types, and Class.pm's INIT block symbol table entry generator needs us to switch back into the primary package so we have
    # that happen in the following line, which furthermore triggers the need to avoid re-defining class accessor/mutator methods; how to fix?
        package RPerl::CodeBlock::Subroutine;
    use strict;
    use warnings;
    1;
}

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CodeBlock);
use RPerl::CodeBlock;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref::method $ast_to_rperl__generate = sub {
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

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::CB::S __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { H => q{} };

    $self = $self->{children}->[0];    # unwrap Subroutine_46 from MethodOrSubroutine_75
    my string $return_type = $self->{children}->[1]->{children}->[0];
    my string $name        = $self->{children}->[2];
    substr $name, 0, 1, '';            # remove leading $ sigil
    my object $arguments_optional = $self->{children}->[4];
    my string_arrayref $arguments = [];

#RPerl::diag( 'in Subroutine->ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES(), have $arguments_optional = ' . "\n" . RPerl::Parser::rperl_ast__dump($arguments_optional) . "\n" );
#RPerl::diag( 'in Subroutine->ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES(), have $return_type = ' . "\n" . RPerl::Parser::rperl_ast__dump($return_type) . "\n" );

    $cpp_source_group->{H} .= $return_type . q{ } . $name . '(';

    if ( exists $arguments_optional->{children}->[0] ) {
        my object $cpp_source_subgroup = $arguments_optional->{children}->[0]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);

#        RPerl::diag( 'in Subroutine->ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES(), have $cpp_source_subgroup = ' . "\n" . RPerl::Parser::rperl_ast__dump($cpp_source_subgroup) . "\n" );
# DEV NOTE: don't use RPerl::Generator::source_group_append() due to cross-wiring H-from-CPP below
        $cpp_source_group->{H} .= $cpp_source_subgroup->{CPP};
        if ( ( exists $cpp_source_subgroup->{H_INCLUDES} ) and ( defined $cpp_source_subgroup->{H_INCLUDES} ) ) {
            $cpp_source_group->{H_INCLUDES} .= $cpp_source_subgroup->{H_INCLUDES};
        }
    }

    $cpp_source_group->{H} .= ');';
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{} };

    $self = $self->{children}->[0];    # unwrap Subroutine_46 from MethodOrSubroutine_75
    my string $return_type = $self->{children}->[1]->{children}->[0];
    my string $name        = $self->{children}->[2];
    substr $name, 0, 1, '';            # remove leading $ sigil
    my object $arguments_optional = $self->{children}->[4];
    my string_arrayref $arguments = [];
    my object $operations_star    = $self->{children}->[5];
    my object $cpp_source_subgroup;

#RPerl::diag( 'in Subroutine->ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES(), have $arguments_optional = ' . "\n" . RPerl::Parser::rperl_ast__dump($arguments_optional) . "\n" );
#RPerl::diag( 'in Subroutine->ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES(), have $return_type = ' . "\n" . RPerl::Parser::rperl_ast__dump($return_type) . "\n" );

    $cpp_source_group->{CPP} .= $return_type . q{ } . $name . '(';

    if ( exists $arguments_optional->{children}->[0] ) {
        $cpp_source_subgroup = $arguments_optional->{children}->[0]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);

#        RPerl::diag( 'in Subroutine->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $cpp_source_subgroup = ' . "\n" . RPerl::Parser::rperl_ast__dump($cpp_source_subgroup) . "\n" );
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
    }

    $cpp_source_group->{CPP} .= ') {' . "\n";

    foreach my object $operation ( @{ $operations_star->{children} } ) {

#        RPerl::diag( 'in Subroutine->ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES(), have $operation = ' . "\n" . RPerl::Parser::rperl_ast__dump($operation) . "\n" );
# disable *_CHECK() and *_CHECKTRACE() data checking routines in CPPOPS_CPPTYPES mode, this is instead handled in xs_unpack_*() called by typemap.rperl
        if (( exists $operation->{children}->[0]->{children}->[0]->{children}->[0] )
            and (  ( ( substr $operation->{children}->[0]->{children}->[0]->{children}->[0], -6, 6 ) eq '_CHECK' )
                or ( ( substr $operation->{children}->[0]->{children}->[0]->{children}->[0], -11, 11 ) eq '_CHECKTRACE' ) )
            )
        {
            next;
        }
        $cpp_source_subgroup = $operation->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);

#        RPerl::diag( 'in Subroutine->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $cpp_source_subgroup = ' . "\n" . RPerl::Parser::rperl_ast__dump($cpp_source_subgroup) . "\n" );
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
    }

    $cpp_source_group->{CPP} .= '}';
    return $cpp_source_group;
};

1;    # end of class
