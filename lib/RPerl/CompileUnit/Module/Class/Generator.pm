# [[[ HEADER ]]]
package RPerl::CompileUnit::Module::Class::Generator;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.016_100;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Parser;
use RPerl::Generator;
use Storable qw(dclone);
use perlapinames_generated;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub ast_to_rperl__generate {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string $package_name_underscores, my string_hashref $modes ) = @ARG;
    my string_hashref $rperl_source_group = {};

#    RPerl::diag( 'in Class::Generator->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    # unwrap Class_76 from Module_25
    if ( ($self_class) eq 'Module_25' ) {
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

#    RPerl::diag( 'in Class::Generator->ast_to_rperl__generate(), have possibly-unwrapped $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    die 'TMP DEBUG';

    if ( ($self_class) ne 'Class_76' ) {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . ($self_class)
                . ' found where Module_25 or Class_76 expected, dying' )
            . "\n";
    }

    # Class: UseParent WordScoped ')' ';' Include Critic* Exports? Include* Constant* Properties SubroutineOrMethod* LITERAL_NUMBER ';' ;
    # UseParent: 'use parent qw(' | 'use parent -norequire, qw(' ;
    my string $use_parent_qw_keyword     = $self->{children}->[0]->{children}->[0];
    my string $parent_name               = $self->{children}->[1]->{children}->[0];
    my string $right_parenthesis         = $self->{children}->[2];
    my string $use_parent_semicolon      = $self->{children}->[3];
    my object $parent_include            = $self->{children}->[4];
    my object $critic_star               = $self->{children}->[5];
    my object $exports_optional          = $self->{children}->[6];
    my object $include_star              = $self->{children}->[7];
    my object $constant_star             = $self->{children}->[8];
    my object $properties                = $self->{children}->[9];
    my object $method_or_subroutine_star = $self->{children}->[10];
    my string $retval_literal_number     = $self->{children}->[11];
    my string $retval_semicolon          = $self->{children}->[12];

#    RPerl::diag( 'in Class::Generator->ast_to_rperl__generate(), have $use_parent_qw_keyword = ' . "\n" . RPerl::Parser::rperl_ast__dump($use_parent_qw_keyword) . "\n" );
#    RPerl::diag( 'in Class::Generator->ast_to_rperl__generate(), have $exports_optional = ' . "\n" . RPerl::Parser::rperl_ast__dump($exports_optional) . "\n" );
#    RPerl::diag( 'in Class::Generator->ast_to_rperl__generate(), have $exports_optional->{children}->[0] = ' . "\n" . RPerl::Parser::rperl_ast__dump($exports_optional->{children}->[0]) . "\n" );

    $rperl_source_group->{PMC} = q{};
    if ( $modes->{label} eq 'ON' ) {
        $rperl_source_group->{PMC} .= '# [[[ OO INHERITANCE ]]]' . "\n";
    }
    $rperl_source_group->{PMC} .= $use_parent_qw_keyword . $parent_name . $right_parenthesis . $use_parent_semicolon . "\n";

    my string_hashref $rperl_source_subgroup = $parent_include->ast_to_rperl__generate($modes);
    RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );

    if ( exists $critic_star->{children}->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $rperl_source_group->{PMC} .= '# [[[ CRITICS ]]]' . "\n";
        }
    }
    foreach my object $critic ( @{ $critic_star->{children} } ) {
        $rperl_source_subgroup = $critic->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }

    if ( exists $exports_optional->{children}->[0] ) {
#        RPerl::diag( 'in Class::Generator->ast_to_rperl__generate(), have YES EXPORTS ' . "\n" );
        if ( $modes->{label} eq 'ON' ) {
            $rperl_source_group->{PMC} .= "\n" . '# [[[ EXPORTS ]]]' . "\n";
        }
        my object $exports = $exports_optional->{children}->[0];
        my string $use_exporter = $exports->{children}->[0];
        my string $export = $exports->{children}->[1];
        my string $export_ok = $exports->{children}->[2];

        $rperl_source_group->{PMC} .= $use_exporter;  # already has a newline
        if ( exists $export->{children}->[0] ) {
            $rperl_source_group->{PMC} .= $export->{children}->[0]->{attr} . $export->{children}->[1]->{attr} . ';' . "\n";  # DEV NOTE: does not capture semicolon in AST for some reason, must hard-code here
        }
        if ( exists $export_ok->{children}->[0] ) {
            $rperl_source_group->{PMC} .= $export_ok->{children}->[0]->{attr} . $export_ok->{children}->[1]->{attr} . ';' . "\n";  # DEV NOTE: does not capture semicolon in AST for some reason, must hard-code here
        }
#        RPerl::diag( 'in Class::Generator->ast_to_rperl__generate(), AFTER EXPORTS, have $rperl_source_group->{PMC} = ' . "\n" . RPerl::Parser::rperl_ast__dump($rperl_source_group->{PMC}) . "\n" );
    }

#    RPerl::diag( 'in Class::Generator->ast_to_rperl__generate(), CHECKPOINT a000', "\n" );

    if ( exists $include_star->{children}->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $rperl_source_group->{PMC} .= "\n" . '# [[[ INCLUDES ]]]' . "\n";
        }
    }

#    RPerl::diag( 'in Class::Generator->ast_to_rperl__generate(), CHECKPOINT a001', "\n" );

    foreach my object $include ( @{ $include_star->{children} } ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        $rperl_source_subgroup = $include->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }

#    RPerl::diag( 'in Class::Generator->ast_to_rperl__generate(), CHECKPOINT a002', "\n" );

    if ( exists $constant_star->{children}->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $rperl_source_group->{PMC} .= "\n" . '# [[[ CONSTANTS ]]]' . "\n";
        }
    }

#    RPerl::diag( 'in Class::Generator->ast_to_rperl__generate(), CHECKPOINT a003', "\n" );

    foreach my object $constant ( @{ $constant_star->{children} } ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        $rperl_source_subgroup = $constant->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }

#    RPerl::diag( 'in Class::Generator->ast_to_rperl__generate(), CHECKPOINT a004', "\n" );

    if ( $modes->{label} eq 'ON' ) {
        $rperl_source_group->{PMC} .= "\n" . '# [[[ OO PROPERTIES ]]]' . "\n";
    }

    # prepare for later use in:
    # disallow name masking of inherited $properties, AND
    # generate accessors & mutators for inherited $properties
    my string $package_name_colons = $package_name_underscores;
    $package_name_colons =~ s/__/::/gxms;

#    RPerl::diag( 'in Class::Generator->ast_to_rperl__generate(), CHECKPOINT a005', "\n" );

    my $parent_package_names = RPerl::CompileUnit::Module::Class::parent_and_grandparent_package_names($package_name_colons);

#    RPerl::diag( 'in Class::Generator->ast_to_rperl__generate(), CHECKPOINT a006', "\n" );

