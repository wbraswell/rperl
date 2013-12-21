## no critic qw(ProhibitExcessMainComplexity PodSpelling)  ## RPERL SYSTEM types, allow long subtypes package; RPERL allow block comments; DEV NOTE: these 2 must appear together on 1st line
## no critic qw(RequirePodAtEnd RequirePodSections)  ## RPERL allow block comments
## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted sigils
## no critic qw(ProhibitMultiplePackages)  ## RPERL SYSTEM types, allow multiple packages
## no critic qw(Capitalization)  ## RPERL SYSTEM types, allow lowercase packages
## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
package RPerl::DataStructure::Array::SubTypes;
use strict;
use warnings;
use version; our $VERSION = 0.003007;
use Carp;

# [[[ ARRAYS ]]]

# an array is a 1-dimensional list/vector/sequence/set of data types
package array;
use parent ('RPerl::DataStructure::Array');

# array with const size
package const_array;
use parent -norequire, qw( array const );

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

# [[[ INTEGER ARRAYS ]]]

# array of integers
package integer__array;
use parent -norequire, ('array');

# array of (integers with const values)
package const_integer__array;
use parent -norequire, ('array');

# array of (refs to integers)
package integer_ref__array;
use parent -norequire, ('array');

# array of (refs to (integers with const values))
package const_integer_ref__array;
use parent -norequire, ('array');

# (array with const size) of integers
package integer__const_array;
use parent -norequire, ('const_array');

# (array with const size) of (integers with const values)
package const_integer__const_array;
use parent -norequire, ('const_array');

# (array with const size) of (refs to integers)
package integer_ref__const_array;
use parent -norequire, ('const_array');

# (array with const size) of (refs to (integers with const values))
package const_integer_ref__const_array;
use parent -norequire, ('const_array');

# [[[ INTEGER ARRAY REF ]]]
# [[[ INTEGER ARRAY REF ]]]
# [[[ INTEGER ARRAY REF ]]]

# (ref to array) of integers
package integer__array_ref;
use parent -norequire, ('array_ref');
use Carp;

# [[[ STRINGIFY ]]]

# convert from (Perl SV containing RV to (Perl AV of (Perl SVs containing IVs))) to Perl-parsable (Perl SV containing PV)
our string $integer__array_ref__stringify = sub {
    ( my $input_av_ref ) = @_;

    print
        "in PERLOPS_PERLTYPES integer__array_ref__stringify(), top of subroutine\n"
        or croak();

    #    ::array_ref__CHECK($input_av_ref);
    ::array_ref__CHECKTRACE( $input_av_ref, '$input_av_ref',
        'integer__array_ref__stringify()' );

    my @input_av;
    my integer $input_av_length;
    my integer $input_av_element;
    my string $output_sv;
    my integer $i_is_0 = 1;   # NEED UPGRADE: should be bool type, not integer

    @input_av        = @{$input_av_ref};
    $input_av_length = scalar @input_av;

#	print "in PERLOPS_PERLTYPES integer__array_ref__stringify(), have \$input_av_length = $input_av_length\n";

    $output_sv = '[';

    for my integer $i ( 0 .. ( $input_av_length - 1 ) ) {

        $input_av_element = $input_av[$i];

        #        ::integer__CHECK($input_av_element);
        ::integer__CHECKTRACE(
            $input_av_element,
            "\$input_av_element at index $i",
            'integer__array_ref__stringify()'
        );

        if ($i_is_0) { $i_is_0 = 0; }
        else         { $output_sv .= ', '; }
        $output_sv .= $input_av_element;
    }

    $output_sv .= ']';

    print
        "in PERLOPS_PERLTYPES integer__array_ref__stringify(), after for() loop, have \$output_sv =\n$output_sv\n"
        or croak();
    print
        "in PERLOPS_PERLTYPES integer__array_ref__stringify(), bottom of subroutine\n"
        or croak();

    return ($output_sv);
};

# [[[ TYPE TESTING ]]]

