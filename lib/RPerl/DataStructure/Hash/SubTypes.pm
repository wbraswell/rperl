## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted sigils
## no critic qw(ProhibitMultiplePackages)  ## RPERL SYSTEM types, allow multiple packages
## no critic qw(Capitalization)  ## RPERL SYSTEM types, allow lowercase packages
## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
package RPerl::DataStructure::Hash::SubTypes;
use strict;
use warnings;
use version; our $VERSION = qv('0.1.2');
use Carp;

# [[[ HASHES ]]]

# a hash is an associative array, meaning a 1-dimensional list/vector/sequence/set of (key, value) pairs
package hash;
use parent ('RPerl::DataStructure::Hash');

# hash with const size
package const_hash;
use parent -norequire, qw(hash const);

# [[[ HASH REF ]]]
# [[[ HASH REF ]]]
# [[[ HASH REF ]]]

# ref to hash
package hash_ref;
use parent -norequire, ('ref');

# [[[ TYPE-CHECKING ]]]

our void $hash_ref__CHECK = sub {
    ( my $possible_hash_ref ) = @_;
    if ( not( defined $possible_hash_ref ) ) {
        croak(
            "\nERROR EHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nhash_ref value expected but undefined/null value found,\ncroaking"
        );
    }

#    if ( UNIVERSAL::isa( $possible_hash_ref, 'HASH' ) ) {  # DEV NOTE: I believe the following 2 lines are equivalent?
    if ( not( main::RPerl_SvHROKp($possible_hash_ref) ) ) {
        croak(
            "\nERROR EHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nhash_ref value expected but non-hash_ref value found,\ncroaking"
        );
    }
};
our void $hash_ref__CHECKTRACE = sub {
    ( my $possible_hash_ref, my $variable_name, my $subroutine_name ) = @_;
    if ( not( defined $possible_hash_ref ) ) {
        croak(
            "\nERROR EHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nhash_ref value expected but undefined/null value found,\nin variable '$variable_name' from subroutine '$subroutine_name',\ncroaking"
        );
    }
    if ( not( main::RPerl_SvHROKp($possible_hash_ref) ) ) {
        croak(
            "\nERROR EHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nhash_ref value expected but non-hash_ref value found,\nin variable '$variable_name' from subroutine '$subroutine_name',\ncroaking"
        );
    }
};

# ref to (hash with const size)
package const_hash_ref;
use parent -norequire, ('ref');

# [[[ INTEGER HASHES ]]]

# hash of integers
package integer__hash;
use parent -norequire, ('hash');

# hash of (integers with const values)
package const_integer__hash;
use parent -norequire, ('hash');

# hash of (refs to integers)
package integer_ref__hash;
use parent -norequire, ('hash');

# hash of (refs to (integers with const values))
package const_integer_ref__hash;
use parent -norequire, ('hash');

# (hash with const size) of integers
package integer__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (integers with const values)
package const_integer__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (refs to integers)
package integer_ref__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (refs to (integers with const values))
package const_integer_ref__const_hash;
use parent -norequire, ('const_hash');

# [[[ INTEGER HASH REF ]]]
# [[[ INTEGER HASH REF ]]]
# [[[ INTEGER HASH REF ]]]

# (ref to hash) of integers
package integer__hash_ref;
use parent -norequire, ('hash_ref');

# [[[ STRINGIFY ]]]

