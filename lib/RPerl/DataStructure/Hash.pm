## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted sigils
## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
## no critic qw(ProhibitMultiplePackages)  ## RPERL SYSTEM types, allow multiple packages
package RPerl::DataStructure::Hash;
use strict;
use warnings;
use version; our $VERSION = qv('0.2.2');
use Carp;

# [[[ SETUP ]]]
# [[[ SETUP ]]]
# [[[ SETUP ]]]

use base ('RPerl::DataStructure');
use RPerl::DataStructure;

# for type-checking via SvIOKp(), SvNOKp(), and SvPOKp(); inside INIT to delay until after 'use MyConfig'
INIT {
    print "in Hash.pm, loading C++ helper functions for type-checking...\n"
        or croak();
}
INIT {
    use RPerl::HelperFunctions_cpp;
    RPerl::HelperFunctions_cpp::cpp_load();
    RPerl::HelperFunctions_cpp::cpp_link();
}

use RPerl::DataType::Void;
use RPerl::DataType::Integer;
use RPerl::DataType::Float;
use RPerl::DataType::Number;
use RPerl::DataType::Character;
use RPerl::DataType::String;
use RPerl::DataType::Scalar;
use RPerl::DataType::Unknown;
use RPerl::DataStructure::Array;
use RPerl::DataStructure::Hash::SubTypes;

# [[[ SWITCH CONTEXT TO MAIN PACKAGE, THUS EXPORTING TYPE-CHECKING ]]]
package main;

# [[[ TYPE-CHECKING ]]]
# [[[ TYPE-CHECKING ]]]
# [[[ TYPE-CHECKING ]]]

our void $CHECK_HASH_REF = sub {
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
our void $CHECKTRACE_HASH_REF = sub {
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

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE ]]]
package RPerl::DataType::Integer;

# [[[ OPERATIONS & DATA TYPES REPORTING ]]]
# [[[ OPERATIONS & DATA TYPES REPORTING ]]]
# [[[ OPERATIONS & DATA TYPES REPORTING ]]]

our integer $OPS_TYPES_ID = 0;                        # PERLOPS_PERLTYPES is 0
our string $ops_hash      = sub { return ('PERL'); };
our string $types_hash    = sub { return ('PERL'); };

# [[[ STRINGIFY ]]]
# [[[ STRINGIFY ]]]
# [[[ STRINGIFY ]]]

# convert from (Perl SV containing RV to (Perl HV of (Perl SVs containing IVs))) to Perl-parsable (Perl SV containing PV)
our string $stringify_integer__hash_ref = sub {
    ( my $input_hv_ref ) = @_;

	print "in PERLOPS_PERLTYPES stringify_integer__hash_ref(), top of subroutine\n" or croak();
#    ::CHECK_HASH_REF($input_hv_ref);
    ::CHECKTRACE_HASH_REF( $input_hv_ref, '$input_hv_ref',
        'stringify_integer__hash_ref()' );

    my %input_hv;

#	my integer $input_hv_length;
    my integer $input_hv_entry_value;
    my string $output_sv;
    my integer $i_is_0 = 1;    # DEV NOTE: should be bool type, not integer

    %input_hv = %{$input_hv_ref};

#	$input_hv_length = scalar keys %input_hv;
#	print "in PERLOPS_PERLTYPES stringify_integer__hash_ref(), have \$input_hv_length = $input_hv_length\n";

    $output_sv = '{';

    foreach my string $key ( keys %input_hv ) {

        $input_hv_entry_value = $input_hv{$key};

        #        ::CHECK_INTEGER($input_hv_entry_value);
        ::CHECKTRACE_INTEGER( $input_hv_entry_value, "\$input_hv_entry_value at key '$key'",
            'stringify_integer__hash_ref()' );

        if ($i_is_0) { $i_is_0 = 0; } else { $output_sv .= ', '; }
        $key =~ s/\'/\\\'/gxms; # delimit all single-quote ' characters with a back-slash \ character
        $output_sv .= "'$key' => $input_hv_entry_value"; # DEV NOTE: emulate Data::Dumper & follow PBP by using single quotes for key strings
    }

    $output_sv .= '}';

	print "in PERLOPS_PERLTYPES stringify_integer__hash_ref(), after for() loop, have \$output_sv =\n$output_sv\n" or croak();
	print "in PERLOPS_PERLTYPES stringify_integer__hash_ref(), bottom of subroutine\n" or croak();

    return ($output_sv);
};

