# [[[ HEADER ]]]
package RPerl::CodeBlock::Subroutine;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.021_000;

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

    # DEV NOTE, CORRELATION #rp003: method types reside in Subroutine.pm, which is a sub-type of Subroutine.pm, causing the need to have this special BEGIN block
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

# [[[ INCLUDES ]]]
use perlapinames_generated;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub ast_to_rperl__generate {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $rperl_source_group = { PMC => q{} };
    my string_hashref $rperl_source_subgroup;

    #    RPerl::diag( 'in Subroutine->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    # unwrap Subroutine_61 from SubroutineOrMethod_93, only if needed
    if ((ref $self) eq 'SubroutineOrMethod_93') { $self = $self->{children}->[0]; }

    if ( ( ref $self ) ne 'Subroutine_61' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule ' . ( ref $self ) . ' found where Subroutine_61 expected, dying' )
            . "\n";
    }

#    RPerl::diag( 'in Subroutine->ast_to_rperl__generate(), have possibly-unwrapped $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $sub                     = $self->{children}->[0];
    my string $name                    = $self->{children}->[1];
    my string $left_brace              = $self->{children}->[2];
    my string $return_type_left_brace  = $self->{children}->[3];
    my string $return_type_my          = $self->{children}->[4];
    my string $return_type             = $self->{children}->[5]->{children}->[0];
    my string $return_type_var         = $self->{children}->[6];
    my string $return_type_right_brace = $self->{children}->[7];
    my string $return_type_semicolon   = $self->{children}->[8];
    my object $arguments_optional      = $self->{children}->[9];
    my object $operations_star         = $self->{children}->[10];
    my string $right_brace             = $self->{children}->[11];





=DISABLE_TMP
    # in C, identifiers beginning with double-underscore '__howdy' or underscore-uppercase '_Howdy' are forbidden everywhere, 
    # and identifiers starting with single-underscore '_howdy' are forbidden in global scope
    if ((substr $name, 0, 1) eq '_') {
        die 'ERROR ECOGEASRP08, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: subroutine name ' . ($name)
                . ' must not start with underscore, dying' . "\n";
    }
=cut





    if ((exists $perlapinames_generated::FUNCTIONS_DOCUMENTED->{$name}) or
        (exists $perlapinames_generated::FUNCTIONS_UNDOCUMENTED->{$name}) or
        (exists $perlapinames_generated::VARIABLES_DOCUMENTED->{$name}) or
        (exists $perlapinames_generated::VARIABLES_UNDOCUMENTED->{$name})) {
        die 'ERROR ECOGEASRP44, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Perl API name conflict, subroutine name ' . q{'}
            . $name . q{'}
            . ' is the same as a protected function or variable name in the Perl API, please choose a different name, dying' . "\n";
    }

    # CREATE SYMBOL TABLE ENTRY
    $modes->{_symbol_table}->{_subroutine} = $name;  # set current subroutine/method
    $modes->{_symbol_table}->{$modes->{_symbol_table}->{_namespace}}->{_global}->{$name} = {isa => 'RPerl::CodeBlock::Subroutine', type => $return_type};  # create individual symtab entry

    # NEED UPGRADE, CORRELATION #rp035: allow multi-line subroutines & other code blocks, where they would be less than 160 chars if on a single line
    # DEV NOTE: no newline appended in the next line, all newlines removed from subroutine body via regex replacement after foreach loop below,
    # thus allowing for single-line subroutines as well as multi-line subroutines, at the control of Perl::Tidy
    $rperl_source_group->{PMC} .= 
        $sub . q{ } . $name . q{ } . $left_brace . q{ } . 
        $return_type_left_brace . q{ } . $return_type_my . q{ } . $return_type . q{ } . $return_type_var . q{ } . 
        $return_type_right_brace . q{ } . $return_type_semicolon;

    if ( exists $arguments_optional->{children}->[0] ) {
        $rperl_source_subgroup = $arguments_optional->{children}->[0]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }

    foreach my object $operation ( @{ $operations_star->{children} } ) {
        $rperl_source_subgroup = $operation->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }

    $rperl_source_group->{PMC} =~ s/\n/\ /gxms;

    $rperl_source_group->{PMC} .= $right_brace . "\n\n";
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::CB::S __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
#    RPerl::diag( 'in Subroutine->ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES(), received $modes->{_symbol_table} = ' . "\n" . Dumper($modes->{_symbol_table}) . "\n");
 
    my string_hashref $cpp_source_group = { H => q{} };

    # unwrap Subroutine_61 from SubroutineOrMethod_93, only if needed
    if ((ref $self) eq 'SubroutineOrMethod_93') { $self = $self->{children}->[0]; }

    my string $name                    = $self->{children}->[1];
    my string $return_type             = $self->{children}->[5]->{children}->[0];
    my object $arguments_optional      = $self->{children}->[9];

#RPerl::diag( 'in Subroutine->ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES(), have $arguments_optional = ' . "\n" . RPerl::Parser::rperl_ast__dump($arguments_optional) . "\n" );
#RPerl::diag( 'in Subroutine->ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES(), have $return_type = ' . "\n" . RPerl::Parser::rperl_ast__dump($return_type) . "\n" );

    my string_arrayref $arguments = [];





=DISABLE_TMP
    if ((substr $name, 0, 1) eq '_') {
        die 'ERROR ECOGEASCP08, CODE GENERATOR, ABSTRACT SYNTAX TO C++: subroutine name ' . ($name)
                . ' must not start with underscore, dying' . "\n";
    }
=cut



    if ((exists $perlapinames_generated::FUNCTIONS_DOCUMENTED->{$name}) or
        (exists $perlapinames_generated::FUNCTIONS_UNDOCUMENTED->{$name}) or
        (exists $perlapinames_generated::VARIABLES_DOCUMENTED->{$name}) or
        (exists $perlapinames_generated::VARIABLES_UNDOCUMENTED->{$name})) {
        die 'ERROR ECOGEASCP44, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Perl API name conflict, subroutine name ' . q{'}
            . $name . q{'}
            . ' is the same as a protected function or variable name in the Perl API, please choose a different name, dying' . "\n";
    }

    # CREATE SYMBOL TABLE ENTRY
    $modes->{_symbol_table}->{_subroutine} = $name;  # set current subroutine/method
    $modes->{_symbol_table}->{$modes->{_symbol_table}->{_namespace}}->{_global}->{$name} = {isa => 'RPerl::CodeBlock::Subroutine', type => $return_type};  # create individual symtab entry

    $return_type = RPerl::Generator::type_convert_perl_to_cpp($return_type, 1);  # $pointerify_classes = 1
    $modes->{_symbol_table}->{$modes->{_symbol_table}->{_namespace}}->{_global}->{$name}->{type_cpp} = $return_type;  # add converted C++ type to symtab entry

    # DEV NOTE, CORRELATION #rp022: must prefix subroutine names with namespace-underscores to simulate Perl's behavior of not exporting subroutines by default
    my string $namespace_underscores = q{};
    if ((exists $modes->{_symbol_table}->{_namespace}) and (defined $modes->{_symbol_table}->{_namespace})) {
        $namespace_underscores = $modes->{_symbol_table}->{_namespace};
        $namespace_underscores =~ s/:/_/gxms;
    }
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
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{} };

    # unwrap Subroutine_61 from SubroutineOrMethod_93, only if needed
    if ((ref $self) eq 'SubroutineOrMethod_93') { $self = $self->{children}->[0]; }

    my string $name                    = $self->{children}->[1];
    my string $return_type             = $self->{children}->[5]->{children}->[0];
    my object $arguments_optional      = $self->{children}->[9];
    my object $operations_star         = $self->{children}->[10];

# DEV NOTE: as of March 2018, the latest draft of the C++ standard, section 5.10 on pages 13-14, states:
#  3  In addition, some identifiers are reserved for use by C ++ implementations and shall not be used otherwise; no diagnostic is required.
# (3.1) — Each identifier that contains a double underscore __ or begins with an underscore followed by an uppercase letter is reserved to the implementation for any use.
# (3.2) — Each identifier that begins with an underscore is reserved to the implementation for use as a name in the global namespace.
# http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/n4727.pdf

# because "no diagnostic is required", we may emit a warning or error here instead of relying on possibly-non-existent C++ compiler errors;
# the last thing we want is undefined behavior, which is exactly what we get if using reserved C++ identifiers;
# AFAICT, identifiers (including subroutine names) beginning with a single underscore are still valid, if and only if within a non-global namespace (such as a C++ class)

    if ((substr $name, 0, 1) eq '_') {




        # THEN START HERE: check if global scope, if so die, if not ignore and no warning???  finalize error (and warning?) codes below
        # THEN START HERE: check if global scope, if so die, if not ignore and no warning???  finalize error (and warning?) codes below
        # THEN START HERE: check if global scope, if so die, if not ignore and no warning???  finalize error (and warning?) codes below



        RPerl::warning( 'WARNING WCOGEASCPxx, CODE GENERATOR, ABSTRACT SYNTAX TO C++: subroutine name ' . ($name)
                . ' should not start with underscore, WARNING' . "\n");
    }
    elsif ($name =~ m/^_[A-Z]/gxms) {
        die 'ERROR ECOGEASCPxx, CODE GENERATOR, ABSTRACT SYNTAX TO C++: subroutine name ' . ($name)
                . ' must not start with an underscore followed by an uppercase letter, forbidden by C++ specification as a reserved identifier, dying' . "\n";
    }
    elsif ($name =~ m/__/gxms) {
        die 'ERROR ECOGEASCPxx, CODE GENERATOR, ABSTRACT SYNTAX TO C++: subroutine name ' . ($name)
                . ' must not include a double-underscore, forbidden by C++ specification as a reserved identifier, dying' . "\n";
    }

    if ((exists $perlapinames_generated::FUNCTIONS_DOCUMENTED->{$name}) or
        (exists $perlapinames_generated::FUNCTIONS_UNDOCUMENTED->{$name}) or
        (exists $perlapinames_generated::VARIABLES_DOCUMENTED->{$name}) or
        (exists $perlapinames_generated::VARIABLES_UNDOCUMENTED->{$name})) {
        die 'ERROR ECOGEASCP44, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Perl API name conflict, subroutine name ' . q{'}
            . $name . q{'}
            . ' is the same as a protected function or variable name in the Perl API, please choose a different name, dying' . "\n";
    }

    my string_arrayref $arguments = [];
    my object $cpp_source_subgroup;
 
#RPerl::diag( 'in Subroutine->ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES(), have $arguments_optional = ' . "\n" . RPerl::Parser::rperl_ast__dump($arguments_optional) . "\n" );
#RPerl::diag( 'in Subroutine->ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES(), have $return_type = ' . "\n" . RPerl::Parser::rperl_ast__dump($return_type) . "\n" );

    $return_type = RPerl::Generator::type_convert_perl_to_cpp($return_type, 1);  # $pointerify_classes = 1
    
    # DEV NOTE: must prefix subroutine names with namespace-underscores to simulate Perl's behavior of not exporting subroutines by default
    my string $namespace_underscores = q{};
    if ((exists $modes->{_symbol_table}->{_namespace}) and (defined $modes->{_symbol_table}->{_namespace})) {
        $namespace_underscores = $modes->{_symbol_table}->{_namespace};
        $namespace_underscores =~ s/:/_/gxms;
    }
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
}

sub ast_to_cpp__generate_shims__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    RPerl::diag( 'in Subroutine->ast_to_cpp__generate_shims__CPPOPS_CPPTYPES(), received $modes->{_symbol_table} = ' . "\n" . Dumper($modes->{_symbol_table}) . "\n");
 
    my string_hashref $cpp_source_group = { CPP => q{} };
    my object $cpp_source_subgroup = undef;

    # unwrap Subroutine_61 from SubroutineOrMethod_93, only if needed
    if ((ref $self) eq 'SubroutineOrMethod_93') { $self = $self->{children}->[0]; }

    my string $name                    = $self->{children}->[1];
#    my string $return_type             = $self->{children}->[5]->{children}->[0];    # SHIM SUBS DEPRECATED IN FAVOR OF MACROS
    my object $arguments_optional      = $self->{children}->[9];

#RPerl::diag( 'in Subroutine->ast_to_cpp__generate_shims__CPPOPS_CPPTYPES(), have $arguments_optional = ' . "\n" . RPerl::Parser::rperl_ast__dump($arguments_optional) . "\n" );
#RPerl::diag( 'in Subroutine->ast_to_cpp__generate_shims__CPPOPS_CPPTYPES(), have $return_type = ' . "\n" . RPerl::Parser::rperl_ast__dump($return_type) . "\n" );

    # DEV NOTE, CORRELATION #rp022: must create shims to un-prefix subroutine names with namespace-underscores to un-simulate Perl's behavior of not exporting subroutines by default
    my string $namespace_colons = q{};
    my string $namespace_underscores = q{};
    if ((exists $modes->{_symbol_table}->{_namespace}) and (defined $modes->{_symbol_table}->{_namespace})) {
        $namespace_colons = $modes->{_symbol_table}->{_namespace};
        $namespace_underscores = $namespace_colons;
        $namespace_underscores =~ s/:/_/gxms;
    }
 
    # DEV NOTE: only generate PMC output file in dynamic (default) subcompile mode
    if ($modes->{subcompile} eq 'DYNAMIC') {
        # hard-coded example, PMC subroutine
        #undef &RPerl::Algorithm::Sort::Bubble::integer_bubblesort;
        #*RPerl::Algorithm::Sort::Bubble::integer_bubblesort = sub { return main::RPerl__Algorithm__Sort__Bubble__integer_bubblesort(@ARG); };
        $cpp_source_group->{PMC} = 'undef &' . $namespace_colons . $name . ';'. "\n";
        $cpp_source_group->{PMC} .= '*' . $namespace_colons . $name . ' = sub { return main::' . $namespace_underscores . $name . '(@ARG); };';
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
}

1;    # end of class
