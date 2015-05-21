# [[[ HEADER ]]]
package RPerl::CodeBlock::Subroutine::Method;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.003_010;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CodeBlock::Subroutine);
use RPerl::CodeBlock::Subroutine;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };
    my string_hashref $rperl_source_subgroup;

#    RPerl::diag( 'in Method->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    # unwrap Method_69 from MethodOrSubroutine_74
    if ( ( ref $self ) eq 'MethodOrSubroutine_74' ) {
        $self = $self->{children}->[0];
    }

    if ( ref $self ne 'Method_69' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEAS00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . ( ref $self )
                . ' found where Method_69 expected, dying' )
            . "\n";
    }

    my string $our                = $self->{children}->[0];
    my string $return_type        = $self->{children}->[1];
    my string $name               = $self->{children}->[2];
    my string $equal_sub          = $self->{children}->[3];
    my object $optional_arguments = $self->{children}->[4];
    my object $star_operations    = $self->{children}->[5];
    my string $right_brace        = $self->{children}->[6];
    my string $semicolon          = $self->{children}->[7];

    $rperl_source_group->{PMC}
        .= $our . q{ } . $return_type . q{ } . $name . q{ } . $equal_sub;

    if ( exists $optional_arguments->{children}->[0] ) {
        $rperl_source_subgroup = $optional_arguments->{children}->[0]
            ->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
    }

    foreach my object $operation ( @{ $star_operations->{children} } ) {
        $rperl_source_subgroup = $operation->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
    }

    $rperl_source_group->{PMC} .= $right_brace . $semicolon;
    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = {
        CPP => q{// <<< RP::CB::S::M DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>}
            . "\n"
        };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = {
        CPP => q{// <<< RP::CB::S::M DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>}
            . "\n"
        };

    #...
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
