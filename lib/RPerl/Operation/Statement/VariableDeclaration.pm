# [[[ HEADER ]]]
package RPerl::Operation::Statement::VariableDeclaration;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.017_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Statement);

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use Scalar::Util 'blessed';
use perlapinames_generated;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub ast_to_rperl__generate {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $rperl_source_group = { PMC => q{} };
    my string_hashref $rperl_source_subgroup;
    my string $self_class = ref $self;
    my string $name;

#    RPerl::diag( 'in VariableDeclaration->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag( 'in VariableDeclaration->ast_to_rperl__generate(), received $modes = ' . "\n" . Dumper($modes) . "\n" );
#    die 'TMP DEBUG, dying';

    # unwrap VariableDeclaration_202, VariableDeclaration_203, VariableDeclaration_204, and VariableDeclaration_205 from Statement_175
    if ( $self_class eq 'Statement_175' ) {    # Statement -> VariableDeclaration
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( $self_class eq 'VariableDeclaration_202' ) {    # VariableDeclaration -> MY Type VARIABLE_SYMBOL ';'
        my string $my        = $self->{children}->[0];
        my string $type      = $self->{children}->[1]->{children}->[0];
        my string $symbol    = $self->{children}->[2];
        my string $semicolon = $self->{children}->[3];

        # remember symbol AKA name for C++ reserved identifier check at bottom of subroutine
        $name = $symbol;

        my string $symbol_no_sigil = substr $symbol, 1;
        if ((exists $perlapinames_generated::FUNCTIONS_DOCUMENTED->{$symbol_no_sigil}) or
            (exists $perlapinames_generated::FUNCTIONS_UNDOCUMENTED->{$symbol_no_sigil}) or
            (exists $perlapinames_generated::VARIABLES_DOCUMENTED->{$symbol_no_sigil}) or
            (exists $perlapinames_generated::VARIABLES_UNDOCUMENTED->{$symbol_no_sigil})) {
            die 'ERROR ECOGEASRP043, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Perl API name conflict, variable name ' . q{'}
                . $symbol_no_sigil . q{'}
                . ' is the same as a protected function or variable name in the Perl API, please choose a different name, dying' . "\n";
        }

        $rperl_source_group->{PMC} .= $my . q{ } . $type . q{ } . $symbol . $semicolon . "\n";

#        RPerl::diag( 'in VariableDeclaration->ast_to_rperl__generate(), have $modes->{_symbol_table} = ' . "\n" . Dumper($modes->{_symbol_table}) . "\n" );
#        RPerl::diag( 'in VariableDeclaration->ast_to_rperl__generate(), have $modes->{_symbol_table}->{_namespace} = ' . "\n" . Dumper($modes->{_symbol_table}->{_namespace}) . "\n" );
#        RPerl::diag( 'in VariableDeclaration->ast_to_rperl__generate(), have $modes->{_symbol_table}->{_subroutine} = ' . "\n" . Dumper($modes->{_symbol_table}->{_subroutine}) . "\n" );

        # CREATE SYMBOL TABLE ENTRY
        if ( exists $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol} ) {
            die 'ERROR ECOGEASRP012, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: variable '
                . q{'} . $symbol . q{'}
                . ' already declared in this scope, namespace '
                . q{'} . $modes->{_symbol_table}->{_namespace} . q{'}
                . ', subroutine/method '
                . q{'} . $modes->{_symbol_table}->{_subroutine} . q{()'}
                . ', dying' . "\n";
        }
        $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol}
            = { isa => 'RPerl::Operation::Expression::SubExpression::Variable', type => $type };
    }
    elsif ( $self_class eq 'VariableDeclaration_203' ) {    # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN OpNamedScolonOrSubExpIn
        my string $my                                = $self->{children}->[0];
        my string $type                              = $self->{children}->[1]->{children}->[0];
        my string $symbol                            = $self->{children}->[2];
        my string $assign                            = $self->{children}->[3];
        my object $opnamed_or_subexp_or_input_scolon = $self->{children}->[4];

        # remember symbol AKA name for C++ reserved identifier check at bottom of subroutine
        $name = $symbol;

        my string $symbol_no_sigil = substr $symbol, 1;
        if ((exists $perlapinames_generated::FUNCTIONS_DOCUMENTED->{$symbol_no_sigil}) or
            (exists $perlapinames_generated::FUNCTIONS_UNDOCUMENTED->{$symbol_no_sigil}) or
            (exists $perlapinames_generated::VARIABLES_DOCUMENTED->{$symbol_no_sigil}) or
            (exists $perlapinames_generated::VARIABLES_UNDOCUMENTED->{$symbol_no_sigil})) {
            die 'ERROR ECOGEASRP043, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Perl API name conflict, variable name ' . q{'}
                . $symbol_no_sigil . q{'}
                . ' is the same as a protected function or variable name in the Perl API, please choose a different name, dying' . "\n";
        }

#        RPerl::diag( 'in VariableDeclaration->ast_to_rperl__generate(), have $opnamed_or_subexp_or_input_scolon = ' . "\n" . RPerl::Parser::rperl_ast__dump($opnamed_or_subexp_or_input_scolon) . "\n" );

        $rperl_source_group->{PMC} .= $my . q{ } . $type . q{ } . $symbol . q{ } . $assign . q{ };

        my string $opnamed_or_subexp_or_input_scolon_type = ref $opnamed_or_subexp_or_input_scolon;

#        RPerl::diag( 'in VariableDeclaration->ast_to_rperl__generate(), have $opnamed_or_subexp_or_input_scolon_type = ' . "\n" . RPerl::Parser::rperl_ast__dump($opnamed_or_subexp_or_input_scolon_type) . "\n" );

        if (   ( $opnamed_or_subexp_or_input_scolon_type eq 'OpNamedScolonOrSubExpIn_260' )
            or ( $opnamed_or_subexp_or_input_scolon_type eq 'OpNamedScolonOrSubExpIn_261' ) )
        {
            # OpNamedScolonOrSubExpIn -> OP01_NAMED_SCOLON
            # OpNamedScolonOrSubExpIn -> OP10_NAMED_UNARY_SCOLON
            $rperl_source_group->{PMC} .= $opnamed_or_subexp_or_input_scolon->{children}->[0];
        }
        elsif ( $opnamed_or_subexp_or_input_scolon_type eq 'OpNamedScolonOrSubExpIn_262' ) {    # OpNamedScolonOrSubExpIn -> SubExpressionOrInput ';'

#            RPerl::diag( 'in VariableDeclaration->ast_to_rperl__generate(), have (ref $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0]) = ' . "\n" . RPerl::Parser::rperl_ast__dump((ref $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0])) . "\n" );

            if (    ( exists $opnamed_or_subexp_or_input_scolon->{children} )
                and ( exists $opnamed_or_subexp_or_input_scolon->{children}->[0] )
                and ( blessed( $opnamed_or_subexp_or_input_scolon->{children}->[0] ) )
                and ( exists $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children} )
                and ( exists $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0] )
                and ( blessed( $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0] ) )
                and ( exists $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children} )
                and ( exists $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0] )
                and ( blessed( $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0] ) )
                and ( $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0]
                    ->isa('RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall') )
                )
            {
                my string $constructor_type
                    = $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[0];

#                    RPerl::diag( 'in VariableDeclaration->ast_to_rperl__generate(), have $constructor_type = ' . "\n" . RPerl::Parser::rperl_ast__dump($constructor_type) . "\n" );

                if ( $type ne $constructor_type ) {
                    die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP020, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL, TYPE-CHECKING MISMATCH: ' . q{'}
                            . $type . q{'}
                            . ' type is different than ' . q{'}
                            . $constructor_type . q{'}
                            . ' constructor type, dying' )
                        . "\n";
                }
            }
            elsif (
                    ( exists $opnamed_or_subexp_or_input_scolon->{children} )
                and ( exists $opnamed_or_subexp_or_input_scolon->{children}->[0] )
                and ( blessed( $opnamed_or_subexp_or_input_scolon->{children}->[0] ) )
                and ( exists $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children} )
                and ( exists $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0] )
                and ( blessed( $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0] ) )
                and ( exists $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children} )
                and ( exists $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0] )
                and ( blessed( $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0] ) )
                and ( $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0]->isa('RPerl::Operation::Expression::SubroutineCall') ) )
            {
                my string $constructor_name
                    = $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[0];
                if ( $constructor_name =~ m/::new$/xms ) {
#                    RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $constructor_name = ' . $constructor_name . "\n" );
                    my string $constructor_type = substr $constructor_name, 0, ( ( length $constructor_name ) - 5 );
#                    RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $constructor_type = ' . $constructor_type . "\n" );

                    if ( $type ne $constructor_type ) {
                        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP020, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL, TYPE-CHECKING MISMATCH: ' . q{'}
                                . $type . q{'}
                                . ' type is different than ' . q{'}
                                . $constructor_type . q{'}
                                . ' constructor type, dying' )
                            . "\n";
                    }
                }
            }

            # CREATE SYMBOL TABLE ENTRY
            # in a *.pl program, you can have variables declared outside of any namespace, which means they are in the default 'main::' namespace AKA '::' using Perl rules
            if ((not exists $modes->{_symbol_table}->{_namespace}) or (not defined $modes->{_symbol_table}->{_namespace})) {
                $modes->{_symbol_table}->{_namespace} = 'main::'; 
            }

            # in a *.pl program, you can have variables declared outside of any subroutine, which means they are in the default 'main()' subroutine using C++ rules
            if ((not exists $modes->{_symbol_table}->{_subroutine}) or (not defined $modes->{_symbol_table}->{_subroutine})) {
                $modes->{_symbol_table}->{_subroutine} = 'main'; 
            }

#            RPerl::diag('in VariableDeclaration->ast_to_rperl__generate(), have $symbol = ' . $symbol . "\n");
#            RPerl::diag('in VariableDeclaration->ast_to_rperl__generate(), have $modes->{_symbol_table} = ' . Dumper($modes->{_symbol_table}) . "\n");
#            RPerl::diag('in VariableDeclaration->ast_to_rperl__generate(), have $modes->{_symbol_table}->{_namespace} = ' . $modes->{_symbol_table}->{_namespace} . "\n");
#            RPerl::diag('in VariableDeclaration->ast_to_rperl__generate(), have $modes->{_symbol_table}->{_subroutine} = ' . $modes->{_symbol_table}->{_subroutine} . "\n");

            if ( exists $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol} ) {
                die 'ERROR ECOGEASRP012, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: variable '
                    . q{'} . $symbol . q{'}
                    . ' already declared in this scope, namespace '
                    . q{'} . $modes->{_symbol_table}->{_namespace} . q{'}
                    . ', subroutine/method '
                    . q{'} . $modes->{_symbol_table}->{_subroutine} . q{()'}
                    . ', dying' . "\n";
            }
            $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol}
                = { isa => 'RPerl::Operation::Expression::SubExpression::Variable', type => $type };

            $rperl_source_subgroup = $opnamed_or_subexp_or_input_scolon->{children}->[0]->ast_to_rperl__generate($modes);    # subexpression
            RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
            $rperl_source_group->{PMC} .= $opnamed_or_subexp_or_input_scolon->{children}->[1];                               # semicolon
        }
        else {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP000, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                    . $opnamed_or_subexp_or_input_scolon_type
                    . ' found where OpNamedScolonOrSubExpIn_260, OpNamedScolonOrSubExpIn_261, or OpNamedScolonOrSubExpIn_262 expected, dying' )
                . "\n";
        }

        $rperl_source_group->{PMC} .= "\n";
    }
    elsif ( $self_class eq 'VariableDeclaration_204' ) { # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef' ';'
        my string $my                 = $self->{children}->[0];
        my string $type               = $self->{children}->[1]->{children}->[0];
        my string $symbol             = $self->{children}->[2];
        my string $arrow_left_bracket = $self->{children}->[3];
        my object $subexpression      = $self->{children}->[4];
        my string $right_bracket      = $self->{children}->[5];
        my string $assign             = $self->{children}->[6];
        my string $undef              = $self->{children}->[7];
        my string $semicolon          = $self->{children}->[8];

        # remember symbol AKA name for C++ reserved identifier check at bottom of subroutine
        $name = $symbol;

        my string $symbol_no_sigil = substr $symbol, 1;
        if ((exists $perlapinames_generated::FUNCTIONS_DOCUMENTED->{$symbol_no_sigil}) or
            (exists $perlapinames_generated::FUNCTIONS_UNDOCUMENTED->{$symbol_no_sigil}) or
            (exists $perlapinames_generated::VARIABLES_DOCUMENTED->{$symbol_no_sigil}) or
            (exists $perlapinames_generated::VARIABLES_UNDOCUMENTED->{$symbol_no_sigil})) {
            die 'ERROR ECOGEASRP043, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Perl API name conflict, variable name ' . q{'}
                . $symbol_no_sigil . q{'}
                . ' is the same as a protected function or variable name in the Perl API, please choose a different name, dying' . "\n";
        }

        # CREATE SYMBOL TABLE ENTRY
        if ( exists $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol} ) {
            die 'ERROR ECOGEASRP012, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: variable '
                . q{'} . $symbol . q{'}
                . ' already declared in this scope, namespace '
                . q{'} . $modes->{_symbol_table}->{_namespace} . q{'}
                . ', subroutine/method '
                . q{'} . $modes->{_symbol_table}->{_subroutine} . q{()'}
                . ', dying' . "\n";
        }
        $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol}
            = { isa => 'RPerl::Operation::Expression::SubExpression::Variable', type => $type };

        $rperl_source_group->{PMC} .= $my . q{ } . $type . q{ } . $symbol . $arrow_left_bracket . q{ };
        $rperl_source_subgroup = $subexpression->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $right_bracket . q{ } . $assign . q{ } . $undef . $semicolon . "\n";
    }
    elsif ( $self_class eq 'VariableDeclaration_205' ) {    # VariableDeclaration -> MY TYPE_FHREF FHREF_SYMBOL ';'
        my string $my           = $self->{children}->[0];
        my string $type_fhref   = $self->{children}->[1];
        my string $symbol_fhref = $self->{children}->[2];
        my string $semicolon    = $self->{children}->[3];

        # remember symbol AKA name for C++ reserved identifier check at bottom of subroutine
        $name = $symbol_fhref;

        my string $symbol_no_sigil = substr $symbol_fhref, 1;
        if ((exists $perlapinames_generated::FUNCTIONS_DOCUMENTED->{$symbol_no_sigil}) or
            (exists $perlapinames_generated::FUNCTIONS_UNDOCUMENTED->{$symbol_no_sigil}) or
            (exists $perlapinames_generated::VARIABLES_DOCUMENTED->{$symbol_no_sigil}) or
            (exists $perlapinames_generated::VARIABLES_UNDOCUMENTED->{$symbol_no_sigil})) {
            die 'ERROR ECOGEASRP043, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Perl API name conflict, variable name ' . q{'}
                . $symbol_no_sigil . q{'}
                . ' is the same as a protected function or variable name in the Perl API, please choose a different name, dying' . "\n";
        }

        # CREATE SYMBOL TABLE ENTRY
        if ( exists $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol_fhref} ) {
            die 'ERROR ECOGEASRP012, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: variable '
                . q{'} . $symbol_fhref . q{'}
                . ' already declared in this scope, namespace '
                . q{'} . $modes->{_symbol_table}->{_namespace} . q{'}
                . ', subroutine/method '
                . q{'} . $modes->{_symbol_table}->{_subroutine} . q{()'}
                . ', dying' . "\n";
        }
        $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol_fhref}
            = { isa => 'RPerl::Operation::Expression::SubExpression::Variable', type => $type_fhref };

        $rperl_source_group->{PMC} .= $my . q{ } . $type_fhref . q{ } . $symbol_fhref . $semicolon . "\n";
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP000, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . $self_class
                . ' found where VariableDeclaration_202, VariableDeclaration_203, VariableDeclaration_204, or VariableDeclaration_205 expected, dying' )
            . "\n";
    }

    # DEV NOTE, CORRELATION #rp045: identifiers containing underscores may be reserved by C++
    # NEED ANSWER: in an *.pl Perl program, should Perl global variables be allowed to begin with underscore, 
    # because they will be made into non-global C++ variables inside the C++ main() function?  and does the Perl vs C++ behavior match in this case???
    my string $name_nosigil = substr $name, 1;