# convert from (Perl SV containing RV to (Perl HV of (Perl SVs containing IVs))) to Perl-parsable (Perl SV containing PV)
our string $integer__hash_ref__stringify = sub {
    ( my $input_hv_ref ) = @_;

    print
        "in PERLOPS_PERLTYPES integer__hash_ref__stringify(), top of subroutine\n"
        or croak();

    #    ::hash_ref__CHECK($input_hv_ref);
    ::hash_ref__CHECKTRACE( $input_hv_ref, '$input_hv_ref',
        'integer__hash_ref__stringify()' );

    my %input_hv;

    #	my integer $input_hv_length;
    my integer $input_hv_entry_value;
    my string $output_sv;
    my integer $i_is_0 = 1;    # DEV NOTE: should be bool type, not integer

    %input_hv = %{$input_hv_ref};

#	$input_hv_length = scalar keys %input_hv;
#	print "in PERLOPS_PERLTYPES integer__hash_ref__stringify(), have \$input_hv_length = $input_hv_length\n";

    $output_sv = '{';

    foreach my string $key ( keys %input_hv ) {

        $input_hv_entry_value = $input_hv{$key};

        #        ::integer__CHECK($input_hv_entry_value);
        ::integer__CHECKTRACE(
            $input_hv_entry_value,
            "\$input_hv_entry_value at key '$key'",
            'integer__hash_ref__stringify()'
        );

        if ($i_is_0) { $i_is_0 = 0; }
        else         { $output_sv .= ', '; }
        $key =~ s/\'/\\\'/gxms; # delimit all single-quote ' characters with a back-slash \ character
        $output_sv .= "'$key' => $input_hv_entry_value"; # DEV NOTE: emulate Data::Dumper & follow PBP by using single quotes for key strings
    }

    $output_sv .= '}';

    print
        "in PERLOPS_PERLTYPES integer__hash_ref__stringify(), after for() loop, have \$output_sv =\n$output_sv\n"
        or croak();
    print
        "in PERLOPS_PERLTYPES integer__hash_ref__stringify(), bottom of subroutine\n"
        or croak();

    return ($output_sv);
};

# [[[ TYPE TESTING ]]]

our string $integer__hash_ref__typetest0 = sub {

  #print "in PERLOPS_PERLTYPES typetest___string__out(), top of subroutine\n";
    ( my integer__hash_ref $lucky_integers) = @_;

    #    ::hash_ref__CHECK($lucky_integers);
    ::hash_ref__CHECKTRACE( $lucky_integers, '$lucky_integers',
        'integer__hash_ref__typetest0()' );
    foreach my string $key ( keys %{$lucky_integers} ) {
        my $lucky_integer = $lucky_integers->{$key};

        #        ::integer__CHECK($lucky_integer);
        ::integer__CHECKTRACE(
            $lucky_integer,
            "\$lucky_integer at key '$key'",
            'integer__hash_ref__typetest0()'
        );
        print
            "in PERLOPS_PERLTYPES integer__hash_ref__typetest0(), have lucky integer '$key' => "
            . $lucky_integer
            . ", BARSTOOL\n"
            or croak();
    }
    print
        "in PERLOPS_PERLTYPES integer__hash_ref__typetest0(), bottom of subroutine\n";
    return (
        integer__hash_ref__stringify($lucky_integers) . 'PERLOPS_PERLTYPES' );
};

our integer__hash_ref $integer__hash_ref__typetest1 = sub {
    ( my integer $my_size) = @_;

    #    ::integer__CHECK($my_size);
    ::integer__CHECKTRACE( $my_size, '$my_size',
        'integer__hash_ref__typetest1()' );
    my integer__hash_ref $new_hash = {};
    my string $temp_key;
    for my integer $i ( 0 .. $my_size ) {
        $temp_key = 'PERLOPS_PERLTYPES_funkey' . $i;
        $new_hash->{$temp_key} = $i * 5;
        print
            "in PERLOPS_PERLTYPES integer__hash_ref__typetest1(), setting entry '$temp_key' => "
            . $new_hash->{$temp_key}
            . ", BARSTOOL\n"
            or croak();
    }
    return ($new_hash);
};

# (ref to hash) of (integers with const values)
package const_integer__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to hash) of (refs to integers)
package integer_ref__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to hash) of (refs to (integers with const values))
package const_integer_ref__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to (hash with const size)) of integers
package integer__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (integers with const values)
package const_integer__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (refs to integers)
package integer_ref__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (refs to (integers with const values))
package const_integer_ref__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# [[[ FLOAT HASHES ]]]

# hash of floats
package float__hash;
use parent -norequire, ('hash');

# hash of (floats with const values)
package const_float__hash;
use parent -norequire, ('hash');