our string $integer__array_ref__typetest0 = sub {
    ( my integer__array_ref $lucky_integers) = @_;

    #    ::array_ref__CHECK($lucky_integers);
    ::array_ref__CHECKTRACE( $lucky_integers, '$lucky_integers',
        'integer__array_ref__typetest0()' );
    my integer $how_lucky = scalar @{$lucky_integers};
    for my integer $i ( 0 .. ( $how_lucky - 1 ) ) {
        my $lucky_integer = $lucky_integers->[$i];

        #        ::integer__CHECK($lucky_integer);
        ::integer__CHECKTRACE(
            $lucky_integer,
            "\$lucky_integer at index $i",
            'integer__array_ref__typetest0()'
        );
        print
            "in PERLOPS_PERLTYPES integer__array_ref__typetest0(), have lucky integer $i/"
            . ( $how_lucky - 1 ) . ' = '
            . $lucky_integers->[$i]
            . ", BARBAT\n"
            or croak();
    }
    print
        "in PERLOPS_PERLTYPES integer__array_ref__typetest0(), bottom of subroutine\n";
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
        print
            "in PERLOPS_PERLTYPES integer__array_ref__typetest1(), setting element $i/"
            . ( $my_size - 1 ) . ' = '
            . $new_array->[$i]
            . ", BARBAT\n"
            or croak();
    }
    return ($new_array);
};

# (ref to array) of (integers with const values)
package const_integer__array_ref;
use parent -norequire, ('array_ref');

# (ref to array) of (refs to integers)
package integer_ref__array_ref;
use parent -norequire, ('array_ref');

# (ref to array) of (refs to (integers with const values))
package const_integer_ref__array_ref;
use parent -norequire, ('array_ref');

# (ref to (array with const size)) of integers
package integer__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (integers with const values)
package const_integer__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (refs to integers)
package integer_ref__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (refs to (integers with const values))
package const_integer_ref__const_array_ref;
use parent -norequire, ('const_array_ref');

# [[[ FLOAT ARRAYS ]]]

# array of floats
package float__array;
use parent -norequire, ('array');

# array of (floats with const values)
package const_float__array;
use parent -norequire, ('array');

# array of (refs to floats)
package float_ref__array;
use parent -norequire, ('array');

# array of (refs to (floats with const values))
package const_float_ref__array;
use parent -norequire, ('array');

# (array with const size) of floats
package float__const_array;
use parent -norequire, ('const_array');

# (array with const size) of (floats with const values)
package const_float__const_array;
use parent -norequire, ('const_array');

# (array with const size) of (refs to floats)
package float_ref__const_array;
use parent -norequire, ('const_array');

# (array with const size) of (refs to (floats with const values))
package const_float_ref__const_array;
use parent -norequire, ('const_array');

# (ref to array) of floats
package float__array_ref;
use parent -norequire, ('array_ref');

# (ref to array) of (floats with const values)
package const_float__array_ref;
use parent -norequire, ('array_ref');

# (ref to array) of (refs to floats)
package float_ref__array_ref;
use parent -norequire, ('array_ref');

# (ref to array) of (refs to (floats with const values))
package const_float_ref__array_ref;
use parent -norequire, ('array_ref');

# (ref to (array with const size)) of floats
package float__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (floats with const values)
package const_float__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (refs to floats)
package float_ref__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (refs to (floats with const values))
package const_float_ref__const_array_ref;
use parent -norequire, ('const_array_ref');

# [[[ NUMBER ARRAYS ]]]

# array of numbers
package number__array;
use parent -norequire, ('array');

# array of (numbers with const values)
package const_number__array;
use parent -norequire, ('array');

# array of (refs to numbers)
package number_ref__array;
use parent -norequire, ('array');

# array of (refs to (numbers with const values))
package const_number_ref__array;
use parent -norequire, ('array');

# (array with const size) of numbers
package number__const_array;
use parent -norequire, ('const_array');

# (array with const size) of (numbers with const values)
package const_number__const_array;
use parent -norequire, ('const_array');

# (array with const size) of (refs to numbers)
package number_ref__const_array;
use parent -norequire, ('const_array');

# (array with const size) of (refs to (numbers with const values))
package const_number_ref__const_array;
use parent -norequire, ('const_array');

