# [[[ HEADER ]]]
package RPerl::CompileUnit::Include;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::GrammarRule);
use RPerl::GrammarRule;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoInclude ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref::method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Include->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag( 'in Include->ast_to_rperl__generate(), have ::class($self) = ' . ::class($self) . "\n" );
    if ( ref $self eq 'Include_43' ) {
        # Include -> USE WordScoped ';'
        my string $use_keyword = $self->{children}->[0];
        my string $module_name
            = $self->{children}->[1]->{children}->[0];
        my string $semicolon = $self->{children}->[2];
        $rperl_source_group->{PMC}
            .= $use_keyword . q{ } . $module_name . $semicolon . "\n";

#        RPerl::diag( 'in Include->ast_to_rperl__generate(), have $module_name = '  . $module_name . "\n" );
    }
    elsif ( ref $self eq 'Include_44' ) {
        # Include -> USE WordScoped OP01_QW PLUS-15 ')' ';'
        my string $use_keyword = $self->{children}->[0];
        my string $module_name
            = $self->{children}->[1]->{children}->[0];
        my string $qw            = $self->{children}->[2];
        my string $element_names = q{};
        my object $elements      = $self->{children}->[3];

#        RPerl::diag( 'in Include->ast_to_rperl__generate(), have $elements = ' . "\n" . RPerl::Parser::rperl_ast__dump($elements) . "\n" );
        foreach my object $element ( @{ $elements->{children} } ) {

#            RPerl::diag( 'in Include->ast_to_rperl__generate(), have $element = ' . "\n" . RPerl::Parser::rperl_ast__dump($element) . "\n" );
            my string $element_name = $element->{attr};
            if ( $element_names ne q{} ) {
                $element_names .= q{ };
            }
            $element_names .= $element_name;
        }
        my string $right_parenthesis = $self->{children}->[4];
        my string $semicolon         = $self->{children}->[5];
        $rperl_source_group->{PMC}
            .= $use_keyword . q{ }
            . $module_name . q{ }
            . $qw
            . $element_names
            . $right_parenthesis
            . $semicolon . "\n";
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . ( ref $self )
                . ' found where Include_43 or Include_44 expected, dying' )
            . "\n";
    }

    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP => q{// <<< RP::CU::I __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string $package_name_underscores, my string_hashref $modes) = @_;
#    RPerl::diag( 'in Include->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
    my string_hashref $cpp_source_group = { H => q{} };

    # NEED ANSWER: no difference between wholesale includes and selective includes in C++?
    if (( ref $self eq 'Include_43' ) or ( ref $self eq 'Include_44' )) {
        # Include -> USE WordScoped ...
        # DEV NOTE: ignore manually included RPerl* and rperl* modules, presumably they will all be automatically included
        my string $module_name = $self->{children}->[1]->{children}->[0];
        if (((substr $module_name, 0, 5) ne 'RPerl') and ((substr $module_name, 0, 5) ne 'rperl')) {
            if ((not exists $cpp_source_group->{_PMC_includes}) or (not defined $cpp_source_group->{_PMC_includes})) {
                $cpp_source_group->{_PMC_includes} = {};
            }
            elsif ((not exists $cpp_source_group->{_PMC_includes}->{$package_name_underscores}) 
                or (not defined $cpp_source_group->{_PMC_includes}->{$package_name_underscores})) {
                $cpp_source_group->{_PMC_includes}->{$package_name_underscores} = q{};
            }
            $cpp_source_group->{_PMC_includes}->{$package_name_underscores} .= 'require ' . $module_name . ';' . "\n";
            $module_name =~ s/::/\//gxms;
            $cpp_source_group->{H} .= q{#include "} . $module_name . q{.cpp"} . "\n";
#            RPerl::diag( 'in Include->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $module_name = '  . $module_name . "\n" );
        }
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: grammar rule '
                . ( ref $self )
                . ' found where Include_43 or Include_44 expected, dying' )
            . "\n";
    }
    
    return $cpp_source_group;
};

1;    # end of class
