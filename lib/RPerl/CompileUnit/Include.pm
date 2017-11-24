# [[[ HEADER ]]]
package RPerl::CompileUnit::Include;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.006_000;

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
        # Include -> 'INIT' LBRACE WordScoped OP02_METHOD_THINARROW_IMP OPTIONAL-23 ')' ';' '}'
        my string $init_keyword = $self->{children}->[0];
        my string $left_brace = $self->{children}->[1];
        my string $module_name = $self->{children}->[2]->{children}->[0];
        my string $thinarrow_import_left_parentheses = $self->{children}->[3];
        my string $qw = q{};
        if (defined $self->{children}->[4]->{children}->[0]) {
            $qw = $self->{children}->[4]->{children}->[0]->{attr};
        }
        my string $right_parentheses         = $self->{children}->[5];
        my string $semicolon         = $self->{children}->[6];
        my string $right_brace         = $self->{children}->[7];
        $rperl_source_group->{PMC} .= 
            $init_keyword . q{ } . $left_brace . q{ } .
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
    # 'INIT { Foo->import(); }'
    # 'INIT { Foo->import(qw(bar)); }'
    if (( ref $self eq 'Include_54' ) or ( ref $self eq 'Include_55' )) {
        my string $module_name;
        # Include -> USE WordScoped ...
        if ( ref $self eq 'Include_54' ) {
            $module_name = $self->{children}->[1]->{children}->[0];
        }
        # Include -> 'INIT' LBRACE WordScoped ...
        else {
            $module_name = $self->{children}->[2]->{children}->[0];
        }

        # DEV NOTE, CORRELATION #rp044: shared logic between class parent includes and misc user includes, always check both when changing either
        my boolean $is_rperl_system = 0;
        my boolean $is_rperl_test = 0;
        if ( ( ( substr $module_name, 0, 5 ) eq 'RPerl' ) or ( ( substr $module_name, 0, 5 ) eq 'rperl' ) ) {
            if ( ( substr $module_name, 0, 11 ) eq 'RPerl::Test' ) {
                $is_rperl_test = 1;
            }
            else {
                $is_rperl_system = 1;
            }
        }

        if ( $module_name =~ /^\w+Perl::Config$/ ) { # DEV NOTE, CORRELATION #rp027: MathPerl::Config, PhysicsPerl::Config, etc
#            RPerl::diag('in CompileUnit::Include->ast_to_cpp__generate__CPPOPS_CPPTYPES(), skipping system config file $module_name = ' . $module_name . "\n");
        }
        elsif ( $is_rperl_test or (not $is_rperl_system) ) {
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
        else {
            # DEV NOTE: ignore manually included RPerl* and rperl* system modules, they should all be automatically included in Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES();
            # delete empty H to avoid error...
            # ERROR ECOCOFI05, COMPILER, SAVE OUTPUT FILES: Expecting source code for suffix 'H', but received empty or no 
#            RPerl::diag('in Include->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have RPerl system module to skip here and defer to Class::Generator->ast_to_cpp__generate__CPPOPS_CPPTYPES() $module_name = ' . $module_name . "\n");
            delete $cpp_source_group->{H};
        }
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule ' . ( ref $self ) . ' found where Include_54 or Include_55 expected, dying' ) . "\n";
    }
    
#    RPerl::diag( 'in Include->ast_to_cpp__generate__CPPOPS_CPPTYPES(), about to return $cpp_source_group = ' . "\n" . RPerl::Parser::rperl_ast__dump($cpp_source_group) . "\n" );
    return $cpp_source_group;
}

1;    # end of class