#    RPerl::diag( 'in Class::Generator->ast_to_rperl__generate(), have $parent_package_names = ' . Dumper($parent_package_names) . "\n" );

    if ( ref $properties eq 'Properties_82' ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
                                                # non-empty $properties
        my string $properties_our_hashref = $properties->{children}->[0];
        my string $properties_equal       = $properties->{children}->[1];
        my string $properties_left_brace  = $properties->{children}->[2];
        my object $property_0             = $properties->{children}->[3];
        my object $properties_1_to_n      = $properties->{children}->[4];
        my string $properties_right_brace = $properties->{children}->[5];
        my string $properties_semicolon   = $properties->{children}->[6];

        $rperl_source_group->{PMC} .= $properties_our_hashref . q{ } . $properties_equal . q{ } . $properties_left_brace . "\n";

        my string $property_key;
        my string $property_fat_arrow;
        my object $property_type_inner;
        my string $property_my;
        my string $property_type;
        my string $property_TYPED;
        my string $property_name;
        my string $property_arrayref_thinarrow;
        my object $property_arrayref_index_max;
        my string $property_arrayref_rightbracket;
        my string $property_assign;
        my object $property_subexpression;
        my string $property_subexpression_string;

        $property_key = $property_0->{children}->[0]->{children}->[0];
        $property_key =~ s/^(\w+)\s*$/$1/gxms;    # strip trailing whitespace, caused by grammar matching operator names with trailing spaces





# DEV NOTE, CORRELATION #rp045: identifiers containing underscores may be reserved by C++
=DISABLE_NEED_FIX
        if ( $property_key !~ /^[a-z]/ ) {
            die 'ERROR ECOGEASRP24, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: invalid OO properties name (hash key) ' . q{'}
                . $property_key . q{'}
                . ' does not start with a lowercase letter a-z, dying' . "\n";
        }
=cut





        $property_fat_arrow  = $property_0->{children}->[1];
        $property_type_inner = $property_0->{children}->[2];
        $property_name       = $property_type_inner->{children}->[3]->{children}->[0];
        $property_name =~ s/^(\w+)\s*$/$1/gxms;    # strip trailing whitespace, caused by grammar matching operator names with trailing spaces

        # DEV NOTE: we can do error checking once here instead of twice for TypeInnerProperties_244 & TypeInnerProperties_245 below
        # because they both have OpStringOrWord as sub-element 3, grabbed as $property_name above
        if ( $property_name ne $property_key ) {
            die 'ERROR ECOGEASRP21, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL, NAME-CHECKING MISMATCH: redundant inner type name ' . q{'}
                . $property_name . q{'}
                . ' does not equal OO properties key ' . q{'}
                . $property_key . q{'}
                . ', dying' . "\n";
        }

#        RPerl::diag( 'in Class::Generator->ast_to_rperl__generate(), have $property_name = ' . $property_name . "\n" );
#        RPerl::diag( 'in Class::Generator->ast_to_rperl__generate(), have $perlapinames_generated::FUNCTIONS_DOCUMENTED = ' . Dumper($perlapinames_generated::FUNCTIONS_DOCUMENTED) . "\n" );

        if ((exists $perlapinames_generated::FUNCTIONS_DOCUMENTED->{$property_name}) or
            (exists $perlapinames_generated::FUNCTIONS_UNDOCUMENTED->{$property_name}) or
            (exists $perlapinames_generated::VARIABLES_DOCUMENTED->{$property_name}) or
            (exists $perlapinames_generated::VARIABLES_UNDOCUMENTED->{$property_name})) {
            die 'ERROR ECOGEASRP41, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Perl API name conflict, OO property name ' . q{'}
                . $property_name . q{'}
                . ' is the same as a protected function or variable name in the Perl API, please choose a different name, dying' . "\n";
        }

        # TypeInnerProperties -> MY Type '$TYPED_' OpStringOrWord OP19_VARIABLE_ASSIGN SubExpression
        if ( ref $property_type_inner eq 'TypeInnerProperties_244' ) {
            $property_my            = $property_type_inner->{children}->[0];
            $property_type          = $property_type_inner->{children}->[1]->{children}->[0];
            $property_TYPED         = $property_type_inner->{children}->[2];
            $property_assign        = $property_type_inner->{children}->[4];
            $property_subexpression = $property_type_inner->{children}->[5];

            $rperl_source_group->{PMC}
                .= $property_key . q{ }
                . $property_fat_arrow . q{ }
                . $property_my . q{ }
                . $property_type . q{ }
                . $property_TYPED
                . $property_name . q{ }
                . $property_assign . q{ };

            $rperl_source_subgroup = $property_subexpression->ast_to_rperl__generate($modes);
            RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        }

        # TypeInnerProperties -> MY Type '$TYPED_' OpStringOrWord OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef'
        elsif ( ref $property_type_inner eq 'TypeInnerProperties_245' ) {
            $property_my                    = $property_type_inner->{children}->[0];
            $property_type                  = $property_type_inner->{children}->[1]->{children}->[0];
            $property_TYPED                 = $property_type_inner->{children}->[2];
            $property_arrayref_thinarrow    = $property_type_inner->{children}->[4];
            $property_arrayref_index_max    = $property_type_inner->{children}->[5];
            $property_arrayref_rightbracket = $property_type_inner->{children}->[6];
            $property_assign                = $property_type_inner->{children}->[7];
            $property_subexpression_string  = $property_type_inner->{children}->[8];

            $rperl_source_group->{PMC}
                .= $property_key . q{ }
                . $property_fat_arrow . q{ }
                . $property_my . q{ }
                . $property_type . q{ }
                . $property_TYPED
                . $property_name
                . $property_arrayref_thinarrow;

            $rperl_source_subgroup = $property_arrayref_index_max->ast_to_rperl__generate($modes);
            RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );

            $rperl_source_group->{PMC} .= $property_arrayref_rightbracket . q{ } . $property_assign . q{ } . $property_subexpression_string;
        }
        else {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                    . ( ref $self )
                    . ' found where TypeInnerProperties_244 or TypeInnerProperties_245 expected, dying' )
                . "\n";
        }

        # CREATE SYMBOL TABLE ENTRY
        if ( exists $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{_properties}->{$property_key} ) {
            die 'ERROR ECOGEASRP10, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: OO property '
                . q{'} . $property_key . q{'}
                . ' already declared in this scope, namespace '
                . q{'} . $modes->{_symbol_table}->{_namespace} . q{'}
                . ', dying' . "\n";
        }

#        RPerl::diag( 'in Class::Generator->ast_to_rperl__generate(), property 0, have $parent_package_names = ' . "\n" . Dumper($parent_package_names) . "\n" ) if (scalar @{$parent_package_names});

        # disallow name masking of inherited $properties, causes mismatching behavior in PERLOPS_PERLTYPES vs CPPOPS_CPPTYPES
        foreach my $parent_package_name (@{$parent_package_names}) {
            if ( exists $modes->{_symbol_table}->{ $parent_package_name . q{::} }->{_properties}->{$property_key} ) {
                die 'ERROR ECOGEASRP11, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: OO property '
                    . q{'} . $property_key . q{'}
                    . ' already declared in parent namespace '
                    . q{'} . $parent_package_name . q{::} . q{'}
                    . ', name masking disallowed, dying' . "\n";
            }
        }

        $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{_properties}->{$property_key}
            = { isa => 'RPerl::DataStructure::Hash::Properties', type => $property_type };

        my integer $i = 0;
        foreach my object $property ( @{ $properties_1_to_n->{children} } ) {
            if ( ( ref $property ) eq 'TERMINAL' ) {
                $rperl_source_group->{PMC} .= $property->{attr};    # comma between properties
            }
            else {
                $i++;
                $property_key = $property->{children}->[0]->{children}->[0];
                $property_key =~ s/^(\w+)\s*$/$1/gxms;              # strip trailing whitespace, caused by grammar matching operator names with trailing spaces




# DEV NOTE, CORRELATION #rp045: identifiers containing underscores may be reserved by C++
=DISABLE_NEED_FIX
                if ( $property_key !~ /^[a-z]/ ) {
                    die 'ERROR ECOGEASRP24, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: invalid OO properties name (hash key) ' . q{'}
                        . $property_key . q{'}
                        . ' does not start with a lowercase letter a-z, dying' . "\n";
                }
=cut



                $property_fat_arrow  = $property->{children}->[1];
                $property_type_inner = $property->{children}->[2];
                $property_name       = $property_type_inner->{children}->[3]->{children}->[0];
                $property_name =~ s/^(\w+)\s*$/$1/gxms;             # strip trailing whitespace, caused by grammar matching operator names with trailing spaces

                if ( $property_name ne $property_key ) {
                    die 'ERROR ECOGEASRP21, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL, NAME-CHECKING MISMATCH: redundant inner type name ' . q{'}
                        . $property_name . q{'}
                        . ' does not equal OO properties key ' . q{'}
                        . $property_key . q{'}
                        . ', dying' . "\n";
                }
                if ((exists $perlapinames_generated::FUNCTIONS_DOCUMENTED->{$property_name}) or
                    (exists $perlapinames_generated::FUNCTIONS_UNDOCUMENTED->{$property_name}) or
                    (exists $perlapinames_generated::VARIABLES_DOCUMENTED->{$property_name}) or
                    (exists $perlapinames_generated::VARIABLES_UNDOCUMENTED->{$property_name})) {
                    die 'ERROR ECOGEASRP41, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Perl API name conflict, OO property name ' . q{'}
                        . $property_name . q{'}
                        . ' is the same as a protected function or variable name in the Perl API, please choose a different name, dying' . "\n";
                }

                # TypeInnerProperties -> MY Type '$TYPED_' WORD OP19_VARIABLE_ASSIGN SubExpression
                if ( ref $property_type_inner eq 'TypeInnerProperties_244' ) {
                    $property_my            = $property_type_inner->{children}->[0];
                    $property_type          = $property_type_inner->{children}->[1]->{children}->[0];
                    $property_TYPED         = $property_type_inner->{children}->[2];
                    $property_assign        = $property_type_inner->{children}->[4];
                    $property_subexpression = $property_type_inner->{children}->[5];

                    $rperl_source_group->{PMC}
                        .= $property_key . q{ }
                        . $property_fat_arrow . q{ }
                        . $property_my . q{ }
                        . $property_type . q{ }
                        . $property_TYPED
                        . $property_name . q{ }
                        . $property_assign . q{ };

                    $rperl_source_subgroup = $property_subexpression->ast_to_rperl__generate($modes);
                    RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
                }

                # TypeInnerProperties -> MY Type '$TYPED_' WORD OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef'
                elsif ( ref $property_type_inner eq 'TypeInnerProperties_245' ) {
                    $property_my                    = $property_type_inner->{children}->[0];
                    $property_type                  = $property_type_inner->{children}->[1]->{children}->[0];
                    $property_TYPED                 = $property_type_inner->{children}->[2];
                    $property_arrayref_thinarrow    = $property_type_inner->{children}->[4];
                    $property_arrayref_index_max    = $property_type_inner->{children}->[5];
                    $property_arrayref_rightbracket = $property_type_inner->{children}->[6];
                    $property_assign                = $property_type_inner->{children}->[7];
                    $property_subexpression_string  = $property_type_inner->{children}->[8];

                    $rperl_source_group->{PMC}
                        .= $property_key . q{ }
                        . $property_fat_arrow . q{ }
                        . $property_my . q{ }
                        . $property_type . q{ }
                        . $property_TYPED
                        . $property_name
                        . $property_arrayref_thinarrow;

                    $rperl_source_subgroup = $property_arrayref_index_max->ast_to_rperl__generate($modes);
                    RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );

                    $rperl_source_group->{PMC} .= $property_arrayref_rightbracket . q{ } . $property_assign . q{ } . $property_subexpression_string;
                }
                else {
                    die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                            . ( ref $self )
                            . ' found where TypeInnerProperties_244 or TypeInnerProperties_245 expected, dying' )
                        . "\n";
                }

                # CREATE SYMBOL TABLE ENTRY
                if ( exists $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{_properties}->{$property_key} ) {
                    die 'ERROR ECOGEASRP10, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: OO property '
                        . $property_key
                        . ' already declared in this scope, namespace '
                        . $modes->{_symbol_table}->{_namespace}
                        . ', dying' . "\n";
                }

#                RPerl::diag( 'in Class::Generator->ast_to_rperl__generate(), property ' . $i . ', have $parent_package_names = ' . "\n" . Dumper($parent_package_names) . "\n" ) if (scalar @{$parent_package_names});

                # disallow name masking of inherited $properties, causes mismatching behavior in PERLOPS_PERLTYPES vs CPPOPS_CPPTYPES
                foreach my $parent_package_name (@{$parent_package_names}) {
                    if ( exists $modes->{_symbol_table}->{ $parent_package_name . q{::} }->{_properties}->{$property_key} ) {
                        die 'ERROR ECOGEASRP11, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: OO property '
                            . q{'} . $property_key . q{'}
                            . ' already declared in parent namespace '
                            . q{'} . $parent_package_name . q{::} . q{'}
                            . ', name masking disallowed, dying' . "\n";
                    }
                }

                $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{_properties}->{$property_key}
                    = { isa => 'RPerl::DataStructure::Hash::Properties', type => $property_type };
            }
        }
        $rperl_source_group->{PMC} .= "\n" . $properties_right_brace . $properties_semicolon . "\n";
    }
    else { # ( ref $properties eq 'Properties_83' ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
              # empty $properties
        my string $properties_our_hashref = $properties->{children}->[0];
        my string $properties_equal       = $properties->{children}->[1];
        my string $properties_left_brace  = $properties->{children}->[2];
        my string $properties_right_brace = $properties->{children}->[3];
        my string $properties_semicolon   = $properties->{children}->[4];
        $rperl_source_group->{PMC}
            .= $properties_our_hashref . q{ } . $properties_equal . q{ } . $properties_left_brace . $properties_right_brace . $properties_semicolon . "\n";
    }

    if ( exists $method_or_subroutine_star->{children}->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $rperl_source_group->{PMC} .= "\n" . '# [[[ SUBROUTINES & OO METHODS ]]]' . "\n\n";
        }
    }
    foreach my object $method_or_subroutine ( ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        @{ $method_or_subroutine_star->{children} }
        )
    {
        $rperl_source_subgroup = $method_or_subroutine->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }

    if ( $modes->{label} eq 'ON' ) {
        $rperl_source_group->{PMC} .= "\n" . $retval_literal_number . $retval_semicolon . '  # end of class' . "\n";
    }
    else {
        $rperl_source_group->{PMC} .= $retval_literal_number . $retval_semicolon . "\n";
    }
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string $package_name_underscores, my string_hashref $modes ) = @ARG;
    my string_hashref $cpp_source_group = {
        CPP => q{// <<< RP::CU::M::C::G __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n",
        H   => q{// <<< RP::CU::M::C::G __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n",
        PMC => q{# <<< RP::CU::M::C::G __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n"
    };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string $package_name_underscores, my string_hashref $modes ) = @ARG;
    my string_hashref $cpp_source_group = { H_INCLUDES => q{}, H => q{}, CPP => q{} };

#RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $package_name_underscores = ' . $package_name_underscores . "\n");
#RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $modes = ' . "\n" . Dumper($modes) . "\n");
#    RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $modes->{_symbol_table} = ' . "\n" . Dumper($modes->{_symbol_table}) . "\n");

    my string $self_class = ref $self;

    # unwrap Class_76 from Module_25
    if ( ($self_class) eq 'Module_25' ) {
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( ($self_class) ne 'Class_76' ) {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++, CPPOPS_CPPTYPES: Grammar rule '
                . ($self_class)
                . ' found where Module_25 or Class_76 expected, dying' )
            . "\n";
    }

    # Class: UseParent WordScoped ')' ';' Include Critic* Exports? Include* Constant* Properties SubroutineOrMethod* LITERAL_NUMBER ';' ;
    # UseParent: 'use parent qw(' | 'use parent -norequire, qw(' ;
    my string $parent_name               = $self->{children}->[1]->{children}->[0];
#    my string $parent_include            = $self->{children}->[4];  # DEV NOTE: the C++ code does not currently make use of the $parent_include line, instead utilizing only the $parent_name 
    my object $exports_optional          = $self->{children}->[6];
    my object $include_star              = $self->{children}->[7];
    my object $constant_star             = $self->{children}->[8];
    my object $properties                = $self->{children}->[9];
    my object $method_or_subroutine_star = $self->{children}->[10];

    if ((not exists $cpp_source_group->{_parent_names}) or (not defined $cpp_source_group->{_parent_names})) {
        $cpp_source_group->{_parent_names} = {};
    }
    $cpp_source_group->{_parent_names}->{$package_name_underscores} = $parent_name;

    if ( $modes->{label} eq 'ON' ) {
        $cpp_source_group->{H_INCLUDES} .= '// [[[ INCLUDES & OO INHERITANCE INCLUDES ]]]' . "\n";
        $cpp_source_group->{CPP}        .= '// [[[ INCLUDES ]]]' . "\n";

        # DEV NOTE, CORRELATION #rp043: no need to include RPerl.cpp multiple times in one file
        if (not ((exists $modes->{current_package_count}) and (defined $modes->{current_package_count}) and ($modes->{current_package_count} >= 1))) {
            $cpp_source_group->{H_INCLUDES} .= <<EOL;
#include <RPerl.cpp>  // -> RPerl.h -> (rperltypes_mode.h; rperloperations.h; rperltypes.h; HelperFunctions.cpp)
EOL
        }
    }
    else {
        # DEV NOTE, CORRELATION #rp043: no need to include RPerl.cpp multiple times in one file
        if (not ((exists $modes->{current_package_count}) and (defined $modes->{current_package_count}) and ($modes->{current_package_count} >= 1))) {
            $cpp_source_group->{H_INCLUDES} .= <<EOL;
#include <RPerl.cpp>
EOL
        }
    }

#    RPerl::diag('in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modes->{_enable_sse} = ' . Dumper($modes->{_enable_sse}) . "\n");
#    RPerl::diag('in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modes->{_enable_gmp} = ' . Dumper($modes->{_enable_gmp}) . "\n");
#    RPerl::diag('in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modes->{_enable_gsl} = ' . Dumper($modes->{_enable_gsl}) . "\n");
#    RPerl::diag('in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modes->{_enable_mongodb} = ' . Dumper($modes->{_enable_mongodb}) . "\n");

    # NEED FIX WIN32: change hard-coded forward-slash in generated path name below?
    # NEED FIX: handle absolute vs relative include paths
    my string $module_file_name = $package_name_underscores;
    $module_file_name =~ s/__/\//gxms;
    $module_file_name .= '.pm';

#    RPerl::diag('in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $module_file_name = ' . $module_file_name . "\n");

#    RPerl::diag('in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modes->{_enable_sse} = ' . Dumper($modes->{_enable_sse}) . "\n");
    if ( ( exists $modes->{_enable_sse} ) and ( defined $modes->{_enable_sse} ) ) {
        foreach my string $enabled_file_name ( keys %{ $modes->{_enable_sse} } ) {
            if ( ( $enabled_file_name =~ /$module_file_name$/xms ) and ( $modes->{_enable_sse}->{$enabled_file_name} ) ) {
                $cpp_source_group->{H_INCLUDES} .= '#include <rperlsse.h>' . "\n";
            }
        }
    }

#    RPerl::diag('in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modes->{_enable_gmp} = ' . Dumper($modes->{_enable_gmp}) . "\n");
    if ( ( exists $modes->{_enable_gmp} ) and ( defined $modes->{_enable_gmp} ) ) {
        foreach my string $enabled_file_name ( keys %{ $modes->{_enable_gmp} } ) {
            if ( ( $enabled_file_name =~ /$module_file_name$/xms ) and ( $modes->{_enable_gmp}->{$enabled_file_name} ) ) {
                $cpp_source_group->{H_INCLUDES} .= '#include <rperlgmp.h>' . "\n";
            }
        }
    }

#    RPerl::diag('in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modes->{_enable_gsl} = ' . Dumper($modes->{_enable_gsl}) . "\n");
    if ( ( exists $modes->{_enable_gsl} ) and ( defined $modes->{_enable_gsl} ) ) {
        foreach my string $enabled_file_name ( keys %{ $modes->{_enable_gsl} } ) {
            if ( ( $enabled_file_name =~ /$module_file_name$/xms ) and ( $modes->{_enable_gsl}->{$enabled_file_name} ) ) {
                $cpp_source_group->{H_INCLUDES} .= '#include <rperlgsl.h>' . "\n";
            }
        }
    }

#    RPerl::diag('in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modes->{_enable_mongodb} = ' . Dumper($modes->{_enable_mongodb}) . "\n");
    if ( ( exists $modes->{_enable_mongodb} ) and ( defined $modes->{_enable_mongodb} ) ) {
        foreach my string $enabled_file_name ( keys %{ $modes->{_enable_mongodb} } ) {
            if ( ( $enabled_file_name =~ /$module_file_name$/xms ) and ( $modes->{_enable_mongodb}->{$enabled_file_name} ) ) {
#                RPerl::diag('in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modes->{_enable_mongodb}->{' . $enabled_file_name . '} = TRUE' . "\n");
                $cpp_source_group->{H_INCLUDES} .= '#include <RPerl/Support/MongoDB.h>' . "\n";
            }
        }
    }

    # NEED FIX WIN32: change hard-coded forward-slash in generated path name below?
    # NEED FIX: handle absolute vs relative include paths
#    RPerl::diag('in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $parent_name = ' . $parent_name . "\n");
    my string $parent_name_path = $parent_name;
    $parent_name_path =~ s/::/\//gxms;
    $parent_name_path .= '.cpp';

    my string $parent_name_underscores = $parent_name;
    $parent_name_underscores =~ s/::/__/gxms;

#    RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $parent_name_underscores = ' . $parent_name_underscores . "\n");

    # DEV NOTE: avoid namespace clobbering of CPPOPS base class over PERLOPS base class
    if ( $parent_name_underscores eq 'RPerl__CompileUnit__Module__Class' ) {
        $parent_name_underscores .= '__CPP';
    }

    # DEV NOTE, CORRELATION #rp044: shared logic between class parent includes and misc user includes, always check both when changing either
    my boolean $is_rperl_system = 0;
    my boolean $is_rperl_test = 0;
    if ( ( ( substr $parent_name_path, 0, 5 ) eq 'RPerl' ) or ( ( substr $parent_name_path, 0, 5 ) eq 'rperl' ) ) {
        if ( ( ( substr $parent_name_path, 0, 10 ) eq 'RPerl/Test' ) or ( ( substr $parent_name_path, 0, 10 ) eq 'RPerl\Test' ) ) {
            $is_rperl_test = 1;
        }
        else {
            $is_rperl_system = 1;
        }
    }

    if ( $parent_name =~ /^\w+Perl::Config$/ ) {    # DEV NOTE, CORRELATION #rp027: RPerl::Config, MathPerl::Config, PhysicsPerl::Config, etc
        #        RPerl::diag('in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), skipping system config file $parent_name = ' . $parent_name . "\n");
    }
    elsif ( $is_rperl_test or (not $is_rperl_system) ) {
        # DEV NOTE: RPerl::Test files do not qualify as RPerl system files
#        RPerl::diag('in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modes = ' . Dumper($modes) . "\n");

        # DEV NOTE, CORRELATION #rp042: do not recursively load the same .cpp/.h file from within itself
        # it is incorrect for a subclass inside a multi-class file to include its parent class' .cpp file name, which is the .cpp version of it's own .h file name 
        if ((not exists $modes->{_input_file_name_current}) or (not defined $modes->{_input_file_name_current}) or ($modes->{_input_file_name_current} eq q{})) {
            die 'ERROR ECOGEASCP46, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Undefined or empty value provided for current input file name, dying' . "\n";
        }
        my string $input_file_name_current_underscores = $modes->{_input_file_name_current};

        substr $input_file_name_current_underscores, -3, 3, q{};  # remove trailing '.pm' 
        $input_file_name_current_underscores =~ s/\//__/gxms;
        $input_file_name_current_underscores =~ s/\\/__/gxms;

        my integer $parent_name_underscores_length = (length $parent_name_underscores);
        $input_file_name_current_underscores = substr $input_file_name_current_underscores, ($parent_name_underscores_length * -1), $parent_name_underscores_length;  # remove leading @INC directories 'lib', etc.
#        RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have user-defined module to possibly #include $input_file_name_current_underscores = ' . $input_file_name_current_underscores . "\n");

        if ($parent_name_underscores ne $input_file_name_current_underscores) {
            # non-RPerl user-defined module, wrapped in double-quotes " " to denote user nature
            $cpp_source_group->{H_INCLUDES} .= '#include "' . $parent_name_path . '"' . "\n";
#            RPerl::diag('in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have user-defined module to #include $parent_name = ' . $parent_name . "\n");
        }
        else {
            $cpp_source_group->{H_INCLUDES} .= '//#include "' . $parent_name_path . '" // DISABLED: do not recursively load the same .cpp/.h file from within itself' . "\n";
#            RPerl::diag('in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have user-defined module to NOT #include $parent_name = ' . $parent_name . "\n");
        }
    }
    else {
        # RPerl system module, wrapped in angle-brackets < > to denote system nature
#        RPerl::diag('in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have RPerl system module to #include $parent_name = ' . $parent_name . "\n");
        $cpp_source_group->{H_INCLUDES} .= '#include <' . $parent_name_path . '>' . "\n";
    }
    $cpp_source_group->{CPP} .= '#include "__NEED_HEADER_PATH"' . "\n";  # DEV NOTE, CORRELATION #rp033: defer setting header include path until files are saved in Compiler

#    RPerl::diag('in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $cpp_source_group->{H} = ' . "\n" . $cpp_source_group->{H} . "\n");
#    RPerl::diag('in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $cpp_source_group->{H_INCLUDES} = ' . "\n" . $cpp_source_group->{H_INCLUDES} . "\n");

    my string_hashref $cpp_source_subgroup;








# START HERE: figure out how to do Exports in C++, convert the Exports code below from RPerl output to C++ output
# START HERE: figure out how to do Exports in C++, convert the Exports code below from RPerl output to C++ output
# START HERE: figure out how to do Exports in C++, convert the Exports code below from RPerl output to C++ output

=DISABLED_NEED_CONVERT_FROM_RPERL_TO_CPP_OUTPUT
    if ( exists $exports_optional->{children}->[0] ) {
#        RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have YES EXPORTS ' . "\n" );
        if ( $modes->{label} eq 'ON' ) {
            $rperl_source_group->{H} .= "\n" . '# [[[ EXPORTS ]]]' . "\n";
        }
        my object $exports = $exports_optional->{children}->[0];
        my string $use_exporter = $exports->{children}->[0];
        my string $export = $exports->{children}->[1];
        my string $export_ok = $exports->{children}->[2];

        $rperl_source_group->{H} .= $use_exporter;  # already has a newline
        if ( exists $export->{children}->[0] ) {
            $rperl_source_group->{H} .= $export->{children}->[0]->{attr} . $export->{children}->[1]->{attr} . ';' . "\n";  # DEV NOTE: does not capture semicolon in AST for some reason, must hard-code here
        }
        if ( exists $export_ok->{children}->[0] ) {
            $rperl_source_group->{H} .= $export_ok->{children}->[0]->{attr} . $export_ok->{children}->[1]->{attr} . ';' . "\n";  # DEV NOTE: does not capture semicolon in AST for some reason, must hard-code here
        }
#        RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), AFTER EXPORTS, have $rperl_source_group->{H} = ' . "\n" . RPerl::Parser::rperl_ast__dump($rperl_source_group->{H}) . "\n" );
    }
=cut









    foreach my object $include ( @{ $include_star->{children} } ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
#        RPerl::diag('in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $package_name_underscores = ' . $package_name_underscores . "\n");
        $cpp_source_subgroup = $include->ast_to_cpp__generate__CPPOPS_CPPTYPES( $package_name_underscores, $modes );
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
    }

    my string $cpp_source_tmp = <<EOL;

# ifdef __PERL__TYPES

Purposefully_die_from_a_compile-time_error,_due_to____PERL__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# elif defined __CPP__TYPES

EOL

    $cpp_source_group->{H}   .= $cpp_source_tmp;
    $cpp_source_group->{CPP} .= $cpp_source_tmp;

    if ( $modes->{label} eq 'ON' ) {
        $cpp_source_tmp = ( ( '// [[[<<< BEGIN CPP TYPES >>>]]]' . "\n" ) x 3 ) . "\n";
        $cpp_source_group->{H}   .= $cpp_source_tmp;
        $cpp_source_group->{CPP} .= $cpp_source_tmp;
    }

    if ( exists $constant_star->{children}->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $cpp_source_group->{H} .= '// [[[ CONSTANTS ]]]' . "\n";
        }
        foreach my object $constant ( @{ $constant_star->{children} } ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
            $cpp_source_subgroup = $constant->ast_to_cpp__generate__CPPOPS_CPPTYPES( $package_name_underscores, $modes );
            $cpp_source_group->{H} .= $cpp_source_subgroup->{H};
            $cpp_source_group->{_H_constants_shims}->{$package_name_underscores} .= $cpp_source_subgroup->{_H_constants_shims}->{$package_name_underscores};
        }
        $cpp_source_group->{H} .= "\n";
    }

    if ( $modes->{label} eq 'ON' ) {
        $cpp_source_group->{H} .= '// [[[ OO INHERITANCE ]]]' . "\n";
    }

    $cpp_source_group->{H} .= 'class ' . $package_name_underscores . ' : public ' . $parent_name_underscores . ' {' . "\n";
    $cpp_source_group->{H} .= 'public:' . "\n";

    my string_arrayref $properties_accessors_mutators       = [];
    my string_arrayref $properties_accessors_mutators_shims = [];
    my string_arrayref $properties_declarations             = [];
    my string_arrayref $properties_initializations          = [];
    my string_arrayref $properties_initializers             = [];
    my string $property_declaration;

    # prepare for later use in:
    # disallow name masking of inherited $properties, AND
    # generate accessors & mutators for inherited $properties
    my string $package_name_colons = $package_name_underscores;
    $package_name_colons =~ s/__/::/gxms;
    my $parent_package_names = RPerl::CompileUnit::Module::Class::parent_and_grandparent_package_names($package_name_colons);
#    RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $parent_package_names = ' . Dumper($parent_package_names) . "\n" );

    # non-empty $properties
    # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE HashEntryProperties STAR-27 '}' ';'
    # HashEntryProperties -> WORD OP20_HASH_FATARROW TypeInnerProperties
    if ( ref $properties eq 'Properties_82' ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        $modes->{_inside_class_properties} = 1;
        $property_declaration = q{};
        my object $property_0        = $properties->{children}->[3];
        my object $properties_1_to_n = $properties->{children}->[4];

        my string $property_key = $property_0->{children}->[0]->{children}->[0];
        $property_key =~ s/^(\w+)\s*$/$1/gxms;    # strip trailing whitespace, caused by grammar matching operator names with trailing spaces





# DEV NOTE, CORRELATION #rp045: identifiers containing underscores may be reserved by C++
=DISABLE_NEED_ANSWER
        if ( $property_key !~ /^[a-z]/ ) {
            die 'ERROR ECOGEASCP24, CODE GENERATOR, ABSTRACT SYNTAX TO C++: invalid OO properties name (hash key) ' . q{'}
                . $property_key . q{'}
                . ' does not start with a lowercase letter a-z, dying' . "\n";
        }
=cut




        my object $property_type_inner         = $property_0->{children}->[2];
        my string $property_type               = undef;
        my object $property_subexpression      = undef;
        my object $property_arrayref_index_max = undef;
        my string $property_name               = $property_type_inner->{children}->[3]->{children}->[0];
        $property_name =~ s/^(\w+)\s*$/$1/gxms;    # strip trailing whitespace, caused by grammar matching operator names with trailing spaces

        # DEV NOTE: we can do error checking once here instead of twice for TypeInnerProperties_244 & TypeInnerProperties_245 below
        # because they both have OpStringOrWord as sub-element 3, grabbed as $property_name above
        if ( $property_name ne $property_key ) {
            die 'ERROR ECOGEASCP21, CODE GENERATOR, ABSTRACT SYNTAX TO C++, NAME-CHECKING MISMATCH: redundant inner type name ' . q{'}
                . $property_name . q{'}
                . ' does not equal OO properties key ' . q{'}
                . $property_key . q{'}
                . ', dying' . "\n";
        }
        if ((exists $perlapinames_generated::FUNCTIONS_DOCUMENTED->{$property_name}) or
            (exists $perlapinames_generated::FUNCTIONS_UNDOCUMENTED->{$property_name}) or
            (exists $perlapinames_generated::VARIABLES_DOCUMENTED->{$property_name}) or
            (exists $perlapinames_generated::VARIABLES_UNDOCUMENTED->{$property_name})) {
            die 'ERROR ECOGEASCP41, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Perl API name conflict, OO property name ' . q{'}
                . $property_name . q{'}
                . ' is the same as a protected function or variable name in the Perl API, please choose a different name, dying' . "\n";
        }

        # TypeInnerProperties -> MY Type '$TYPED_' WORD OP19_VARIABLE_ASSIGN SubExpression
        if ( ref $property_type_inner eq 'TypeInnerProperties_244' ) {
            $property_type          = $property_type_inner->{children}->[1]->{children}->[0];
            $property_subexpression = $property_type_inner->{children}->[5];
        }

        # TypeInnerProperties -> MY Type '$TYPED_' WORD OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef'
        elsif ( ref $property_type_inner eq 'TypeInnerProperties_245' ) {
            $property_type               = $property_type_inner->{children}->[1]->{children}->[0];
            $property_arrayref_index_max = $property_type_inner->{children}->[5];
        }
        else {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                    . ( ref $self )
                    . ' found where TypeInnerProperties_244 or TypeInnerProperties_245 expected, dying' )
                . "\n";
        }

#        RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), property 0, have $property_key = ' . "\n" . RPerl::Parser::rperl_ast__dump($property_key) . "\n" );
#        RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), property 0, have $property_type_inner = ' . "\n" . RPerl::Parser::rperl_ast__dump($property_type_inner) . "\n" );
#        RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), property 0, have $property_subexpression = ' . "\n" . RPerl::Parser::rperl_ast__dump($property_subexpression) . "\n" );
#        RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), property 0, have $property_type = ' . "\n" . RPerl::Parser::rperl_ast__dump($property_type) . "\n" );
#        RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), property 0, have $property_arrayref_index_max = ' . "\n" . RPerl::Parser::rperl_ast__dump($property_arrayref_index_max) . "\n" );

        # CREATE SYMBOL TABLE ENTRY
        if ( exists $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{_properties}->{$property_key} ) {
            die 'ERROR ECOGEASCP10, CODE GENERATOR, ABSTRACT SYNTAX TO C++: OO property '
                . q{'} . $property_key . q{'}
                . ' already declared in this scope, namespace '
                . q{'} . $modes->{_symbol_table}->{_namespace} . q{'}
                . ', dying' . "\n";
        }

#        RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), property 0, have $parent_package_names = ' . "\n" . Dumper($parent_package_names) . "\n" ) if (scalar @{$parent_package_names});

        # disallow name masking of inherited $properties, causes mismatching behavior in PERLOPS_PERLTYPES vs CPPOPS_CPPTYPES
        foreach my $parent_package_name (@{$parent_package_names}) {
            if ( exists $modes->{_symbol_table}->{ $parent_package_name . q{::} }->{_properties}->{$property_key} ) {
                die 'ERROR ECOGEASCP11, CODE GENERATOR, ABSTRACT SYNTAX TO C++: OO property '
                    . q{'} . $property_key . q{'}
                    . ' already declared in parent namespace '
                    . q{'} . $parent_package_name . q{::} . q{'}
                    . ', name masking disallowed, dying' . "\n";
            }
        }

        $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{_properties}->{$property_key}
            = { isa => 'RPerl::DataStructure::Hash::Properties', type => $property_type };

        $property_type = RPerl::Generator::type_convert_perl_to_cpp( $property_type, 1 );    # $pointerify_classes = 1
        $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{_properties}->{$property_key}->{type_cpp} = $property_type; # add converted C++ type to symtab entry

        if ( defined $property_arrayref_index_max ) {
            my string $property_arrayref_index_max_address = "$property_arrayref_index_max";
            $property_arrayref_index_max = RPerl::Generator::arrayref_convert_index_max_to_size($property_arrayref_index_max);
            $cpp_source_subgroup         = $property_arrayref_index_max->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            if ( $property_arrayref_index_max_address eq "$property_arrayref_index_max" ) {    # not compensated automatically, must compensate manually
                $cpp_source_subgroup->{CPP} = q{(} . $cpp_source_subgroup->{CPP} . q{) + 1};
            }
            push @{$properties_initializations}, ( q{        } . 'this->' . $property_key . '.resize(' . $cpp_source_subgroup->{CPP} . ');' );
        }

        $property_declaration = q{    } . $property_type . q{ } . $property_key;

        # SubExpression_156 ISA RPerl::Operation::Expression::SubExpression::Literal::Undefined,
        # don't perform any C++ initialization for properties initialized to 'undef' in Perl
        if ( ( defined $property_subexpression ) and ( ( ref $property_subexpression ) ne 'SubExpression_156' ) ) {
            $cpp_source_subgroup = $property_subexpression->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            $property_declaration .= ' = ' . $cpp_source_subgroup->{CPP};
        }

        $property_declaration .= ';';
        push @{$properties_declarations}, $property_declaration;

        $cpp_source_subgroup = ast_to_cpp__generate_accessors_mutators_initializers__CPPOPS_CPPTYPES( $property_key, $modes->{_symbol_table}->{_namespace}, $package_name_underscores, 0, $modes );  # $is_inherited = 0
        if ( $cpp_source_subgroup->{H} ne q{} ) {
            push @{$properties_accessors_mutators}, $cpp_source_subgroup->{H};
        }
        if ( $cpp_source_subgroup->{_H_initializers} ne q{} ) {
            push @{$properties_initializers}, $cpp_source_subgroup->{_H_initializers};
        }
        if ((exists $cpp_source_subgroup->{PMC}) and (defined $cpp_source_subgroup->{PMC}) and ($cpp_source_subgroup->{PMC} ne q{})) {
            push @{$properties_accessors_mutators_shims}, $cpp_source_subgroup->{PMC};
        }

        my integer $i = 0;
        foreach my object $property ( @{ $properties_1_to_n->{children} } ) {
            if ( ( ref $property ) eq 'TERMINAL' ) {    # skip comma between properties
                next;
            }
            $i++;

            $property_subexpression      = undef;
            $property_arrayref_index_max = undef;

            $property_key = $property->{children}->[0]->{children}->[0];
            $property_key =~ s/^(\w+)\s*$/$1/gxms;      # strip trailing whitespace, caused by grammar matching operator names with trailing spaces









# DEV NOTE, CORRELATION #rp045: identifiers containing underscores may be reserved by C++
=DISABLE_NEED_ANSWER
            if ( $property_key !~ /^[a-z]/ ) {
                die 'ERROR ECOGEASCP24, CODE GENERATOR, ABSTRACT SYNTAX TO C++: invalid OO properties name (hash key) ' . q{'}
                    . $property_key . q{'}
                    . ' does not start with a lowercase letter a-z, dying' . "\n";
            }
=cut







            $property_type_inner = $property->{children}->[2];
            $property_name       = $property_type_inner->{children}->[3]->{children}->[0];
            $property_name =~ s/^(\w+)\s*$/$1/gxms;     # strip trailing whitespace, caused by grammar matching operator names with trailing spaces

            # DEV NOTE: we can do error checking once here instead of twice for TypeInnerProperties_244 & TypeInnerProperties_245 below
            # because they both have OpStringOrWord as sub-element 3, grabbed as $property_name above
            if ( $property_name ne $property_key ) {
                die 'ERROR ECOGEASCP21, CODE GENERATOR, ABSTRACT SYNTAX TO C++, NAME-CHECKING MISMATCH: redundant inner type name ' . q{'}
                    . $property_name . q{'}
                    . ' does not equal OO properties key ' . q{'}
                    . $property_key . q{'}
                    . ', dying' . "\n";
            }
            if ((exists $perlapinames_generated::FUNCTIONS_DOCUMENTED->{$property_name}) or
                (exists $perlapinames_generated::FUNCTIONS_UNDOCUMENTED->{$property_name}) or
                (exists $perlapinames_generated::VARIABLES_DOCUMENTED->{$property_name}) or
                (exists $perlapinames_generated::VARIABLES_UNDOCUMENTED->{$property_name})) {
                die 'ERROR ECOGEASCP41, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Perl API name conflict, OO property name ' . q{'}
                    . $property_name . q{'}
                    . ' is the same as a protected function or variable name in the Perl API, please choose a different name, dying' . "\n";
            }

            # TypeInnerProperties -> MY Type '$TYPED_' WORD OP19_VARIABLE_ASSIGN SubExpression
            if ( ref $property_type_inner eq 'TypeInnerProperties_244' ) {
                $property_type          = $property_type_inner->{children}->[1]->{children}->[0];
                $property_subexpression = $property_type_inner->{children}->[5];
            }

            # TypeInnerProperties -> MY Type '$TYPED_' WORD OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef'
            elsif ( ref $property_type_inner eq 'TypeInnerProperties_245' ) {
                $property_type               = $property_type_inner->{children}->[1]->{children}->[0];
                $property_arrayref_index_max = $property_type_inner->{children}->[5];
            }
            else {
                die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                        . ( ref $self )
                        . ' found where TypeInnerProperties_244 or TypeInnerProperties_245 expected, dying' )
                    . "\n";
            }

#            RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), property ' . $i . ', have $property_key = ' . "\n" . RPerl::Parser::rperl_ast__dump($property_key) . "\n" );
#            RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), property ' . $i . ', have $property_type_inner = ' . "\n" . RPerl::Parser::rperl_ast__dump($property_type_inner) . "\n" );
#            RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), property ' . $i . ', have $property_subexpression = ' . "\n" . RPerl::Parser::rperl_ast__dump($property_subexpression) . "\n" );
#            RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), property ' . $i . ', have $property_type = ' . "\n" . RPerl::Parser::rperl_ast__dump($property_type) . "\n" );
#            RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), property ' . $i . ', have $property_arrayref_index_max = ' . "\n" . RPerl::Parser::rperl_ast__dump($property_arrayref_index_max) . "\n" );

            # CREATE SYMBOL TABLE ENTRY
            if ( exists $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{_properties}->{$property_key} ) {
                die 'ERROR ECOGEASCP10, CODE GENERATOR, ABSTRACT SYNTAX TO C++: OO property '
                    . $property_key
                    . ' already declared in this scope, namespace '
                    . $modes->{_symbol_table}->{_namespace}
                    . ', dying' . "\n";
            }

#            RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), property ' . $i . ', have $parent_package_names = ' . "\n" . Dumper($parent_package_names) . "\n" ) if (scalar @{$parent_package_names});
    
            # disallow name masking of inherited $properties, causes mismatching behavior in PERLOPS_PERLTYPES vs CPPOPS_CPPTYPES
            foreach my $parent_package_name (@{$parent_package_names}) {
                if ( exists $modes->{_symbol_table}->{ $parent_package_name . q{::} }->{_properties}->{$property_key} ) {
                    die 'ERROR ECOGEASCP11, CODE GENERATOR, ABSTRACT SYNTAX TO C++: OO property '
                        . q{'} . $property_key . q{'}
                        . ' already declared in parent namespace '
                        . q{'} . $parent_package_name . q{::} . q{'}
                        . ', name masking disallowed, dying' . "\n";
                }
            }

            $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{_properties}->{$property_key}
                = { isa => 'RPerl::DataStructure::Hash::Properties', type => $property_type };

            $property_type = RPerl::Generator::type_convert_perl_to_cpp( $property_type, 1 );    # $pointerify_classes = 1
            $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{_properties}->{$property_key}->{type_cpp} = $property_type; # add converted C++ type to symtab entry

            if ( defined $property_arrayref_index_max ) {
                my string $property_arrayref_index_max_address = "$property_arrayref_index_max";
                $property_arrayref_index_max = RPerl::Generator::arrayref_convert_index_max_to_size($property_arrayref_index_max);
                $cpp_source_subgroup         = $property_arrayref_index_max->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
                if ( $property_arrayref_index_max_address eq "$property_arrayref_index_max" ) {    # not compensated automatically, must compensate manually
                    $cpp_source_subgroup->{CPP} = q{(} . $cpp_source_subgroup->{CPP} . q{) + 1};
                }
                push @{$properties_initializations}, ( q{        } . 'this->' . $property_key . '.resize(' . $cpp_source_subgroup->{CPP} . ');' );
            }

            $property_declaration = q{    } . $property_type . q{ } . $property_key;

            # SubExpression_156 ISA RPerl::Operation::Expression::SubExpression::Literal::Undefined,
            # don't perform any C++ initialization for properties initialized to 'undef' in Perl
            if ( ( defined $property_subexpression ) and ( ( ref $property_subexpression ) ne 'SubExpression_156' ) ) {
                $cpp_source_subgroup = $property_subexpression->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
                $property_declaration .= ' = ' . $cpp_source_subgroup->{CPP};
            }

            $property_declaration .= ';';
            push @{$properties_declarations}, $property_declaration;

            $cpp_source_subgroup = ast_to_cpp__generate_accessors_mutators_initializers__CPPOPS_CPPTYPES( $property_key, $modes->{_symbol_table}->{_namespace}, $package_name_underscores, 0, $modes );  # $is_inherited = 0
            if ( $cpp_source_subgroup->{H} ne q{} ) {
                push @{$properties_accessors_mutators}, $cpp_source_subgroup->{H};
            }
            if ( $cpp_source_subgroup->{_H_initializers} ne q{} ) {
                push @{$properties_initializers}, $cpp_source_subgroup->{_H_initializers};
            }
            if ((exists $cpp_source_subgroup->{PMC}) and (defined $cpp_source_subgroup->{PMC}) and ($cpp_source_subgroup->{PMC} ne q{})) {
                push @{$properties_accessors_mutators_shims}, $cpp_source_subgroup->{PMC};
            }
        }
        delete $modes->{_inside_class_properties};
    }







    # generate accessors & mutators for inherited $properties
    foreach my $parent_package_name (@{$parent_package_names}) {
#        RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $parent_package_name = ' . $parent_package_name . "\n" );
#        RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modes->{_symbol_table}->{ $parent_package_name . q{::} } = ' . Dumper($modes->{_symbol_table}->{ $parent_package_name . q{::} }) . "\n" );
        foreach my $parent_property_key (keys %{ $modes->{_symbol_table}->{ $parent_package_name . q{::} }->{_properties} }) {
            if (not exists $modes->{_symbol_table}->{ $package_name_colons . q{::} }->{_properties}->{$parent_property_key}) {
                $cpp_source_subgroup = ast_to_cpp__generate_accessors_mutators_initializers__CPPOPS_CPPTYPES( $parent_property_key, $parent_package_name . q{::}, $package_name_underscores, 1, $modes );  # $is_inherited = 1
                if ( $cpp_source_subgroup->{H} ne q{} ) {
                    push @{$properties_accessors_mutators}, $cpp_source_subgroup->{H};
                }
                if ( $cpp_source_subgroup->{_H_initializers} ne q{} ) {
                    push @{$properties_initializers}, $cpp_source_subgroup->{_H_initializers};
                }
                if ((exists $cpp_source_subgroup->{PMC}) and (defined $cpp_source_subgroup->{PMC}) and ($cpp_source_subgroup->{PMC} ne q{})) {
                    push @{$properties_accessors_mutators_shims}, $cpp_source_subgroup->{PMC};
                }
            }
        }
    }








    if ( exists $properties_declarations->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $cpp_source_group->{H} .= '    // [[[ OO PROPERTIES ]]]' . "\n";
        }
        $cpp_source_group->{H} .= ( join "\n", @{$properties_declarations} ) . "\n\n";
    }

    if ( $modes->{label} eq 'ON' ) {
        $cpp_source_group->{H} .= '    // [[[ OO METHODS ]]]' . "\n\n";
    }

    if ( exists $properties_accessors_mutators->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $cpp_source_group->{H} .= '    // <<< OO PROPERTIES, ACCESSORS & MUTATORS >>>' . "\n";
        }
        $cpp_source_group->{H} .= ( join "\n", @{$properties_accessors_mutators} ) . "\n\n";
    }

    if ( exists $properties_accessors_mutators_shims->[0] ) {
        if ( ( not exists $cpp_source_group->{_PMC_accessors_mutators_shims} ) or ( not defined $cpp_source_group->{_PMC_accessors_mutators_shims} ) ) {
            $cpp_source_group->{_PMC_accessors_mutators_shims} = {};
        }
        elsif (( not exists $cpp_source_group->{_PMC_accessors_mutators_shims}->{$package_name_underscores} )
            or ( not defined $cpp_source_group->{_PMC_accessors_mutators_shims}->{$package_name_underscores} ) )
        {
            $cpp_source_group->{_PMC_accessors_mutators_shims}->{$package_name_underscores} = q{};
        }
        $cpp_source_group->{_PMC_accessors_mutators_shims}->{$package_name_underscores} .= ( join "\n", @{$properties_accessors_mutators_shims} ) . "\n";
    }

    if ( $modes->{label} eq 'ON' ) {
        $cpp_source_group->{H} .= '    // <<< CONSTRUCTOR & DESTRUCTOR >>>' . "\n";
    }
    if ( exists $properties_initializations->[0] ) {    # initialize properties in constructor
        $cpp_source_group->{H} .= q{    } . $package_name_underscores . '() {' . "\n" . ( join "\n", @{$properties_initializations} ) . "\n" . '}' . "\n"; # CONSTRUCTOR
    }
    else {    # empty constructor
        $cpp_source_group->{H} .= q{    } . $package_name_underscores . '() {}' . "\n";    # CONSTRUCTOR
    }
    $cpp_source_group->{H} .= q{    } . '~' . $package_name_underscores . '() {}' . "\n\n";    # DESTRUCTOR

    if ( $modes->{label} eq 'ON' ) {
        $cpp_source_group->{H} .= '    // <<< CLASS NAME REPORTER >>>' . "\n";
    }
    my string $package_name_scoped = $package_name_underscores;
    $package_name_scoped =~ s/__/::/gxms;
    $cpp_source_group->{H} .= '    virtual string myclassname() { return (const string) "' . $package_name_scoped . '"; }' . "\n";    # CLASS NAME REPORTER

#    RPerl::diag('in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $cpp_source_group->{_H_constants_shims}->{$package_name_underscores} = ' . Dumper($cpp_source_group->{_H_constants_shims}->{$package_name_underscores}) . "\n");
    if (    ( exists $cpp_source_group->{_H_constants_shims} )
        and ( defined $cpp_source_group->{_H_constants_shims} )
        and ( exists $cpp_source_group->{_H_constants_shims}->{$package_name_underscores} )
        and ( defined $cpp_source_group->{_H_constants_shims}->{$package_name_underscores} ) )
    {
        $cpp_source_group->{H} .= "\n";
        if ( $modes->{label} eq 'ON' ) { $cpp_source_group->{H} .= '    // <<< CONSTANTS, SHIMS >>>' . "\n"; }
        $cpp_source_group->{H} .= $cpp_source_group->{_H_constants_shims}->{$package_name_underscores};
    }

    my string_arrayref $method_declarations     = [];
    my string_arrayref $method_definitions      = [];
    my string_arrayref $subroutine_declarations = [];
    my string_arrayref $subroutine_definitions  = [];
    my string_arrayref $PMC_subroutines_shims   = [];
    my string_arrayref $CPP_subroutines_shims   = [];

    foreach my object $method_or_subroutine ( ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        @{ $method_or_subroutine_star->{children} }
        )
    {
        if ( ( ref $method_or_subroutine ) eq 'SubroutineOrMethod_94' ) {    # METHOD
            $cpp_source_subgroup = $method_or_subroutine->ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES($modes);
            push @{$method_declarations}, $cpp_source_subgroup->{H};
            $cpp_source_subgroup = $method_or_subroutine->ast_to_cpp__generate__CPPOPS_CPPTYPES( $package_name_underscores, $modes );
            push @{$method_definitions}, $cpp_source_subgroup->{CPP};
            if ( ( exists $cpp_source_subgroup->{H_INCLUDES} ) and ( defined $cpp_source_subgroup->{H_INCLUDES} ) ) {
                $cpp_source_group->{H_INCLUDES} .= $cpp_source_subgroup->{H_INCLUDES};
            }
        }
        elsif ( ( ref $method_or_subroutine ) eq 'SubroutineOrMethod_93' ) {    # SUBROUTINE
            $cpp_source_subgroup = $method_or_subroutine->ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES($modes);
            push @{$subroutine_declarations}, $cpp_source_subgroup->{H};
            $cpp_source_subgroup = $method_or_subroutine->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            push @{$subroutine_definitions}, $cpp_source_subgroup->{CPP};
            $cpp_source_subgroup = $method_or_subroutine->ast_to_cpp__generate_shims__CPPOPS_CPPTYPES($modes);
            if ((exists $cpp_source_subgroup->{PMC}) and (defined $cpp_source_subgroup->{PMC})) {
                push @{$PMC_subroutines_shims}, $cpp_source_subgroup->{PMC};
            }
            push @{$CPP_subroutines_shims}, $cpp_source_subgroup->{CPP};
            if ( ( exists $cpp_source_subgroup->{H_INCLUDES} ) and ( defined $cpp_source_subgroup->{H_INCLUDES} ) ) {
                $cpp_source_group->{H_INCLUDES} .= $cpp_source_subgroup->{H_INCLUDES};
            }
        }
        else {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++, CPPOPS_CPPTYPES: Grammar rule '
                    . ( ref $method_or_subroutine )
                    . ' found where SubroutineOrMethod_94 or SubroutineOrMethod_93 expected, dying' )
                . "\n";
        }
    }

    if ( exists $method_declarations->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $cpp_source_group->{H} .= "\n" . '    // <<< USER-DEFINED METHODS >>>' . "\n";
        }
        $cpp_source_group->{H} .= ( join "\n", @{$method_declarations} ) . "\n";
    }

    if ( ( exists $method_definitions->[0] ) or ( exists $subroutine_definitions->[0] ) ) {
        if ( $modes->{label} eq 'ON' ) {
            $cpp_source_group->{CPP} .= '// [[[ SUBROUTINES & OO METHODS ]]]' . "\n\n";
        }
        $cpp_source_group->{CPP} .= ( join "\n\n", @{$method_definitions} );
        if ( exists $method_definitions->[0] ) { $cpp_source_group->{CPP} .= "\n\n"; }
        $cpp_source_group->{CPP} .= ( join "\n\n", @{$subroutine_definitions} );
        if ( exists $subroutine_definitions->[0] ) { $cpp_source_group->{CPP} .= "\n\n"; }
        if ( exists $PMC_subroutines_shims->[0] ) {
            if ( ( not exists $cpp_source_group->{_PMC_subroutines_shims} ) or ( not defined $cpp_source_group->{_PMC_subroutines_shims} ) ) {
                $cpp_source_group->{_PMC_subroutines_shims} = {};
            }
            elsif (( not exists $cpp_source_group->{_PMC_subroutines_shims}->{$package_name_underscores} )
                or ( not defined $cpp_source_group->{_PMC_subroutines_shims}->{$package_name_underscores} ) )
            {
                $cpp_source_group->{_PMC_subroutines_shims}->{$package_name_underscores} = q{};
            }
            $cpp_source_group->{_PMC_subroutines_shims}->{$package_name_underscores} .= ( join "\n", @{$PMC_subroutines_shims} ) . "\n";
        }
    }

    $cpp_source_group->{H} .= '};  // end of class' . "\n\n";

    if ( $modes->{label} eq 'ON' ) {
        $cpp_source_group->{H} .= '// [[[ OO SUBCLASSES ]]]' . "\n";
    }
    $cpp_source_group->{H} .= '#define ' . $package_name_underscores . '_rawptr ' . $package_name_underscores . '*' . "\n";
    $cpp_source_group->{H} .= 'typedef std::unique_ptr<' . $package_name_underscores . '> ' . $package_name_underscores . '_ptr;' . "\n";
    $cpp_source_group->{H} .= 'typedef std::vector<' . $package_name_underscores . '_ptr> ' . $package_name_underscores . '_arrayref;' . "\n";
    $cpp_source_group->{H} .= 'typedef std::unordered_map<string, ' . $package_name_underscores . '_ptr> ' . $package_name_underscores . '_hashref;' . "\n";
    $cpp_source_group->{H}
        .= 'typedef std::unordered_map<string, ' . $package_name_underscores . '_ptr>::iterator ' . $package_name_underscores . '_hashref_iterator;' . "\n\n";

    if ( $modes->{label} eq 'ON' ) {
        $cpp_source_group->{H} .= '// [[[ OO CONSTRUCTOR WRAPPER CLASS ]]]' . "\n";
    }

    $cpp_source_group->{H} .= 'class NEW_' . $package_name_underscores . ' {' . "\n";
    $cpp_source_group->{H} .= 'public:' . "\n";
    $cpp_source_group->{H} .= q{    } . $package_name_underscores . '_ptr wrapped_object;' . "\n";
    $cpp_source_group->{H} .= q{    } . 'NEW_' . $package_name_underscores . '() : wrapped_object{new ' . $package_name_underscores . '()} {}' . "\n";
    $cpp_source_group->{H} .= q{    } . $package_name_underscores . '_ptr&& NEW() { return std::move(wrapped_object); }' . "\n\n";

    if ( exists $properties_initializers->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $cpp_source_group->{H} .= '    // <<< OO PROPERTIES, INITIALIZERS >>>' . "\n";
        }
        $cpp_source_group->{H} .= ( join "\n", @{$properties_initializers} ) . "\n";
    }

    $cpp_source_group->{H} .= '};' . "\n\n";

=HARDCODED_EXAMPLE
// [[[ OO CONSTRUCTOR WRAPPER CLASS ]]]
class NEW_MyClass02LowRPerlNew {
public:
    MyClass02LowRPerlNew_ptr wrapped_object;
    NEW_MyClass02LowRPerlNew() : wrapped_object{new MyClass02LowRPerlNew()} {}
    MyClass02LowRPerlNew_ptr&& NEW() { return std::move(wrapped_object); }

    // <<< OO PROPERTIES, INITIALIZERS >>>
    NEW_MyClass02LowRPerlNew& bar(integer bar_init) { wrapped_object->bar = bar_init; return *this; }
};
=cut

    if ( exists $subroutine_declarations->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $cpp_source_group->{H} .= '// [[[ SUBROUTINES ]]]' . "\n";
        }
        $cpp_source_group->{H} .= ( join "\n", @{$subroutine_declarations} ) . "\n\n";
        if ( $modes->{label} eq 'ON' ) {
            $cpp_source_group->{H} .= '// <<< SHIM MACROS >>>' . "\n";
        }
        $cpp_source_group->{H} .= ( join "\n", @{$CPP_subroutines_shims} ) . "\n\n";
    }

    if ( $modes->{label} eq 'ON' ) {
        $cpp_source_group->{H} .= '// <<< OPERATIONS & DATA TYPES REPORTER >>>' . "\n";
    }
    $cpp_source_group->{H} .= 'integer ' . $package_name_underscores . '__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2' . "\n\n";

    if ( $modes->{label} eq 'ON' ) {
        $cpp_source_tmp = ( ( '// [[[<<< END CPP TYPES >>>]]]' . "\n" ) x 3 ) . "\n";
        $cpp_source_group->{H}   .= $cpp_source_tmp;
        $cpp_source_group->{CPP} .= $cpp_source_tmp;
    }

    $cpp_source_tmp = <<EOL;
# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# endif

EOL

    $cpp_source_group->{H}   .= $cpp_source_tmp;
    $cpp_source_group->{CPP} .= $cpp_source_tmp;

    # deferred, prepend possibly-updated H_INCLUDES to H, discarding duplicates
    my string $H_INCLUDES_UNIQUE = '';
    foreach my string $H_INCLUDE ( split /\n/, $cpp_source_group->{H_INCLUDES} ) {
        if ( $H_INCLUDES_UNIQUE !~ /$H_INCLUDE/ ) {
            $H_INCLUDES_UNIQUE .= $H_INCLUDE . "\n";
        }
    }
    $cpp_source_group->{H} = $H_INCLUDES_UNIQUE . $cpp_source_group->{H};
    delete $cpp_source_group->{H_INCLUDES};

#    RPerl::diag( "\n" . 'in Class::Generator::ast_to_cpp__generate__CPPOPS_CPPTYPES(), returning $cpp_source_group = ' . "\n" . Dumper($cpp_source_group) . "\n" );

    return $cpp_source_group;
}

# generate accessors/mutators
sub ast_to_cpp__generate_accessors_mutators_initializers__CPPOPS_CPPTYPES {
    { my string_hashref $RETURN_TYPE };
    ( my string $property_key, my string $namespace_from, my string $package_name_underscores, my boolean $is_inherited, my string_hashref $modes ) = @ARG;
    my string_hashref $cpp_source_group = { H => q{}, _H_initializers => q{} };

#    RPerl::diag( "\n" . 'in Class::Generator::ast_to_cpp__generate_accessors_mutators_initializers__CPPOPS_CPPTYPES(), received $modes = ' . "\n" . Dumper($modes) . "\n" );

    # grab RPerl-style type out of symtab, instead of accepting-as-arg now-C++-style type from $property_type in caller
#    my string $property_type = $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{_properties}->{$property_key}->{type};
    my string $property_type = $modes->{_symbol_table}->{ $namespace_from }->{_properties}->{$property_key}->{type};
    my boolean $is_direct    = 0;
    my $property_element_or_value_type;

    # array element accessors/mutators
    if ( $property_type =~ /_arrayref$/ ) {
        $property_element_or_value_type = substr $property_type, 0, ( ( length $property_type ) - 9 );    # strip trailing '_arrayref'
        if ( exists $rperlnamespaces_generated::RPERL->{ $property_element_or_value_type . '::' } ) {

            # arrayref of RPerl data types
            if ( ( $property_element_or_value_type eq 'object' ) or ( $property_element_or_value_type eq 'hashref' ) ) {

                # arrayref of objects or hashrefs (same as Perl object which is a blessed hashref), set address, return void
                $is_direct = 0;
            }
            elsif ( $property_element_or_value_type eq 'arrayref' ) {

                # arrayref of arrayrefs, set address, return void
                $is_direct = 0;
            }
            else {
                # arrayref of scalars, return value
                $is_direct = 1;
            }
        }
        else {
            # arrayref of user-defined data types (objects), set address, return void
            $is_direct = 0;
        }
    }

    # hash value accessors/mutators
    elsif ( $property_type =~ /_hashref$/ ) {
        $property_element_or_value_type = substr $property_type, 0, ( ( length $property_type ) - 8 );    # strip trailing '_hashref'
        if ( exists $rperlnamespaces_generated::RPERL->{ $property_element_or_value_type . '::' } ) {

            # hashref of RPerl data types
            if ( ( $property_element_or_value_type eq 'object' ) or ( $property_element_or_value_type eq 'hashref' ) ) {

                # hashref of objects or hashrefs (same as Perl object which is a blessed hashref), set address, return void
                $is_direct = 0;
            }
            elsif ( $property_element_or_value_type eq 'arrayref' ) {

                # hashref of arrayrefs, set address, return void
                $is_direct = 0;
            }
            else {
                # hashref of scalars, return value
                $is_direct = 1;
            }
        }
        else {
            # hashref of user-defined data types (objects), set address, return void
            $is_direct = 0;
        }
    }

    # scalar accessors/mutators, return value
    else {
        $is_direct = 1;
    }

    if ($is_direct) {
        my string $inherited_comment = q{};
        if ($is_inherited) { $inherited_comment = '  // inherited from ' . $namespace_from; }

        # disabled unnecessary usage of 'this->'
#        $cpp_source_group->{H} = $property_type . ' get_' . $property_key . '() { return this->' . $property_key . '; }' . "\n";
#        $cpp_source_group->{H} .= 'void set_' . $property_key . '(' . $property_type . q{ } . $property_key . '_new) { this->' . $property_key . ' = ' . $property_key . '_new; }';

        $cpp_source_group->{H} = q{    } . $property_type . ' get_' . $property_key . '() { return ' . $property_key . '; }' . $inherited_comment . "\n";
        $cpp_source_group->{H} .= q{    } . 'void set_' . $property_key . '(' . $property_type . q{ } . $property_key . '_new) { ' . $property_key . ' = ' . $property_key . '_new; }' . $inherited_comment;

        # HARD-CODED EXAMPLE
        # NEW_MyClass02LowRPerlNew& bar(integer bar_init) { wrapped_object->bar = bar_init; return *this; }
        $cpp_source_group->{_H_initializers} .= q{    } . 'NEW_' . $package_name_underscores . '& ' . $property_key . '(' . $property_type . q{ } . $property_key . 
                                                '_init) { wrapped_object->' . $property_key . ' = ' . $property_key . '_init; return *this; }' . $inherited_comment;
    }
    # NEED UPDATE: remove unnecessary usage of 'this->' below
    else {
# HARD-CODED EXAMPLE:
#integer get_bodies_size() { return this->bodies.size(); }  // call from Perl or C++
#string_arrayref get_bodies_keys() { string_arrayref keys; keys.reserve(this->keys.size()); for(auto hash_entry : this->bodies) { keys.push_back(hash_entry.first); } }  // call from Perl or C++
#PhysicsPerl__Astro__Body_ptr& get_bodies_element(integer i) { return this->bodies[i]; }  // call from C++
#void get_bodies_element_indirect(integer i, PhysicsPerl__Astro__Body_rawptr bodies_element_rawptr) { *bodies_element_rawptr = *(this->bodies[i].get_raw()); }  // call from Perl shim
#void set_bodies_element(integer i, PhysicsPerl__Astro__Body_ptr& bodies_element_ptr) { *(this->bodies[i].get_raw()) = *(bodies_element_ptr.get_raw()); }  // call from C++
#void set_bodies_element(integer i, PhysicsPerl__Astro__Body_rawptr bodies_element_rawptr) { *(this->bodies[i].get_raw()) = *bodies_element_rawptr; }  // call from Perl
#sub get_bodies_element {
#    ( my PhysicsPerl::Astro::System $self, my integer $i ) = @ARG;
#    my PhysicsPerl::Astro::Body $bodies_element = PhysicsPerl::Astro::Body->new();
#    $self->get_bodies_element_indirect($i, $bodies_element);
#    return $bodies_element;
#}

        my string $property_element_or_value_type_cpp_nopointerify = RPerl::Generator::type_convert_perl_to_cpp( $property_element_or_value_type, 0 ); # $pointerify_classes = 0

        # C++ code
        if ( $property_type =~ /_arrayref$/ ) {
            $cpp_source_group->{H} = 'integer get_' . $property_key . '_size() { return this->' . $property_key . '.size(); }  // call from Perl or C++' . "\n";
        }
        elsif ( $property_type =~ /_hashref$/ ) {
            $cpp_source_group->{H}
                = 'string_arrayref get_'
                . $property_key
                . '_keys() { string_arrayref keys; keys.reserve(this->'
                . $property_key
                . '.size()); for(auto hash_entry : this->'
                . $property_key
                . ') { keys.push_back(hash_entry.first); } }  // call from Perl or C++' . "\n";
        }
        $cpp_source_group->{H}
            .= $property_element_or_value_type_cpp_nopointerify
            . '_ptr& get_'
            . $property_key
            . '_element(integer i) { return this->'
            . $property_key
            . '[i]; }  // call from C++' . "\n";
        $cpp_source_group->{H}
            .= 'void get_'
            . $property_key
            . '_element_indirect(integer i, '
            . $property_element_or_value_type_cpp_nopointerify
            . '_rawptr '
            . $property_key
            . '_element_rawptr) { *'
            . $property_key
            . '_element_rawptr = *(this->'
            . $property_key
            . '[i].get_raw()); }  // call from Perl shim' . "\n";
        $cpp_source_group->{H}
            .= 'void set_'
            . $property_key
            . '_element(integer i, '
            . $property_element_or_value_type_cpp_nopointerify
            . '_ptr& '
            . $property_key
            . '_element_ptr) { *(this->'
            . $property_key
            . '[i].get_raw()) = *('
            . $property_key
            . '_element_ptr.get_raw()); }  // call from C++' . "\n";
        $cpp_source_group->{H}
            .= 'void set_'
            . $property_key
            . '_element(integer i, '
            . $property_element_or_value_type_cpp_nopointerify
            . '_rawptr '
            . $property_key
            . '_element_rawptr) { *(this->'
            . $property_key
            . '[i].get_raw()) = *'
            . $property_key
            . '_element_rawptr; }  // call from Perl';

#        RPerl::diag( "\n" . 'in Class::Generator::ast_to_cpp__generate_accessors_mutators_initializers__CPPOPS_CPPTYPES(), have $modes->{subcompile} = ' . "\n" . $modes->{subcompile} . "\n" );

        # DEV NOTE: only generate PMC output file in dynamic (default) subcompile mode
        if ($modes->{subcompile} eq 'DYNAMIC') {
#            RPerl::diag( 'in Class::Generator::ast_to_cpp__generate_accessors_mutators_initializers__CPPOPS_CPPTYPES(), YES PMC SHIMS' . "\n" );
            # Perl shim code
            # DEV NOTE: must create return variable object in Perl so it will be memory-managed by Perl,
            # and not wrongly destructed or double-destructed by Perl garbage collector and/or C++ memory.h,
            # even though Perl object contents will be replaced by C++ memory address, TRICKY!
            # HARD-CODED EXAMPLE:
            # undef &PhysicsPerl::Astro::System::get_bodies_element;
            # *PhysicsPerl::Astro::System::get_bodies_element = sub { ... };

#            $cpp_source_group->{PMC} = 'sub get_' . $property_key . '_element {' . "\n";  # DEV NOTE: use alternate syntax to avoid "subroutine redefined" errors
            $cpp_source_group->{PMC} = 'undef &' . $modes->{_symbol_table}->{_namespace} . 'get_' . $property_key . '_element;' . "\n";
            $cpp_source_group->{PMC} .= '*' . $modes->{_symbol_table}->{_namespace} . 'get_' . $property_key . '_element = sub {' . "\n";
            $cpp_source_group->{PMC}
                .= '( my '
                . ( substr $modes->{_symbol_table}->{_namespace}, 0, ( ( length $modes->{_symbol_table}->{_namespace} ) - 2 ) )
                . ' $self, my integer $i ) = @ARG;' . "\n";
            $cpp_source_group->{PMC}
                .= 'my ' . $property_element_or_value_type . ' $' . $property_key . '_element = ' . $property_element_or_value_type . '->new();' . "\n";
            $cpp_source_group->{PMC} .= '$self->get_' . $property_key . '_element_indirect($i, $' . $property_key . '_element);' . "\n";
            $cpp_source_group->{PMC} .= 'return $' . $property_key . '_element;' . "\n";
#            $cpp_source_group->{PMC} .= '}';  # DEV NOTE: use alternate syntax to avoid "subroutine redefined" errors
            $cpp_source_group->{PMC} .= '};';
        }
#        else { RPerl::diag( 'in Class::Generator::ast_to_cpp__generate_accessors_mutators_initializers__CPPOPS_CPPTYPES(), NO PMC SHIMS' . "\n" ); }

#            RPerl::diag( 'in Class::Generator::ast_to_cpp__generate_accessors_mutators_initializers__CPPOPS_CPPTYPES(), have $cpp_source_group->{H} = ' . "\n" . $cpp_source_group->{H} . "\n" );
    }
    return $cpp_source_group;
}

1;    # end of class

