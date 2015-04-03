## no critic qw(ProhibitUselessNoCritic PodSpelling ProhibitExcessMainComplexity)  # DEVELOPER DEFAULT 1a: allow unreachable & POD-commented code; SYSTEM SPECIAL 5: allow complex code outside subroutines, must be on line 1
package RPerl::DataStructure::Array::SubTypes;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.005_010;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitUnreachableCode RequirePodSections RequirePodAtEnd) # DEVELOPER DEFAULT 1b: allow unreachable & POD-commented code, must be after line 1
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages)  # SYSTEM DEFAULT 3: allow multiple lower case package names

# [[[ ARRAYS ]]]

# an array is a 1-dimensional list/vector/sequence/set of data types;
# we never use this type directly, instead we always use the array_ref type,
# per LMPC #27: Thou Shalt Not Use Direct Access To Arrays & Hashes Stored In @ Or % Non-Scalar Variables
package array;
use parent ('RPerl::DataStructure::Array');

# [[[ ARRAY REF ]]]
# [[[ ARRAY REF ]]]
# [[[ ARRAY REF ]]]

# ref to array
package array_ref;
use parent -norequire, ('ref');
use Carp;

# [[[ TYPE-CHECKING ]]]

our void $array_ref__CHECK = sub {
    ( my $possible_array_ref ) = @_;
    if ( not( defined $possible_array_ref ) ) {
        croak(
            "\nERROR EAVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\narray_ref value expected but undefined/null value found,\ncroaking"
        );
    }

#    if ( UNIVERSAL::isa( $possible_array_ref, 'ARRAY' ) ) {  # DEV NOTE: I believe these 2 lines are equivalent?
    if ( not( main::RPerl_SvAROKp($possible_array_ref) ) ) {
        croak(
            "\nERROR EAVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\narray_ref value expected but non-array_ref value found,\ncroaking"
        );
    }
};
our void $array_ref__CHECKTRACE = sub {
    ( my $possible_array_ref, my $variable_name, my $subroutine_name ) = @_;
    if ( not( defined $possible_array_ref ) ) {
        croak(
            "\nERROR EAVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\narray_ref value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }
    if ( not( main::RPerl_SvAROKp($possible_array_ref) ) ) {
        croak(
            "\nERROR EAVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\narray_ref value expected but non-array_ref value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }
};

# ref to (array with const size)
package const_array_ref;
use parent -norequire, ('ref');

# [[[ INTEGER ARRAY REF ]]]
# [[[ INTEGER ARRAY REF ]]]
# [[[ INTEGER ARRAY REF ]]]

# (ref to array) of integers
package integer__array_ref;
use parent -norequire, ('array_ref');
use Carp;

# [[[ TYPE-CHECKING ]]]

our void $integer__array_ref__CHECK = sub {
    ( my $possible_integer__array_ref ) = @_;

# DEV NOTE: the following two if() statements are functionally equivalent to the array_ref__CHECK() subroutine, but with integer-specific error codes
    if ( not( defined $possible_integer__array_ref ) ) {
        croak(
            "\nERROR EIVAVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger__array_ref value expected but undefined/null value found,\ncroaking"
        );
    }

    if ( not( main::RPerl_SvAROKp($possible_integer__array_ref) ) ) {
        croak(
            "\nERROR EIVAVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger__array_ref value expected but non-array_ref value found,\ncroaking"
        );
    }

    my integer $possible_integer;
    for my integer $i (
        0 .. ( ( scalar @{$possible_integer__array_ref} ) - 1 ) )
    {
        $possible_integer = $possible_integer__array_ref->[$i];

# DEV NOTE: the following two if() statements are functionally equivalent to the integer__CHECK() subroutine, but with array-specific error codes
        if ( not( defined $possible_integer ) ) {
            croak(
                "\nERROR EIVAVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger__array_ref element value expected but undefined/null value found at index $i,\ncroaking"
            );
        }
        if ( not( main::RPerl_SvIOKp($possible_integer) ) ) {
            croak(
                "\nERROR EIVAVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger__array_ref element value expected but non-integer value found at index $i,\ncroaking"
            );
        }
    }
};
our void $integer__array_ref__CHECKTRACE = sub {
    (   my $possible_integer__array_ref,
        my $variable_name,
        my $subroutine_name
    ) = @_;
    if ( not( defined $possible_integer__array_ref ) ) {
        croak(
            "\nERROR EIVAVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger__array_ref value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }
    if ( not( main::RPerl_SvAROKp($possible_integer__array_ref) ) ) {
        croak(
            "\nERROR EIVAVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger__array_ref value expected but non-array_ref value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }

    my integer $possible_integer;
    for my integer $i (
        0 .. ( ( scalar @{$possible_integer__array_ref} ) - 1 ) )
    {
        $possible_integer = $possible_integer__array_ref->[$i];
        if ( not( defined $possible_integer ) ) {
            croak(
                "\nERROR EIVAVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger__array_ref element value expected but undefined/null value found at index $i,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
            );
        }
        if ( not( main::RPerl_SvIOKp($possible_integer) ) ) {
            croak(
                "\nERROR EIVAVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger__array_ref element value expected but non-integer value found at index $i,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
            );
        }
    }
};

# [[[ STRINGIFY ]]]

# convert from (Perl SV containing RV to (Perl AV of (Perl SVs containing IVs))) to Perl-parsable (Perl SV containing PV)
our string $integer__array_ref__stringify = sub {
    ( my $input_av_ref ) = @_;

#    RPerl::diag "in PERLOPS_PERLTYPES integer__array_ref__stringify(), top of subroutine\n" or croak();

    #    ::integer__array_ref__CHECK($input_av_ref);
    ::integer__array_ref__CHECKTRACE( $input_av_ref, '$input_av_ref',
        'integer__array_ref__stringify()' );

    my @input_av;
    my integer $input_av_length;
    my integer $input_av_element;
    my string $output_sv;
    my integer $i_is_0 = 1;   # NEED UPGRADE: should be bool type, not integer

    @input_av        = @{$input_av_ref};
    $input_av_length = scalar @input_av;

#	RPerl::diag "in PERLOPS_PERLTYPES integer__array_ref__stringify(), have \$input_av_length = $input_av_length\n";

    $output_sv = '[';

    for my integer $i ( 0 .. ( $input_av_length - 1 ) ) {

        $input_av_element = $input_av[$i];

# DEV NOTE: integer type-checking already done as part of integer__array_ref__CHECKTRACE()
#        ::integer__CHECK($input_av_element);
#::integer__CHECKTRACE( $input_av_element, "\$input_av_element at index $i", 'integer__array_ref__stringify()' );

        if ($i_is_0) { $i_is_0 = 0; }
        else         { $output_sv .= ', '; }
        $output_sv .= $input_av_element;
    }

    $output_sv .= ']';

#    RPerl::diag "in PERLOPS_PERLTYPES integer__array_ref__stringify(), after for() loop, have \$output_sv =\n$output_sv\n" or croak();
#    RPerl::diag "in PERLOPS_PERLTYPES integer__array_ref__stringify(), bottom of subroutine\n" or croak();

    return ($output_sv);
};

# [[[ TYPE TESTING ]]]

our string $integer__array_ref__typetest0 = sub {
    ( my integer__array_ref $lucky_integers) = @_;

    #    ::integer__array_ref__CHECK($lucky_integers);
    ::integer__array_ref__CHECKTRACE( $lucky_integers, '$lucky_integers',
        'integer__array_ref__typetest0()' );

#    my integer $how_lucky = scalar @{$lucky_integers};
#    for my integer $i ( 0 .. ( $how_lucky - 1 ) ) {
#        my $lucky_integer = $lucky_integers->[$i];
#        RPerl::diag "in PERLOPS_PERLTYPES integer__array_ref__typetest0(), have lucky integer $i/" . ( $how_lucky - 1 ) . ' = ' . $lucky_integers->[$i] . ", BARBAT\n" or croak();
#    }
#    RPerl::diag "in PERLOPS_PERLTYPES integer__array_ref__typetest0(), bottom of subroutine\n";
    return ( integer__array_ref__stringify($lucky_integers)
            . 'PERLOPS_PERLTYPES' );
};

our integer__array_ref $integer__array_ref__typetest1 = sub {
    ( my integer $my_size) = @_;

    #    ::integer__CHECK($my_size);
    ::integer__CHECKTRACE( $my_size, '$my_size',
        'integer__array_ref__typetest1()' );
    my integer__array_ref $new_array = [];
    for my integer $i ( 0 .. ( $my_size - 1 ) ) {
        $new_array->[$i] = $i * 5;

#        RPerl::diag "in PERLOPS_PERLTYPES integer__array_ref__typetest1(), setting element $i/" . ( $my_size - 1 ) . ' = ' . $new_array->[$i] . ", BARBAT\n" or croak();
    }
    return ($new_array);
};

# (ref to array) of (integers with const values)
package const_integer__array_ref;
use parent -norequire, ('array_ref');

# (ref to (array with const size)) of integers
package integer__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (integers with const values)
package const_integer__const_array_ref;
use parent -norequire, ('const_array_ref');

# [[[ FLOAT ARRAYS ]]]

# (ref to array) of floats
package float__array_ref;
use parent -norequire, ('array_ref');

# (ref to array) of (floats with const values)
package const_float__array_ref;
use parent -norequire, ('array_ref');

# (ref to (array with const size)) of floats
package float__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (floats with const values)
package const_float__const_array_ref;
use parent -norequire, ('const_array_ref');

# [[[ NUMBER ARRAY REF ]]]
# [[[ NUMBER ARRAY REF ]]]
# [[[ NUMBER ARRAY REF ]]]

# (ref to array) of numbers
package number__array_ref;
use parent -norequire, ('array_ref');
use Carp;

# [[[ TYPE-CHECKING ]]]

our void $number__array_ref__CHECK = sub {
    ( my $possible_number__array_ref ) = @_;
    if ( not( defined $possible_number__array_ref ) ) {
        croak(
            "\nERROR ENVAVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber__array_ref value expected but undefined/null value found,\ncroaking"
        );
    }

    if ( not( main::RPerl_SvAROKp($possible_number__array_ref) ) ) {
        croak(
            "\nERROR ENVAVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber__array_ref value expected but non-array_ref value found,\ncroaking"
        );
    }

    my number $possible_number;
    for my integer $i (
        0 .. ( ( scalar @{$possible_number__array_ref} ) - 1 ) )
    {
        $possible_number = $possible_number__array_ref->[$i];
        if ( not( defined $possible_number ) ) {
            croak(
                "\nERROR ENVAVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber__array_ref element value expected but undefined/null value found at index $i,\ncroaking"
            );
        }
        if (not(   main::RPerl_SvNOKp($possible_number)
                || main::RPerl_SvIOKp($possible_number) )
            )
        {
            croak(
                "\nERROR ENVAVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber__array_ref element value expected but non-number value found at index $i,\ncroaking"
            );
        }
    }
};
our void $number__array_ref__CHECKTRACE = sub {
    ( my $possible_number__array_ref, my $variable_name, my $subroutine_name )
        = @_;
    if ( not( defined $possible_number__array_ref ) ) {
        croak(
            "\nERROR ENVAVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber__array_ref value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }
    if ( not( main::RPerl_SvAROKp($possible_number__array_ref) ) ) {
        croak(
            "\nERROR ENVAVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber__array_ref value expected but non-array_ref value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }

    my number $possible_number;
    for my integer $i (
        0 .. ( ( scalar @{$possible_number__array_ref} ) - 1 ) )
    {
        $possible_number = $possible_number__array_ref->[$i];
        if ( not( defined $possible_number ) ) {
            croak(
                "\nERROR ENVAVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber__array_ref element value expected but undefined/null value found at index $i,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
            );
        }
        if (not(   main::RPerl_SvNOKp($possible_number)
                || main::RPerl_SvIOKp($possible_number) )
            )
        {
            croak(
                "\nERROR ENVAVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber__array_ref element value expected but non-number value found at index $i,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
            );
        }
    }
};

# [[[ STRINGIFY ]]]

# convert from (Perl SV containing RV to (Perl AV of (Perl SVs containing NVs))) to Perl-parsable (Perl SV containing PV)
our string $number__array_ref__stringify = sub {
    ( my $input_av_ref ) = @_;

#    RPerl::diag "in PERLOPS_PERLTYPES number__array_ref__stringify(), top of subroutine\n" or croak();

    #    ::number__array_ref__CHECK($input_av_ref);
    ::number__array_ref__CHECKTRACE( $input_av_ref, '$input_av_ref',
        'number__array_ref__stringify()' );

    my @input_av;
    my integer $input_av_length;
    my number $input_av_element;
    my string $output_sv;
    my integer $i_is_0 = 1;   # NEED UPGRADE: should be bool type, not integer

    @input_av        = @{$input_av_ref};
    $input_av_length = scalar @input_av;

#	RPerl::diag "in PERLOPS_PERLTYPES number__array_ref__stringify(), have \$input_av_length = $input_av_length\n";

    $output_sv = '[';

    for my integer $i ( 0 .. ( $input_av_length - 1 ) ) {

        $input_av_element = $input_av[$i];

        if ($i_is_0) { $i_is_0 = 0; }
        else         { $output_sv .= ', '; }
        $output_sv .= $input_av_element;
    }

    $output_sv .= ']';

#    RPerl::diag "in PERLOPS_PERLTYPES number__array_ref__stringify(), after for() loop, have \$output_sv =\n$output_sv\n" or croak();
#    RPerl::diag "in PERLOPS_PERLTYPES number__array_ref__stringify(), bottom of subroutine\n" or croak();

    return ($output_sv);
};

# [[[ TYPE TESTING ]]]

our string $number__array_ref__typetest0 = sub {
    ( my number__array_ref $lucky_numbers) = @_;

    #    ::number__array_ref__CHECK($lucky_numbers);
    ::number__array_ref__CHECKTRACE( $lucky_numbers, '$lucky_numbers',
        'number__array_ref__typetest0()' );

#    my integer $how_lucky = scalar @{$lucky_numbers};
#    for my integer $i ( 0 .. ( $how_lucky - 1 ) ) {
#        my $lucky_number = $lucky_numbers->[$i];
#        RPerl::diag "in PERLOPS_PERLTYPES number__array_ref__typetest0(), have lucky number $i/" . ( $how_lucky - 1 ) . ' = ' . $lucky_numbers->[$i] . ", BARBAZ\n" or croak();
#    }
#    RPerl::diag "in PERLOPS_PERLTYPES number__array_ref__typetest0(), bottom of subroutine\n";
    return (
        number__array_ref__stringify($lucky_numbers) . 'PERLOPS_PERLTYPES' );
};

our number__array_ref $number__array_ref__typetest1 = sub {
    ( my integer $my_size) = @_;

    #    ::integer__CHECK($my_size);
    ::integer__CHECKTRACE( $my_size, '$my_size',
        'number__array_ref__typetest1()' );
    my number__array_ref $new_array = [];
    for my integer $i ( 0 .. ( $my_size - 1 ) ) {
        $new_array->[$i] = $i * 5.123456789;

#        RPerl::diag "in PERLOPS_PERLTYPES number__array_ref__typetest1(), setting element $i/" . ( $my_size - 1 ) . ' = ' . $new_array->[$i] . ", BARBAZ\n" or croak();
    }
    return ($new_array);
};

# (ref to array) of (numbers with const values)
package const_number__array_ref;
use parent -norequire, ('array_ref');

# (ref to (array with const size)) of numbers
package number__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (numbers with const values)
package const_number__const_array_ref;
use parent -norequire, ('const_array_ref');

# [[[ CHAR ARRAYS ]]]

# (ref to array) of chars
package char__array_ref;
use parent -norequire, ('array_ref');

# (ref to array) of (chars with const values)
package const_char__array_ref;
use parent -norequire, ('array_ref');

# (ref to (array with const size)) of chars
package char__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (chars with const values)
package const_char__const_array_ref;
use parent -norequire, ('const_array_ref');

# [[[ STRING ARRAY REF ]]]
# [[[ STRING ARRAY REF ]]]
# [[[ STRING ARRAY REF ]]]

# (ref to array) of strings
package string__array_ref;
use parent -norequire, ('array_ref');
use Carp;

# [[[ TYPE-CHECKING ]]]

our void $string__array_ref__CHECK = sub {
    ( my $possible_string__array_ref ) = @_;
    if ( not( defined $possible_string__array_ref ) ) {
        croak(
            "\nERROR EPVAVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring__array_ref value expected but undefined/null value found,\ncroaking"
        );
    }

    if ( not( main::RPerl_SvAROKp($possible_string__array_ref) ) ) {
        croak(
            "\nERROR EPVAVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring__array_ref value expected but non-array_ref value found,\ncroaking"
        );
    }

    my string $possible_string;
    for my integer $i (
        0 .. ( ( scalar @{$possible_string__array_ref} ) - 1 ) )
    {
        $possible_string = $possible_string__array_ref->[$i];
        if ( not( defined $possible_string ) ) {
            croak(
                "\nERROR EPVAVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring__array_ref element value expected but undefined/null value found at index $i,\ncroaking"
            );
        }
        if ( not( main::RPerl_SvPOKp($possible_string) ) ) {
            croak(
                "\nERROR EPVAVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring__array_ref element value expected but non-string value found at index $i,\ncroaking"
            );
        }
    }
};
our void $string__array_ref__CHECKTRACE = sub {
    ( my $possible_string__array_ref, my $variable_name, my $subroutine_name )
        = @_;
    if ( not( defined $possible_string__array_ref ) ) {
        croak(
            "\nERROR EPVAVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring__array_ref value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }
    if ( not( main::RPerl_SvAROKp($possible_string__array_ref) ) ) {
        croak(
            "\nERROR EPVAVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring__array_ref value expected but non-array_ref value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }

    my string $possible_string;
    for my integer $i (
        0 .. ( ( scalar @{$possible_string__array_ref} ) - 1 ) )
    {
        $possible_string = $possible_string__array_ref->[$i];
        if ( not( defined $possible_string ) ) {
            croak(
                "\nERROR EPVAVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring__array_ref element value expected but undefined/null value found at index $i,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
            );
        }
        if ( not( main::RPerl_SvPOKp($possible_string) ) ) {
            croak(
                "\nERROR EPVAVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring__array_ref element value expected but non-string value found at index $i,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
            );
        }
    }
};

# [[[ STRINGIFY ]]]

# convert from (Perl SV containing RV to (Perl AV of (Perl SVs containing PVs))) to Perl-parsable (Perl SV containing PV)
our string $string__array_ref__stringify = sub {
    ( my $input_av_ref ) = @_;

#    RPerl::diag "in PERLOPS_PERLTYPES string__array_ref__stringify(), top of subroutine\n" or croak();

    #    ::string__array_ref__CHECK($input_av_ref);
    ::string__array_ref__CHECKTRACE( $input_av_ref, '$input_av_ref',
        'string__array_ref__stringify()' );

    my @input_av;
    my integer $input_av_length;
    my string $input_av_element;
    my string $output_sv;
    my integer $i_is_0 = 1;   # NEED UPGRADE: should be bool type, not integer

    @input_av        = @{$input_av_ref};
    $input_av_length = scalar @input_av;

#	RPerl::diag "in PERLOPS_PERLTYPES string__array_ref__stringify(), have \$input_av_length = $input_av_length\n";

    $output_sv = '[';

    for my integer $i ( 0 .. ( $input_av_length - 1 ) ) {

        $input_av_element = $input_av[$i];

        if ($i_is_0) { $i_is_0 = 0; }
        else         { $output_sv .= ', '; }
        $input_av_element =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
        $input_av_element =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
        $output_sv .= "'$input_av_element'";
    }

    $output_sv .= ']';

#    RPerl::diag "in PERLOPS_PERLTYPES string__array_ref__stringify(), after for() loop, have \$output_sv =\n$output_sv\n" or croak();
#    RPerl::diag "in PERLOPS_PERLTYPES string__array_ref__stringify(), bottom of subroutine\n" or croak();

    return ($output_sv);
};

# [[[ TYPE TESTING ]]]

our string $string__array_ref__typetest0 = sub {
    ( my string__array_ref $people) = @_;

    #    ::string__array_ref__CHECK($people);
    ::string__array_ref__CHECKTRACE( $people, '$people',
        'string__array_ref__typetest0()' );

#    my integer $how_crowded = scalar @{$people};
#    for my integer $i ( 0 .. ( $how_crowded - 1 ) ) {
#        my $person = $people->[$i];
#        RPerl::diag "in PERLOPS_PERLTYPES string__array_ref__typetest0(), have person $i/" . ( $how_crowded - 1 ) . ' = ' . $people->[$i] . ", BARBAR\n" or croak();
#    }
#    RPerl::diag "in PERLOPS_PERLTYPES string__array_ref__typetest0(), bottom of subroutine\n";
    return ( string__array_ref__stringify($people) . 'PERLOPS_PERLTYPES' );
};

our string__array_ref $string__array_ref__typetest1 = sub {
    ( my integer $my_size) = @_;

    #    ::integer__CHECK($my_size);
    ::integer__CHECKTRACE( $my_size, '$my_size',
        'string__array_ref__typetest1()' );
    my string__array_ref $new_array = [];
    for my integer $i ( 0 .. ( $my_size - 1 ) ) {
        $new_array->[$i]
            = "Jeffy Ten! $i/" . ( $my_size - 1 ) . ' PERLOPS_PERLTYPES';

#        RPerl::diag "in PERLOPS_PERLTYPES string__array_ref__typetest1(), bottom of for() loop, have i = $i, just set another Jeffy, BARBAR\n" or croak();
    }
    return ($new_array);
};

=block_comment
THIS IS AN EXAMPLE BLOCK COMMENT
it's purpose is to keep from triggering the UselessNoCritic rule,
so we can keep the no critic sections at the top of the file for reference
=cut

# (ref to array) of (strings with const values)
package const_string__array_ref;
use parent -norequire, ('array_ref');

# (ref to (array with const size)) of strings
package string__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (strings with const values)
package const_string__const_array_ref;
use parent -norequire, ('const_array_ref');

# [[[ SCALAR ARRAYS ]]]

# (ref to array) of scalartypes
package scalartype__array_ref;
use parent -norequire, ('array_ref');

# (ref to array) of (scalartypes with const values)
package const_scalartype__array_ref;
use parent -norequire, ('array_ref');

# (ref to (array with const size)) of scalartypes
package scalartype__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (scalartypes with const values)
package const_scalartype__const_array_ref;
use parent -norequire, ('const_array_ref');

# [[[ UNKNOWN ARRAYS ]]]

# (ref to array) of unknowns
package unknown__array_ref;
use parent -norequire, ('array_ref');

# (ref to array) of (refs to unknowns)
package unknown_ref__array_ref;
use parent -norequire, ('array_ref');

# (ref to (array with const size)) of unknowns
package unknown__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (refs to unknowns)
package unknown_ref__const_array_ref;
use parent -norequire, ('const_array_ref');

# [[[ ARRAY ARRAYS (2-dimensional) ]]]

# (ref to array) of (refs to arrays)
package array_ref__array_ref;
use parent -norequire, ('array_ref');

# (ref to array) of (refs to (arrays with const sizes))
package const_array_ref__array_ref;
use parent -norequire, ('array_ref');

# (ref to (array with const size)) of (refs to arrays)
package array_ref__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (refs to (arrays with const sizes))
package const_array_ref__const_array_ref;
use parent -norequire, ('const_array_ref');

# [ HOMOGENEOUS ARRAY ARRAYS (2-dimensional) ]

# (ref to array) of (refs to (arrays of integers))
package integer__array_ref__array_ref;
use parent -norequire, ('array_ref__array_ref');

# (ref to array) of (refs to (arrays of numbers))
package number__array_ref__array_ref;
use parent -norequire, ('array_ref__array_ref');

# (ref to array) of (refs to (arrays of strings))
package string__array_ref__array_ref;
use parent -norequire, ('array_ref__array_ref');

# (ref to array) of (refs to (arrays of scalars))
package scalartype__array_ref__array_ref;
use parent -norequire, ('array_ref__array_ref');

# (ref to array) of (refs to (arrays of unknowns))
package unknown__array_ref__array_ref;
use parent -norequire, ('array_ref__array_ref');

# [[[ HASH ARRAYS (2-dimesional) ]]]

# (ref to array) of (refs to hashs)
package hash_ref__array_ref;
use parent -norequire, ('array_ref');

# (ref to array) of (refs to (hashs with const sizes))
package const_hash_ref__array_ref;
use parent -norequire, ('array_ref');

# (ref to (array with const size)) of (refs to hashs)
package hash_ref__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (refs to (hashs with const sizes))
package const_hash_ref__const_array_ref;
use parent -norequire, ('const_array_ref');

# [[[ OBJECT ARRAYS (2-dimesional) ]]]

# (ref to array) of objects
package object__array_ref;
use parent -norequire, ('array_ref');

# (ref to (array with const size)) of objects
package object__const_array_ref;
use parent -norequire, ('const_array_ref');

1;