#    RPerl::diag('in VariableDeclaration->ast_to_rperl__generate(), have $name = ' . q{'} . $name . q{'} . "\n");
#    RPerl::diag('in VariableDeclaration->ast_to_rperl__generate(), have $name_nosigil = ' . q{'} . $name_nosigil . q{'} . "\n");
#    RPerl::diag('in VariableDeclaration->ast_to_rperl__generate(), have $modes->{_symbol_table}->{_namespace} = ' . q{'} . $modes->{_symbol_table}->{_namespace} . q{'} . "\n");
#    RPerl::diag('in VariableDeclaration->ast_to_rperl__generate(), have $modes->{_symbol_table}->{_subroutine} = ' . q{'} . $modes->{_symbol_table}->{_subroutine} . q{'} . "\n");
    if (((substr $name_nosigil, 0, 1) eq '_') and ($modes->{_symbol_table}->{_namespace} eq q{}) and ($modes->{_symbol_table}->{_subroutine} eq q{})) {
        die 'ERROR ECOGEASRP180a, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL:' . "\n" . 'global variable name ' . q{'} . $name . q{'} .
            ' must not start with an underscore, forbidden by C++ specification as a reserved identifier, dying' . "\n";
    }
    elsif ($name_nosigil =~ m/^_[A-Z]/gxms) {
        die 'ERROR ECOGEASRP180b, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL:' . "\n" . 'variable name ' . q{'} . $name . q{'} .
            ' must not start with an underscore followed by an uppercase letter, forbidden by C++ specification as a reserved identifier, dying' . "\n";
    }
    elsif ($name_nosigil =~ m/__/gxms) {
        die 'ERROR ECOGEASRP180c, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL:' . "\n" . 'variable name ' . q{'} . $name . q{'} .
            ' must not include a double-underscore, forbidden by C++ specification as a reserved identifier, dying' . "\n";
    }

    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::O::S::VD __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{} };
    my string_hashref $cpp_source_subgroup;
    my string $self_class = ref $self;
    my string $name;