# hash of (refs to floats)
package float_ref__hash;
use parent -norequire, ('hash');

# hash of (refs to (floats with const values))
package const_float_ref__hash;
use parent -norequire, ('hash');

# (hash with const size) of floats
package float__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (floats with const values)
package const_float__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (refs to floats)
package float_ref__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (refs to (floats with const values))
package const_float_ref__const_hash;
use parent -norequire, ('const_hash');

# (ref to hash) of floats
package float__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to hash) of (floats with const values)
package const_float__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to hash) of (refs to floats)
package float_ref__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to hash) of (refs to (floats with const values))
package const_float_ref__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to (hash with const size)) of floats
package float__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (floats with const values)
package const_float__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (refs to floats)
package float_ref__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (refs to (floats with const values))
package const_float_ref__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# [[[ NUMBER HASHES ]]]

# hash of numbers
package number__hash;
use parent -norequire, ('hash');

# hash of (numbers with const values)
package const_number__hash;
use parent -norequire, ('hash');

# hash of (refs to numbers)
package number_ref__hash;
use parent -norequire, ('hash');

# hash of (refs to (numbers with const values))
package const_number_ref__hash;
use parent -norequire, ('hash');

# (hash with const size) of numbers
package number__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (numbers with const values)
package const_number__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (refs to numbers)
package number_ref__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (refs to (numbers with const values))
package const_number_ref__const_hash;
use parent -norequire, ('const_hash');

# [[[ NUMBER HASH REF ]]]
# [[[ NUMBER HASH REF ]]]
# [[[ NUMBER HASH REF ]]]

# (ref to hash) of numbers
package number__hash_ref;
use parent -norequire, ('hash_ref');

# [[[ STRINGIFY ]]]

# convert from (Perl SV containing RV to (Perl HV of (Perl SVs containing NVs))) to Perl-parsable (Perl SV containing PV)
our string $number__hash_ref__stringify = sub {
    ( my $input_hv_ref ) = @_;

    print
        "in PERLOPS_PERLTYPES number__hash_ref__stringify(), top of subroutine\n"
        or croak();

    #    ::hash_ref__CHECK($input_hv_ref);
    ::hash_ref__CHECKTRACE( $input_hv_ref, '$input_hv_ref',
        'number__hash_ref__stringify()' );

    my %input_hv;

    #	my integer $input_hv_length;
    my number $input_hv_entry_value;
    my string $output_sv;
    my integer $i_is_0 = 1;

    %input_hv = %{$input_hv_ref};

#	$input_hv_length = scalar keys %input_hv;
#	print "in PERLOPS_PERLTYPES number__hash_ref__stringify(), have \$input_hv_length = $input_hv_length\n";

    $output_sv = '{';

    foreach my string $key ( keys %input_hv ) {

        $input_hv_entry_value = $input_hv{$key};

        #        ::number__CHECK($input_hv_entry_value);
        ::number__CHECKTRACE(
            $input_hv_entry_value,
            "\$input_hv_entry_value at key '$key'",
            'number__hash_ref__stringify()'
        );

        if ($i_is_0) { $i_is_0 = 0; }
        else         { $output_sv .= ', '; }
        $key =~ s/\'/\\\'/gxms;
        $output_sv .= "'$key' => $input_hv_entry_value";
    }

    $output_sv .= '}';

    print
        "in PERLOPS_PERLTYPES number__hash_ref__stringify(), after for() loop, have \$output_sv =\n$output_sv\n"
        or croak();
    print
        "in PERLOPS_PERLTYPES number__hash_ref__stringify(), bottom of subroutine\n"
        or croak();

    return ($output_sv);
};

# [[[ TYPE TESTING ]]]

