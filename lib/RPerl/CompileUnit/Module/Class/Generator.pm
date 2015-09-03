# [[[ HEADER ]]]
package RPerl::CompileUnit::Module::Class::Generator;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_510;

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

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref::method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes ) = @_;
    my string_hashref $rperl_source_group = {};

    #    RPerl::diag( 'in Class::Generator->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    # unwrap Class_63 from Module_25
    if ( ($self_class) eq 'Module_25' ) {
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( ($self_class) ne 'Class_63' ) {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . ($self_class)
                . ' found where Module_25 or Class_63 expected, dying' )
            . "\n";
    }

    # Class:   'use parent qw(' WordScoped ')' ';' Include Critic* Include* Constant* Properties MethodOrSubroutine* LITERAL_NUMBER ';' ;
    # Class -> 'use parent qw(' WordScoped ')' ';' Include STAR-20 STAR-21  STAR-22   Properties STAR-23             LITERAL_NUMBER ';'
    my string $use_parent_qw_keyword     = $self->{children}->[0];
    my string $parent_name               = $self->{children}->[1]->{children}->[0];
    my string $right_parenthesis         = $self->{children}->[2];
    my string $use_parent_semicolon      = $self->{children}->[3];
    my object $parent_include            = $self->{children}->[4];
    my object $critic_star               = $self->{children}->[5];
    my object $include_star              = $self->{children}->[6];
    my object $constant_star             = $self->{children}->[7];
    my object $properties                = $self->{children}->[8];
    my object $method_or_subroutine_star = $self->{children}->[9];
    my string $retval_literal_number     = $self->{children}->[10];
    my string $retval_semicolon          = $self->{children}->[11];

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

    if ( exists $include_star->{children}->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $rperl_source_group->{PMC} .= "\n" . '# [[[ INCLUDES ]]]' . "\n";
        }
    }
    foreach my object $include ( @{ $include_star->{children} } ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        $rperl_source_subgroup = $include->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }

    if ( exists $constant_star->{children}->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $rperl_source_group->{PMC} .= "\n" . '# [[[ CONSTANTS ]]]' . "\n";
        }
    }
    foreach my object $constant ( @{ $constant_star->{children} } ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        $rperl_source_subgroup = $constant->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }

    if ( $modes->{label} eq 'ON' ) {
        $rperl_source_group->{PMC} .= "\n" . '# [[[ OO PROPERTIES ]]]' . "\n";
    }
    if ( ref $properties eq 'Properties_67' ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
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

        $property_key        = $property_0->{children}->[0];
        $property_fat_arrow  = $property_0->{children}->[1];
        $property_type_inner = $property_0->{children}->[2];
        $property_name       = $property_type_inner->{children}->[3];

        if ($property_name !~ /$property_key$/xms) {
            die 'ERROR ECVGEASRP17, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: redundant name mismatch, inner type name ' . q{'}
                . $property_name . q{'} . ' does not end with OO properties key ' . q{'} . $property_key . q{'} . ', dying' . "\n";
        }

        # TypeInnerProperties -> MY Type '$TYPED_' WORD OP19_VARIABLE_ASSIGN SubExpression
        if ( ref $property_type_inner eq 'TypeInnerProperties_221' ) {
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
        elsif ( ref $property_type_inner eq 'TypeInnerProperties_222' ) {
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
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: grammar rule '
                    . ( ref $self )
                    . ' found where TypeInnerProperties_221 or TypeInnerProperties_222 expected, dying' )
                . "\n";
        }

        foreach my object $property ( @{ $properties_1_to_n->{children} } ) {
            if ( ( ref $property ) eq 'TERMINAL' ) {
                $rperl_source_group->{PMC} .= $property->{attr};    # comma between properties
            }
            else {
                $property_key        = $property->{children}->[0];
                $property_fat_arrow  = $property->{children}->[1];
                $property_type_inner = $property->{children}->[2];
                $property_name       = $property_type_inner->{children}->[3];

                if ($property_name !~ /$property_key$/xms) {
                    die 'ERROR ECVGEASRP17, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: redundant name mismatch, inner type name ' . q{'}
                        . $property_name . q{'} . ' does not end with OO properties key ' . q{'} . $property_key . q{'} . ', dying' . "\n";
                }

                # TypeInnerProperties -> MY Type '$TYPED_' WORD OP19_VARIABLE_ASSIGN SubExpression
                if ( ref $property_type_inner eq 'TypeInnerProperties_221' ) {
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
                elsif ( ref $property_type_inner eq 'TypeInnerProperties_222' ) {
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
                    die RPerl::Parser::rperl_rule__replace( 'ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: grammar rule '
                            . ( ref $self )
                            . ' found where TypeInnerProperties_221 or TypeInnerProperties_222 expected, dying' )
                        . "\n";
                }
            }
        }
        $rperl_source_group->{PMC} .= "\n" . $properties_right_brace . $properties_semicolon . "\n";
    }
    else {           # Properties_68
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
            $rperl_source_group->{PMC} .= "\n" . '# [[[ OO METHODS & SUBROUTINES ]]]' . "\n\n";
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
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes ) = @_;
    my string_hashref $cpp_source_group = {
        CPP => q{// <<< RP::CU::M::C::G __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n",
        H   => q{// <<< RP::CU::M::C::G __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n",
        PMC => q{# <<< RP::CU::M::C::G __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n"
    };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string $package_name_underscores, my string_hashref $modes ) = @_;
    my string_hashref $cpp_source_group = { H_INCLUDES => q{}, H => q{}, CPP => q{} };

#RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $package_name_underscores = ' . $package_name_underscores . "\n");
#RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $modes = ' . "\n" . Dumper($modes) . "\n");
#    RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $modes->{_symbol_table} = ' . "\n" . Dumper($modes->{_symbol_table}) . "\n");

    my string $self_class = ref $self;

    # unwrap Class_63 from Module_25
    if ( ($self_class) eq 'Module_25' ) {
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( ($self_class) ne 'Class_63' ) {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++, CPPOPS_CPPTYPES: grammar rule '
                . ($self_class)
                . ' found where Module_25 or Class_63 expected, dying' )
            . "\n";
    }

    # Class:   'use parent qw(' WordScoped ')' ';' Include Critic* Include* Constant* Properties MethodOrSubroutine* LITERAL_NUMBER ';' ;
    # Class -> 'use parent qw(' WordScoped ')' ';' Include STAR-20 STAR-21  STAR-22   Properties STAR-23             LITERAL_NUMBER ';'
    my string $parent_name               = $self->{children}->[1]->{children}->[0];
    my object $include_star              = $self->{children}->[6];
    my object $constant_star             = $self->{children}->[7];
    my object $properties                = $self->{children}->[8];
    my object $method_or_subroutine_star = $self->{children}->[9];

    if ( $modes->{label} eq 'ON' ) {
        $cpp_source_group->{H_INCLUDES} .= '// [[[ INCLUDES & OO INHERITANCE INCLUDES ]]]' . "\n";
        $cpp_source_group->{CPP}        .= '// [[[ INCLUDES ]]]' . "\n";
    }

    $cpp_source_group->{H_INCLUDES} .= <<EOL;
#include <RPerl.cpp>  // -> RPerl.h -> (rperltypes_mode.h; rperltypes.h; HelperFunctions.cpp)
EOL

    # NEED FIX WIN32: change hard-coded forward-slash in generated path name below?
    # NEED FIX: handle absolute vs relative include paths
    my string $parent_name_path = $parent_name;
    $parent_name_path =~ s/::/\//gxms;
    $parent_name_path .= '.cpp';
    if ( ( ( substr $parent_name_path, 0, 5 ) ne 'RPerl' ) and ( ( substr $parent_name_path, 0, 5 ) ne 'rperl' ) ) {

        # non-RPerl user module, wrapped in double-quotes " " to denote user nature
        $cpp_source_group->{H_INCLUDES} .= '#include "' . $parent_name_path . '"' . "\n";
    }
    else {
        # RPerl system module, wrapped in angle-brackets < > to denote system nature
        $cpp_source_group->{H_INCLUDES} .= '#include <' . $parent_name_path . '>' . "\n";
    }
    $cpp_source_group->{CPP} .= '#include "__NEED_MODULE_HEADER_PATH"' . "\n";    # defer setting header include path until files are saved in Compiler

    my string_hashref $cpp_source_subgroup;

    foreach my object $include ( @{ $include_star->{children} } ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        $cpp_source_subgroup = $include->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
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
        }
        $cpp_source_group->{H} .= "\n";
    }

    if ( $modes->{label} eq 'ON' ) {
        $cpp_source_group->{H} .= '// [[[ OO INHERITANCE ]]]' . "\n";
    }
    my string $parent_name_underscores = $parent_name;
    $parent_name_underscores =~ s/::/__/gxms;

    #    RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $parent_name_underscores = ' . $parent_name_underscores . "\n");

    # DEV NOTE: avoid namespace clobbering of CPPOPS base class over PERLOPS base class
    if ( $parent_name_underscores eq 'RPerl__CompileUnit__Module__Class' ) {
        $parent_name_underscores .= '__CPP';
    }

    $cpp_source_group->{H} .= 'class ' . $package_name_underscores . ' : public ' . $parent_name_underscores . ' {' . "\n";
    $cpp_source_group->{H} .= 'public:' . "\n";

    my string_arrayref $properties_accessors_mutators       = [];
    my string_arrayref $properties_accessors_mutators_shims = [];
    my string_arrayref $properties_declarations             = [];
    my string_arrayref $properties_initializations          = [];
    my string $property_declaration;

    # non-empty $properties
    # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE HashEntryProperties STAR-27 '}' ';'
    # HashEntryProperties -> WORD OP20_HASH_FATARROW TypeInnerProperties
    if ( ref $properties eq 'Properties_67' ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        $property_declaration = q{};
        my object $property_0        = $properties->{children}->[3];
        my object $properties_1_to_n = $properties->{children}->[4];

        my string $property_key                = $property_0->{children}->[0];
        my object $property_type_inner         = $property_0->{children}->[2];
        my string $property_type               = undef;
        my object $property_subexpression      = undef;
        my object $property_arrayref_index_max = undef;

        # TypeInnerProperties -> MY Type '$TYPED_' WORD OP19_VARIABLE_ASSIGN SubExpression
        if ( ref $property_type_inner eq 'TypeInnerProperties_221' ) {
            $property_type          = $property_type_inner->{children}->[1]->{children}->[0];
            $property_subexpression = $property_type_inner->{children}->[5];
        }

        # TypeInnerProperties -> MY Type '$TYPED_' WORD OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef'
        elsif ( ref $property_type_inner eq 'TypeInnerProperties_222' ) {
            $property_type               = $property_type_inner->{children}->[1]->{children}->[0];
            $property_arrayref_index_max = $property_type_inner->{children}->[5];
        }
        else {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: grammar rule '
                    . ( ref $self )
                    . ' found where TypeInnerProperties_221 or TypeInnerProperties_222 expected, dying' )
                . "\n";
        }

#        RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), property 0, have $property_key = ' . "\n" . RPerl::Parser::rperl_ast__dump($property_key) . "\n" );
#        RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), property 0, have $property_type_inner = ' . "\n" . RPerl::Parser::rperl_ast__dump($property_type_inner) . "\n" );
#        RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), property 0, have $property_subexpression = ' . "\n" . RPerl::Parser::rperl_ast__dump($property_subexpression) . "\n" );
#        RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), property 0, have $property_type = ' . "\n" . RPerl::Parser::rperl_ast__dump($property_type) . "\n" );
#        RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), property 0, have $property_arrayref_index_max = ' . "\n" . RPerl::Parser::rperl_ast__dump($property_arrayref_index_max) . "\n" );

        if ( exists $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{_properties}->{$property_key} ) {
            die 'ERROR ECVGEASCP10, CODE GENERATOR, ABSTRACT SYNTAX TO C++: OO property '
                . $property_key
                . ' already declared in this scope, namespace '
                . $modes->{_symbol_table}->{_namespace}
                . ', dying' . "\n";
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

        # SubExpression_135 ISA RPerl::Operation::Expression::SubExpression::Literal::Undefined,
        # don't perform any C++ initialization for properties initialized to 'undef' in Perl
        if ( ( defined $property_subexpression ) and ( ( ref $property_subexpression ) ne 'SubExpression_135' ) ) {
            $cpp_source_subgroup = $property_subexpression->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            $property_declaration .= ' = ' . $cpp_source_subgroup->{CPP};
        }

        $property_declaration .= ';';
        push @{$properties_declarations}, $property_declaration;

        $cpp_source_subgroup = ast_to_cpp__generate_accessors_mutators__CPPOPS_CPPTYPES( $property_key, $modes );
        if ( $cpp_source_subgroup->{H} ne q{} ) {
            push @{$properties_accessors_mutators}, $cpp_source_subgroup->{H};
        }
        if ( $cpp_source_subgroup->{PMC} ne q{} ) {
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

            $property_key        = $property->{children}->[0];
            $property_type_inner = $property->{children}->[2];

            # TypeInnerProperties -> MY Type '$TYPED_' WORD OP19_VARIABLE_ASSIGN SubExpression
            if ( ref $property_type_inner eq 'TypeInnerProperties_221' ) {
                $property_type          = $property_type_inner->{children}->[1]->{children}->[0];
                $property_subexpression = $property_type_inner->{children}->[5];
            }

            # TypeInnerProperties -> MY Type '$TYPED_' WORD OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef'
            elsif ( ref $property_type_inner eq 'TypeInnerProperties_222' ) {
                $property_type               = $property_type_inner->{children}->[1]->{children}->[0];
                $property_arrayref_index_max = $property_type_inner->{children}->[5];
            }
            else {
                die RPerl::Parser::rperl_rule__replace( 'ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: grammar rule '
                        . ( ref $self )
                        . ' found where TypeInnerProperties_221 or TypeInnerProperties_222 expected, dying' )
                    . "\n";
            }

#            RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), property ' . $i . ', have $property_key = ' . "\n" . RPerl::Parser::rperl_ast__dump($property_key) . "\n" );
#            RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), property ' . $i . ', have $property_type_inner = ' . "\n" . RPerl::Parser::rperl_ast__dump($property_type_inner) . "\n" );
#            RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), property ' . $i . ', have $property_subexpression = ' . "\n" . RPerl::Parser::rperl_ast__dump($property_subexpression) . "\n" );
#            RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), property ' . $i . ', have $property_type = ' . "\n" . RPerl::Parser::rperl_ast__dump($property_type) . "\n" );
#            RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), property ' . $i . ', have $property_arrayref_index_max = ' . "\n" . RPerl::Parser::rperl_ast__dump($property_arrayref_index_max) . "\n" );

            if ( exists $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{_properties}->{$property_key} ) {
                die 'ERROR ECVGEASCP10, CODE GENERATOR, ABSTRACT SYNTAX TO C++: OO property '
                    . $property_key
                    . ' already declared in this scope, namespace '
                    . $modes->{_symbol_table}->{_namespace}
                    . ', dying' . "\n";
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

            # SubExpression_135 ISA RPerl::Operation::Expression::SubExpression::Literal::Undefined,
            # don't perform any C++ initialization for properties initialized to 'undef' in Perl
            if ( ( defined $property_subexpression ) and ( ( ref $property_subexpression ) ne 'SubExpression_135' ) ) {
                $cpp_source_subgroup = $property_subexpression->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
                $property_declaration .= ' = ' . $cpp_source_subgroup->{CPP};
            }

            $property_declaration .= ';';
            push @{$properties_declarations}, $property_declaration;

            $cpp_source_subgroup = ast_to_cpp__generate_accessors_mutators__CPPOPS_CPPTYPES( $property_key, $modes );
            if ( $cpp_source_subgroup->{H} ne q{} ) {
                push @{$properties_accessors_mutators}, $cpp_source_subgroup->{H};
            }
            if ( $cpp_source_subgroup->{PMC} ne q{} ) {
                push @{$properties_accessors_mutators_shims}, $cpp_source_subgroup->{PMC};
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
        $cpp_source_group->{_PMC_accessors_mutators_shims} .= ( join "\n", @{$properties_accessors_mutators_shims} ) . "\n";
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

    my string_arrayref $method_declarations     = [];
    my string_arrayref $method_definitions      = [];
    my string_arrayref $subroutine_declarations = [];
    my string_arrayref $subroutine_definitions  = [];
    my string_arrayref $subroutines_shims       = [];

    foreach my object $method_or_subroutine ( ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        @{ $method_or_subroutine_star->{children} }
        )
    {
        if ( ( ref $method_or_subroutine ) eq 'MethodOrSubroutine_78' ) {  # METHOD
            $cpp_source_subgroup = $method_or_subroutine->ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES($modes);
            push @{$method_declarations}, $cpp_source_subgroup->{H};
            $cpp_source_subgroup = $method_or_subroutine->ast_to_cpp__generate__CPPOPS_CPPTYPES( $package_name_underscores, $modes );
            push @{$method_definitions}, $cpp_source_subgroup->{CPP};
            if ( ( exists $cpp_source_subgroup->{H_INCLUDES} ) and ( defined $cpp_source_subgroup->{H_INCLUDES} ) ) {
                $cpp_source_group->{H_INCLUDES} .= $cpp_source_subgroup->{H_INCLUDES};
            }
        }
        elsif ( ( ref $method_or_subroutine ) eq 'MethodOrSubroutine_79' ) {  # SUBROUTINE
            $cpp_source_subgroup = $method_or_subroutine->ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES($modes);
            push @{$subroutine_declarations}, $cpp_source_subgroup->{H};
            $cpp_source_subgroup = $method_or_subroutine->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            push @{$subroutine_definitions}, $cpp_source_subgroup->{CPP};
            $cpp_source_subgroup = $method_or_subroutine->ast_to_cpp__generate_shim__CPPOPS_CPPTYPES($modes);
            push @{$subroutines_shims}, $cpp_source_subgroup->{PMC};
            if ( ( exists $cpp_source_subgroup->{H_INCLUDES} ) and ( defined $cpp_source_subgroup->{H_INCLUDES} ) ) {
                $cpp_source_group->{H_INCLUDES} .= $cpp_source_subgroup->{H_INCLUDES};
            }
        }
        else {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++, CPPOPS_CPPTYPES: grammar rule '
                    . ( ref $method_or_subroutine )
                    . ' found where MethodOrSubroutine_78 or MethodOrSubroutine_79 expected, dying' )
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
            $cpp_source_group->{CPP} .= '// [[[ OO METHODS & SUBROUTINES ]]]' . "\n\n";
        }
        $cpp_source_group->{CPP} .= ( join "\n\n", @{$method_definitions} );
        if ( exists $method_definitions->[0] ) { $cpp_source_group->{CPP} .= "\n\n"; }
        $cpp_source_group->{CPP} .= ( join "\n\n", @{$subroutine_definitions} );
        if ( exists $subroutine_definitions->[0] ) { $cpp_source_group->{CPP} .= "\n\n"; }
        if ( exists $subroutines_shims->[0] ) {
            $cpp_source_group->{_PMC_subroutines_shims} .= ( join "\n", @{$subroutines_shims} ) . "\n";
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

    if ( exists $subroutine_declarations->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $cpp_source_group->{H} .= '// [[[ SUBROUTINES ]]]' . "\n";
        }
        $cpp_source_group->{H} .= ( join "\n", @{$subroutine_declarations} ) . "\n\n";
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

    return $cpp_source_group;
};

# generate accessors/mutators
our string_hashref $ast_to_cpp__generate_accessors_mutators__CPPOPS_CPPTYPES = sub {
    ( my string $property_key, my string_hashref $modes ) = @_;
    my string_hashref $cpp_source_group = { PMC => q{}, H => q{} };

    # grab RPerl-style type out of symtab, instead of accepting-as-arg now-C++-style type from $property_type in caller
    my string $property_type = $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{_properties}->{$property_key}->{type};
    my bool $is_direct       = 0;
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
        $cpp_source_group->{H} = $property_type . ' get_' . $property_key . '() { return this->' . $property_key . '; }' . "\n";
        $cpp_source_group->{H}
            .= 'void set_' . $property_key . '(' . $property_type . q{ } . $property_key . '_new) { this->' . $property_key . ' = ' . $property_key . '_new; }';
    }
    else {
# hard-coded example
#integer get_bodies_size() { return this->bodies.size(); }  // call from Perl or C++
#string_arrayref get_bodies_keys() { string_arrayref keys; keys.reserve(this->keys.size()); for(auto hash_entry : this->bodies) { keys.push_back(hash_entry.first); } }  // call from Perl or C++
#PhysicsPerl__Astro__Body_ptr& get_bodies_element(integer i) { return this->bodies[i]; }  // call from C++
#void get_bodies_element_indirect(integer i, PhysicsPerl__Astro__Body_rawptr bodies_element_rawptr) { *bodies_element_rawptr = *(this->bodies[i].get_raw()); }  // call from Perl shim
#void set_bodies_element(integer i, PhysicsPerl__Astro__Body_ptr& bodies_element_ptr) { *(this->bodies[i].get_raw()) = *(bodies_element_ptr.get_raw()); }  // call from C++
#void set_bodies_element(integer i, PhysicsPerl__Astro__Body_rawptr bodies_element_rawptr) { *(this->bodies[i].get_raw()) = *bodies_element_rawptr; }  // call from Perl
#sub get_bodies_element {
#    ( my PhysicsPerl::Astro::System $self, my integer $i ) = @_;
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

        # Perl shim code
        # DEV NOTE: must create return variable object in Perl so it will be memory-managed by Perl,
        # and not wrongly destructed or double-destructed by Perl garbage collector and/or C++ memory.h,
        # even though Perl object contents will be replaced by C++ memory address, TRICKY!
        $cpp_source_group->{PMC} = 'sub get_' . $property_key . '_element {' . "\n";
        $cpp_source_group->{PMC}
            .= '( my '
            . ( substr $modes->{_symbol_table}->{_namespace}, 0, ( ( length $modes->{_symbol_table}->{_namespace} ) - 2 ) )
            . ' $self, my integer $i ) = @_;' . "\n";
        $cpp_source_group->{PMC}
            .= 'my ' . $property_element_or_value_type . ' $' . $property_key . '_element = ' . $property_element_or_value_type . '->new();' . "\n";
        $cpp_source_group->{PMC} .= '$self->get_' . $property_key . '_element_indirect($i, $' . $property_key . '_element);' . "\n";
        $cpp_source_group->{PMC} .= 'return $' . $property_key . '_element;' . "\n";
        $cpp_source_group->{PMC} .= '}';

#            RPerl::diag( 'in Class::Generator::ast_to_cpp__generate_accessors_mutators__CPPOPS_CPPTYPES(), have $cpp_source_group->{H} = ' . "\n" . $cpp_source_group->{H} . "\n" );
    }

    return $cpp_source_group;
};

1;    # end of class
