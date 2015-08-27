# [[[ HEADER ]]]
package RPerl::CompileUnit::Constant;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.001_200;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit);
use RPerl::CompileUnit;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref::method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

    #    RPerl::diag( 'in CompileUnit::Constant->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $use_constant           = $self->{children}->[0];
    my string $name                   = $self->{children}->[1];
    my string $fat_arrow              = $self->{children}->[2];
    my object $type_inner_constant    = $self->{children}->[3];
    my string $type_inner_constant_my = $type_inner_constant->{children}->[0];
    my string $type_inner_constant_type
        = $type_inner_constant->{children}->[1]->{children}->[0];
    my string $type_inner_constant_TYPED = $type_inner_constant->{children}->[2];
    my string $type_inner_constant_name  = $type_inner_constant->{children}->[3];
    my string $type_inner_constant_equal = $type_inner_constant->{children}->[4];
    my object $subexpression             = $self->{children}->[4];
    my string $semicolon                 = $self->{children}->[5];

    $rperl_source_group->{PMC}
        .= $use_constant . q{ }
        . $name . q{ }
        . $fat_arrow . q{ }
        . $type_inner_constant_my . q{ }
        . $type_inner_constant_type . q{ }
        . $type_inner_constant_TYPED
        . $type_inner_constant_name . q{ }
        . $type_inner_constant_equal . q{ };

    my string_hashref $rperl_source_subgroup = $subexpression->ast_to_rperl__generate($modes);
    RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );

    $rperl_source_group->{PMC} .= $semicolon . "\n";

    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { H => q{// <<< RP::CU::Co __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string $package_name_underscores, my string_hashref $modes ) = @_;
    my string_hashref $cpp_source_group = { H => q{} };

   #RPerl::diag( 'in CompileUnit::Constant->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $name                     = $self->{children}->[1];
    my string $type_inner_constant_type = $self->{children}->[3]->{children}->[1]->{children}->[0];
    my object $subexpression            = $self->{children}->[4];

    if ( exists $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{_global}->{$name} ) {
        die 'ERROR ECVGEASCP10, CODE GENERATOR, ABSTRACT SYNTAX TO C++: variable '
            . $name
            . ' already declared in this scope, namespace '
            . $modes->{_symbol_table}->{_namespace}
            . ', subroutine/method '
            . $modes->{_symbol_table}->{_subroutine}
            . '(), dying' . "\n";
    }
    $modes->{_symbol_table}->{ $modes->{_symbol_table}->{_namespace} }->{_global}->{$name}
        = { isa => 'RPerl::CompileUnit::Constant', type => $type_inner_constant_type };

    $cpp_source_group->{H} .= 'const ' . $type_inner_constant_type . q{ } . $package_name_underscores . '__' . $name . ' = ';

#    RPerl::diag( 'in CompileUnit::Constant->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $subexpression = ' . "\n" . RPerl::Parser::rperl_ast__dump($subexpression) . "\n" );

    my string_hashref $cpp_source_subgroup = $subexpression->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
    $cpp_source_group->{H} .= $cpp_source_subgroup->{CPP};
    $cpp_source_group->{H} .= ';' . "\n";

    return $cpp_source_group;
};

1;                                                                                         # end of class