#    RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    # unwrap VariableDeclaration_202, VariableDeclaration_203, VariableDeclaration_204, and VariableDeclaration_205 from Statement_175
    if ( $self_class eq 'Statement_175' ) {    # Statement -> VariableDeclaration
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( $self_class eq 'VariableDeclaration_202' ) {    # VariableDeclaration -> MY Type VARIABLE_SYMBOL ';'
        my string $type   = $self->{children}->[1]->{children}->[0];
        my string $symbol = $self->{children}->[2];

        # remember symbol AKA name for C++ reserved identifier check at bottom of subroutine
        $name = $symbol;

        my string $symbol_no_sigil = substr $symbol, 1;
        if ((exists $perlapinames_generated::FUNCTIONS_DOCUMENTED->{$symbol_no_sigil}) or
            (exists $perlapinames_generated::FUNCTIONS_UNDOCUMENTED->{$symbol_no_sigil}) or
            (exists $perlapinames_generated::VARIABLES_DOCUMENTED->{$symbol_no_sigil}) or
            (exists $perlapinames_generated::VARIABLES_UNDOCUMENTED->{$symbol_no_sigil})) {
            die 'ERROR ECOGEASCP043, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Perl API name conflict, variable name ' . q{'}
                . $symbol_no_sigil . q{'}
                . ' is the same as a protected function or variable name in the Perl API, please choose a different name, dying' . "\n";
        }

        substr $symbol, 0, 1, q{};                       # remove leading $ sigil

        # CREATE SYMBOL TABLE ENTRY
        if ( exists $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol} ) {
            die 'ERROR ECOGEASCP012, CODE GENERATOR, ABSTRACT SYNTAX TO C++: variable '
                . q{'} . $symbol . q{'}
                . ' already declared in this scope, namespace '
                . q{'} . $modes->{_symbol_table}->{_namespace} . q{'}
                . ', subroutine/method '
                . q{'} . $modes->{_symbol_table}->{_subroutine} . q{()'}
                . ', dying' . "\n";
        }
        $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol}
            = { isa => 'RPerl::Operation::Expression::SubExpression::Variable', type => $type };

        $type = RPerl::Generator::type_convert_perl_to_cpp( $type, 1 );    # $pointerify_classes = 1
        $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol}->{type_cpp} = $type; # add converted C++ type to symtab entry

        $cpp_source_group->{CPP} .= $type . q{ } . $symbol . ';' . "\n";
    }
    elsif ( $self_class eq 'VariableDeclaration_203' ) {    # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN OpNamedScolonOrSubExpIn
        my string $type                              = $self->{children}->[1]->{children}->[0];
        my string $symbol                            = $self->{children}->[2];
        my string $assign                            = $self->{children}->[3];
        my object $opnamed_or_subexp_or_input_scolon = $self->{children}->[4];

        # remember symbol AKA name for C++ reserved identifier check at bottom of subroutine
        $name = $symbol;

        my string $symbol_no_sigil = substr $symbol, 1;
        if ((exists $perlapinames_generated::FUNCTIONS_DOCUMENTED->{$symbol_no_sigil}) or
            (exists $perlapinames_generated::FUNCTIONS_UNDOCUMENTED->{$symbol_no_sigil}) or
            (exists $perlapinames_generated::VARIABLES_DOCUMENTED->{$symbol_no_sigil}) or
            (exists $perlapinames_generated::VARIABLES_UNDOCUMENTED->{$symbol_no_sigil})) {
            die 'ERROR ECOGEASCP043, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Perl API name conflict, variable name ' . q{'}
                . $symbol_no_sigil . q{'}
                . ' is the same as a protected function or variable name in the Perl API, please choose a different name, dying' . "\n";
        }

#        RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $opnamed_or_subexp_or_input_scolon = ' . "\n" . RPerl::Parser::rperl_ast__dump($opnamed_or_subexp_or_input_scolon) . "\n" );

        substr $symbol, 0, 1, q{};                          # remove leading $ sigil
        my boolean $is_constructor_call_normal  = 0;
        my boolean $is_constructor_call_params  = 0;
        my boolean $is_constructor_call_mongodb = 0;
        my boolean $is_constructor_call_special = 0;
        my boolean $pointerify_classes          = 1;

        my string $opnamed_or_subexp_or_input_scolon_type = ref $opnamed_or_subexp_or_input_scolon;

#        RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $opnamed_or_subexp_or_input_scolon_type = ' . "\n" . RPerl::Parser::rperl_ast__dump($opnamed_or_subexp_or_input_scolon_type) . "\n" );

        if (((substr $type, 0, 7) eq 'MongoDB') or ((substr $type, 0, 4) eq 'bson')) {
            if ((not exists $modes->{_enable_mongodb}) or (not defined $modes->{_enable_mongodb}) or (not $modes->{_enable_mongodb})) {
                die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP090, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Found variable declaration for package '
                    . q{'} . $type . q{'}
                    . ' but MongoDB support is not enabled, perhaps you forgot to load MongoDB support via `use RPerl::Support::MongoDB;`, dying' )
                    . "\n";
            }
            $pointerify_classes = 0;
        }

        if (   ( $opnamed_or_subexp_or_input_scolon_type eq 'OpNamedScolonOrSubExpIn_260' )
            or ( $opnamed_or_subexp_or_input_scolon_type eq 'OpNamedScolonOrSubExpIn_261' ) )
        {
#            RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $opnamed_or_subexp_or_input_scolon_type = OpNamedScolonOrSubExpIn_260 or OpNamedScolonOrSubExpIn_261' . "\n" );
            # OpNamedScolonOrSubExpIn -> OP01_NAMED_SCOLON
            # OpNamedScolonOrSubExpIn -> OP10_NAMED_UNARY_SCOLON
            $cpp_source_group->{CPP} .= $opnamed_or_subexp_or_input_scolon->{children}->[0];
        }
        elsif ( $opnamed_or_subexp_or_input_scolon_type eq 'OpNamedScolonOrSubExpIn_262' ) {    # OpNamedScolonOrSubExpIn -> SubExpressionOrInput ';'
#            RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $opnamed_or_subexp_or_input_scolon_type = OpNamedScolonOrSubExpIn_262' . "\n" );
            if (    ( exists $opnamed_or_subexp_or_input_scolon->{children} )
                and ( exists $opnamed_or_subexp_or_input_scolon->{children}->[0] )
                and ( blessed( $opnamed_or_subexp_or_input_scolon->{children}->[0] ) )
                and ( exists $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children} )
                and ( exists $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0] )
                and ( blessed( $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0] ) )
                and ( exists $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children} )
                and ( exists $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0] )
                and ( blessed( $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0] ) )
                and ( $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0]
                    ->isa('RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall') )
                )
            {
#                RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall' . "\n" );
                my object $constructor_call = $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0];
                my object $properties_init_optional  = $constructor_call->{children}->[2];
                my string $constructor_type = $constructor_call->{children}->[0]->{children}->[0];