# [[[ NUMBER ARRAY REF ]]]
# [[[ NUMBER ARRAY REF ]]]
# [[[ NUMBER ARRAY REF ]]]

# (ref to array) of numbers
package number__array_ref;
use parent -norequire, ('array_ref');
use Carp;

# [[[ STRINGIFY ]]]

# convert from (Perl SV containing RV to (Perl AV of (Perl SVs containing NVs))) to Perl-parsable (Perl SV containing PV)
our string $number__array_ref__stringify = sub {
    ( my $input_av_ref ) = @_;

    print
        "in PERLOPS_PERLTYPES number__array_ref__stringify(), top of subroutine\n"
        or croak();

    #    ::array_ref__CHECK($input_av_ref);
    ::array_ref__CHECKTRACE( $input_av_ref, '$input_av_ref',
        'number__array_ref__stringify()' );

    my @input_av;
    my integer $input_av_length;
    my number $input_av_element;
    my string $output_sv;
    my integer $i_is_0 = 1;   # NEED UPGRADE: should be bool type, not integer

    @input_av        = @{$input_av_ref};
    $input_av_length = scalar @input_av;

#	print "in PERLOPS_PERLTYPES number__array_ref__stringify(), have \$input_av_length = $input_av_length\n";

    $output_sv = '[';

    for my integer $i ( 0 .. ( $input_av_length - 1 ) ) {

        $input_av_element = $input_av[$i];

        #        ::number__CHECK($input_av_element);
        ::number__CHECKTRACE(
            $input_av_element,
            "\$input_av_element at index $i",
            'number__array_ref__stringify()'
        );

        if ($i_is_0) { $i_is_0 = 0; }
        else         { $output_sv .= ', '; }
        $output_sv .= $input_av_element;
    }

    $output_sv .= ']';

    print
        "in PERLOPS_PERLTYPES number__array_ref__stringify(), after for() loop, have \$output_sv =\n$output_sv\n"
        or croak();
    print
        "in PERLOPS_PERLTYPES number__array_ref__stringify(), bottom of subroutine\n"
        or croak();

    return ($output_sv);
};

# [[[ TYPE TESTING ]]]

our string $number__array_ref__typetest0 = sub {
    ( my number__array_ref $lucky_numbers) = @_;

    #    ::array_ref__CHECK($lucky_numbers);
    ::array_ref__CHECKTRACE( $lucky_numbers, '$lucky_numbers',
        'number__array_ref__typetest0()' );
    my integer $how_lucky = scalar @{$lucky_numbers};
    for my integer $i ( 0 .. ( $how_lucky - 1 ) ) {
        my $lucky_number = $lucky_numbers->[$i];

        #        ::number__CHECK($lucky_number);
        ::number__CHECKTRACE(
            $lucky_number,
            "\$lucky_number at index $i",
            'number__array_ref__typetest0()'
        );
        print
            "in PERLOPS_PERLTYPES number__array_ref__typetest0(), have lucky number $i/"
            . ( $how_lucky - 1 ) . ' = '
            . $lucky_numbers->[$i]
            . ", BARBAZ\n"
            or croak();
    }
    print
        "in PERLOPS_PERLTYPES number__array_ref__typetest0(), bottom of subroutine\n";
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
        print
            "in PERLOPS_PERLTYPES number__array_ref__typetest1(), setting element $i/"
            . ( $my_size - 1 ) . ' = '
            . $new_array->[$i]
            . ", BARBAZ\n"
            or croak();
    }
    return ($new_array);
};

# (ref to array) of (numbers with const values)
package const_number__array_ref;
use parent -norequire, ('array_ref');

# (ref to array) of (refs to numbers)
package number_ref__array_ref;
use parent -norequire, ('array_ref');

# (ref to array) of (refs to (numbers with const values))
package const_number_ref__array_ref;
use parent -norequire, ('array_ref');

# (ref to (array with const size)) of numbers
package number__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (numbers with const values)
package const_number__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (refs to numbers)
package number_ref__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (refs to (numbers with const values))
package const_number_ref__const_array_ref;
use parent -norequire, ('const_array_ref');

# [[[ CHAR ARRAYS ]]]

# array of chars
package char__array;
use parent -norequire, ('array');

