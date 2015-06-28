# [[[ HEADER ]]]
package RPerl::CodeBlock::Subroutine::Method;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.003_110;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CodeBlock::Subroutine);
use RPerl::CodeBlock::Subroutine;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ INCLUDES ]]]
use Storable qw(dclone);

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };
    my string_hashref $rperl_source_subgroup;

    #    RPerl::diag( 'in Method->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    # unwrap Method_69 from MethodOrSubroutine_74
    if ( ( ref $self ) eq 'MethodOrSubroutine_74' ) {
        $self = $self->{children}->[0];
    }

    if ( ( ref $self ) ne 'Method_69' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule ' . ( ref $self ) . ' found where Method_69 expected, dying' )
            . "\n";
    }

    my string $our                = $self->{children}->[0];
    my string $return_type        = $self->{children}->[1];
    my string $name               = $self->{children}->[2];
    my string $equal_sub          = $self->{children}->[3];
    my object $arguments_optional = $self->{children}->[4];
    my object $operations_star    = $self->{children}->[5];
    my string $right_brace        = $self->{children}->[6];
    my string $semicolon          = $self->{children}->[7];

    $rperl_source_group->{PMC} .= $our . q{ } . $return_type . q{ } . $name . q{ } . $equal_sub . "\n";

    if ( exists $arguments_optional->{children}->[0] ) {
        $rperl_source_subgroup = $arguments_optional->{children}->[0]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }

    foreach my object $operation ( @{ $operations_star->{children} } ) {
        $rperl_source_subgroup = $operation->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }

    $rperl_source_group->{PMC} .= $right_brace . $semicolon . "\n\n";
    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::CB::S::M __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { H => q{} };

#    RPerl::diag( 'in Method->ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    $self             = $self->{children}->[0];     # unwrap Method_69 from MethodOrSubroutine_74
    my string $return_type = $self->{children}->[1];
    substr $return_type, -7, 7, '';                      # remove leading 'method_'
    my string $name = $self->{children}->[2];
    substr $name, 0, 1, '';                              # remove leading $ sigil
    my object $arguments_optional = $self->{children}->[4];

#    RPerl::diag( 'in Method->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $name = ' . $name . "\n" );
#    RPerl::diag( 'in Method->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $arguments_optional = ' . "\n" . RPerl::Parser::rperl_ast__dump($arguments_optional) . "\n" );

    $cpp_source_group->{H} .= q{    } . $return_type . q{ } . $name . '(';
    if ( exists $arguments_optional->{children}->[0] ) {
        my object $arguments = $arguments_optional->{children}->[0];
        my string_hashref $cpp_source_subgroup = $arguments->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        $cpp_source_group->{H} .= $cpp_source_subgroup->{CPP};
    }
    $cpp_source_group->{H} .= ');';

    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string $package_name_underscores, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{} };
    my string_hashref $cpp_source_subgroup;

    #    RPerl::diag( 'in Method->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    # unwrap Method_69 from MethodOrSubroutine_74
    if ( ( ref $self ) eq 'MethodOrSubroutine_74' ) {
        $self = $self->{children}->[0];
    }

    if ( ( ref $self ) ne 'Method_69' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: grammar rule ' . ( ref $self ) . ' found where Method_69 expected, dying' )
            . "\n";
    }

    my string $return_type        = $self->{children}->[1];
    my string $name               = $self->{children}->[2];
    my object $arguments_optional = $self->{children}->[4];
    my object $operations_star    = $self->{children}->[5];

    $cpp_source_group->{CPP} .= (substr $return_type, 0, ((length $return_type) - 7)) . q{ } . $package_name_underscores . '::' . (substr $name, 1) . '(';

    if ( exists $arguments_optional->{children}->[0] ) {
        $cpp_source_subgroup = $arguments_optional->{children}->[0]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
    }

    $cpp_source_group->{CPP} .= ') {' . "\n";

    foreach my object $operation ( @{ $operations_star->{children} } ) {
        $cpp_source_subgroup = $operation->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
    }

    $cpp_source_group->{CPP} .= '}';
    return $cpp_source_group;
};

# [[[ TYPES & SUBTYPES BELOW THIS LINE ]]]

# a method is a subroutine belonging to a class or object
package method;
use parent ('RPerl::CodeBlock::Subroutine::Method');

# [[[ SCALAR & SCALAR REF METHODS ]]]

# method with void return type
package void_method;
use parent -norequire, ('method');

# method with integer return type
package integer_method;
use parent -norequire, ('method');

# method with float return type
package float_method;
use parent -norequire, ('method');

# method with number return type
package number_method;
use parent -norequire, ('method');

# method with char return type
package char_method;
use parent -norequire, ('method');

# method with string return type
package string_method;
use parent -norequire, ('method');

# method with scalartype return type
package scalartype_method;
use parent -norequire, ('method');

# method with unknown return type
package unknown_method;
use parent -norequire, ('method');

# method with object return type
package object_method;
use parent -norequire, ('method');

# [[[ HASH METHODS ]]]

package integer_hashref_method;
use parent -norequire, ('method');

package number_hashref_method;
use parent -norequire, ('method');

package string_hashref_method;
use parent -norequire, ('method');

package object_hashref_method;
use parent -norequire, ('method');

package hashref_hashref_method;
use parent -norequire, ('method');

# [[[ ARRAY METHODS ]]]

package integer_arrayref_method;
use parent -norequire, ('method');

package number_arrayref_method;
use parent -norequire, ('method');

package string_arrayref_method;
use parent -norequire, ('method');

package object_arrayref_method;
use parent -norequire, ('method');

package arrayref_arrayref_method;
use parent -norequire, ('method');

1;
