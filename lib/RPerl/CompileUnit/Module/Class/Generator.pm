# [[[ HEADER ]]]
package RPerl::CompileUnit::Module::Class::Generator;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.002_010;

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
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++, CPPOPS_CPPTYPES: grammar rule '
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
        $cpp_source_group->{H}   .= '// [[[ INCLUDES & OO INHERITANCE INCLUDES ]]]' . "\n";
        $cpp_source_group->{CPP} .= '// [[[ INCLUDES ]]]' . "\n";
    }

    $cpp_source_group->{H} .= <<EOL;
#include <RPerl.cpp>  // -> RPerl.h -> (rperltypes_mode.h; rperltypes.h; HelperFunctions.cpp)
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

    if ( exists $constant_star->{children}->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $cpp_source_group->{H} .= '// [[[ CONSTANTS ]]]' . "\n";
        }
        foreach my object $constant ( @{ $constant_star->{children} } ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
            $cpp_source_subgroup = $constant->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            $cpp_source_group->{H} .= q{    } . $cpp_source_subgroup->{H};
        }
        $cpp_source_group->{H} .= "\n";
    }

    my string_arrayref $method_declarations     = [];
    my string_arrayref $method_definitions      = [];
    my string_arrayref $subroutine_declarations = [];
    my string_arrayref $subroutine_definitions  = [];

    foreach my object $method_or_subroutine ( ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        @{ $method_or_subroutine_star->{children} }
        )
    {
        if ( ( ref $method_or_subroutine ) eq 'MethodOrSubroutine_74' ) {
            $cpp_source_subgroup = $method_or_subroutine->ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES($modes);
            push @{$method_declarations}, $cpp_source_subgroup->{H};
            $cpp_source_subgroup = $method_or_subroutine->ast_to_cpp__generate__CPPOPS_CPPTYPES( $package_name_underscores, $modes );
            push @{$method_definitions}, $cpp_source_subgroup->{CPP};
        }
        elsif ( ( ref $method_or_subroutine ) eq 'MethodOrSubroutine_75' ) {
            $cpp_source_subgroup = $method_or_subroutine->ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES($modes);
            push @{$subroutine_declarations}, $cpp_source_subgroup->{H};
            $cpp_source_subgroup = $method_or_subroutine->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            push @{$subroutine_definitions}, $cpp_source_subgroup->{CPP};
        }
        else {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++, CPPOPS_CPPTYPES: grammar rule '
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

    if ( ( exists $method_definitions->[0] ) or ( exists $subroutine_definitions->[0] ) ) {
        if ( $modes->{label} eq 'ON' ) {
            $cpp_source_group->{CPP} .= '// [[[ OO METHODS & SUBROUTINES ]]]' . "\n\n";
        }
        $cpp_source_group->{CPP} .= ( join "\n\n", @{$method_definitions} ) . "\n\n";
        $cpp_source_group->{CPP} .= ( join "\n\n", @{$subroutine_definitions} ) . "\n\n";
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
        push @{$properties_accessors_mutators}, ( q{    } . $property_type . ' get_' . $property_key . '() { return this->' . $property_key . '; }' ); # ACCESSOR
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
            push @{$properties_accessors_mutators}, ( q{    } . $property_type . ' get_' . $property_key . '() { return this->' . $property_key . '; }' ); # ACCESSOR
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

    if ( $modes->{label} eq 'ON' ) {
        $cpp_source_group->{H} .= q{    } . '// <<< CLASS NAME REPORTER >>>' . "\n";
    }
    my string $package_name_scoped = $package_name_underscores;
    $package_name_scoped =~ s/__/::/gxms;
    $cpp_source_group->{H} .= '    virtual string myclassname() { return (const string) "' . $package_name_scoped . '"; }' . "\n";    # CLASS NAME REPORTER

    if ( exists $properties_declarations->[0] ) {
        $cpp_source_group->{H} .= "\n" . 'private:' . "\n";
        if ( $modes->{label} eq 'ON' ) {
            $cpp_source_group->{H} .= '// [[[ OO PROPERTIES ]]]' . "\n";
        }
        $cpp_source_group->{H} .= ( join "\n", @{$properties_declarations} ) . "\n";
    }

    $cpp_source_group->{H} .= '};' . "\n\n";

    if ( exists $subroutine_declarations->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $cpp_source_group->{H} .= '// [[[ SUBROUTINES ]]]' . "\n\n";
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

    return $cpp_source_group;
};

1;    # end of class