# array of (chars with const values)
package const_char__array;
use parent -norequire, ('array');

# array of (refs to chars)
package char_ref__array;
use parent -norequire, ('array');

# array of (refs to (chars with const values))
package const_char_ref__array;
use parent -norequire, ('array');

# (array with const size) of chars
package char__const_array;
use parent -norequire, ('const_array');

# (array with const size) of (chars with const values)
package const_char__const_array;
use parent -norequire, ('const_array');

# (array with const size) of (refs to chars)
package char_ref__const_array;
use parent -norequire, ('const_array');

# (array with const size) of (refs to (chars with const values))
package const_char_ref__const_array;
use parent -norequire, ('const_array');

# (ref to array) of chars
package char__array_ref;
use parent -norequire, ('array_ref');

# (ref to array) of (chars with const values)
package const_char__array_ref;
use parent -norequire, ('array_ref');

# (ref to array) of (refs to chars)
package char_ref__array_ref;
use parent -norequire, ('array_ref');

# (ref to array) of (refs to (chars with const values))
package const_char_ref__array_ref;
use parent -norequire, ('array_ref');

# (ref to (array with const size)) of chars
package char__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (chars with const values)
package const_char__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (refs to chars)
package char_ref__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (refs to (chars with const values))
package const_char_ref__const_array_ref;
use parent -norequire, ('const_array_ref');

# [[[ STRING ARRAYS ]]]

# array of strings
package string__array;
use parent -norequire, ('array');

# array of (strings with const values)
package const_string__array;
use parent -norequire, ('array');

# array of (refs to strings)
package string_ref__array;
use parent -norequire, ('array');

# array of (refs to (strings with const values))
package const_string_ref__array;
use parent -norequire, ('array');

# (array with const size) of strings
package string__const_array;
use parent -norequire, ('const_array');

# (array with const size) of (strings with const values)
package const_string__const_array;
use parent -norequire, ('const_array');

# (array with const size) of (refs to strings)
package string_ref__const_array;
use parent -norequire, ('const_array');

# (array with const size) of (refs to (strings with const values))
package const_string_ref__const_array;
use parent -norequire, ('const_array');

# [[[ STRING ARRAY REF ]]]
# [[[ STRING ARRAY REF ]]]
# [[[ STRING ARRAY REF ]]]

# (ref to array) of strings
package string__array_ref;
use parent -norequire, ('array_ref');
use Carp;

# [[[ STRINGIFY ]]]

# convert from (Perl SV containing RV to (Perl AV of (Perl SVs containing PVs))) to Perl-parsable (Perl SV containing PV)
our string $string__array_ref__stringify = sub {
    ( my $input_av_ref ) = @_;

    print
        "in PERLOPS_PERLTYPES string__array_ref__stringify(), top of subroutine\n"
        or croak();

    #    ::array_ref__CHECK($input_av_ref);
    ::array_ref__CHECKTRACE( $input_av_ref, '$input_av_ref',
        'string__array_ref__stringify()' );

    my @input_av;
    my integer $input_av_length;
    my string $input_av_element;
    my string $output_sv;
    my integer $i_is_0 = 1;   # NEED UPGRADE: should be bool type, not integer

    @input_av        = @{$input_av_ref};
    $input_av_length = scalar @input_av;

#	print "in PERLOPS_PERLTYPES string__array_ref__stringify(), have \$input_av_length = $input_av_length\n";

    $output_sv = '[';

    for my integer $i ( 0 .. ( $input_av_length - 1 ) ) {

        $input_av_element = $input_av[$i];

        #        ::string__CHECK($input_av_element);
        ::string__CHECKTRACE(
            $input_av_element,
            "\$input_av_element at index $i",
            'string__array_ref__stringify()'
        );

        if ($i_is_0) { $i_is_0 = 0; }
        else         { $output_sv .= ', '; }
        $input_av_element =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
        $input_av_element =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
        $output_sv .= "'$input_av_element'";
    }

    $output_sv .= ']';

    print
        "in PERLOPS_PERLTYPES string__array_ref__stringify(), after for() loop, have \$output_sv =\n$output_sv\n"
        or croak();
    print
        "in PERLOPS_PERLTYPES string__array_ref__stringify(), bottom of subroutine\n"
        or croak();

    return ($output_sv);
};