#                RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $constructor_type = ' . "\n" . RPerl::Parser::rperl_ast__dump($constructor_type) . "\n" );

                if ( $type ne $constructor_type ) {
                    die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP020, CODE GENERATOR, ABSTRACT SYNTAX TO C++, TYPE-CHECKING MISMATCH: ' . q{'}
                            . $type . q{'}
                            . ' type is different than ' . q{'}
                            . $constructor_type . q{'}
                            . ' constructor type, dying' )
                        . "\n";
                }

                # DEV NOTE, CORRELATION #rp131: constructor call for MongoDB
                if ( (substr $type, 0, 7) eq 'MongoDB' ) {
#                    RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall, MongoDB' . "\n" );
                    if ((not exists $modes->{_enable_mongodb}) or (not defined $modes->{_enable_mongodb}) or (not $modes->{_enable_mongodb})) {
                        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP091a, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Found constructor call for package '
                            . q{'} . $type . q{'}
                            . ' but MongoDB support is not enabled, perhaps you forgot to load MongoDB support via `use RPerl::Support::MongoDB;`, dying' )
                            . "\n";
                    }
                    # only MongoClient objects may be directly constructed, see MongoDB::Database & MongoDB::Collection documentation
                    if ($type ne 'MongoDB::MongoClient') {
                        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP092a, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Found constructor call for package '
                            . q{'} . $type . q{'}
                            . ' but only ' . q{'} . 'MongoDB::MongoClient' . q{'} . ' may be directly constructed, please see the MongoDB documentation on CPAN for more information, dying' )
                            . "\n";
                    }
                    $is_constructor_call_mongodb = 1;
                    $pointerify_classes = 0;
                }
                # constructor call with properties to initialize
                elsif (exists $properties_init_optional->{children}->[0]) {
#                    RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall, w/ properties' . "\n" );
                    $is_constructor_call_params = 1;
                    $pointerify_classes = 1;
                }
                # constructor call without properties to initialize
                else {
#                    RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall, w/out properties' . "\n" );
                    $is_constructor_call_normal = 1;
                    $pointerify_classes = 1;
                }
            }
            elsif (
                    ( exists $opnamed_or_subexp_or_input_scolon->{children} )
                and ( exists $opnamed_or_subexp_or_input_scolon->{children}->[0] )
                and ( blessed( $opnamed_or_subexp_or_input_scolon->{children}->[0] ) )
                and ( exists $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children} )
                and ( exists $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0] )
                and ( blessed( $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0] ) )
                and ( exists $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children} )
                and ( exists $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0] )
                and ( blessed( $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0] ) )
                and ( $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0]->isa('RPerl::Operation::Expression::SubroutineCall') ) )
            {
#                RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have RPerl::Operation::Expression::SubroutineCall' . "\n" );
                my string $constructor_name
                    = $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[0];
                if ( $constructor_name =~ m/::new$/xms ) {
                    $is_constructor_call_special = 1;
                    $pointerify_classes = 1;
#                    RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $constructor_name = ' . $constructor_name . "\n" );
                    my string $constructor_type = substr $constructor_name, 0, ( ( length $constructor_name ) - 5 );
#                    RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $constructor_type = ' . $constructor_type . "\n" );

                    if ( $type ne $constructor_type ) {
                        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP020, CODE GENERATOR, ABSTRACT SYNTAX TO C++, TYPE-CHECKING MISMATCH: ' . q{'}
                                . $type . q{'}
                                . ' type is different than ' . q{'}
                                . $constructor_type . q{'}
                                . ' constructor type, dying' )
                            . "\n";
                    }
                }
            }

            # CREATE SYMBOL TABLE ENTRY
            # in a *.pl program, you can have variables declared outside of any namespace, which means they are in the default 'main::' namespace AKA '::' using Perl rules
            if ((not exists $modes->{_symbol_table}->{_namespace}) or (not defined $modes->{_symbol_table}->{_namespace})) {
                $modes->{_symbol_table}->{_namespace} = 'main::'; 
            }

            # in a *.pl program, you can have variables declared outside of any subroutine, which means they are in the default 'main()' subroutine using C++ rules
            if ((not exists $modes->{_symbol_table}->{_subroutine}) or (not defined $modes->{_symbol_table}->{_subroutine})) {
                $modes->{_symbol_table}->{_subroutine} = 'main'; 
            }

#            RPerl::diag('in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $symbol = ' . $symbol . "\n");
#            RPerl::diag('in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modes->{_symbol_table} = ' . Dumper($modes->{_symbol_table}) . "\n");
#            RPerl::diag('in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modes->{_symbol_table}->{_namespace} = ' . $modes->{_symbol_table}->{_namespace} . "\n");
#            RPerl::diag('in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modes->{_symbol_table}->{_subroutine} = ' . $modes->{_symbol_table}->{_subroutine} . "\n");

            if ( exists $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol} ) {
                 die 'ERROR ECOGEASCP012, CODE GENERATOR, ABSTRACT SYNTAX TO C++: variable '
                    . q{'} . $symbol . q{'} 
                    . ' already declared in this scope, namespace '
                    . q{'} . $modes->{_symbol_table}->{_namespace} . q{'}
                    . ', subroutine/method '
                    . q{'} . $modes->{_symbol_table}->{_subroutine} . q{()'}
                    . ', dying' . "\n";
            }
            $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol}
                = { isa => 'RPerl::Operation::Expression::SubExpression::Variable', type => $type };

            $type = RPerl::Generator::type_convert_perl_to_cpp( $type, $pointerify_classes );
            $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol}->{type_cpp} = $type; # add converted C++ type to symtab entry

            # detect user-defined class std::unique_ptr constant reference semantics
            # NEED ANSWER: does it matter if the RHS is a ConstructorCall?  we are currently ignoring the RHS completely for these semantics
            # NEED UPGRADE: enable detection logic for non-trivial cases where $type may be in parentheses or otherwise buried deeper in $self?
            # HARD-CODED EXAMPLE:
            # my Bat::Bax $quux = $self->{foo}->{$bar};   # Perl
            # Bat__Bax_ptr        quux = this->foo[bar];  # C++, BAD
            # Bat__Bax_ptr const& quux = this->foo[bar];  # C++, GOOD

