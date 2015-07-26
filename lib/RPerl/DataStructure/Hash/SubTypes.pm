## no critic qw(ProhibitUselessNoCritic PodSpelling ProhibitExcessMainComplexity)  # DEVELOPER DEFAULT 1a: allow unreachable & POD-commented code; SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1
package RPerl::DataStructure::Hash::SubTypes;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.007_000;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitUnreachableCode RequirePodSections RequirePodAtEnd) # DEVELOPER DEFAULT 1b: allow unreachable & POD-commented code, must be after line 1
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ HASHES ]]]

# a hash is an associative array, meaning a 1-dimensional list/vector/sequence/set of (key, value) pairs;
# we never use this type directly, instead we always use the hashref type,
# per LMPC #27: Thou Shalt Not Use Direct Access To Arrays & Hashes Stored In @ Or % Non-Scalar Variables
package  # hide from PAUSE indexing
    hash;
use strict;
use warnings;
use RPerl;
use parent ('RPerl::DataStructure::Hash');

# [[[ HASH REF ]]]
# [[[ HASH REF ]]]
# [[[ HASH REF ]]]

# ref to hash
package  # hide from PAUSE indexing
    hashref;
use strict;
use warnings;
use RPerl;
#use parent -norequire, ('ref');  # NEED REMOVE: properly replaced by line below?
use parent -norequire, ('RPerl::DataStructure::Hash::Reference');
use Carp;

# [[[ TYPE-CHECKING ]]]

