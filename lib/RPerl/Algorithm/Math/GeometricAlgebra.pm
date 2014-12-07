# [[[ CHECK: TRACE ]]]
# [[[ HEADER ]]]
package RPerl::Algorithm::Math::GeometricAlgebra;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_002;

# [[[ OO INHERITANCE ]]]
use parent ('RPerl::Algorithm::Math');
use RPerl::Algorithm::Math;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values and print operator
## no critic qw(RequireInterpolationOfMetachars)  # SYSTEM DEFAULT 2: allow single-quoted control characters, sigils, and regexes

# [[[ OO OBJECT PROPERTIES ]]]
our %properties = ( ## no critic qw(ProhibitPackageVars)  # USER DEFAULT 2: allow OO properties
);

# [[[ SUBROUTINES ]]]

our number $inner_product__vector_vector_euclidean = sub {
    (   my number__array_ref $input_vector_1,
        my number__array_ref $input_vector_2)
        = @_;

#    ::number__array_ref__CHECK($input_vector_1);
#    ::number__array_ref__CHECKTRACE( $input_vector_1, '$input_vector_1', 'inner_product__vector_vector_euclidean()' );

#    ::number__array_ref__CHECK($input_vector_2);
#    ::number__array_ref__CHECKTRACE( $input_vector_2, '$input_vector_2', 'inner_product__vector_vector_euclidean()' );

    # bound checking
    ( ( scalar @{$input_vector_1} ) == 4 )
        or croak('Argument vector 1 is not of magnitude 4, croaking');
    ( ( scalar @{$input_vector_2} ) == 4 )
        or croak('Argument vector 2 is not of magnitude 4, croaking');

    my number $return_value_number = 0.0;

#    RPerl::diag "in PERLOPS_PERLTYPES inner_product__vector_vector_euclidean(), top of subroutine...\n" or croak();
#    RPerl::diag "in PERLOPS_PERLTYPES inner_product__vector_vector_euclidean(), received \$input_vector_1\n" . Dumper($input_vector_1) . "\n";
#    RPerl::diag "in PERLOPS_PERLTYPES inner_product__vector_vector_euclidean(), received \$input_vector_2\n" . Dumper($input_vector_2) . "\n";

    for my integer $i ( 1 .. 3 ) {

#       RPerl::diag "in PERLOPS_PERLTYPES inner_product__vector_vector_euclidean(), inside for() loop \$i = $i\n";

        $return_value_number = $return_value_number
            + ( $input_vector_1->[$i] * $input_vector_2->[$i] );

#       RPerl::diag "in PERLOPS_PERLTYPES inner_product__vector_vector_euclidean(), inside for() loop \$i = $i, have \$input_vector_1->[$i] = $input_vector_1->[$i]\n";
#       RPerl::diag "in PERLOPS_PERLTYPES inner_product__vector_vector_euclidean(), inside for() loop \$i = $i, have \$input_vector_2->[$i] = $input_vector_2->[$i]\n";
#       RPerl::diag "in PERLOPS_PERLTYPES inner_product__vector_vector_euclidean(), inside for() loop \$i = $i, have \$return_value_number = $return_value_number\n";
    }

    return $return_value_number;
};

our number__array_ref $inner_product__bivector_vector_euclidean = sub {
    (   my number__array_ref $input_bivector,
        my number__array_ref $input_vector)
        = @_;

#    ::number__array_ref__CHECK($input_bivector);
#    ::number__array_ref__CHECKTRACE( $input_bivector, '$input_bivector', 'inner_product__bivector_vector_euclidean()' );

#    ::number__array_ref__CHECK($input_vector);
#    ::number__array_ref__CHECKTRACE( $input_vector, '$input_vector', 'inner_product__bivector_vector_euclidean()' );

    # bound checking
    ( ( scalar @{$input_bivector} ) == 4 )
        or croak('Argument bivector is not of magnitude 4, croaking');
    ( ( scalar @{$input_vector} ) == 4 )
        or croak('Argument vector is not of magnitude 4, croaking');

    my number__array_ref $return_value_vector = [];

#    RPerl::diag "in PERLOPS_PERLTYPES inner_product__bivector_vector_euclidean(), top of subroutine...\n" or croak();
#    RPerl::diag "in PERLOPS_PERLTYPES inner_product__bivector_vector_euclidean(), received \$input_bivector\n" . Dumper($input_bivector) . "\n";
#    RPerl::diag "in PERLOPS_PERLTYPES inner_product__bivector_vector_euclidean(), received \$input_vector\n" . Dumper($input_vector) . "\n";

    $return_value_vector->[1] = ( $input_bivector->[1] * $input_vector->[2] )
        - ( $input_bivector->[3] * $input_vector->[3] );
    $return_value_vector->[2] = ( $input_bivector->[2] * $input_vector->[3] )
        - ( $input_bivector->[1] * $input_vector->[1] );
    $return_value_vector->[3] = ( $input_bivector->[3] * $input_vector->[1] )
        - ( $input_bivector->[2] * $input_vector->[2] );

#    RPerl::diag "in PERLOPS_PERLTYPES inner_product__bivector_vector_euclidean(), returning \$return_value_vector\n" . Dumper($return_value_vector) . "\n";
    return $return_value_vector;
};