our string $number__hash_ref__typetest0 = sub {
    ( my number__hash_ref $lucky_numbers) = @_;

    #    ::hash_ref__CHECK($lucky_numbers);
    ::hash_ref__CHECKTRACE( $lucky_numbers, '$lucky_numbers',
        'number__hash_ref__typetest0()' );
    foreach my string $key ( keys %{$lucky_numbers} ) {
        my $lucky_number = $lucky_numbers->{$key};

        #        ::number__CHECK($lucky_number);
        ::number__CHECKTRACE(
            $lucky_number,
            "\$lucky_number at key '$key'",
            'number__hash_ref__typetest0()'
        );
        print
            "in PERLOPS_PERLTYPES number__hash_ref__typetest0(), have lucky number '$key' => "
            . $lucky_number
            . ", BARSTOOL\n"
            or croak();
    }
    return (
        number__hash_ref__stringify($lucky_numbers) . 'PERLOPS_PERLTYPES' );
};

our number__hash_ref $number__hash_ref__typetest1 = sub {
    ( my integer $my_size) = @_;

    #    ::integer__CHECK($my_size);
    ::integer__CHECKTRACE( $my_size, '$my_size',
        'number__hash_ref__typetest1()' );
    my number__hash_ref $new_hash = {};
    my string $temp_key;
    for my integer $i ( 0 .. $my_size ) {
        $temp_key = 'PERLOPS_PERLTYPES_funkey' . $i;
        $new_hash->{$temp_key} = $i * 5.123456789;
        print
            "in PERLOPS_PERLTYPES number__hash_ref__typetest1(), setting entry '$temp_key' => "
            . $new_hash->{$temp_key}
            . ", BARSTOOL\n"
            or croak();
    }
    return ($new_hash);
};

# (ref to hash) of (numbers with const values)
package const_number__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to hash) of (refs to numbers)
package number_ref__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to hash) of (refs to (numbers with const values))
package const_number_ref__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to (hash with const size)) of numbers
package number__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (numbers with const values)
package const_number__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (refs to numbers)
package number_ref__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (refs to (numbers with const values))
package const_number_ref__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# [[[ CHAR HASHES ]]]

# hash of chars
package char__hash;
use parent -norequire, ('hash');

# hash of (chars with const values)
package const_char__hash;
use parent -norequire, ('hash');

# hash of (refs to chars)
package char_ref__hash;
use parent -norequire, ('hash');

# hash of (refs to (chars with const values))
package const_char_ref__hash;
use parent -norequire, ('hash');

# (hash with const size) of chars
package char__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (chars with const values)
package const_char__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (refs to chars)
package char_ref__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (refs to (chars with const values))
package const_char_ref__const_hash;
use parent -norequire, ('const_hash');

# (ref to hash) of chars
package char__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to hash) of (chars with const values)
package const_char__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to hash) of (refs to chars)
package char_ref__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to hash) of (refs to (chars with const values))
package const_char_ref__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to (hash with const size)) of chars
package char__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (chars with const values)
package const_char__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (refs to chars)
package char_ref__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (refs to (chars with const values))
package const_char_ref__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# [[[ STRING HASHES ]]]

# hash of strings
package string__hash;
use parent -norequire, ('hash');

# hash of (strings with const values)
package const_string__hash;
use parent -norequire, ('hash');

# hash of (refs to strings)
package string_ref__hash;
use parent -norequire, ('hash');

# hash of (refs to (strings with const values))
package const_string_ref__hash;
use parent -norequire, ('hash');

# (hash with const size) of strings
package string__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (strings with const values)
package const_string__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (refs to strings)
package string_ref__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (refs to (strings with const values))
package const_string_ref__const_hash;
use parent -norequire, ('const_hash');

# [[[ STRING HASH REF ]]]
# [[[ STRING HASH REF ]]]
# [[[ STRING HASH REF ]]]

# (ref to hash) of strings
package string__hash_ref;
use parent -norequire, ('hash_ref');

# [[[ STRINGIFY ]]]

