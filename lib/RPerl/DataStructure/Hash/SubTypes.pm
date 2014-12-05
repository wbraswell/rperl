## no critic qw(ProhibitUselessNoCritic PodSpelling ProhibitExcessMainComplexity)  # DEVELOPER DEFAULT 1a: allow unreachable & POD-commented code; SYSTEM SPECIAL 5: allow complex code outside subroutines, must be on line 1
package RPerl::DataStructure::Hash::SubTypes;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.004_001;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values and print operator
## no critic qw(ProhibitUnreachableCode RequirePodSections RequirePodAtEnd) # DEVELOPER DEFAULT 1b: allow unreachable & POD-commented code, must be after line 1
## no critic qw(RequireInterpolationOfMetachars)  # SYSTEM DEFAULT 2: allow single-quoted control characters, sigils, and regexes
## no critic qw(Capitalization ProhibitMultiplePackages)  # SYSTEM DEFAULT 4: allow multiple lower case package names

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
use Carp;

# [[[ TYPE-CHECKING ]]]

our void $hash_ref__CHECK = sub {
    ( my $possible_hash_ref ) = @_;
    if ( not( defined $possible_hash_ref ) ) {
        croak(
            "\nERROR EHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nhash_ref value expected but undefined/null value found,\ncroaking"
        );
    }

#    if ( UNIVERSAL::isa( $possible_hash_ref, 'HASH' ) ) {  # DEV NOTE: I believe these 2 lines are equivalent?
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
            "\nERROR EHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nhash_ref value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }
    if ( not( main::RPerl_SvHROKp($possible_hash_ref) ) ) {
        croak(
            "\nERROR EHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nhash_ref value expected but non-hash_ref value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
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
use Carp;

# [[[ TYPE-CHECKING ]]]

our void $integer__hash_ref__CHECK = sub {
    ( my $possible_integer__hash_ref ) = @_;

# DEV NOTE: the following two if() statements are functionally equivalent to the hash_ref__CHECK() subroutine, but with integer-specific error codes
    if ( not( defined $possible_integer__hash_ref ) ) {
        croak(
            "\nERROR EIVHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger__hash_ref value expected but undefined/null value found,\ncroaking"
        );
    }

    if ( not( main::RPerl_SvHROKp($possible_integer__hash_ref) ) ) {
        croak(
            "\nERROR EIVHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger__hash_ref value expected but non-hash_ref value found,\ncroaking"
        );
    }

    my integer $possible_integer;
    foreach my string $key ( keys %{$possible_integer__hash_ref} ) {
        $possible_integer = $possible_integer__hash_ref->{$key};

# DEV NOTE: the following two if() statements are functionally equivalent to the integer__CHECK() subroutine, but with hash-specific error codes
        if ( not( defined $possible_integer ) ) {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak(
                "\nERROR EIVHVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger__hash_ref element value expected but undefined/null value found at key '$key',\ncroaking"
            );
        }
        if ( not( main::RPerl_SvIOKp($possible_integer) ) ) {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak(
                "\nERROR EIVHVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger__hash_ref element value expected but non-integer value found at key '$key',\ncroaking"
            );
        }
    }
};
our void $integer__hash_ref__CHECKTRACE = sub {
    ( my $possible_integer__hash_ref, my $variable_name, my $subroutine_name )
        = @_;

# DEV NOTE: the following two if() statements are functionally equivalent to the hash_ref__CHECKTRACE() subroutine, but with integer-specific error codes
    if ( not( defined $possible_integer__hash_ref ) ) {
        croak(
            "\nERROR EIVHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger__hash_ref value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }

    if ( not( main::RPerl_SvHROKp($possible_integer__hash_ref) ) ) {
        croak(
            "\nERROR EIVHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger__hash_ref value expected but non-hash_ref value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }

    my integer $possible_integer;
    foreach my string $key ( keys %{$possible_integer__hash_ref} ) {
        $possible_integer = $possible_integer__hash_ref->{$key};

# DEV NOTE: the following two if() statements are functionally equivalent to the integer__CHECKTRACE() subroutine, but with hash-specific error codes
        if ( not( defined $possible_integer ) ) {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak(
                "\nERROR EIVHVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger__hash_ref element value expected but undefined/null value found at key '$key',\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
            );
        }
        if ( not( main::RPerl_SvIOKp($possible_integer) ) ) {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak(
                "\nERROR EIVHVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger__hash_ref element value expected but non-integer value found at key '$key',\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
            );
        }
    }
};

# [[[ STRINGIFY ]]]

# convert from (Perl SV containing RV to (Perl HV of (Perl SVs containing IVs))) to Perl-parsable (Perl SV containing PV)
our string $integer__hash_ref__stringify = sub {
    ( my $input_hv_ref ) = @_;

#    RPerl::diag "in PERLOPS_PERLTYPES integer__hash_ref__stringify(), top of subroutine\n" or croak();

    #    ::integer__hash_ref__CHECK($input_hv_ref);
    ::integer__hash_ref__CHECKTRACE( $input_hv_ref, '$input_hv_ref',
        'integer__hash_ref__stringify()' );

    my %input_hv;

    #	my integer $input_hv_length;
    my integer $input_hv_entry_value;
    my string $output_sv;
    my integer $i_is_0 = 1;   # NEED UPGRADE: should be bool type, not integer

    %input_hv = %{$input_hv_ref};

#	$input_hv_length = scalar keys %input_hv;
#	RPerl::diag "in PERLOPS_PERLTYPES integer__hash_ref__stringify(), have \$input_hv_length = $input_hv_length\n";

    $output_sv = '{';

    foreach my string $key ( keys %input_hv ) {

        $input_hv_entry_value = $input_hv{$key};
        $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
        $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character

# DEV NOTE: integer type-checking already done as part of integer__hash_ref__CHECKTRACE()
#        ::integer__CHECK($input_hv_entry_value);
#        ::integer__CHECKTRACE( $input_hv_entry_value, "\$input_hv_entry_value at key '$key'", 'integer__hash_ref__stringify()' );

        if ($i_is_0) { $i_is_0 = 0; }
        else         { $output_sv .= ', '; }
        $output_sv .= "'$key' => $input_hv_entry_value"; # DEV NOTE: emulate Data::Dumper & follow PBP by using single quotes for key strings
    }

    $output_sv .= '}';

#    RPerl::diag "in PERLOPS_PERLTYPES integer__hash_ref__stringify(), after for() loop, have \$output_sv =\n$output_sv\n" or croak();
#    RPerl::diag "in PERLOPS_PERLTYPES integer__hash_ref__stringify(), bottom of subroutine\n" or croak();

    return ($output_sv);
};

# [[[ TYPE TESTING ]]]

our string $integer__hash_ref__typetest0 = sub {
    ( my integer__hash_ref $lucky_integers) = @_;

    #    ::integer__hash_ref__CHECK($lucky_integers);
    ::integer__hash_ref__CHECKTRACE( $lucky_integers, '$lucky_integers',
        'integer__hash_ref__typetest0()' );

=disable
    foreach my string $key ( keys %{$lucky_integers} ) {
        my $lucky_integer = $lucky_integers->{$key};
        $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
        $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character

        RPerl::diag
            "in PERLOPS_PERLTYPES integer__hash_ref__typetest0(), have lucky integer '$key' => "
            . $lucky_integer
            . ", BARSTOOL\n"
            or croak();
    }
    RPerl::diag
        "in PERLOPS_PERLTYPES integer__hash_ref__typetest0(), bottom of subroutine\n";
=cut

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
    for my integer $i ( 0 .. ( $my_size - 1 ) ) {
        $temp_key = 'PERLOPS_PERLTYPES_funkey' . $i;
        $new_hash->{$temp_key} = $i * 5;

#        RPerl::diag "in PERLOPS_PERLTYPES integer__hash_ref__typetest1(), setting entry '$temp_key' => " . $new_hash->{$temp_key} . ", BARSTOOL\n" or croak();
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
use Carp;

# [[[ TYPE-CHECKING ]]]

our void $number__hash_ref__CHECK = sub {
    ( my $possible_number__hash_ref ) = @_;

# DEV NOTE: the following two if() statements are functionally equivalent to the hash_ref__CHECK() subroutine, but with number-specific error codes
    if ( not( defined $possible_number__hash_ref ) ) {
        croak(
            "\nERROR ENVHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber__hash_ref value expected but undefined/null value found,\ncroaking"
        );
    }

    if ( not( main::RPerl_SvHROKp($possible_number__hash_ref) ) ) {
        croak(
            "\nERROR ENVHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber__hash_ref value expected but non-hash_ref value found,\ncroaking"
        );
    }

    my number $possible_number;
    foreach my string $key ( keys %{$possible_number__hash_ref} ) {
        $possible_number = $possible_number__hash_ref->{$key};

# DEV NOTE: the following two if() statements are functionally equivalent to the number__CHECK() subroutine, but with hash-specific error codes
        if ( not( defined $possible_number ) ) {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak(
                "\nERROR ENVHVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber__hash_ref element value expected but undefined/null value found at key '$key',\ncroaking"
            );
        }
        if (not(   main::RPerl_SvNOKp($possible_number)
                || main::RPerl_SvIOKp($possible_number) )
            )
        {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak(
                "\nERROR ENVHVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber__hash_ref element value expected but non-number value found at key '$key',\ncroaking"
            );
        }
    }
};
our void $number__hash_ref__CHECKTRACE = sub {
    ( my $possible_number__hash_ref, my $variable_name, my $subroutine_name )
        = @_;

# DEV NOTE: the following two if() statements are functionally equivalent to the hash_ref__CHECKTRACE() subroutine, but with number-specific error codes
    if ( not( defined $possible_number__hash_ref ) ) {
        croak(
            "\nERROR ENVHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber__hash_ref value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }

    if ( not( main::RPerl_SvHROKp($possible_number__hash_ref) ) ) {
        croak(
            "\nERROR ENVHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber__hash_ref value expected but non-hash_ref value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }

    my number $possible_number;
    foreach my string $key ( keys %{$possible_number__hash_ref} ) {
        $possible_number = $possible_number__hash_ref->{$key};

# DEV NOTE: the following two if() statements are functionally equivalent to the number__CHECKTRACE() subroutine, but with hash-specific error codes
        if ( not( defined $possible_number ) ) {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak(
                "\nERROR ENVHVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber__hash_ref element value expected but undefined/null value found at key '$key',\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
            );
        }
        if (not(   main::RPerl_SvNOKp($possible_number)
                || main::RPerl_SvIOKp($possible_number) )
            )
        {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak(
                "\nERROR ENVHVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber__hash_ref element value expected but non-number value found at key '$key',\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
            );
        }
    }
};

# [[[ STRINGIFY ]]]

# convert from (Perl SV containing RV to (Perl HV of (Perl SVs containing NVs))) to Perl-parsable (Perl SV containing PV)
our string $number__hash_ref__stringify = sub {
    ( my $input_hv_ref ) = @_;

#    RPerl::diag "in PERLOPS_PERLTYPES number__hash_ref__stringify(), top of subroutine\n" or croak();

    #    ::number__hash_ref__CHECK($input_hv_ref);
    ::number__hash_ref__CHECKTRACE( $input_hv_ref, '$input_hv_ref',
        'number__hash_ref__stringify()' );

    my %input_hv;

    #	my integer $input_hv_length;
    my number $input_hv_entry_value;
    my string $output_sv;
    my integer $i_is_0 = 1;   # NEED UPGRADE: should be bool type, not integer

    %input_hv = %{$input_hv_ref};

#	$input_hv_length = scalar keys %input_hv;
#	RPerl::diag "in PERLOPS_PERLTYPES number__hash_ref__stringify(), have \$input_hv_length = $input_hv_length\n";

    $output_sv = '{';

    foreach my string $key ( keys %input_hv ) {

        $input_hv_entry_value = $input_hv{$key};
        $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
        $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character

        if ($i_is_0) { $i_is_0 = 0; }
        else         { $output_sv .= ', '; }
        $output_sv .= "'$key' => $input_hv_entry_value";
    }

    $output_sv .= '}';

#    RPerl::diag "in PERLOPS_PERLTYPES number__hash_ref__stringify(), after for() loop, have \$output_sv =\n$output_sv\n" or croak();
#    RPerl::diag "in PERLOPS_PERLTYPES number__hash_ref__stringify(), bottom of subroutine\n" or croak();

    return ($output_sv);
};

# [[[ TYPE TESTING ]]]

our string $number__hash_ref__typetest0 = sub {
    ( my number__hash_ref $lucky_numbers) = @_;

    #    ::number__hash_ref__CHECK($lucky_numbers);
    ::number__hash_ref__CHECKTRACE( $lucky_numbers, '$lucky_numbers',
        'number__hash_ref__typetest0()' );

=disable
    foreach my string $key ( keys %{$lucky_numbers} ) {
        my $lucky_number = $lucky_numbers->{$key};
        $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
        $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
#        RPerl::diag "in PERLOPS_PERLTYPES number__hash_ref__typetest0(), have lucky number '$key' => " . $lucky_number . ", BARSTOOL\n" or croak();
    }
=cut

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
    for my integer $i ( 0 .. ( $my_size - 1 ) ) {
        $temp_key = 'PERLOPS_PERLTYPES_funkey' . $i;
        $new_hash->{$temp_key} = $i * 5.123456789;

#        RPerl::diag "in PERLOPS_PERLTYPES number__hash_ref__typetest1(), setting entry '$temp_key' => " . $new_hash->{$temp_key} . ", BARSTOOL\n" or croak();
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
use Carp;

# [[[ TYPE-CHECKING ]]]

our void $string__hash_ref__CHECK = sub {
    ( my $possible_string__hash_ref ) = @_;

# DEV NOTE: the following two if() statements are functionally equivalent to the hash_ref__CHECK() subroutine, but with string-specific error codes
    if ( not( defined $possible_string__hash_ref ) ) {
        croak(
            "\nERROR EPVHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring__hash_ref value expected but undefined/null value found,\ncroaking"
        );
    }

    if ( not( main::RPerl_SvHROKp($possible_string__hash_ref) ) ) {
        croak(
            "\nERROR EPVHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring__hash_ref value expected but non-hash_ref value found,\ncroaking"
        );
    }

    my string $possible_string;
    foreach my string $key ( keys %{$possible_string__hash_ref} ) {
        $possible_string = $possible_string__hash_ref->{$key};

# DEV NOTE: the following two if() statements are functionally equivalent to the string__CHECK() subroutine, but with hash-specific error codes
        if ( not( defined $possible_string ) ) {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak(
                "\nERROR EPVHVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring__hash_ref element value expected but undefined/null value found at key '$key',\ncroaking"
            );
        }
        if ( not( main::RPerl_SvPOKp($possible_string) ) ) {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak(
                "\nERROR EPVHVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring__hash_ref element value expected but non-string value found at key '$key',\ncroaking"
            );
        }
    }
};
our void $string__hash_ref__CHECKTRACE = sub {
    ( my $possible_string__hash_ref, my $variable_name, my $subroutine_name )
        = @_;

# DEV NOTE: the following two if() statements are functionally equivalent to the hash_ref__CHECKTRACE() subroutine, but with string-specific error codes
    if ( not( defined $possible_string__hash_ref ) ) {
        croak(
            "\nERROR EPVHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring__hash_ref value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }

    if ( not( main::RPerl_SvHROKp($possible_string__hash_ref) ) ) {
        croak(
            "\nERROR EPVHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring__hash_ref value expected but non-hash_ref value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }

    my string $possible_string;
    foreach my string $key ( keys %{$possible_string__hash_ref} ) {
        $possible_string = $possible_string__hash_ref->{$key};

# DEV NOTE: the following two if() statements are functionally equivalent to the string__CHECKTRACE() subroutine, but with hash-specific error codes
        if ( not( defined $possible_string ) ) {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak(
                "\nERROR EPVHVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring__hash_ref element value expected but undefined/null value found at key '$key',\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
            );
        }
        if ( not( main::RPerl_SvPOKp($possible_string) ) ) {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak(
                "\nERROR EPVHVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring__hash_ref element value expected but non-string value found at key '$key',\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
            );
        }
    }
};

# [[[ STRINGIFY ]]]

# convert from (Perl SV containing RV to (Perl HV of (Perl SVs containing PVs))) to Perl-parsable (Perl SV containing PV)
our string $string__hash_ref__stringify = sub {
    ( my $input_hv_ref ) = @_;

#    RPerl::diag "in PERLOPS_PERLTYPES string__hash_ref__stringify(), top of subroutine\n" or croak();

    #    ::string__hash_ref__CHECK($input_hv_ref);
    ::string__hash_ref__CHECKTRACE( $input_hv_ref, '$input_hv_ref',
        'string__hash_ref__stringify()' );

    my %input_hv;

    #	my integer $input_hv_length;
    my string $input_hv_entry_value;
    my string $output_sv;
    my integer $i_is_0 = 1;   # NEED UPGRADE: should be bool type, not integer

    %input_hv = %{$input_hv_ref};

#	$input_hv_length = scalar keys %input_hv;
#	RPerl::diag "in PERLOPS_PERLTYPES string__hash_ref__stringify(), have \$input_hv_length = $input_hv_length\n";

    $output_sv = '{';

    foreach my string $key ( keys %input_hv ) {

        $input_hv_entry_value = $input_hv{$key};
        $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
        $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character

        if ($i_is_0) { $i_is_0 = 0; }
        else         { $output_sv .= ', '; }
        $input_hv_entry_value =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
        $input_hv_entry_value =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
        $output_sv .= "'$key' => '$input_hv_entry_value'";
    }

    $output_sv .= '}';

#    RPerl::diag "in PERLOPS_PERLTYPES string__hash_ref__stringify(), after for() loop, have \$output_sv =\n$output_sv\n" or croak();
#    RPerl::diag "in PERLOPS_PERLTYPES string__hash_ref__stringify(), bottom of subroutine\n" or croak();

    return ($output_sv);
};

# [[[ TYPE TESTING ]]]

our string $string__hash_ref__typetest0 = sub {
    ( my string__hash_ref $people) = @_;

    #    ::string__hash_ref__CHECK($lucky_numbers);
    ::string__hash_ref__CHECKTRACE( $people, '$people',
        'string__hash_ref__typetest0()' );

=disable
    foreach my string $key ( keys %{$people} ) {
        my $person = $people->{$key};
        $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
        $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
#        RPerl::diag "in PERLOPS_PERLTYPES string__hash_ref__typetest0(), have person '$key' => '" . $person . "', STARBOOL\n" or croak();
    }
=cut

    return ( string__hash_ref__stringify($people) . 'PERLOPS_PERLTYPES' );
};

our string__hash_ref $string__hash_ref__typetest1 = sub {
    ( my integer $my_size) = @_;

    #    ::integer__CHECK($my_size);
    ::integer__CHECKTRACE( $my_size, '$my_size',
        'string__hash_ref__typetest1()' );
    my string__hash_ref $people = {};
    for my integer $i ( 0 .. ( $my_size - 1 ) ) {
        $people->{ 'PERLOPS_PERLTYPES_Luker_key' . $i }
            = q{Jeffy Ten! } . $i . q{/} . ( $my_size - 1 );

#        RPerl::diag "in PERLOPS_PERLTYPES string__hash_ref__typetest1(), bottom of for() loop, have i = $i, just set another Jeffy!\n" or croak();
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

# hash of scalartypes
package scalartype__hash;
use parent -norequire, ('hash');

# hash of (scalartypes with const values)
package const_scalartype__hash;
use parent -norequire, ('hash');

# hash of (refs to scalartypes)
package scalartype_ref__hash;
use parent -norequire, ('hash');

# hash of (refs to (scalartypes with const values))
package const_scalartype_ref__hash;
use parent -norequire, ('hash');

# (hash with const size) of scalartypes
package scalartype__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (scalartypes with const values)
package const_scalartype__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (refs to scalartypes)
package scalartype_ref__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (refs to (scalartypes with const values))
package const_scalartype_ref__const_hash;
use parent -norequire, ('const_hash');

# (ref to hash) of scalartypes
package scalartype__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to hash) of (scalartypes with const values)
package const_scalartype__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to hash) of (refs to scalartypes)
package scalartype_ref__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to hash) of (refs to (scalartypes with const values))
package const_scalartype_ref__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to (hash with const size)) of scalartypes
package scalartype__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (scalartypes with const values)
package const_scalartype__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (refs to scalartypes)
package scalartype_ref__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (refs to (scalartypes with const values))
package const_scalartype_ref__const_hash_ref;
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

# [[[ OBJECT HASHES (2-dimensional) ]]]

# hash of objects
package object__hash;
use parent -norequire, ('hash');

# hash of (objects with const sizes)
package const_object__hash;
use parent -norequire, ('hash');

# hash of (refs to objects)
package object_ref__hash;
use parent -norequire, ('hash');

# hash of (refs to (objects with const sizes))
package const_object_ref__hash;
use parent -norequire, ('hash');

# (hash with const size) of objects
package object__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (objects with const sizes)
package const_object__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (refs to objects)
package object_ref__const_hash;
use parent -norequire, ('const_hash');

# (hash with const size) of (refs to (objects with const sizes))
package const_object_ref__const_hash;
use parent -norequire, ('const_hash');

# (ref to hash) of objects
package object__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to hash) of (objects with const sizes)
package const_object__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to hash) of (refs to objects)
package object_ref__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to hash) of (refs to (objects with const sizes))
package const_object_ref__hash_ref;
use parent -norequire, ('hash_ref');

# (ref to (hash with const size)) of objects
package object__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (objects with const sizes)
package const_object__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (refs to objects)
package object_ref__const_hash_ref;
use parent -norequire, ('const_hash_ref');

# (ref to (hash with const size)) of (refs to (objects with const sizes))
package const_object_ref__const_hash_ref;
use parent -norequire, ('const_hash_ref');

1;