our void $hashref_CHECK = sub {
    ( my $possible_hashref ) = @_;
    if ( not( defined $possible_hashref ) ) {
        croak(
            "\nERROR EHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nhashref value expected but undefined/null value found,\ncroaking"
        );
    }

#    if ( UNIVERSAL::isa( $possible_hashref, 'HASH' ) ) {  # DEV NOTE: I believe these 2 lines are equivalent?
    if ( not( main::RPerl_SvHROKp($possible_hashref) ) ) {
        croak(
            "\nERROR EHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nhashref value expected but non-hashref value found,\ncroaking"
        );
    }
};
our void $hashref_CHECKTRACE = sub {
    ( my $possible_hashref, my $variable_name, my $subroutine_name ) = @_;
    if ( not( defined $possible_hashref ) ) {
        croak(
            "\nERROR EHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nhashref value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }
    if ( not( main::RPerl_SvHROKp($possible_hashref) ) ) {
        croak(
            "\nERROR EHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nhashref value expected but non-hashref value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }
};

# [[[ INTEGER HASH REF ]]]
# [[[ INTEGER HASH REF ]]]
# [[[ INTEGER HASH REF ]]]

# (ref to hash) of integers
package  # hide from PAUSE indexing
    integer_hashref;
use strict;
use warnings;
use RPerl;
use parent -norequire, ('hashref');
use Carp;

# [[[ TYPE-CHECKING ]]]

our void $integer_hashref_CHECK = sub {
    ( my $possible_integer_hashref ) = @_;

# DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECK() subroutine, but with integer-specific error codes
    if ( not( defined $possible_integer_hashref ) ) {
        croak(
            "\nERROR EIVHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger_hashref value expected but undefined/null value found,\ncroaking"
        );
    }

    if ( not( main::RPerl_SvHROKp($possible_integer_hashref) ) ) {
        croak(
            "\nERROR EIVHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger_hashref value expected but non-hashref value found,\ncroaking"
        );
    }

    my integer $possible_integer;
    foreach my string $key ( keys %{$possible_integer_hashref} ) {
        $possible_integer = $possible_integer_hashref->{$key};

# DEV NOTE: the following two if() statements are functionally equivalent to the integer_CHECK() subroutine, but with hash-specific error codes
        if ( not( defined $possible_integer ) ) {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak(
                "\nERROR EIVHVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger_hashref element value expected but undefined/null value found at key '$key',\ncroaking"
            );
        }
        if ( not( main::RPerl_SvIOKp($possible_integer) ) ) {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak(
                "\nERROR EIVHVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger_hashref element value expected but non-integer value found at key '$key',\ncroaking"
            );
        }
    }
};
our void $integer_hashref_CHECKTRACE = sub {
    ( my $possible_integer_hashref, my $variable_name, my $subroutine_name )
        = @_;

# DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECKTRACE() subroutine, but with integer-specific error codes
    if ( not( defined $possible_integer_hashref ) ) {
        croak(
            "\nERROR EIVHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger_hashref value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }

    if ( not( main::RPerl_SvHROKp($possible_integer_hashref) ) ) {
        croak(
            "\nERROR EIVHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger_hashref value expected but non-hashref value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }

    my integer $possible_integer;
    foreach my string $key ( keys %{$possible_integer_hashref} ) {
        $possible_integer = $possible_integer_hashref->{$key};

# DEV NOTE: the following two if() statements are functionally equivalent to the integer_CHECKTRACE() subroutine, but with hash-specific error codes
        if ( not( defined $possible_integer ) ) {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak(
                "\nERROR EIVHVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger_hashref element value expected but undefined/null value found at key '$key',\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
            );
        }
        if ( not( main::RPerl_SvIOKp($possible_integer) ) ) {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak(
                "\nERROR EIVHVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger_hashref element value expected but non-integer value found at key '$key',\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
            );
        }
    }
};

# [[[ STRINGIFY ]]]

# convert from (Perl SV containing RV to (Perl HV of (Perl SVs containing IVs))) to Perl-parsable (Perl SV containing PV)
our string $integer_hashref_to_string = sub {
    ( my $input_hv_ref ) = @_;

#    RPerl::diag("in PERLOPS_PERLTYPES integer_hashref_to_string(), top of subroutine\n");

    #    ::integer_hashref_CHECK($input_hv_ref);
    ::integer_hashref_CHECKTRACE( $input_hv_ref, '$input_hv_ref',
        'integer_hashref_to_string()' );

    my %input_hv;

    #	my integer $input_hv_length;
    my integer $input_hv_entry_value;
    my string $output_sv;
    my integer $i_is_0 = 1;   # NEED UPGRADE: should be bool type, not integer

    %input_hv = %{$input_hv_ref};

#	$input_hv_length = scalar keys %input_hv;
#	RPerl::diag("in PERLOPS_PERLTYPES integer_hashref_to_string(), have \$input_hv_length = $input_hv_length\n");

    $output_sv = '{';

    foreach my string $key ( keys %input_hv ) {

        $input_hv_entry_value = $input_hv{$key};
        $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
        $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character

# DEV NOTE: integer type-checking already done as part of integer_hashref_CHECKTRACE()
#        ::integer_CHECK($input_hv_entry_value);
#        ::integer_CHECKTRACE( $input_hv_entry_value, "\$input_hv_entry_value at key '$key'", 'integer_hashref_to_string()' );

        if ($i_is_0) { $i_is_0 = 0; }
        else         { $output_sv .= ', '; }
        $output_sv .= "'$key' => $input_hv_entry_value"; # DEV NOTE: emulate Data::Dumper & follow PBP by using single quotes for key strings
    }

    $output_sv .= '}';

#    RPerl::diag("in PERLOPS_PERLTYPES integer_hashref_to_string(), after for() loop, have \$output_sv =\n$output_sv\n");
#    RPerl::diag("in PERLOPS_PERLTYPES integer_hashref_to_string(), bottom of subroutine\n");

    return ($output_sv);
};

# [[[ TYPE TESTING ]]]

our string $integer_hashref__typetest0 = sub {
    ( my integer_hashref $lucky_integers) = @_;

    #    ::integer_hashref_CHECK($lucky_integers);
    ::integer_hashref_CHECKTRACE( $lucky_integers, '$lucky_integers',
        'integer_hashref__typetest0()' );

#    foreach my string $key ( keys %{$lucky_integers} ) {
#        my $lucky_integer = $lucky_integers->{$key};
#        $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
#        $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
#
#        RPerl::diag("in PERLOPS_PERLTYPES integer_hashref__typetest0(), have lucky integer '$key' => " . $lucky_integer . ", BARSTOOL\n");
#    }
#    RPerl::diag("in PERLOPS_PERLTYPES integer_hashref__typetest0(), bottom of subroutine\n");

    return (
        integer_hashref_to_string($lucky_integers) . 'PERLOPS_PERLTYPES' );
};

our integer_hashref $integer_hashref__typetest1 = sub {
    ( my integer $my_size) = @_;

    #    ::integer_CHECK($my_size);
    ::integer_CHECKTRACE( $my_size, '$my_size',
        'integer_hashref__typetest1()' );
    my integer_hashref $new_hash = {};
    my string $temp_key;
    for my integer $i ( 0 .. ( $my_size - 1 ) ) {
        $temp_key = 'PERLOPS_PERLTYPES_funkey' . $i;
        $new_hash->{$temp_key} = $i * 5;

#        RPerl::diag("in PERLOPS_PERLTYPES integer_hashref__typetest1(), setting entry '$temp_key' => " . $new_hash->{$temp_key} . ", BARSTOOL\n");
    }
    return ($new_hash);
};

# [[[ FLOAT HASHES ]]]

# (ref to hash) of floats
package  # hide from PAUSE indexing
    float_hashref;
use strict;
use warnings;
use RPerl;
use parent -norequire, ('hashref');

# [[[ NUMBER HASH REF ]]]
# [[[ NUMBER HASH REF ]]]
# [[[ NUMBER HASH REF ]]]

# (ref to hash) of numbers
package  # hide from PAUSE indexing
    number_hashref;
use strict;
use warnings;
use RPerl;
use parent -norequire, ('hashref');
use Carp;

# [[[ TYPE-CHECKING ]]]

our void $number_hashref_CHECK = sub {
    ( my $possible_number_hashref ) = @_;

# DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECK() subroutine, but with number-specific error codes
    if ( not( defined $possible_number_hashref ) ) {
        croak(
            "\nERROR ENVHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber_hashref value expected but undefined/null value found,\ncroaking"
        );
    }

    if ( not( main::RPerl_SvHROKp($possible_number_hashref) ) ) {
        croak(
            "\nERROR ENVHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber_hashref value expected but non-hashref value found,\ncroaking"
        );
    }

    my number $possible_number;
    foreach my string $key ( keys %{$possible_number_hashref} ) {
        $possible_number = $possible_number_hashref->{$key};

# DEV NOTE: the following two if() statements are functionally equivalent to the number_CHECK() subroutine, but with hash-specific error codes
        if ( not( defined $possible_number ) ) {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak(
                "\nERROR ENVHVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber_hashref element value expected but undefined/null value found at key '$key',\ncroaking"
            );
        }
        if (not(   main::RPerl_SvNOKp($possible_number)
                || main::RPerl_SvIOKp($possible_number) )
            )
        {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak(
                "\nERROR ENVHVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber_hashref element value expected but non-number value found at key '$key',\ncroaking"
            );
        }
    }
};
our void $number_hashref_CHECKTRACE = sub {
    ( my $possible_number_hashref, my $variable_name, my $subroutine_name )
        = @_;

# DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECKTRACE() subroutine, but with number-specific error codes
    if ( not( defined $possible_number_hashref ) ) {
        croak(
            "\nERROR ENVHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber_hashref value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }

    if ( not( main::RPerl_SvHROKp($possible_number_hashref) ) ) {
        croak(
            "\nERROR ENVHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber_hashref value expected but non-hashref value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }

    my number $possible_number;
    foreach my string $key ( keys %{$possible_number_hashref} ) {
        $possible_number = $possible_number_hashref->{$key};

# DEV NOTE: the following two if() statements are functionally equivalent to the number_CHECKTRACE() subroutine, but with hash-specific error codes
        if ( not( defined $possible_number ) ) {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak(
                "\nERROR ENVHVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber_hashref element value expected but undefined/null value found at key '$key',\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
            );
        }
        if (not(   main::RPerl_SvNOKp($possible_number)
                || main::RPerl_SvIOKp($possible_number) )
            )
        {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak(
                "\nERROR ENVHVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber_hashref element value expected but non-number value found at key '$key',\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
            );
        }
    }
};

# [[[ STRINGIFY ]]]

# convert from (Perl SV containing RV to (Perl HV of (Perl SVs containing NVs))) to Perl-parsable (Perl SV containing PV)
our string $number_hashref_to_string = sub {
    ( my $input_hv_ref ) = @_;

#    RPerl::diag("in PERLOPS_PERLTYPES number_hashref_to_string(), top of subroutine\n");

    #    ::number_hashref_CHECK($input_hv_ref);
    ::number_hashref_CHECKTRACE( $input_hv_ref, '$input_hv_ref',
        'number_hashref_to_string()' );

    my %input_hv;

    #	my integer $input_hv_length;
    my number $input_hv_entry_value;
    my string $output_sv;
    my integer $i_is_0 = 1;   # NEED UPGRADE: should be bool type, not integer

    %input_hv = %{$input_hv_ref};

#	$input_hv_length = scalar keys %input_hv;
#	RPerl::diag("in PERLOPS_PERLTYPES number_hashref_to_string(), have \$input_hv_length = $input_hv_length\n");

    $output_sv = '{';

    foreach my string $key ( keys %input_hv ) {

        $input_hv_entry_value = $input_hv{$key};
        $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
        $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character

        if ($i_is_0) { $i_is_0 = 0; }
        else         { $output_sv .= ', '; }
#        $output_sv .= "'$key' => $input_hv_entry_value";
        $output_sv .= q{'} . $key . q{' => } . RPerl::DataType::Number::number_to_string($input_hv_entry_value);
    }

    $output_sv .= '}';

#    RPerl::diag("in PERLOPS_PERLTYPES number_hashref_to_string(), after for() loop, have \$output_sv =\n$output_sv\n");
#    RPerl::diag("in PERLOPS_PERLTYPES number_hashref_to_string(), bottom of subroutine\n");

    return ($output_sv);
};

# [[[ TYPE TESTING ]]]

our string $number_hashref__typetest0 = sub {
    ( my number_hashref $lucky_numbers) = @_;

    #    ::number_hashref_CHECK($lucky_numbers);
    ::number_hashref_CHECKTRACE( $lucky_numbers, '$lucky_numbers',
        'number_hashref__typetest0()' );

#    foreach my string $key ( keys %{$lucky_numbers} ) {
#        my $lucky_number = $lucky_numbers->{$key};
#        $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
#        $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
#        RPerl::diag("in PERLOPS_PERLTYPES number_hashref__typetest0(), have lucky number '$key' => " . $lucky_number . ", BARSTOOL\n");
#    }

    return (
        number_hashref_to_string($lucky_numbers) . 'PERLOPS_PERLTYPES' );
};

our number_hashref $number_hashref__typetest1 = sub {
    ( my integer $my_size) = @_;

    #    ::integer_CHECK($my_size);
    ::integer_CHECKTRACE( $my_size, '$my_size',
        'number_hashref__typetest1()' );
    my number_hashref $new_hash = {};
    my string $temp_key;
    for my integer $i ( 0 .. ( $my_size - 1 ) ) {
        $temp_key = 'PERLOPS_PERLTYPES_funkey' . $i;
        $new_hash->{$temp_key} = $i * 5.123456789;

#        RPerl::diag("in PERLOPS_PERLTYPES number_hashref__typetest1(), setting entry '$temp_key' => " . $new_hash->{$temp_key} . ", BARSTOOL\n");
    }
    return ($new_hash);
};

# [[[ CHAR HASHES ]]]

# (ref to hash) of chars
package  # hide from PAUSE indexing
    char_hashref;
use strict;
use warnings;
use RPerl;
use parent -norequire, ('hashref');

# [[[ STRING HASH REF ]]]
# [[[ STRING HASH REF ]]]
# [[[ STRING HASH REF ]]]

# (ref to hash) of strings
package  # hide from PAUSE indexing
    string_hashref;
use strict;
use warnings;
use RPerl;
use parent -norequire, ('hashref');
use Carp;

# [[[ TYPE-CHECKING ]]]

our void $string_hashref_CHECK = sub {
    ( my $possible_string_hashref ) = @_;

# DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECK() subroutine, but with string-specific error codes
    if ( not( defined $possible_string_hashref ) ) {
        croak(
            "\nERROR EPVHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring_hashref value expected but undefined/null value found,\ncroaking"
        );
    }

    if ( not( main::RPerl_SvHROKp($possible_string_hashref) ) ) {
        croak(
            "\nERROR EPVHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring_hashref value expected but non-hashref value found,\ncroaking"
        );
    }

    my string $possible_string;
    foreach my string $key ( keys %{$possible_string_hashref} ) {
        $possible_string = $possible_string_hashref->{$key};

# DEV NOTE: the following two if() statements are functionally equivalent to the string_CHECK() subroutine, but with hash-specific error codes
        if ( not( defined $possible_string ) ) {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak(
                "\nERROR EPVHVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring_hashref element value expected but undefined/null value found at key '$key',\ncroaking"
            );
        }
        if ( not( main::RPerl_SvPOKp($possible_string) ) ) {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak(
                "\nERROR EPVHVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring_hashref element value expected but non-string value found at key '$key',\ncroaking"
            );
        }
    }
};
our void $string_hashref_CHECKTRACE = sub {
    ( my $possible_string_hashref, my $variable_name, my $subroutine_name )
        = @_;

# DEV NOTE: the following two if() statements are functionally equivalent to the hashref_CHECKTRACE() subroutine, but with string-specific error codes
    if ( not( defined $possible_string_hashref ) ) {
        croak(
            "\nERROR EPVHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring_hashref value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }

    if ( not( main::RPerl_SvHROKp($possible_string_hashref) ) ) {
        croak(
            "\nERROR EPVHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring_hashref value expected but non-hashref value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }

    my string $possible_string;
    foreach my string $key ( keys %{$possible_string_hashref} ) {
        $possible_string = $possible_string_hashref->{$key};

# DEV NOTE: the following two if() statements are functionally equivalent to the string_CHECKTRACE() subroutine, but with hash-specific error codes
        if ( not( defined $possible_string ) ) {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak(
                "\nERROR EPVHVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring_hashref element value expected but undefined/null value found at key '$key',\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
            );
        }
        if ( not( main::RPerl_SvPOKp($possible_string) ) ) {
            $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
            $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
            croak(
                "\nERROR EPVHVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring_hashref element value expected but non-string value found at key '$key',\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
            );
        }
    }
};

# [[[ STRINGIFY ]]]

# convert from (Perl SV containing RV to (Perl HV of (Perl SVs containing PVs))) to Perl-parsable (Perl SV containing PV)
our string $string_hashref_to_string = sub {
    ( my $input_hv_ref ) = @_;

#    RPerl::diag("in PERLOPS_PERLTYPES string_hashref_to_string(), top of subroutine\n");

    #    ::string_hashref_CHECK($input_hv_ref);
    ::string_hashref_CHECKTRACE( $input_hv_ref, '$input_hv_ref',
        'string_hashref_to_string()' );

    my %input_hv;

    #	my integer $input_hv_length;
    my string $input_hv_entry_value;
    my string $output_sv;
    my integer $i_is_0 = 1;   # NEED UPGRADE: should be bool type, not integer

    %input_hv = %{$input_hv_ref};

#	$input_hv_length = scalar keys %input_hv;
#	RPerl::diag("in PERLOPS_PERLTYPES string_hashref_to_string(), have \$input_hv_length = $input_hv_length\n");

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

#    RPerl::diag("in PERLOPS_PERLTYPES string_hashref_to_string(), after for() loop, have \$output_sv =\n$output_sv\n");
#    RPerl::diag("in PERLOPS_PERLTYPES string_hashref_to_string(), bottom of subroutine\n");

    return ($output_sv);
};

# [[[ TYPE TESTING ]]]

our string $string_hashref__typetest0 = sub {
    ( my string_hashref $people) = @_;

    #    ::string_hashref_CHECK($lucky_numbers);
    ::string_hashref_CHECKTRACE( $people, '$people',
        'string_hashref__typetest0()' );

#    foreach my string $key ( keys %{$people} ) {
#        my $person = $people->{$key};
#        $key =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
#        $key =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
#        RPerl::diag("in PERLOPS_PERLTYPES string_hashref__typetest0(), have person '$key' => '" . $person . "', STARBOOL\n");
#    }

    return ( string_hashref_to_string($people) . 'PERLOPS_PERLTYPES' );
};

our string_hashref $string_hashref__typetest1 = sub {
    ( my integer $my_size) = @_;

    #    ::integer_CHECK($my_size);
    ::integer_CHECKTRACE( $my_size, '$my_size',
        'string_hashref__typetest1()' );
    my string_hashref $people = {};
    for my integer $i ( 0 .. ( $my_size - 1 ) ) {
        $people->{ 'PERLOPS_PERLTYPES_Luker_key' . $i }
            = q{Jeffy Ten! } . $i . q{/} . ( $my_size - 1 );

#        RPerl::diag("in PERLOPS_PERLTYPES string_hashref__typetest1(), bottom of for() loop, have i = $i, just set another Jeffy!\n");
    }
    return ($people);
};

# [[[ SCALAR HASHES ]]]

# (ref to hash) of scalartypes
package  # hide from PAUSE indexing
    scalartype_hashref;
use strict;
use warnings;
use RPerl;
use parent -norequire, ('hashref');

# [[[ ARRAY HASHES (2-dimensional) ]]]

# (ref to hash) of (refs to arrays)
package  # hide from PAUSE indexing
    arrayref_hashref;
use strict;
use warnings;
use RPerl;
use parent -norequire, ('hashref');

# [[[ HASH HASHES (2-dimesional) ]]]

# (ref to hash) of (refs to hashs)
package  # hide from PAUSE indexing
    hashref_hashref;
use strict;
use warnings;
use RPerl;
use parent -norequire, ('hashref');

# [ HOMOGENEOUS HASH HASHES (2-dimensional) ]

# (ref to hash) of (refs to (hashs of integers))
package  # hide from PAUSE indexing
    integer_hashref_hashref;
use strict;
use warnings;
use RPerl;
use parent -norequire, ('hashref_hashref');

# (ref to hash) of (refs to (hashs of numbers))
package  # hide from PAUSE indexing
    number_hashref_hashref;
use strict;
use warnings;
use RPerl;
use parent -norequire, ('hashref_hashref');

# (ref to hash) of (refs to (hashs of strings))
package  # hide from PAUSE indexing
    string_hashref_hashref;
use strict;
use warnings;
use RPerl;
use parent -norequire, ('hashref_hashref');

# (ref to hash) of (refs to (hashs of scalars))
package  # hide from PAUSE indexing
    scalartype_hashref_hashref;
use strict;
use warnings;
use RPerl;
use parent -norequire, ('hashref_hashref');

# [[[ OBJECT HASHES (2-dimensional) ]]]

# (ref to hash) of objects
package  # hide from PAUSE indexing
    object_hashref;
use strict;
use warnings;
use RPerl;
use parent -norequire, ('hashref');

1;