# convert from (Perl SV containing RV to (Perl HV of (Perl SVs containing PVs))) to Perl-parsable (Perl SV containing PV)
our string $string__hash_ref__stringify = sub {
    ( my $input_hv_ref ) = @_;

    print
        "in PERLOPS_PERLTYPES string__hash_ref__stringify(), top of subroutine\n"
        or croak();

    #    ::hash_ref__CHECK($input_hv_ref);
    ::hash_ref__CHECKTRACE( $input_hv_ref, '$input_hv_ref',
        'string__hash_ref__stringify()' );

    my %input_hv;

    #	my integer $input_hv_length;
    my string $input_hv_entry_value;
    my string $output_sv;
    my integer $i_is_0 = 1;

    %input_hv = %{$input_hv_ref};

#	$input_hv_length = scalar keys %input_hv;
#	print "in PERLOPS_PERLTYPES string__hash_ref__stringify(), have \$input_hv_length = $input_hv_length\n";

    $output_sv = '{';

    foreach my string $key ( keys %input_hv ) {

        $input_hv_entry_value = $input_hv{$key};

        #        ::string__CHECK($input_hv_entry_value);
        ::string__CHECKTRACE(
            $input_hv_entry_value,
            "\$input_hv_entry_value at key '$key'",
            'string__hash_ref__stringify()'
        );

        if ($i_is_0) { $i_is_0 = 0; }
        else         { $output_sv .= ', '; }
        $key =~ s/\'/\\\'/gxms;
        $input_hv_entry_value =~ s/\'/\\\'/gxms;
        $output_sv .= "'$key' => '$input_hv_entry_value'";
    }

    $output_sv .= '}';

    print
        "in PERLOPS_PERLTYPES string__hash_ref__stringify(), after for() loop, have \$output_sv =\n$output_sv\n"
        or croak();
    print
        "in PERLOPS_PERLTYPES string__hash_ref__stringify(), bottom of subroutine\n"
        or croak();

    return ($output_sv);
};

# [[[ TYPE TESTING ]]]

our string $string__hash_ref__typetest0 = sub {
    ( my string__hash_ref $people) = @_;

    #    ::hash_ref__CHECK($lucky_numbers);
    ::hash_ref__CHECKTRACE( $people, '$people',
        'string__hash_ref__typetest0()' );
    foreach my string $key ( keys %{$people} ) {
        my $person = $people->{$key};

        #        ::string__CHECK($person);
        ::string__CHECKTRACE(
            $person,
            "\$person at key '$key'",
            'string__hash_ref__typetest0()'
        );
        print
            "in PERLOPS_PERLTYPES string__hash_ref__typetest0(), have person '$key' => '"
            . $people->{$key}
            . "', STARBOOL\n"
            or croak();
    }
    return ( string__hash_ref__stringify($people) . 'PERLOPS_PERLTYPES' );
};

our string__hash_ref $string__hash_ref__typetest1 = sub {
    ( my integer $my_size) = @_;

    #    ::integer__CHECK($my_size);
    ::integer__CHECKTRACE( $my_size, '$my_size',
        'string__hash_ref__typetest1()' );
    my string__hash_ref $people = {};
    for my integer $i ( 0 .. $my_size ) {
        $people->{ 'PERLOPS_PERLTYPES_Luker_key' . $i }
            = q{Jeffy Ten! } . $i . q{/} . ( $my_size - 1 );
        print
            "in PERLOPS_PERLTYPES string__hash_ref__typetest1(), bottom of for() loop, have i = $i, just set another Jeffy!\n"
            or croak();
    }
    return ($people);
};

# (ref to hash) of (strings with const values)
package const_string__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to hash) of (refs to strings)
package string_ref__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to hash) of (refs to (strings with const values))
package const_string_ref__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to (hash with const size)) of strings
package string__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (strings with const values)
package const_string__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (refs to strings)
package string_ref__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (refs to (strings with const values))
package const_string_ref__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# [[[ SCALAR HASHES ]]]

# hash of scalars
package scalar__hash;
use parent -norequire, ('hash');

# hash of (scalars with const values)
package const_scalar__hash;
use parent -norequire, ('hash');

# hash of (refs to scalars)
package scalar_ref__hash;
use parent -norequire, ('hash');

# hash of (refs to (scalars with const values))
package const_scalar_ref__hash;
use parent -norequire, ('hash');

