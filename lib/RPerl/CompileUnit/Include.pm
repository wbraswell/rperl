# [[[ HEADER ]]]
package RPerl::CompileUnit::Include;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_300;

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
    if ( ref $self eq 'Include_41' ) {
        # Include -> USE_OR_REQUIRE WordScoped ';'
        my string $use_or_require_keyword = $self->{children}->[0];
        my string $module_name
            = $self->{children}->[1]->{children}->[0];
        my string $semicolon = $self->{children}->[2];
        $rperl_source_group->{PMC}
            .= $use_or_require_keyword . q{ } . $module_name . $semicolon . "\n";

#        RPerl::diag( 'in Include->ast_to_rperl__generate(), have $module_name = '  . $module_name . "\n" );
    }
    elsif ( ref $self eq 'Include_42' ) {
        # Include -> USE_OR_REQUIRE WordScoped OP01_QW ';'
        my string $use_or_require_keyword = $self->{children}->[0];
        my string $module_name
            = $self->{children}->[1]->{children}->[0];
        my string $qw            = $self->{children}->[2];
        my string $semicolon         = $self->{children}->[3];
        $rperl_source_group->{PMC}
            .= $use_or_require_keyword . q{ }
            . $module_name . q{ }
            . $qw
            . $semicolon . "\n";
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . ( ref $self )
                . ' found where Include_41 or Include_42 expected, dying' )
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
    if (( ref $self eq 'Include_41' ) or ( ref $self eq 'Include_42' )) {
        # Include -> USE_OR_REQUIRE WordScoped ...
        # DEV NOTE: ignore manually included RPerl* and rperl* modules, presumably they will all be automatically included
        my string $module_name = $self->{children}->[1]->{children}->[0];
        if ( $module_name =~ /^\w+Perl::Config$/ ) { # DEV NOTE, CORRELATION #rp27: MathPerl::Config, PhysicsPerl::Config, etc
#            RPerl::diag('in CompileUnit::Include->ast_to_cpp__generate__CPPOPS_CPPTYPES(), skipping system config file $module_name = ' . $module_name . "\n");
        }
        elsif (((substr $module_name, 0, 5) ne 'RPerl') and ((substr $module_name, 0, 5) ne 'rperl')) {
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
            'ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                . ( ref $self )
                . ' found where Include_41 or Include_42 expected, dying' )
            . "\n";
    }
    
    return $cpp_source_group;
};

1;    # end of class
