# [[[ HEADER ]]]
package RPerl::Algorithm::Sort::Bubble;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.010_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Algorithm::Sort);
use RPerl::Algorithm::Sort;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case & mixed-case package names
## no critic qw(ProhibitAutomaticExportation)  # SYSTEM SPECIAL 14: allow global exports from Config.pm & elsewhere

# [[[ EXPORTS ]]]
use RPerl::Exporter qw(import);
our @EXPORT = qw(integer_sort number_sort integer_bubblesort number_bubblesort uninherited_Bubble uninherited integer_bubblesort_typetest0 number_bubblesort_typetest0);
#our @EXPORT_OK = qw(integer_sort number_sort integer_bubblesort number_bubblesort uninherited_Bubble uninherited integer_bubblesort_typetest0 number_bubblesort_typetest0);

# [[[ CONSTANTS ]]]
use constant TIME_BEST    => my string $TYPED_TIME_BEST    = 'O($n)';
use constant TIME_AVERAGE => my string $TYPED_TIME_AVERAGE = 'O($n ** 2)';
use constant TIME_WORST   => my string $TYPED_TIME_WORST   = 'O($n ** 2)';
use constant SPACE_WORST  => my string $TYPED_SPACE_WORST  = 'O(1)';

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    integer_data => my integer_arrayref $TYPED_integer_data = undef,
    number_data  => my number_arrayref $TYPED_number_data   = undef
};

# [[[ SUBROUTINES & OO METHODS ]]]

sub integer_sort {
    { my void::method $RETURN_TYPE };
    ( my RPerl::Algorithm::Sort::Bubble $self ) = @ARG;
    $self->{integer_data} = RPerl::Algorithm::Sort::Bubble::integer_bubblesort( $self->{integer_data} );
    return;
}

sub number_sort {
    { my void::method $RETURN_TYPE };
    ( my RPerl::Algorithm::Sort::Bubble $self ) = @ARG;
    $self->{number_data} = RPerl::Algorithm::Sort::Bubble::number_bubblesort( $self->{number_data} );
    return;
}

sub integer_bubblesort {
    { my integer_arrayref $RETURN_TYPE };
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
}

sub number_bubblesort {
    { my number_arrayref $RETURN_TYPE };
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
}

# [ INHERITANCE TESTING ]

sub inherited_Bubble {
    { my void::method $RETURN_TYPE };
    ( my RPerl::Algorithm::Sort::Bubble $self, my string $person ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Bubble->inherited_Bubble(), have ::class($self) = ' . ::class($self) . ' and $person = ' . $person . ', FRIED' . "\n" );
    return;
}

# NEED UPGRADE, CORRELATION #rp023: Inline::CPP support for multiple inheritance
#sub inherited_Bubble_bar_set {
#   { my void::method $RETURN_TYPE };
#    ( my RPerl::Algorithm::Sort::Bubble $self, my string $bar_new ) = @ARG;
#    RPerl::diag( 'in PERLOPS_PERLTYPES Bubble->inherited_Bubble_bar_set(), have ::class($self) = ' . ::class($self) . ' and $bar_new = ' . $bar_new . ', FRIED' . "\n" );
#    $self->{bar} = $bar_new;
#}

sub inherited_Bubble_foo_get {
    { my string::method $RETURN_TYPE };
    ( my RPerl::Algorithm::Sort::Bubble $self ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Bubble->inherited_Bubble_foo_get(), have ::class($self) = ' . ::class($self) . ', FRIED' . "\n" );
    return $self->{foo};
}

sub inherited_Bubble_foo_set {
    { my void::method $RETURN_TYPE };
    ( my RPerl::Algorithm::Sort::Bubble $self, my string $foo_new ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Bubble->inherited_Bubble_foo_set(), have ::class($self) = ' . ::class($self) . ' and $foo_new = ' . $foo_new . ', FRIED' . "\n" );
    $self->{foo} = $foo_new;
    return;
}

sub inherited {
    { my void::method $RETURN_TYPE };
    ( my RPerl::Algorithm::Sort::Bubble $self, my string $person ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Bubble->inherited(), have ::class($self) = ' . ::class($self) . ' and $person = ' . $person . ', ILLOGICAL' . "\n" );
    return;
}

sub uninherited_Bubble {
    { my string $RETURN_TYPE };
    ( my string $person ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Bubble::uninherited_Bubble(), received $person = ' . $person . ', MITOCHONDRIAL' . "\n" );
    return 'Bubble::uninherited_Bubble() RULES! PERLOPS_PERLTYPES';
}

# DEV NOTE, CORRELATION #rp004: inheritance testing, manually enable uninherited() in exactly one of Algorithm.*, Inefficient.*, Sort.*, or Bubble.*
sub uninherited {
    { my string $RETURN_TYPE };
    ( my string $person ) = @ARG;
    RPerl::diag( 'in PERLOPS_PERLTYPES Bubble::uninherited(), received $person = ' . $person . ', TETRAHEDRON' . "\n" );
    return 'Bubble::uninherited() ROCKS! PERLOPS_PERLTYPES';
}

# [ TYPE TESTING ]

sub integer_bubblesort_typetest0 {
    { my string $RETURN_TYPE };
    ( my integer_arrayref $lucky_integers ) = @ARG;
    ::integer_arrayref_CHECKTRACE( $lucky_integers, '$lucky_integers', 'integer_bubblesort_typetest0()' );
    return ( ::integer_arrayref_to_string( RPerl::Algorithm::Sort::Bubble::integer_bubblesort($lucky_integers) ) . 'PERLOPS_PERLTYPES' );
}

sub number_bubblesort_typetest0 {
    { my string $RETURN_TYPE };
    ( my number_arrayref $lucky_numbers ) = @ARG;
    ::number_arrayref_CHECKTRACE( $lucky_numbers, '$lucky_numbers', 'number_bubblesort_typetest0()' );
    return ( ::number_arrayref_to_string( RPerl::Algorithm::Sort::Bubble::number_bubblesort($lucky_numbers) ) . 'PERLOPS_PERLTYPES' );
}

1;    # end of class