# (hash with const size) of scalars
package scalar__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (scalars with const values)
package const_scalar__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (refs to scalars)
package scalar_ref__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (refs to (scalars with const values))
package const_scalar_ref__const_hash;
use parent -norequire, ('const_hash');

# (ref to hash) of scalars
package scalar__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to hash) of (scalars with const values)
package const_scalar__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to hash) of (refs to scalars)
package scalar_ref__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to hash) of (refs to (scalars with const values))
package const_scalar_ref__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to (hash with const size)) of scalars
package scalar__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (scalars with const values)
package const_scalar__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (refs to scalars)
package scalar_ref__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (refs to (scalars with const values))
package const_scalar_ref__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# [[[ UNKNOWN HASHES ]]]

# hash of unknowns
package unknown__hash;
use parent -norequire, ('hash');

# hash of (unknowns with const values)
package const_unknown__hash;
use parent -norequire, ('hash');

# hash of (refs to unknowns)
package unknown_ref__hash;
use parent -norequire, ('hash');

# hash of (refs to (unknowns with const values))
package const_unknown_ref__hash;
use parent -norequire, ('hash');

# (hash with const size) of unknowns
package unknown__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (unknowns with const values)
package const_unknown__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (refs to unknowns)
package unknown_ref__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (refs to (unknowns with const values))
package const_unknown_ref__const_hash;
use parent -norequire, ('const_hash');

# (ref to hash) of unknowns
package unknown__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to hash) of (unknowns with const values)
package const_unknown__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to hash) of (refs to unknowns)
package unknown_ref__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to hash) of (refs to (unknowns with const values))
package const_unknown_ref__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to (hash with const size)) of unknowns
package unknown__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (unknowns with const values)
package const_unknown__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (refs to unknowns)
package unknown_ref__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (refs to (unknowns with const values))
package const_unknown_ref__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# [[[ ARRAY HASHES (2-dimensional) ]]]

# hash of arrays
package array__hash;
use parent -norequire, ('hash');

# hash of (arrays with const sizes)
package const_array__hash;
use parent -norequire, ('hash');

# hash of (refs to arrays)
package array_ref__hash;
use parent -norequire, ('hash');

# hash of (refs to (arrays with const sizes))
package const_array_ref__hash;
use parent -norequire, ('hash');

# (hash with const size) of arrays
package array__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (arrays with const sizes)
package const_array__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (refs to arrays)
package array_ref__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (refs to (arrays with const sizes))
package const_array_ref__const_hash;
use parent -norequire, ('const_hash');

# (ref to hash) of arrays
package array__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to hash) of (arrays with const sizes)
package const_array__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to hash) of (refs to arrays)
package array_ref__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to hash) of (refs to (arrays with const sizes))
package const_array_ref__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to (hash with const size)) of arrays
package array__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (arrays with const sizes)
package const_array__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (refs to arrays)
package array_ref__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (refs to (arrays with const sizes))
package const_array_ref__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# [[[ HASH HASHES (2-dimesional) ]]]

# hash of hashs
package hash__hash;
use parent -norequire, ('hash');

# hash of (hashs with const sizes)
package const_hash__hash;
use parent -norequire, ('hash');

# hash of (refs to hashs)
package hash_ref__hash;
use parent -norequire, ('hash');

# hash of (refs to (hashs with const sizes))
package const_hash_ref__hash;
use parent -norequire, ('hash');

# (hash with const size) of hashs
package hash__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (hashs with const sizes)
package const_hash__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (refs to hashs)
package hash_ref__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (refs to (hashs with const sizes))
package const_hash_ref__const_hash;
use parent -norequire, ('const_hash');

# (ref to hash) of hashs
package hash__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to hash) of (hashs with const sizes)
package const_hash__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to hash) of (refs to hashs)
package hash_ref__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to hash) of (refs to (hashs with const sizes))
package const_hash_ref__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to (hash with const size)) of hashs
package hash__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (hashs with const sizes)
package const_hash__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (refs to hashs)
package hash_ref__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (refs to (hashs with const sizes))
package const_hash_ref__const_hash_ref;
use parent -norequire, ('const_hash_ref');

1;