# [[[ TYPE TESTING ]]]

our string $string__array_ref__typetest0 = sub {
    ( my string__array_ref $people) = @_;

    #    ::array_ref__CHECK($people);
    ::array_ref__CHECKTRACE( $people, '$people',
        'string__array_ref__typetest0()' );
    my integer $how_crowded = scalar @{$people};
    for my integer $i ( 0 .. ( $how_crowded - 1 ) ) {
        my $person = $people->[$i];

        #        ::string__CHECK($person);
        ::string__CHECKTRACE(
            $person,
            "\$person at index $i",
            'string__array_ref__typetest0()'
        );
        print
            "in PERLOPS_PERLTYPES string__array_ref__typetest0(), have person $i/"
            . ( $how_crowded - 1 ) . ' = '
            . $people->[$i]
            . ", BARBAR\n"
            or croak();
    }
    print
        "in PERLOPS_PERLTYPES string__array_ref__typetest0(), bottom of subroutine\n";
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
        print
            "in PERLOPS_PERLTYPES string__array_ref__typetest1(), bottom of for() loop, have i = $i, just set another Jeffy, BARBAR\n"
            or croak();
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

# (ref to array) of (refs to strings)
package string_ref__array_ref;
use parent -norequire, ('array_ref');

# (ref to array) of (refs to (strings with const values))
package const_string_ref__array_ref;
use parent -norequire, ('array_ref');

# (ref to (array with const size)) of strings
package string__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (strings with const values)
package const_string__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (refs to strings)
package string_ref__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (refs to (strings with const values))
package const_string_ref__const_array_ref;
use parent -norequire, ('const_array_ref');

# [[[ SCALAR ARRAYS ]]]

# array of scalars
package scalar__array;
use parent -norequire, ('array');

# array of (scalars with const values)
package const_scalar__array;
use parent -norequire, ('array');

# array of (refs to scalars)
package scalar_ref__array;
use parent -norequire, ('array');

# array of (refs to (scalars with const values))
package const_scalar_ref__array;
use parent -norequire, ('array');

# (array with const size) of scalars
package scalar__const_array;
use parent -norequire, ('const_array');

# (array with const size) of (scalars with const values)
package const_scalar__const_array;
use parent -norequire, ('const_array');

# (array with const size) of (refs to scalars)
package scalar_ref__const_array;
use parent -norequire, ('const_array');

# (array with const size) of (refs to (scalars with const values))
package const_scalar_ref__const_array;
use parent -norequire, ('const_array');

# (ref to array) of scalars
package scalar__array_ref;
use parent -norequire, ('array_ref');

# (ref to array) of (scalars with const values)
package const_scalar__array_ref;
use parent -norequire, ('array_ref');

# (ref to array) of (refs to scalars)
package scalar_ref__array_ref;
use parent -norequire, ('array_ref');

# (ref to array) of (refs to (scalars with const values))
package const_scalar_ref__array_ref;
use parent -norequire, ('array_ref');

# (ref to (array with const size)) of scalars
package scalar__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (scalars with const values)
package const_scalar__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (refs to scalars)
package scalar_ref__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (refs to (scalars with const values))
package const_scalar_ref__const_array_ref;
use parent -norequire, ('const_array_ref');

# [[[ UNKNOWN ARRAYS ]]]

# array of unknowns
package unknown__array;
use parent -norequire, ('array');

# array of (unknowns with const values)
package const_unknown__array;
use parent -norequire, ('array');

# array of (refs to unknowns)
package unknown_ref__array;
use parent -norequire, ('array');

# array of (refs to (unknowns with const values))
package const_unknown_ref__array;
use parent -norequire, ('array');

# (array with const size) of unknowns
package unknown__const_array;
use parent -norequire, ('const_array');

# (array with const size) of (unknowns with const values)
package const_unknown__const_array;
use parent -norequire, ('const_array');

# (array with const size) of (refs to unknowns)
package unknown_ref__const_array;
use parent -norequire, ('const_array');

# (array with const size) of (refs to (unknowns with const values))
package const_unknown_ref__const_array;
use parent -norequire, ('const_array');

# (ref to array) of unknowns
package unknown__array_ref;
use parent -norequire, ('array_ref');

# (ref to array) of (unknowns with const values)
package const_unknown__array_ref;
use parent -norequire, ('array_ref');

# (ref to array) of (refs to unknowns)
package unknown_ref__array_ref;
use parent -norequire, ('array_ref');

# (ref to array) of (refs to (unknowns with const values))
package const_unknown_ref__array_ref;
use parent -norequire, ('array_ref');

# (ref to (array with const size)) of unknowns
package unknown__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (unknowns with const values)
package const_unknown__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (refs to unknowns)
package unknown_ref__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (refs to (unknowns with const values))
package const_unknown_ref__const_array_ref;
use parent -norequire, ('const_array_ref');

# [[[ ARRAY ARRAYS (2-dimensional) ]]]

# array of arrays
package array__array;
use parent -norequire, ('array');

# array of (arrays with const sizes)
package const_array__array;
use parent -norequire, ('array');

# array of (refs to arrays)
package array_ref__array;
use parent -norequire, ('array');

# array of (refs to (arrays with const sizes))
package const_array_ref__array;
use parent -norequire, ('array');

# (array with const size) of arrays
package array__const_array;
use parent -norequire, ('const_array');

# (array with const size) of (arrays with const sizes)
package const_array__const_array;
use parent -norequire, ('const_array');

# (array with const size) of (refs to arrays)
package array_ref__const_array;
use parent -norequire, ('const_array');

# (array with const size) of (refs to (arrays with const sizes))
package const_array_ref__const_array;
use parent -norequire, ('const_array');

# (ref to array) of arrays
package array__array_ref;
use parent -norequire, ('array_ref');

# (ref to array) of (arrays with const sizes)
package const_array__array_ref;
use parent -norequire, ('array_ref');

# (ref to array) of (refs to arrays)
package array_ref__array_ref;
use parent -norequire, ('array_ref');

# (ref to array) of (refs to (arrays with const sizes))
package const_array_ref__array_ref;
use parent -norequire, ('array_ref');

# (ref to (array with const size)) of arrays
package array__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (arrays with const sizes)
package const_array__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (refs to arrays)
package array_ref__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (refs to (arrays with const sizes))
package const_array_ref__const_array_ref;
use parent -norequire, ('const_array_ref');

# [[[ HASH ARRAYS (2-dimesional) ]]]

# array of hashs
package hash__array;
use parent -norequire, ('array');

# array of (hashs with const sizes)
package const_hash__array;
use parent -norequire, ('array');

# array of (refs to hashs)
package hash_ref__array;
use parent -norequire, ('array');

# array of (refs to (hashs with const sizes))
package const_hash_ref__array;
use parent -norequire, ('array');

# (array with const size) of hashs
package hash__const_array;
use parent -norequire, ('const_array');

# (array with const size) of (hashs with const sizes)
package const_hash__const_array;
use parent -norequire, ('const_array');

# (array with const size) of (refs to hashs)
package hash_ref__const_array;
use parent -norequire, ('const_array');

# (array with const size) of (refs to (hashs with const sizes))
package const_hash_ref__const_array;
use parent -norequire, ('const_array');

# (ref to array) of hashs
package hash__array_ref;
use parent -norequire, ('array_ref');

# (ref to array) of (hashs with const sizes)
package const_hash__array_ref;
use parent -norequire, ('array_ref');

# (ref to array) of (refs to hashs)
package hash_ref__array_ref;
use parent -norequire, ('array_ref');

# (ref to array) of (refs to (hashs with const sizes))
package const_hash_ref__array_ref;
use parent -norequire, ('array_ref');

# (ref to (array with const size)) of hashs
package hash__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (hashs with const sizes)
package const_hash__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (refs to hashs)
package hash_ref__const_array_ref;
use parent -norequire, ('const_array_ref');

# (ref to (array with const size)) of (refs to (hashs with const sizes))
package const_hash_ref__const_array_ref;
use parent -norequire, ('const_array_ref');

1;
