# [[[ HEADER ]]]
package RPerl::CodeBlock::Subroutine;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.007_000;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
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

    # DEV NOTE, CORRELATION #rp03: method types reside in Subroutine.pm, which is a sub-type of Subroutine.pm, causing the need to have this special BEGIN block
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

# [[[ SUBROUTINES & OO METHODS ]]]

our string_hashref::method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };
    my string_hashref $rperl_source_subgroup;

    #    RPerl::diag( 'in Subroutine->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    # unwrap Subroutine_48 from SubroutineOrMethod_77
    if ( ( ref $self ) eq 'SubroutineOrMethod_77' ) {
        $self = $self->{children}->[0];
    }

    if ( ( ref $self ) ne 'Subroutine_48' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule ' . ( ref $self ) . ' found where Subroutine_48 expected, dying' )
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
 
    if ((substr $name, 1, 1) eq '_') {
        die 'ERROR ECOGEASRP08, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: subroutine name ' . ($name)
                . ' must not start with underscore, dying' . "\n";
    }

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
#    RPerl::diag( 'in Subroutine->ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES(), received $modes->{_symbol_table} = ' . "\n" . Dumper($modes->{_symbol_table}) . "\n");
 
    my string_hashref $cpp_source_group = { H => q{} };

    $self = $self->{children}->[0];    # unwrap Subroutine_48 from SubroutineOrMethod_77
    my string $return_type = $self->{children}->[1]->{children}->[0];
    my string $name        = $self->{children}->[2];
    my object $arguments_optional = $self->{children}->[4];

#RPerl::diag( 'in Subroutine->ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES(), have $arguments_optional = ' . "\n" . RPerl::Parser::rperl_ast__dump($arguments_optional) . "\n" );
#RPerl::diag( 'in Subroutine->ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES(), have $return_type = ' . "\n" . RPerl::Parser::rperl_ast__dump($return_type) . "\n" );

    substr $name, 0, 1, q{};            # remove leading $ sigil
    my string_arrayref $arguments = [];
 
    if ((substr $name, 0, 1) eq '_') {
        die 'ERROR ECOGEASCP08, CODE GENERATOR, ABSTRACT SYNTAX TO C++: subroutine name ' . ($name)
                . ' must not start with underscore, dying' . "\n";
    }
    $modes->{_symbol_table}->{_subroutine} = $name;  # set current subroutine/method
    $modes->{_symbol_table}->{$modes->{_symbol_table}->{_namespace}}->{_global}->{$name} = {isa => 'RPerl::CodeBlock::Subroutine', type => $return_type};  # create individual symtab entry

    $return_type = RPerl::Generator::type_convert_perl_to_cpp($return_type, 1);  # $pointerify_classes = 1
    $modes->{_symbol_table}->{$modes->{_symbol_table}->{_namespace}}->{_global}->{$name}->{type_cpp} = $return_type;  # add converted C++ type to symtab entry

    # DEV NOTE, CORRELATION #rp22: must prefix subroutine names with namespace-underscores to simulate Perl's behavior of not exporting subroutines by default
    my string $namespace_underscores = $modes->{_symbol_table}->{_namespace};
    $namespace_underscores =~ s/:/_/gxms;
    $cpp_source_group->{H} .= $return_type . q{ } . $namespace_underscores . $name . '(';

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

    $self = $self->{children}->[0];    # unwrap Subroutine_48 from SubroutineOrMethod_77
    my string $return_type = $self->{children}->[1]->{children}->[0];
    my string $name        = $self->{children}->[2];
    my object $arguments_optional = $self->{children}->[4];
    my object $operations_star    = $self->{children}->[5];

    substr $name, 0, 1, q{};            # remove leading $ sigil
    my string_arrayref $arguments = [];
    my object $cpp_source_subgroup;
 
#RPerl::diag( 'in Subroutine->ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES(), have $arguments_optional = ' . "\n" . RPerl::Parser::rperl_ast__dump($arguments_optional) . "\n" );
#RPerl::diag( 'in Subroutine->ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES(), have $return_type = ' . "\n" . RPerl::Parser::rperl_ast__dump($return_type) . "\n" );

    $return_type = RPerl::Generator::type_convert_perl_to_cpp($return_type, 1);  # $pointerify_classes = 1
    
    # DEV NOTE: must prefix subroutine names with namespace-underscores to simulate Perl's behavior of not exporting subroutines by default
    my string $namespace_underscores = $modes->{_symbol_table}->{_namespace};
    $namespace_underscores =~ s/:/_/gxms;
    $cpp_source_group->{CPP} .= $return_type . q{ } . $namespace_underscores . $name . '(';

    if ( exists $arguments_optional->{children}->[0] ) {
        $cpp_source_subgroup = $arguments_optional->{children}->[0]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);

#        RPerl::diag( 'in Subroutine->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $cpp_source_subgroup = ' . "\n" . RPerl::Parser::rperl_ast__dump($cpp_source_subgroup) . "\n" );
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
    }

    $cpp_source_group->{CPP} .= ') {' . "\n";
    my string $CPP_saved = $cpp_source_group->{CPP};
    $cpp_source_group->{CPP} = q{};

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

    # COMPILE-TIME OPTIMIZATION #02: declare all loop iterators at top of subroutine/method to avoid re-declarations in nested loops
    if ((exists $modes->{_loop_iterators}) and (defined $modes->{_loop_iterators})) {
        foreach my string $loop_iterator_symbol (sort keys %{$modes->{_loop_iterators}}) {
            $CPP_saved .= $modes->{_loop_iterators}->{$loop_iterator_symbol} . q{ } . $loop_iterator_symbol . ';' . "\n";
        }
        delete $modes->{_loop_iterators};
    }

    $CPP_saved .= $cpp_source_group->{CPP};
    $cpp_source_group->{CPP} = $CPP_saved;

    $cpp_source_group->{CPP} .= '}';

    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate_shims__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
