# [[[ HEADER ]]]
package RPerl::CompileUnit::Module::Class::Generator;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.002_000;

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

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes ) = @_;
    my string_hashref $rperl_source_group = {};

    #    RPerl::diag( 'in Class::Generator->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    # unwrap Class_59 from Module_23
    if ( ($self_class) eq 'Module_23' ) {
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( ($self_class) ne 'Class_59' ) {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . ($self_class)
                . ' found where Module_23 or Class_59 expected, dying' )
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
    if ( ref $properties eq 'Properties_63' ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
                                                # non-empty $properties
        my string $properties_our_hashref = $properties->{children}->[0];
        my string $properties_equal       = $properties->{children}->[1];
        my string $properties_left_brace  = $properties->{children}->[2];
        my object $property_0             = $properties->{children}->[3];
        my object $properties_1_to_n      = $properties->{children}->[4];
        my string $properties_right_brace = $properties->{children}->[5];
        my string $properties_semicolon   = $properties->{children}->[6];

        $rperl_source_group->{PMC} .= $properties_our_hashref . q{ } . $properties_equal . q{ } . $properties_left_brace . "\n";

        $rperl_source_subgroup = $property_0->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );

        foreach my object $property ( @{ $properties_1_to_n->{children} } ) {
            if ( ( ref $property ) eq 'TERMINAL' ) {
                $rperl_source_group->{PMC} .= $property->{attr};    # comma between properties
            }
            else {
                $rperl_source_subgroup = $property->ast_to_rperl__generate($modes);
                RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
            }
        }
        $rperl_source_group->{PMC} .= "\n" . $properties_right_brace . $properties_semicolon . "\n";
    }
    else {                                                          # Properties_64
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
            $rperl_source_group->{PMC} .= "\n" . '# [[[ OO METHODS & SUBROUTINES ]]]' . "\n";
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

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes ) = @_;
    my string_hashref $cpp_source_group = {
        CPP => q{// <<< RP::CU::M::C::G __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n",
        H   => q{// <<< RP::CU::M::C::G __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n",
        PMC => q{# <<< RP::CU::M::C::G __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n"
    };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string $package_name_underscores, my string_hashref $modes ) = @_;
    my string_hashref $cpp_source_group = { H => q{}, CPP => q{} };

    #RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
    #RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $package_name_underscores = ' . $package_name_underscores . "\n");
    #RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $modes = ' . "\n" . Dumper($modes) . "\n");

    my string $self_class = ref $self;

    # unwrap Class_59 from Module_23
    if ( ($self_class) eq 'Module_23' ) {
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( ($self_class) ne 'Class_59' ) {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL, CPPOPS_CPPTYPES: grammar rule '
                . ($self_class)
                . ' found where Module_23 or Class_59 expected, dying' )
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
        $cpp_source_group->{H}   .= '// [[[ INCLUDES ]]]' . "\n";
        $cpp_source_group->{CPP} .= '// [[[ INCLUDES ]]]' . "\n";
    }

    $cpp_source_group->{H} .= <<EOL;
#include <rperltypes_mode.h>  // for default definitions of __PERL__TYPES or __CPP__TYPES
#include <rperltypes.h>  // for data types and structures
#include <RPerl/HelperFunctions.cpp>  // -> HelperFunctions.h
EOL

    # NEED FIX WIN32: change hard-coded forward-slash in generated path name below?
    # NEED FIX: handle absolute vs relative include paths
    my string $parent_name_path = $parent_name;
    $parent_name_path =~ s/::/\//gxms;
    $parent_name_path        .= '.cpp';
    $cpp_source_group->{H}   .= '#include <' . $parent_name_path . '>' . "\n";
    $cpp_source_group->{CPP} .= '#include <__NEED_MODULE_HEADER_PATH>' . "\n";    # defer setting header include path until files are saved in Compiler

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

    if ( $modes->{label} eq 'ON' ) {
        $cpp_source_group->{H} .= '// [[[ OO INHERITANCE ]]]' . "\n";
    }
    my string $parent_name_underscores = $parent_name;
    $parent_name_underscores =~ s/::/__/gxms;
    $cpp_source_group->{H} .= 'class ' . $package_name_underscores . ' : public ' . $parent_name_underscores . ' {' . "\n";
    $cpp_source_group->{H} .= 'public:' . "\n";

    my string_arrayref $method_declarations     = [];
    my string_arrayref $subroutine_declarations = [];

    foreach my object $method_or_subroutine ( ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        @{ $method_or_subroutine_star->{children} }
        )
    {
        if ( ( ref $method_or_subroutine ) eq 'MethodOrSubroutine_74' ) {
            my object $method             = $method_or_subroutine->{children}->[0];    # unwrap Method_69 from MethodOrSubroutine_74
            my string $method_return_type = $method->{children}->[1];
            substr $method_return_type, -7, 7, '';                                     # remove leading 'method_'
            my string $method_name = $method->{children}->[2];
            substr $method_name, 0, 1, '';                                             # remove leading $ sigil
            my object $method_arguments_optional = $method->{children}->[4];
            my string_arrayref $method_arguments = [];

#RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $method_arguments_optional = ' . "\n" . RPerl::Parser::rperl_ast__dump($method_arguments_optional) . "\n" );

            if ( exists $method_arguments_optional->{children}->[0] ) {
                my object $method_arguments_star = $method_arguments_optional->{children}->[0]->{children}->[2];

#RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $method_arguments_star = ' . "\n" . RPerl::Parser::rperl_ast__dump($method_arguments_star) . "\n" );

                # (OP21_LIST_COMMA MY Type VARIABLE_SYMBOL)*
                my object $method_arguments_star_dclone = dclone($method_arguments_star);
                while ( exists $method_arguments_star_dclone->{children}->[0] ) {
                    shift @{ $method_arguments_star_dclone->{children} };    # discard $comma
                    shift @{ $method_arguments_star_dclone->{children} };    # discard $my
                    my object $method_arguments_type = shift @{ $method_arguments_star_dclone->{children} };
                    my object $method_arguments_name = shift @{ $method_arguments_star_dclone->{children} };
                    push @{$method_arguments}, ( $method_arguments_type->{children}->[0] . q{ } . ( substr $method_arguments_name->{attr}, 1 ) );
                }

            }
            push @{$method_declarations}, ( q{    } . $method_return_type . q{ } . $method_name . '(' . ( join ', ', @{$method_arguments} ) . ');' );
        }
        elsif ( ( ref $method_or_subroutine ) eq 'MethodOrSubroutine_75' ) {
            my object $subroutine             = $method_or_subroutine->{children}->[0];          # unwrap Subroutine_46 from MethodOrSubroutine_75
            my string $subroutine_return_type = $subroutine->{children}->[1]->{children}->[0];
            my string $subroutine_name        = $subroutine->{children}->[2];
            substr $subroutine_name, 0, 1, '';                                                   # remove leading $ sigil
            my object $subroutine_arguments_optional = $subroutine->{children}->[4];
            my string_arrayref $subroutine_arguments = [];

#RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $subroutine_arguments_optional = ' . "\n" . RPerl::Parser::rperl_ast__dump($subroutine_arguments_optional) . "\n" );
#RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $subroutine_return_type = ' . "\n" . RPerl::Parser::rperl_ast__dump($subroutine_return_type) . "\n" );

            if ( exists $subroutine_arguments_optional->{children}->[0] ) {
                my object $subroutine_arguments_type = $subroutine_arguments_optional->{children}->[0]->{children}->[1];
                my object $subroutine_arguments_name = $subroutine_arguments_optional->{children}->[0]->{children}->[2];

#RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $subroutine_arguments_type = ' . "\n" . RPerl::Parser::rperl_ast__dump($subroutine_arguments_type) . "\n" );
#RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $subroutine_arguments_name = ' . "\n" . RPerl::Parser::rperl_ast__dump($subroutine_arguments_name) . "\n" );

                push @{$subroutine_arguments}, ( $subroutine_arguments_type->{children}->[0] . q{ } . ( substr $subroutine_arguments_name, 1 ) );

                my object $subroutine_arguments_star = $subroutine_arguments_optional->{children}->[0]->{children}->[3];

#RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $subroutine_arguments_star = ' . "\n" . RPerl::Parser::rperl_ast__dump($subroutine_arguments_star) . "\n" );

                # (OP21_LIST_COMMA MY Type VARIABLE_SYMBOL)*
                my object $subroutine_arguments_star_dclone = dclone($subroutine_arguments_star);
                while ( exists $subroutine_arguments_star_dclone->{children}->[0] ) {
                    shift @{ $subroutine_arguments_star_dclone->{children} };    # discard $comma
                    shift @{ $subroutine_arguments_star_dclone->{children} };    # discard $my
                    $subroutine_arguments_type = shift @{ $subroutine_arguments_star_dclone->{children} };
                    $subroutine_arguments_name = shift @{ $subroutine_arguments_star_dclone->{children} };
                    push @{$subroutine_arguments}, ( $subroutine_arguments_type->{children}->[0] . q{ } . ( substr $subroutine_arguments_name, 1 ) );
                }

            }
            push @{$subroutine_declarations}, ( $subroutine_return_type . q{ } . $subroutine_name . '(' . ( join ', ', @{$subroutine_arguments} ) . ');' );
        }
        else {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL, CPPOPS_CPPTYPES: grammar rule '
                    . ( ref $method_or_subroutine )
                    . ' found where MethodOrSubroutine_74 or MethodOrSubroutine_75 expected, dying' )
                . "\n";
        }
    }

    if ( exists $method_declarations->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $cpp_source_group->{H} .= '// [[[ OO METHODS ]]]' . "\n";
        }
        $cpp_source_group->{H} .= ( join "\n", @{$method_declarations} ) . "\n\n";
    }

    my string_arrayref $properties_accessors_mutators = [];
    my string_arrayref $properties_declarations       = [];
    my string $property_declaration;

    # non-empty $properties
    if ( ref $properties eq 'Properties_63' ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        $property_declaration = q{};
        my object $property_0        = $properties->{children}->[3];
        my object $properties_1_to_n = $properties->{children}->[4];

        my string $property_key           = $property_0->{children}->[0];
        my object $property_type_inner    = $property_0->{children}->[2];
        my object $property_subexpression = $property_0->{children}->[3];
        my string $property_type          = $property_type_inner->{children}->[1]->{children}->[0];

#RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $property_key = ' . "\n" . RPerl::Parser::rperl_ast__dump($property_key) . "\n" );
#RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $property_type_inner = ' . "\n" . RPerl::Parser::rperl_ast__dump($property_type_inner) . "\n" );
#RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $property_subexpression = ' . "\n" . RPerl::Parser::rperl_ast__dump($property_subexpression) . "\n" );
#RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $property_type = ' . "\n" . RPerl::Parser::rperl_ast__dump($property_type) . "\n" );

        $property_declaration = q{    } . $property_type . q{ } . $property_key;

        # SubExpression_130 ISA RPerl::Operation::Expression::SubExpression::Literal::Undefined,
        # don't perform any C++ initialization for properties initialized to 'undef' in Perl
        if ( ( ref $property_subexpression ) ne 'SubExpression_130' ) {
            $cpp_source_subgroup = $property_subexpression->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            $property_declaration .= ' = ' . $cpp_source_subgroup->{CPP};
        }

        $property_declaration .= ';';
        push @{$properties_declarations}, $property_declaration;
        push @{$properties_accessors_mutators}, ( q{    } . $property_type . ' get_' . $property_key . '() { return(this->' . $property_key . '); }' );  # ACCESSOR
        push @{$properties_accessors_mutators},
            (     q{    }
                . 'void set_'
                . $property_key . '('
                . $property_type . q{ }
                . $property_key
                . '_new) { this->'
                . $property_key . ' = '
                . $property_key
                . '_new; }' );                                                                                                                        # MUTATOR

        foreach my object $property ( @{ $properties_1_to_n->{children} } ) {
            if ( ( ref $property ) eq 'TERMINAL' ) {    # skip comma between properties
                next;
            }

            $property_key           = $property->{children}->[0];
            $property_type_inner    = $property->{children}->[2];
            $property_subexpression = $property->{children}->[3];
            $property_type          = $property_type_inner->{children}->[1]->{children}->[0];

#RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $property_key = ' . "\n" . RPerl::Parser::rperl_ast__dump($property_key) . "\n" );
#RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $property_type_inner = ' . "\n" . RPerl::Parser::rperl_ast__dump($property_type_inner) . "\n" );
#RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $property_subexpression = ' . "\n" . RPerl::Parser::rperl_ast__dump($property_subexpression) . "\n" );
#RPerl::diag( 'in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $property_type = ' . "\n" . RPerl::Parser::rperl_ast__dump($property_type) . "\n" );

            $property_declaration = q{    } . $property_type . q{ } . $property_key;

            # SubExpression_130 ISA RPerl::Operation::Expression::SubExpression::Literal::Undefined,
            # don't perform any C++ initialization for properties initialized to 'undef' in Perl
            if ( ( ref $property_subexpression ) ne 'SubExpression_130' ) {
                $cpp_source_subgroup = $property_subexpression->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
                $property_declaration .= ' = ' . $cpp_source_subgroup->{CPP};
            }

            $property_declaration .= ';';
            push @{$properties_declarations}, $property_declaration;
            push @{$properties_accessors_mutators}, ( q{    } . $property_type . ' get_' . $property_key . '() { return(this->' . $property_key . '); }' ); # ACCESSOR
            push @{$properties_accessors_mutators},
                (     q{    }
                    . 'void set_'
                    . $property_key . '('
                    . $property_type . q{ }
                    . $property_key
                    . '_new) { this->'
                    . $property_key . ' = '
                    . $property_key
                    . '_new; }' );    # MUTATOR

        }
    }

    if ( exists $properties_accessors_mutators->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $cpp_source_group->{H} .= q{    } . '// <<< OO PROPERTIES, ACCESSORS & MUTATORS >>>' . "\n";
        }
        $cpp_source_group->{H} .= ( join "\n", @{$properties_accessors_mutators} ) . "\n\n";
    }

    if ( $modes->{label} eq 'ON' ) {
        $cpp_source_group->{H} .= q{    } . '// <<< CONSTRUCTOR & DESTRUCTOR >>>' . "\n";
    }
    $cpp_source_group->{H} .= q{    } . $package_name_underscores . '() {}' . "\n";            # CONSTRUCTOR
    $cpp_source_group->{H} .= q{    } . '~' . $package_name_underscores . '() {}' . "\n\n";    # DESTRUCTOR

    if ( exists $properties_declarations->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $cpp_source_group->{H} .= '// [[[ OO PROPERTIES ]]]' . "\n";
        }
        $cpp_source_group->{H} .= 'private:' . "\n";
        $cpp_source_group->{H} .= ( join "\n", @{$properties_declarations} ) . "\n";
    }

# START HERE: handle constants
# START HERE: handle constants
# START HERE: handle constants

=DISABLE_tmp

    if ( exists $constant_star->{children}->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $cpp_source_group->{CPP} .= "\n" . '# [[[ CONSTANTS ]]]' . "\n";
        }
    }
    foreach my object $constant ( @{ $constant_star->{children} } ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        $cpp_source_subgroup = $constant->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
    }

=cut

    $cpp_source_group->{H} .= '};' . "\n\n";

    if ( exists $subroutine_declarations->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $cpp_source_group->{H} .= '// [[[ SUBROUTINES ]]]' . "\n\n";
        }
        $cpp_source_group->{H} .= ( join "\n", @{$subroutine_declarations} ) . "\n\n";
    }

    if ( $modes->{label} eq 'ON' ) {
        $cpp_source_group->{H} .= '// <<< OPERATIONS & DATA TYPES REPORTING >>>' . "\n";
    }
    $cpp_source_group->{H} .= 'integer ' . $package_name_underscores . '__MODE_ID() { integer retval = 2;  return(retval); }  // CPPOPS_CPPTYPES is 2' . "\n\n";

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

    return $cpp_source_group;
};

1;    # end of class
