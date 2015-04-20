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
our hash_ref $properties = {};

# [[[ OO METHODS ]]]

our string__hash_ref__method $ast_to_rperl__generate = sub {
    ( my object $self, my string__hash_ref $modes) = @_;
    my string__hash_ref $rperl_source_group = {};

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
    $rperl_source_group->{PMC}
        .= $use_parent_qw_keyword
        . $parent_name
        . $right_parenthesis
        . $use_parent_semicolon . "\n";

#    RPerl::diag( 'in Class::Generator->ast_to_rperl__generate(), have ref $parent_include = ' . (ref $parent_include) . "\n" );
#    RPerl::diag( 'in Class::Generator->ast_to_rperl__generate(), have $parent_include = ' . "\n" . RPerl::Parser::rperl_ast__dump($parent_include) . "\n" );
    if ( ref $parent_include eq 'Include_39' ) {
        my string $parent_include_use_keyword
            = $parent_include->{children}->[0];
        my string $parent_include_parent_name
            = $parent_include->{children}->[1]->{children}->[0];
        my string $parent_include_semicolon
            = $parent_include->{children}->[2];
        $rperl_source_group->{PMC}
            .= $parent_include_use_keyword . q{ }
            . $parent_include_parent_name
            . $parent_include_semicolon . "\n";

#        RPerl::diag( 'in Class::Generator->ast_to_rperl__generate(), have $parent_include_parent_name = '  . $parent_include_parent_name . "\n" );
    }
    else {    # Include_40
        my string $parent_include_use_keyword
            = $parent_include->{children}->[0];
        my string $parent_include_parent_name
            = $parent_include->{children}->[1]->{children}->[0];
        my string $parent_include_qw = $parent_include->{children}->[2];
        my string $parent_include_element_names = q{};
        my object $parent_include_elements = $parent_include->{children}->[3];

#        RPerl::diag( 'in Class::Generator->ast_to_rperl__generate(), have $parent_include_elements = ' . "\n" . RPerl::Parser::rperl_ast__dump($parent_include_elements) . "\n" );
        foreach my object $parent_include_element (
            @{ $parent_include_elements->{children} } )
        {
#            RPerl::diag( 'in Class::Generator->ast_to_rperl__generate(), have $parent_include_element = ' . "\n" . RPerl::Parser::rperl_ast__dump($parent_include_element) . "\n" );
            my string $parent_include_element_name
                = $parent_include_element->{attr};
            if ( $parent_include_element_names ne q{} ) {
                $parent_include_element_names .= q{ };
            }
            $parent_include_element_names .= $parent_include_element_name;
        }
        my string $parent_include_right_parenthesis
            = $parent_include->{children}->[4];
        my string $parent_include_semicolon
            = $parent_include->{children}->[5];
        $rperl_source_group->{PMC}
            .= $parent_include_use_keyword . q{ }
            . $parent_include_parent_name . q{ }
            . $parent_include_qw
            . $parent_include_element_names
            . $parent_include_right_parenthesis
            . $parent_include_semicolon . "\n";
    }

    foreach my object $critic ( @{ $critic_star->{children} } ) {
        my string__hash_ref $rperl_source_subgroup
            = $critic->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
    }

    foreach my object $include ( @{ $include_star->{children} } ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 7: PERL CRITIC UNFILED ISSUE, not postfix foreach or if
        my string__hash_ref $rperl_source_subgroup
            = $include->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
    }

    foreach my object $constant ( @{ $constant_star->{children} } ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 7: PERL CRITIC UNFILED ISSUE, not postfix foreach or if
        my string__hash_ref $rperl_source_subgroup
            = $constant->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
    }

    if ( ref $properties eq 'Properties_63' ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 7: PERL CRITIC UNFILED ISSUE, not postfix foreach or if
        # START HERE: generate non-empty $properties
        # START HERE: generate non-empty $properties
        # START HERE: generate non-empty $properties
    }
    else {                                      # Properties_64
        my string $properties_our_hash_ref = $properties->{children}->[0];
        my string $properties_equal        = $properties->{children}->[1];
        my string $properties_left_brace   = $properties->{children}->[2];
        my string $properties_right_brace  = $properties->{children}->[3];
        my string $properties_semicolon    = $properties->{children}->[4];
        $rperl_source_group->{PMC}
            .= $properties_our_hash_ref . q{ }
            . $properties_equal . q{ }
            . $properties_left_brace
            . $properties_right_brace
            . $properties_semicolon . "\n";
    }

    foreach my object $method_or_subroutine ( ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 7: PERL CRITIC UNFILED ISSUE, not postfix foreach or if
        @{ $method_or_subroutine_star->{children} }
        )
    {
        my string__hash_ref $rperl_source_subgroup
            = $method_or_subroutine->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
    }

    $rperl_source_group->{PMC}
        .= $retval_literal_number . $retval_semicolon . "\n";

    return $rperl_source_group;
};

our string__hash_ref__method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string__hash_ref $modes) = @_;
    my string__hash_ref $cpp_source_group
        = { CPP => q{<<< RP::CU::M::C DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

our string__hash_ref__method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string__hash_ref $modes) = @_;
    my string__hash_ref $cpp_source_group
        = { CPP => q{<<< RP::CU::M::C DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

1;    # end of class