# convert from (Perl SV containing RV to (Perl HV of (Perl SVs containing NVs))) to Perl-parsable (Perl SV containing PV)
our string $stringify_number__hash_ref = sub {
    ( my $input_hv_ref ) = @_;

	print "in PERLOPS_PERLTYPES stringify_number__hash_ref(), top of subroutine\n" or croak();
#    ::CHECK_HASH_REF($input_hv_ref);
    ::CHECKTRACE_HASH_REF( $input_hv_ref, '$input_hv_ref',
        'stringify_number__hash_ref()' );

    my %input_hv;

    #	my integer $input_hv_length;
    my number $input_hv_entry_value;
    my string $output_sv;
    my integer $i_is_0 = 1;

    %input_hv = %{$input_hv_ref};

#	$input_hv_length = scalar keys %input_hv;
#	print "in PERLOPS_PERLTYPES stringify_number__hash_ref(), have \$input_hv_length = $input_hv_length\n";

    $output_sv = '{';

    foreach my string $key ( keys %input_hv ) {

        $input_hv_entry_value = $input_hv{$key};

        #        ::CHECK_NUMBER($input_hv_entry_value);
        ::CHECKTRACE_NUMBER( $input_hv_entry_value, "\$input_hv_entry_value at key '$key'",
            'stringify_number__hash_ref()' );

        if ($i_is_0) { $i_is_0 = 0; } else { $output_sv .= ', '; }
        $key =~ s/\'/\\\'/gxms;
        $output_sv .= "'$key' => $input_hv_entry_value";
    }

    $output_sv .= '}';

	print "in PERLOPS_PERLTYPES stringify_number__hash_ref(), after for() loop, have \$output_sv =\n$output_sv\n" or croak();
	print "in PERLOPS_PERLTYPES stringify_number__hash_ref(), bottom of subroutine\n" or croak();

    return ($output_sv);
};

# convert from (Perl SV containing RV to (Perl HV of (Perl SVs containing PVs))) to Perl-parsable (Perl SV containing PV)
our string $stringify_string__hash_ref = sub {
    ( my $input_hv_ref ) = @_;

	print "in PERLOPS_PERLTYPES stringify_string__hash_ref(), top of subroutine\n" or croak();
#    ::CHECK_HASH_REF($input_hv_ref);
    ::CHECKTRACE_HASH_REF( $input_hv_ref, '$input_hv_ref',
        'stringify_string__hash_ref()' );

    my %input_hv;

    #	my integer $input_hv_length;
    my string $input_hv_entry_value;
    my string $output_sv;
    my integer $i_is_0 = 1;

    %input_hv = %{$input_hv_ref};

#	$input_hv_length = scalar keys %input_hv;
#	print "in PERLOPS_PERLTYPES stringify_string__hash_ref(), have \$input_hv_length = $input_hv_length\n";

    $output_sv = '{';

    foreach my string $key ( keys %input_hv ) {

        $input_hv_entry_value = $input_hv{$key};

        #        ::CHECK_STRING($input_hv_entry_value);
        ::CHECKTRACE_STRING( $input_hv_entry_value, "\$input_hv_entry_value at key '$key'",
            'stringify_string__hash_ref()' );

        if ($i_is_0) { $i_is_0 = 0; } else { $output_sv .= ', '; }
        $key =~ s/\'/\\\'/gxms;
        $input_hv_entry_value =~ s/\'/\\\'/gxms;
        $output_sv .= "'$key' => '$input_hv_entry_value'";
    }

    $output_sv .= '}';

	print "in PERLOPS_PERLTYPES stringify_string__hash_ref(), after for() loop, have \$output_sv =\n$output_sv\n" or croak();
	print "in PERLOPS_PERLTYPES stringify_string__hash_ref(), bottom of subroutine\n" or croak();

    return ($output_sv);
};

# [[[ TYPE TESTING ]]]
# [[[ TYPE TESTING ]]]
# [[[ TYPE TESTING ]]]

our string $typetest___integer__hash_ref__in___string__out = sub {
#print "in PERLOPS_PERLTYPES Hash::typetest___integer__hash_ref__in___string__out(), top of subroutine\n";
    ( my integer__hash_ref $lucky_integers) = @_;

    #    ::CHECK_HASH_REF($lucky_integers);
    ::CHECKTRACE_HASH_REF( $lucky_integers, '$lucky_integers',
        'typetest___integer__hash_ref__in___string__out()' );
    foreach my string $key ( keys %{$lucky_integers} ) {
        my $lucky_integer = $lucky_integers->{$key};

        #        ::CHECK_INTEGER($lucky_integer);
        ::CHECKTRACE_INTEGER( $lucky_integer, "\$lucky_integer at key '$key'",
            'typetest___integer__hash_ref__in___string__out()' );
        print
            "in PERLOPS_PERLTYPES Hash::typetest___integer__hash_ref__in___string__out(), have lucky integer '$key' => "
            . $lucky_integer
            . ", BARSTOOL\n"
            or croak();
    }
print "in PERLOPS_PERLTYPES Hash::typetest___integer__hash_ref__in___string__out(), bottom of subroutine\n";
    return (
        stringify_integer__hash_ref($lucky_integers) . 'PERLOPS_PERLTYPES' );
};

