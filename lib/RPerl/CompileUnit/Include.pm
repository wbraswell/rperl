# [[[ HEADER ]]]
package RPerl::CompileUnit::Include;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.004_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::GrammarRule);
use RPerl::GrammarRule;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoInclude ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub ast_to_rperl__generate {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Include->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag( 'in Include->ast_to_rperl__generate(), have ::class($self) = ' . ::class($self) . "\n" );

    if ( ref $self eq 'Include_54' ) {
        # Include -> USE WordScoped OPTIONAL-22 ';'
        my string $use_keyword = $self->{children}->[0];
        my string $module_name = $self->{children}->[1]->{children}->[0];
        my string $qw = q{};
        if (defined $self->{children}->[2]->{children}->[0]) {
            $qw = $self->{children}->[2]->{children}->[0]->{attr};
        }
        my string $semicolon        = $self->{children}->[3];
        $rperl_source_group->{PMC} .= $use_keyword . q{ } . $module_name . q{ } . $qw . $semicolon . "\n";
#        RPerl::diag( 'in Include->ast_to_rperl__generate(), have $module_name = '  . $module_name . "\n" );
    }
    elsif ( ref $self eq 'Include_55' ) {
        # Include -> 'BEGIN {' WordScoped OP02_METHOD_THINARROW_IMP OPTIONAL-23 ')' ';' '}'
        my string $begin_keyword_left_brace = $self->{children}->[0];
        my string $module_name = $self->{children}->[1]->{children}->[0];
        my string $thinarrow_import_left_parentheses = $self->{children}->[2];
        my string $qw = q{};
        if (defined $self->{children}->[3]->{children}->[0]) {
            $qw = $self->{children}->[3]->{children}->[0]->{attr};
        }
        my string $right_parentheses         = $self->{children}->[4];
        my string $semicolon         = $self->{children}->[5];
        my string $right_brace         = $self->{children}->[6];
        $rperl_source_group->{PMC} .= 
            $begin_keyword_left_brace . q{ } .
            $module_name . $thinarrow_import_left_parentheses . q{ } .
            $qw . q{ } .
            $right_parentheses . q{ } .
            $semicolon . q{ } .
            $right_brace . "\n" ;
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . ( ref $self )
                . ' found where Include_54 or Include_55 expected, dying' )
            . "\n";
    }
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group
        = { CPP => q{// <<< RP::CU::I __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string $package_name_underscores, my string_hashref $modes) = @ARG;
#    RPerl::diag( 'in Include->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
    my string_hashref $cpp_source_group = { H => q{} };

    # NEED UPGRADE: implement proper import() semantics in C++
    # DEV NOTE: for now, treat all 4 of the following the same in C++, ignoring 'bar'
    # 'use Foo;'
    # 'use Foo qw(bar)'
    # 'BEGIN { Foo->import(); }'
    # 'BEGIN { Foo->import(qw(bar)); }'
    if (( ref $self eq 'Include_54' ) or ( ref $self eq 'Include_55' )) {
        # Include -> USE WordScoped ...
        # DEV NOTE: ignore manually included RPerl* and rperl* modules, presumably they will all be automatically included
        my string $module_name = $self->{children}->[1]->{children}->[0];
        if ( $module_name =~ /^\w+Perl::Config$/ ) { # DEV NOTE, CORRELATION #rp027: MathPerl::Config, PhysicsPerl::Config, etc
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
                . ' found where Include_54 or Include_55 expected, dying' )
            . "\n";
    }
    
#    RPerl::diag( 'in Include->ast_to_cpp__generate__CPPOPS_CPPTYPES(), about to return $cpp_source_group = ' . "\n" . RPerl::Parser::rperl_ast__dump($cpp_source_group) . "\n" );
    return $cpp_source_group;
}

1;    # end of class
