package RPerl::DataType::String;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.004_000;

# [[[ OO INHERITANCE ]]]
use parent ('RPerl::DataType::Scalar');
use RPerl::DataType::Scalar;

# [[[ CRITICS ]]]
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ SUB-TYPES BEFORE INCLUDES ]]]
# a string is 0 or more letters, digits, or other ASCII (Unicode???) symbols
package string;
use parent ('RPerl::DataType::String');

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE ]]]
package RPerl::DataType::String;

# [[[ INCLUDES ]]]
use RPerl::DataType::Integer; # need integer type, normally included by rperltypes.pm but put here in case we don't use rperltypes.pm
use RPerl::DataType::Number; # need number type, same as above
use POSIX qw(floor);

# [[[ TYPE CHECKING ]]]
our void $string_CHECK = sub {
    ( my $possible_string ) = @_;
    if ( not( defined $possible_string ) ) {
        croak(
            "\nERROR EPV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring value expected but undefined/null value found,\ncroaking"
        );
    }
    if ( not( main::RPerl_SvPOKp($possible_string) ) ) {
        croak(
            "\nERROR EPV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring value expected but non-string value found,\ncroaking"
        );
    }
};
our void $string_CHECKTRACE = sub {
    ( my $possible_string, my $variable_name, my $subroutine_name ) = @_;
    if ( not( defined $possible_string ) ) {
        croak(
            "\nERROR EPV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }
    if ( not( main::RPerl_SvPOKp($possible_string) ) ) {
        croak(
            "\nERROR EPV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring value expected but non-string value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }
};

# [[[ INTEGERIFY ]]]
our integer $string_to_integer = sub {
    (my string $input_string) = @_;
    return floor ($input_string * 1);
};

# [[[ NUMBERIFY ]]]
our number $string_to_number = sub {
    (my string $input_string) = @_;
    return $input_string * 1.0;
};

# [[[ STRINGIFY ]]]
our string $string_to_string = sub {
    ( my string $input_string ) = @_;

    #    string_CHECK($input_string);
    string_CHECKTRACE( $input_string, '$input_string',
        'string_to_string()' );

#    RPerl::diag "in PERLOPS_PERLTYPES string_to_string(), received \$input_string =\n$input_string\n\n";
    $input_string =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
    $input_string =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
    $input_string = "'$input_string'";

#    RPerl::diag "in PERLOPS_PERLTYPES string_to_string(), bottom of subroutine, returning possibly-modified \$input_string =\n$input_string\n\n";

    return ($input_string);
};

# [[[ TYPE TESTING ]]]
our string $string__typetest0 = sub {
    my string $retval = 'Spice PERLOPS_PERLTYPES';

#    RPerl::diag "in PERLOPS_PERLTYPES string__typetest0(), have \$retval = '$retval'\n";
    return ($retval);
};
our string $string__typetest1 = sub {
    ( my string $lucky_string ) = @_;

    #    string_CHECK($lucky_string);
    string_CHECKTRACE( $lucky_string, '$lucky_string',
        'string__typetest1()' );

#    RPerl::diag "in PERLOPS_PERLTYPES string__typetest1(), received \$lucky_string = '$lucky_string'\n";
    return ( string_to_string($lucky_string) . ' PERLOPS_PERLTYPES' );
};

1;