#            RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol} = ' . RPerl::Parser::rperl_ast__dump($modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol}) . "\n" );

            # check if LHS type is a user-defined class, if so then must take const& constant reference to std::unique_ptr because it is not a std::shared_ptr
            # (see RPerl::Generator::type_convert_perl_to_cpp() for similar logic)
            if (( not exists $rperlnamespaces_generated::RPERL->{ $type . '::' } ) and $pointerify_classes ) {
#                RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have std::unique_ptr constant reference semantics semantics, generating LHS type and const& and symbol' . "\n" );
                $cpp_source_group->{CPP} .= $type . q{ const& } . $symbol;
            }
            else {
#                RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have normal semantics, generating LHS type and symbol' . "\n" );
                $cpp_source_group->{CPP} .= $type . q{ } . $symbol;
            }

            # OO constructor, no params: omit '=' assignment operator and wrap in parentheses
            if ($is_constructor_call_normal) {
#                RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $is_constructor_call_normal' . "\n" );
                if ( not exists $rperlnamespaces_generated::RPERL->{ $type . '::' } ) {    # not scalar or SSE number pair
#                    RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $is_constructor_call_normal, wrapping in parentheses' . "\n" );
                    $cpp_source_group->{CPP} .= '(';
                    $cpp_source_subgroup = $opnamed_or_subexp_or_input_scolon->{children}->[0]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);   # subexpression
                    RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
                    $cpp_source_group->{CPP} .= ')';
                }
                # purposefully do nothing here, no code needed
            }
            # OO constructor, yes params: include '=' assignment operator, no additional parentheses
            elsif ($is_constructor_call_params) {
#                RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $is_constructor_call_params' . "\n" );
                if ( not exists $rperlnamespaces_generated::RPERL->{ $type . '::' } ) {    # not scalar or SSE number pair
                    $cpp_source_group->{CPP} .= q{ } . $assign . q{ };
                    $cpp_source_subgroup = $opnamed_or_subexp_or_input_scolon->{children}->[0]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);   # subexpression
                    RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
                }
                else {
                    die 'ERROR ECOGEASCP064, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Constructor for RPerl data type ' . q{'} . $type . q{'} . ' should not be passed initialization parameters, dying' . "\n";
                }
            }
            # MongoDB constructor, optional params: omit '=' assignment operator, no additional parentheses
            # FROM: my MongoDB::MongoClient $my_client = MongoDB::MongoClient->new({host => 'mongodb://localhost:27017'});
            #   TO:    MongoDB__MongoClient  my_client                       {mongocxx::uri{"mongodb://localhost:27017"}};
            elsif ($is_constructor_call_mongodb) {
                $cpp_source_subgroup = $opnamed_or_subexp_or_input_scolon->{children}->[0]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);   # subexpression
                RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
            }
            # special constructors, including *_arrayref_arrayref 2-D data structures, for example:
            # my integer_arrayref_arrayref $my_2d_set = integer_arrayref_arrayref::new( $y_count,                 $x_count );  # Perl, row-major form (RMF)
            #    integer_arrayref_arrayref  my_2d_set(                                   y_count, integer_arrayref(x_count));  # C++, row-major form (RMF)
            elsif ($is_constructor_call_special) {
#                RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $is_constructor_call_special' . "\n" );
                if ( exists $rperlnamespaces_generated::RPERL->{ $type . '::' } ) {
                    if (($type eq 'integer_arrayref_arrayref') or ($type eq 'number_arrayref_arrayref') or ($type eq 'string_arrayref_arrayref')) {
                        my string $base_type = (split /_/, $type)[0];
#                        RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $base_type = ' . $base_type . "\n" );
                        $cpp_source_group->{CPP} .= '(';
                        if (not exists $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[2]->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[0]) {
                            die 'ERROR ECOGEASCP060, CODE GENERATOR, ABSTRACT SYNTAX TO C++: first argument missing, constructor for type ' . $type . ', dying' . "\n";
                        }
                        elsif (not exists $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[2]->{children}->[0]->{children}->[1]->{children}->[1]->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[0]) {
                            die 'ERROR ECOGEASCP061, CODE GENERATOR, ABSTRACT SYNTAX TO C++: second argument missing, constructor for type ' . $type . ', dying' . "\n";
                        }
                        my string $row_count_argument = $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[2]->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[0];
                        substr $row_count_argument, 0, 1, q{};  # remove leading '$' sigil
                        $cpp_source_group->{CPP} .= $row_count_argument . ', ' . $base_type . '_arrayref(';
#                        RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $opnamed_or_subexp_or_input_scolon->... = ' . "\n" . RPerl::Parser::rperl_ast__dump($opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[2]->{children}->[0]->{children}->[1]->{children}->[1]->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[0]) . "\n" );
                        my string $column_count_argument = $opnamed_or_subexp_or_input_scolon->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[2]->{children}->[0]->{children}->[1]->{children}->[1]->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[0];
                        substr $column_count_argument, 0, 1, q{};  # remove leading '$' sigil
                        $cpp_source_group->{CPP} .= $column_count_argument . '))';
                    }
                    else {
                        die 'ERROR ECOGEASCP062, CODE GENERATOR, ABSTRACT SYNTAX TO C++: constructor called for recognized but currently unsupported type ' . $type . ', dying' . "\n";
                    }
                }
                else {
                    die 'ERROR ECOGEASCP063, CODE GENERATOR, ABSTRACT SYNTAX TO C++: constructor called for unrecognized type ' . $type . ', dying' . "\n";
                }
            }
            else {
#                RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have non-constructor' . "\n" );
                my $subexpression = $opnamed_or_subexp_or_input_scolon->{children}->[0];
#                RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $subexpression = ' . "\n" . RPerl::Parser::rperl_ast__dump($subexpression) . "\n" );
#                RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have (ref $subexpression) = ' . (ref $subexpression) . "\n" );
#                RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have (ref $subexpression->{children}->[0]) = ' . (ref $subexpression->{children}->[0]) . "\n" );
#                RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have (ref $subexpression->{children}->[0]->{children}->[0]) = ' . (ref $subexpression->{children}->[0]->{children}->[0]) . "\n" );
#                RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have (ref $subexpression->{children}->[0]->{children}->[0]->{children}->[1]) = ' . (ref $subexpression->{children}->[0]->{children}->[0]->{children}->[1]) . "\n" );
#                RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $subexpression->{children}->[0]->{children}->[0]->{children}->[1]->{children} = ' . "\n" . $subexpression->{children}->[0]->{children}->[0]->{children}->[1]->{children} . "\n" );
#                RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $subexpression->{children}->[0]->{children}->[0]->{children}->[1]->{children} = ' . "\n" . Dumper($subexpression->{children}->[0]->{children}->[0]->{children}->[1]->{children}) . "\n" );
#                RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have scalar @{$subexpression->{children}->[0]->{children}->[0]->{children}->[1]->{children}} = ' . "\n" . (scalar @{$subexpression->{children}->[0]->{children}->[0]->{children}->[1]->{children}}) . "\n" );

                # test for empty array ref as value for variable initialization, discard in C++
                if (
                    (blessed $subexpression) and
                    ((ref    $subexpression) eq 'SubExpressionOrInput_164') and
                    (exists  $subexpression->{children}) and
                    (defined $subexpression->{children}) and
                    (defined $subexpression->{children}->[0]) and
                    (blessed $subexpression->{children}->[0]) and
                    ((ref    $subexpression->{children}->[0]) eq 'SubExpression_159') and
                    (exists  $subexpression->{children}->[0]->{children}) and
                    (defined $subexpression->{children}->[0]->{children}) and
                    (defined $subexpression->{children}->[0]->{children}->[0]) and
                    (blessed $subexpression->{children}->[0]->{children}->[0]) and
                    ((ref    $subexpression->{children}->[0]->{children}->[0]) eq 'ArrayReference_218') and
                    (exists  $subexpression->{children}->[0]->{children}->[0]->{children}) and
                    (defined $subexpression->{children}->[0]->{children}->[0]->{children}) and
                    (defined $subexpression->{children}->[0]->{children}->[0]->{children}->[0]) and
                    (        $subexpression->{children}->[0]->{children}->[0]->{children}->[0] eq '[') and
                    (defined $subexpression->{children}->[0]->{children}->[0]->{children}->[1]) and
                    (blessed $subexpression->{children}->[0]->{children}->[0]->{children}->[1]) and
                    ((ref    $subexpression->{children}->[0]->{children}->[0]->{children}->[1]) eq '_OPTIONAL') and
                    (exists  $subexpression->{children}->[0]->{children}->[0]->{children}->[1]->{children}) and
                    (defined $subexpression->{children}->[0]->{children}->[0]->{children}->[1]->{children}) and
                    ((scalar @{$subexpression->{children}->[0]->{children}->[0]->{children}->[1]->{children}}) == 0) and
                    (defined $subexpression->{children}->[0]->{children}->[0]->{children}->[2]) and
                    (        $subexpression->{children}->[0]->{children}->[0]->{children}->[2] eq ']')
                    ) {
#                    RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have empty array ref' . "\n");
                    1;  # do nothing
                }
                else {
#                    RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have non-constructor, generating' . "\n" );
                    $cpp_source_group->{CPP} .= q{ } . $assign . q{ };
                    $cpp_source_subgroup = $opnamed_or_subexp_or_input_scolon->{children}->[0]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);       # subexpression
                    RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
                }
            }
            $cpp_source_group->{CPP} .= $opnamed_or_subexp_or_input_scolon->{children}->[1];                                                     # semicolon
        }
        else {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP000, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                    . $opnamed_or_subexp_or_input_scolon_type
                    . ' found where OpNamedScolonOrSubExpIn_260, OpNamedScolonOrSubExpIn_261, or OpNamedScolonOrSubExpIn_262 expected, dying' )
                . "\n";
        }

        $cpp_source_group->{CPP} .= "\n";
    }
    elsif ( $self_class eq 'VariableDeclaration_204' ) { # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef' ';'
        my string $type          = $self->{children}->[1]->{children}->[0];
        my string $symbol        = $self->{children}->[2];
        my object $subexpression = $self->{children}->[4];
        my string $semicolon     = $self->{children}->[8];

        # remember symbol AKA name for C++ reserved identifier check at bottom of subroutine
        $name = $symbol;

        my string $symbol_no_sigil = substr $symbol, 1;
        if ((exists $perlapinames_generated::FUNCTIONS_DOCUMENTED->{$symbol_no_sigil}) or
            (exists $perlapinames_generated::FUNCTIONS_UNDOCUMENTED->{$symbol_no_sigil}) or
            (exists $perlapinames_generated::VARIABLES_DOCUMENTED->{$symbol_no_sigil}) or
            (exists $perlapinames_generated::VARIABLES_UNDOCUMENTED->{$symbol_no_sigil})) {
            die 'ERROR ECOGEASCP043, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Perl API name conflict, variable name ' . q{'}
                . $symbol_no_sigil . q{'}
                . ' is the same as a protected function or variable name in the Perl API, please choose a different name, dying' . "\n";
        }

        substr $symbol, 0, 1, q{};                       # remove leading $ sigil

#        RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $subexpression = ' . RPerl::Parser::rperl_ast__dump($subexpression) . "\n" );

        # CREATE SYMBOL TABLE ENTRY
        if ( exists $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol} ) {
            die 'ERROR ECOGEASCP012, CODE GENERATOR, ABSTRACT SYNTAX TO C++: variable '
                . q{'} . $symbol . q{'} 
                . ' already declared in this scope, namespace '
                . q{'} . $modes->{_symbol_table}->{_namespace} . q{'}
                . ', subroutine/method '
                . q{'} . $modes->{_symbol_table}->{_subroutine} . q{()'}
                . ', dying' . "\n";
        }
        $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol}
            = { isa => 'RPerl::Operation::Expression::SubExpression::Variable', type => $type };

        $type = RPerl::Generator::type_convert_perl_to_cpp( $type, 1 );    # $pointerify_classes = 1
        $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol}->{type_cpp} = $type; # add converted C++ type to symtab entry

        my string $subexpression_address = "$subexpression";

        # POSSIBLE COMPILE-TIME OPTIMIZATION #01: avoids compensation addition below
        $subexpression = RPerl::Generator::arrayref_convert_index_max_to_size($subexpression);

        $cpp_source_group->{CPP} .= $type . q{ } . $symbol . $semicolon . "\n";
        $cpp_source_group->{CPP} .= $symbol . q{.resize(};
        $cpp_source_subgroup = $subexpression->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        if ( $subexpression_address eq "$subexpression" ) {    # not compensated automatically, must compensate manually
                                                               # 'foo() * $bar' becomes '(foo() * $bar) + 1'
            $cpp_source_subgroup->{CPP} = q{(} . $cpp_source_subgroup->{CPP} . q{) + 1};
        }
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
        $cpp_source_group->{CPP} .= q{)} . $semicolon . "\n";
    }
    elsif ( $self_class eq 'VariableDeclaration_205' ) {       # VariableDeclaration -> MY TYPE_FHREF FHREF_SYMBOL ';'
        my string $type_fhref   = $self->{children}->[1];
        my string $symbol_fhref = $self->{children}->[2];

        # remember symbol AKA name for C++ reserved identifier check at bottom of subroutine
        $name = $symbol_fhref;

        my string $symbol_no_sigil = substr $symbol_fhref, 1;
        if ((exists $perlapinames_generated::FUNCTIONS_DOCUMENTED->{$symbol_no_sigil}) or
            (exists $perlapinames_generated::FUNCTIONS_UNDOCUMENTED->{$symbol_no_sigil}) or
            (exists $perlapinames_generated::VARIABLES_DOCUMENTED->{$symbol_no_sigil}) or
            (exists $perlapinames_generated::VARIABLES_UNDOCUMENTED->{$symbol_no_sigil})) {
            die 'ERROR ECOGEASCP043, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Perl API name conflict, variable name ' . q{'}
                . $symbol_no_sigil . q{'}
                . ' is the same as a protected function or variable name in the Perl API, please choose a different name, dying' . "\n";
        }

        substr $symbol_fhref, 0, 1, q{};                       # remove leading $ sigil

        # CREATE SYMBOL TABLE ENTRY
        if ( exists $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol_fhref} ) {
            die 'ERROR ECOGEASCP012, CODE GENERATOR, ABSTRACT SYNTAX TO C++: variable '
                . q{'} . $symbol_fhref . q{'} 
                . ' already declared in this scope, namespace '
                . q{'} . $modes->{_symbol_table}->{_namespace} . q{'}
                . ', subroutine/method '
                . q{'} . $modes->{_symbol_table}->{_subroutine} . q{()'}
                . ', dying' . "\n";
        }
        $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol_fhref}
            = { isa => 'RPerl::Operation::Expression::SubExpression::Variable', type => $type_fhref };

        # NEED ANSWER: should we enable type_convert_perl_to_cpp() for future use of constant_filehandleref type?
        #        $type_fhref = RPerl::Generator::type_convert_perl_to_cpp($type_fhref, 1);  # $pointerify_classes = 1
        $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{ $modes->{_symbol_table}->{_subroutine} }->{$symbol_fhref}->{type_cpp}
            = $type_fhref;    # add converted C++ type to symtab entry

        $cpp_source_group->{CPP} .= $type_fhref . q{ } . $symbol_fhref . ';' . "\n";
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP000, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                . $self_class
                . ' found where VariableDeclaration_202, VariableDeclaration_203, VariableDeclaration_204, or VariableDeclaration_205 expected, dying' )
            . "\n";
    }

    # DEV NOTE, CORRELATION #rp045: identifiers containing underscores may be reserved by C++
    # NEED ANSWER: in an *.pl Perl program, should Perl global variables be allowed to begin with underscore, 
    # because they will be made into non-global C++ variables inside the C++ main() function?  and does the Perl vs C++ behavior match in this case???
    my string $name_nosigil = substr $name, 1;