our integer__hash_ref $typetest___integer__in___integer__hash_ref__out = sub {
    ( my integer $my_size) = @_;

    #    ::CHECK_INTEGER($my_size);
    ::CHECKTRACE_INTEGER( $my_size, '$my_size',
        'typetest___integer__in___integer__hash_ref__out()' );
    my integer__hash_ref $new_hash = {};
    my string $temp_key;
    for my integer $i ( 0 .. $my_size ) {
        $temp_key = 'PERLOPS_PERLTYPES_funkey' . $i;
        $new_hash->{$temp_key} = $i * 5;
        print
            "in PERLOPS_PERLTYPES Hash::typetest___integer__in___integer__hash_ref__out(), setting entry '$temp_key' => "
            . $new_hash->{$temp_key}
            . ", BARSTOOL\n"
            or croak();
    }
    return ($new_hash);
};

our string $typetest___number__hash_ref__in___string__out = sub {
    ( my number__hash_ref $lucky_numbers) = @_;

    #    ::CHECK_HASH_REF($lucky_numbers);
    ::CHECKTRACE_HASH_REF( $lucky_numbers, '$lucky_numbers',
        'typetest___number__hash_ref__in___string__out()' );
    foreach my string $key ( keys %{$lucky_numbers} ) {
        my $lucky_number = $lucky_numbers->{$key};

        #        ::CHECK_NUMBER($lucky_number);
        ::CHECKTRACE_NUMBER( $lucky_number, "\$lucky_number at key '$key'",
            'typetest___number__hash_ref__in___string__out()' );
        print
            "in PERLOPS_PERLTYPES Hash::typetest___number__hash_ref__in___string__out(), have lucky number '$key' => "
            . $lucky_number
            . ", BARSTOOL\n"
            or croak();
    }
    return (
        stringify_number__hash_ref($lucky_numbers) . 'PERLOPS_PERLTYPES' );
};

our number__hash_ref $typetest___integer__in___number__hash_ref__out = sub {
    ( my integer $my_size) = @_;

    #    ::CHECK_INTEGER($my_size);
    ::CHECKTRACE_INTEGER( $my_size, '$my_size',
        'typetest___integer__in___number__hash_ref__out()' );
    my number__hash_ref $new_hash = {};
    my string $temp_key;
    for my integer $i ( 0 .. $my_size ) {
        $temp_key = 'PERLOPS_PERLTYPES_funkey' . $i;
        $new_hash->{$temp_key} = $i * 5.123456789;
        print
            "in PERLOPS_PERLTYPES Hash::typetest___integer__in___number__hash_ref__out(), setting entry '$temp_key' => "
            . $new_hash->{$temp_key}
            . ", BARSTOOL\n"
            or croak();
    }
    return ($new_hash);
};

our string $typetest___string__hash_ref__in___string__out = sub {
    ( my string__hash_ref $people) = @_;

    #    ::CHECK_HASH_REF($lucky_numbers);
    ::CHECKTRACE_HASH_REF( $people, '$people',
        'typetest___string__hash_ref__in___string__out()' );
    foreach my string $key ( keys %{$people} ) {
        my $person = $people->{$key};

        #        ::CHECK_STRING($person);
        ::CHECKTRACE_STRING( $person, "\$person at key '$key'",
            'typetest___string__hash_ref__in___string__out()' );
        print
            "in PERLOPS_PERLTYPES Hash::typetest___string__hash_ref__in___string__out(), have person '$key' => '"
            . $people->{$key}
            . "', STARBOOL\n"
            or croak();
    }
    return ( stringify_string__hash_ref($people) . 'PERLOPS_PERLTYPES' );
};

our string__hash_ref $typetest___integer__in___string__hash_ref__out = sub {
    ( my integer $my_size) = @_;

    #    ::CHECK_INTEGER($my_size);
    ::CHECKTRACE_INTEGER( $my_size, '$my_size',
        'typetest___integer__in___string__hash_ref__out()' );
    my string__hash_ref $people = {};
    for my integer $i ( 0 .. $my_size ) {
        $people->{ 'PERLOPS_PERLTYPES_Luker_key' . $i }
            = q{Jeffy Ten! } . $i . q{/} . ( $my_size - 1 );
        print
            "in PERLOPS_PERLTYPES Hash::typetest___integer__in___string__hash_ref__out(), bottom of for() loop, have i = $i, just set another Jeffy!\n"
            or croak();
    }
    return ($people);
};

1;