our number__array_ref $outer_product__vector_vector_euclidean = sub {
    (   my number__array_ref $input_vector_1,
        my number__array_ref $input_vector_2)
        = @_;

#    ::number__array_ref__CHECK($input_vector_1);
#    ::number__array_ref__CHECKTRACE( $input_vector_1, '$input_vector_1', 'outer_product__vector_vector_euclidean()' );

#    ::number__array_ref__CHECK($input_vector_2);
#    ::number__array_ref__CHECKTRACE( $input_vector_2, '$input_vector_2', 'outer_product__vector_vector_euclidean()' );

    # bound checking
    ( ( scalar @{$input_vector_1} ) == 4 )
        or croak('Argument vector 1 is not of magnitude 4, croaking');
    ( ( scalar @{$input_vector_2} ) == 4 )
        or croak('Argument vector 2 is not of magnitude 4, croaking');

    my number__array_ref $return_value_bivector = [];

#    RPerl::diag "in PERLOPS_PERLTYPES outer_product__vector_vector_euclidean(), top of subroutine...\n" or croak();
#    RPerl::diag "in PERLOPS_PERLTYPES outer_product__vector_vector_euclidean(), received \$input_vector_1\n" . Dumper($input_vector_1) . "\n";
#    RPerl::diag "in PERLOPS_PERLTYPES outer_product__vector_vector_euclidean(), received \$input_vector_2\n" . Dumper($input_vector_2) . "\n";

    $return_value_bivector->[1]
        = ( $input_vector_1->[1] * $input_vector_2->[2] )
        - ( $input_vector_1->[2] * $input_vector_2->[1] );
    $return_value_bivector->[2]
        = ( $input_vector_1->[2] * $input_vector_2->[3] )
        - ( $input_vector_1->[3] * $input_vector_2->[2] );
    $return_value_bivector->[3]
        = ( $input_vector_1->[3] * $input_vector_2->[1] )
        - ( $input_vector_1->[1] * $input_vector_2->[3] );

#    RPerl::diag "in PERLOPS_PERLTYPES inner_product__bivector_vector_euclidean(), returning \$return_value_bivector\n" . Dumper($return_value_bivector) . "\n";
    return $return_value_bivector;
};

our number $outer_product__bivector_vector_euclidean = sub {
    (   my number__array_ref $input_bivector,
        my number__array_ref $input_vector)
        = @_;

#    ::number__array_ref__CHECK($input_bivector);
#    ::number__array_ref__CHECKTRACE( $input_bivector, '$input_bivector', 'outer_product__bivector_vector_euclidean()' );

#    ::number__array_ref__CHECK($input_vector);
#    ::number__array_ref__CHECKTRACE( $input_vector, '$input_vector', 'outer_product__bivector_vector_euclidean()' );

    # bound checking
    ( ( scalar @{$input_bivector} ) == 4 )
        or croak('Argument bivector is not of magnitude 4, croaking');
    ( ( scalar @{$input_vector} ) == 4 )
        or croak('Argument vector is not of magnitude 4, croaking');

    my number $return_value_number;

#    RPerl::diag "in PERLOPS_PERLTYPES outer_product__vector_vector_euclidean(), top of subroutine...\n" or croak();
#    RPerl::diag "in PERLOPS_PERLTYPES outer_product__vector_vector_euclidean(), received \$input_vector_1\n" . Dumper($input_vector_1) . "\n";
#    RPerl::diag "in PERLOPS_PERLTYPES outer_product__vector_vector_euclidean(), received \$input_vector_2\n" . Dumper($input_vector_2) . "\n";

    $return_value_number
        = ( $input_bivector->[1] * $input_vector->[3] )
        + ( $input_bivector->[2] * $input_vector->[1] )
        + ( $input_bivector->[3] * $input_vector->[2] );

#    RPerl::diag "in PERLOPS_PERLTYPES outer_product__vector_vector_euclidean(), have \$return_value_number = $return_value_number\n";
    return $return_value_number;
};

1;  # end of class