#    RPerl::diag('in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $name = ' . q{'} . $name . q{'} . "\n");
#    RPerl::diag('in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $name_nosigil = ' . q{'} . $name_nosigil . q{'} . "\n");
#    RPerl::diag('in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modes->{_symbol_table}->{_namespace} = ' . q{'} . $modes->{_symbol_table}->{_namespace} . q{'} . "\n");
    if (((substr $name_nosigil, 0, 1) eq '_') and ($modes->{_symbol_table}->{_namespace} eq q{}) and ($modes->{_symbol_table}->{_subroutine} eq q{})) {
        die 'ERROR ECOGEASCP180a, CODE GENERATOR, ABSTRACT SYNTAX TO C++:' . "\n" . 'global variable name ' . q{'} . $name . q{'} .
            ' must not start with an underscore, forbidden by C++ specification as a reserved identifier, dying' . "\n";
    }
    elsif ($name_nosigil =~ m/^_[A-Z]/gxms) {
        die 'ERROR ECOGEASCP180b, CODE GENERATOR, ABSTRACT SYNTAX TO C++:' . "\n" . 'variable name ' . q{'} . $name . q{'} .
            ' must not start with an underscore followed by an uppercase letter, forbidden by C++ specification as a reserved identifier, dying' . "\n";
    }
    elsif ($name_nosigil =~ m/__/gxms) {
        die 'ERROR ECOGEASCP180c, CODE GENERATOR, ABSTRACT SYNTAX TO C++:' . "\n" . 'variable name ' . q{'} . $name . q{'} .
            ' must not include a double-underscore, forbidden by C++ specification as a reserved identifier, dying' . "\n";
    }

#    RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), returning $cpp_source_group = ', "\n", RPerl::Parser::rperl_ast__dump($cpp_source_group), "\n" );
    return $cpp_source_group;
}

1;    # end of class
