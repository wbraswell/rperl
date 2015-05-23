# [[[ HEADER ]]]
package RPerl::CompileUnit::Module::Class::Generator;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Parser;
use RPerl::Generator;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = {};

    RPerl::diag(
        'in Class::Generator->ast_to_rperl__generate(), received $self = '
            . "\n"
            . RPerl::Parser::rperl_ast__dump($self)
            . "\n" );

    my object $class                 = $self->{children}->[0];
    my string $use_parent_qw_keyword = $class->{children}->[0];
    my string $parent_name       = $class->{children}->[1]->{children}->[0];
    my string $right_parenthesis = $class->{children}->[2];
    my string $use_parent_semicolon      = $class->{children}->[3];
    my object $parent_include            = $class->{children}->[4];
    my object $critic_star               = $class->{children}->[5];
    my object $include_star              = $class->{children}->[6];
    my object $constant_star             = $class->{children}->[7];
    my object $properties                = $class->{children}->[8];
    my object $method_or_subroutine_star = $class->{children}->[9];
    my string $retval_literal_number     = $class->{children}->[10];
    my string $retval_semicolon          = $class->{children}->[11];

    $rperl_source_group->{PMC} = q{};
    if ( $modes->{label} eq 'ON' ) {
        $rperl_source_group->{PMC} .= '# [[[ OO INHERITANCE ]]]' . "\n";
    }
    $rperl_source_group->{PMC}
        .= $use_parent_qw_keyword
        . $parent_name
        . $right_parenthesis
        . $use_parent_semicolon . "\n";

    my string_hashref $rperl_source_subgroup
        = $parent_include->ast_to_rperl__generate($modes);
    RPerl::Generator::source_group_append( $rperl_source_group,
        $rperl_source_subgroup );

    if ( exists $critic_star->{children}->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $rperl_source_group->{PMC} .= '# [[[ CRITICS ]]]' . "\n";
        }
    }
    foreach my object $critic ( @{ $critic_star->{children} } ) {
        $rperl_source_subgroup
            = $critic->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
    }

    if ( exists $include_star->{children}->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $rperl_source_group->{PMC} .= "\n" . '# [[[ INCLUDES ]]]' . "\n";
        }
    }
    foreach my object $include ( @{ $include_star->{children} } ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        $rperl_source_subgroup
            = $include->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
    }

    if ( exists $constant_star->{children}->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $rperl_source_group->{PMC} .= "\n" . '# [[[ CONSTANTS ]]]' . "\n";
        }
    }
    foreach my object $constant ( @{ $constant_star->{children} } ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        $rperl_source_subgroup
            = $constant->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
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

        $rperl_source_group->{PMC}
            .= $properties_our_hashref . q{ }
            . $properties_equal . q{ }
            . $properties_left_brace . "\n";

        $rperl_source_subgroup
            = $property_0->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );

        foreach my object $property ( @{ $properties_1_to_n->{children} } ) {
            if ( ( ref $property ) eq 'TERMINAL' ) {
                $rperl_source_group->{PMC} .= $property->{attr}; # comma between properties
            }
            else {
                $rperl_source_subgroup
                    = $property->ast_to_rperl__generate($modes);
                RPerl::Generator::source_group_append( $rperl_source_group,
                    $rperl_source_subgroup );
            }
        }
        $rperl_source_group->{PMC}
            .= "\n" . $properties_right_brace . $properties_semicolon . "\n";
    }
    else {    # Properties_64
              # empty $properties
        my string $properties_our_hashref = $properties->{children}->[0];
        my string $properties_equal       = $properties->{children}->[1];
        my string $properties_left_brace  = $properties->{children}->[2];
        my string $properties_right_brace = $properties->{children}->[3];
        my string $properties_semicolon   = $properties->{children}->[4];
        $rperl_source_group->{PMC}
            .= $properties_our_hashref . q{ }
            . $properties_equal . q{ }
            . $properties_left_brace
            . $properties_right_brace
            . $properties_semicolon . "\n";
    }

    if ( exists $method_or_subroutine_star->{children}->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $rperl_source_group->{PMC}
                .= "\n" . '# [[[ OO METHODS & SUBROUTINES ]]]' . "\n";
        }
    }
    foreach my object $method_or_subroutine ( ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        @{ $method_or_subroutine_star->{children} }
        )
    {
        $rperl_source_subgroup
            = $method_or_subroutine->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
    }

    if ( $modes->{label} eq 'ON' ) {
        $rperl_source_group->{PMC}
            .= "\n"
            . $retval_literal_number
            . $retval_semicolon
            . '  # end of class' . "\n";
    }
    else {
        $rperl_source_group->{PMC}
            .= $retval_literal_number . $retval_semicolon . "\n";
    }

    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP => q{// <<< RP::CU::M::C DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP => q{// <<< RP::CU::M::C DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

1;    # end of class