#    RPerl::diag( 'in Subroutine->ast_to_cpp__generate_shims__CPPOPS_CPPTYPES(), received $modes->{_symbol_table} = ' . "\n" . Dumper($modes->{_symbol_table}) . "\n");
 
    my string_hashref $cpp_source_group = { CPP => q{} };
    my object $cpp_source_subgroup = undef;

    $self = $self->{children}->[0];    # unwrap Subroutine_48 from SubroutineOrMethod_77
#    my string $return_type = $self->{children}->[1]->{children}->[0];  # SHIM SUBS DEPRECATED IN FAVOR OF MACROS
    my string $name        = $self->{children}->[2];
    my object $arguments_optional = $self->{children}->[4];

#RPerl::diag( 'in Subroutine->ast_to_cpp__generate_shims__CPPOPS_CPPTYPES(), have $arguments_optional = ' . "\n" . RPerl::Parser::rperl_ast__dump($arguments_optional) . "\n" );
#RPerl::diag( 'in Subroutine->ast_to_cpp__generate_shims__CPPOPS_CPPTYPES(), have $return_type = ' . "\n" . RPerl::Parser::rperl_ast__dump($return_type) . "\n" );

    substr $name, 0, 1, q{};            # remove leading $ sigil
 
    if ((substr $name, 0, 1) eq '_') {
        die 'ERROR ECOGEASCP08, CODE GENERATOR, ABSTRACT SYNTAX TO C++: subroutine name ' . ($name)
                . ' must not start with underscore, dying' . "\n";
    }

    # DEV NOTE, CORRELATION #rp22: must create shims to un-prefix subroutine names with namespace-underscores to un-simulate Perl's behavior of not exporting subroutines by default
    my string $namespace_colons = $modes->{_symbol_table}->{_namespace};
    my string $namespace_underscores = $namespace_colons;
    $namespace_underscores =~ s/:/_/gxms;
 
    # DEV NOTE: only generate PMC output file in dynamic (default) subcompile mode
    if ($modes->{subcompile} eq 'DYNAMIC') {
        # hard-coded example, PMC subroutine
        #undef &RPerl::Algorithm::Sort::Bubble::integer_bubblesort;
        #*RPerl::Algorithm::Sort::Bubble::integer_bubblesort = sub { return main::RPerl__Algorithm__Sort__Bubble__integer_bubblesort(@_); };
        $cpp_source_group->{PMC} = 'undef &' . $namespace_colons . $name . ';'. "\n";
        $cpp_source_group->{PMC} .= '*' . $namespace_colons . $name . ' = sub { return main::' . $namespace_underscores . $name . '(@_); };';
    }

=DEPRECATED IN FAVOR OF MACROS
# hard-coded example, CPP subroutine
# void display_pi_digits(integer n) { return MathPerl__Geometry__PiDigits__display_pi_digits(n); }

    $cpp_source_group->{CPP} .= $return_type . q{ } . $name . '(';

    if ( exists $arguments_optional->{children}->[0] ) {
        $cpp_source_subgroup = $arguments_optional->{children}->[0]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);

#        RPerl::diag( 'in Subroutine->ast_to_cpp__generate_shims__CPPOPS_CPPTYPES(), have $cpp_source_subgroup = ' . "\n" . RPerl::Parser::rperl_ast__dump($cpp_source_subgroup) . "\n" );
        $cpp_source_group->{CPP} .= $cpp_source_subgroup->{CPP};
    }

    $cpp_source_group->{CPP} .= ') ' . ' { return ' . $namespace_underscores . $name . '(';

    # remove type declarations from arguments when passing from shim to real subroutine
    if (defined $cpp_source_subgroup) {
       # split on commas, split again on space, discard types, join names on space, join again on commas, append 
       my string_arrayref $split_arguments    = [ split ', ', $cpp_source_subgroup->{CPP} ];
       my string_arrayref $typeless_arguments = [];
       foreach my string $argument (@{$split_arguments}) {
           my string_arrayref $split_argument = [ split /[ ]/xms, $argument ];
           push @{$typeless_arguments}, $split_argument->[1];
       }
       $cpp_source_group->{CPP} .= ( join ', ', @{$typeless_arguments} );
    }

    $cpp_source_group->{CPP} .= '); }';
=cut

# hard-coded example, CPP macro
# #define display_pi_digits(n) MathPerl__Geometry__PiDigits__display_pi_digits(n)
    $cpp_source_group->{CPP} .= '#define ' . $name . '(';

    if ( exists $arguments_optional->{children}->[0] ) {
        $cpp_source_subgroup = $arguments_optional->{children}->[0]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
    }

    # remove type declarations from arguments
    my string $typeless_arguments_joined = q{};
    if (defined $cpp_source_subgroup) {
       # split on commas, split again on space, discard types, join names on space, join again on commas, append 
       my string_arrayref $split_arguments    = [ split ', ', $cpp_source_subgroup->{CPP} ];
       my string_arrayref $typeless_arguments = [];
       foreach my string $argument (@{$split_arguments}) {
           my string_arrayref $split_argument = [ split /[ ]/xms, $argument ];
           push @{$typeless_arguments}, $split_argument->[1];
       }
       $typeless_arguments_joined = ( join ', ', @{$typeless_arguments} );
    }

    $cpp_source_group->{CPP} .= $typeless_arguments_joined . ') ' . $namespace_underscores . $name . '(' . $typeless_arguments_joined . ')';

    return $cpp_source_group;
};

1;    # end of class
