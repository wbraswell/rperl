# [[[ HEADER ]]]
package RPerl::Algorithm::Sort::Bubble;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.007_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Algorithm::Sort);
use RPerl::Algorithm::Sort;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    complexity => my string $TYPED_complexity = 'O($n ** 2)',
    usefulness => my string $TYPED_usefulness = 'simple educational example',
    integer_data => my integer_arrayref $TYPED_integer_data = undef,
    number_data  => my number_arrayref $TYPED_number_data   = undef
};

# [[[ SUBROUTINES & OO METHODS ]]]

our void::method $integer_sort = sub {
    ( my object $self ) = @ARG;
    $self->{integer_data} = RPerl::Algorithm::Sort::Bubble::integer_bubblesort( $self->{integer_data} );
};

our void::method $number_sort = sub {
    ( my object $self ) = @ARG;
    $self->{number_data} = RPerl::Algorithm::Sort::Bubble::number_bubblesort( $self->{number_data} );
};

our void::method $inherited__Bubble = sub {
    ( my object $self, my string $person ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Bubble->inherited__Bubble(), have ::class($self) = ' . ::class($self) . ' and $person = ' . $person . ', FRIED' . "\n" );
};

our void::method $inherited = sub {
    ( my object $self, my string $person ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Bubble->inherited(), have ::class($self) = ' . ::class($self) . ' and $person = ' . $person . ', ILLOGICAL' . "\n" );
};

our integer_arrayref $integer_bubblesort = sub {
    ( my integer_arrayref $integer_data ) = @ARG;
    ::integer_arrayref_CHECKTRACE( $integer_data, '$integer_data', 'integer_bubblesort()' );
    my integer $is_sorted           = 0;
    my integer $integer_data_length = scalar @{$integer_data};    # CONSTANT
    my integer $integer_data_i;
    my integer $integer_data_i_plus_1;
#    my integer $swap;
    while ( not $is_sorted ) {
        $is_sorted = 1;
        for my integer $i ( 0 .. ( $integer_data_length - 2 ) ) {
            $integer_data_i = $integer_data->[$i];
            $integer_data_i_plus_1 = $integer_data->[ ( $i + 1 ) ];
            if ( $integer_data_i > $integer_data_i_plus_1 ) {
                $is_sorted          = 0;
#                $swap               = $integer_data_i;
                $integer_data->[$i] = $integer_data_i_plus_1;
#                $integer_data->[ ( $i + 1 ) ] = $swap;
                $integer_data->[ ( $i + 1 ) ] = $integer_data_i;
            }
        }
    }
    return $integer_data;
};

our number_arrayref $number_bubblesort = sub {
    ( my number_arrayref $number_data ) = @ARG;
    ::number_arrayref_CHECKTRACE( $number_data, '$number_data', 'number_bubblesort()' );
    my integer $is_sorted          = 0;
    my integer $number_data_length = scalar @{$number_data};    # CONSTANT
    my number $number_data_i;
    my number $number_data_i_plus_1;
#    my number $swap;
    while ( not $is_sorted ) {
        $is_sorted = 1;
        for my integer $i ( 0 .. ( $number_data_length - 2 ) ) {
            $number_data_i = $number_data->[$i];
            $number_data_i_plus_1 = $number_data->[ ( $i + 1 ) ];
            if ( $number_data_i > $number_data_i_plus_1 ) {
                $is_sorted         = 0;
#                $swap              = $number_data_i;
                $number_data->[$i] = $number_data_i_plus_1;
#                $number_data->[ ( $i + 1 ) ] = $swap;
                $number_data->[ ( $i + 1 ) ] = $number_data_i;
            }
        }
    }
    return $number_data;
};

our string $uninherited__Bubble = sub {
    ( my string $person ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Bubble::uninherited__Bubble(), received $person = ' . $person . ', MITOCHONDRIAL' . "\n" );
    return 'Bubble::uninherited__Bubble() RULES! PERLOPS_PERLTYPES';
};

# DEV NOTE, CORRELATION #rp004: inheritance testing, manually enable uninherited() in exactly one of Algorithm.*, Inefficient.*, Sort.*, or Bubble.*
our string $uninherited = sub {
    ( my string $person ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Bubble::uninherited(), received $person = ' . $person . ', TETRAHEDRON' . "\n" );
    return 'Bubble::uninherited() ROCKS! PERLOPS_PERLTYPES';
};

our string $integer_bubblesort__typetest0 = sub {
    ( my integer_arrayref $lucky_integers ) = @ARG;
    ::integer_arrayref_CHECKTRACE( $lucky_integers, '$lucky_integers', 'integer_bubblesort__typetest0()' );
    return ( ::integer_arrayref_to_string( RPerl::Algorithm::Sort::Bubble::integer_bubblesort($lucky_integers) ) . 'PERLOPS_PERLTYPES' );
};

our string $number_bubblesort__typetest0 = sub {
    ( my number_arrayref $lucky_numbers ) = @ARG;
    ::number_arrayref_CHECKTRACE( $lucky_numbers, '$lucky_numbers', 'number_bubblesort__typetest0()' );
    return ( ::number_arrayref_to_string( RPerl::Algorithm::Sort::Bubble::number_bubblesort($lucky_numbers) ) . 'PERLOPS_PERLTYPES' );
};

1;    # end of class
