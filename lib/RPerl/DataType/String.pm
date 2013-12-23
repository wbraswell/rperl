## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted sigils
## no critic qw(ProhibitMultiplePackages)  ## RPERL SYSTEM types, allow multiple packages
## no critic qw(Capitalization)  ## RPERL SYSTEM types, allow lowercase packages
package RPerl::DataType::String;
use strict;
use warnings;
use version; our $VERSION = 0.003_003;
use parent ('RPerl::DataType');
use RPerl::DataType;
use Carp;

# [[[ SUB-TYPES BEFORE SETUP ]]]
# a string is 0 or more letters, digits, or other ASCII (Unicode???) symbols
package string;
use parent ('RPerl::DataType::String');

# string with const value
package const_string;
use parent -norequire, qw(string const);

# ref to string
package string_ref;
use parent -norequire, ('ref');

# ref to (string with const value)
package const_string_ref;
use parent -norequire, ('ref');

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE ]]]
package RPerl::DataType::String;

# [[[ SETUP ]]]
use parent ('RPerl::DataType::Scalar');
use RPerl::DataType::Scalar;
use RPerl::DataType::Integer; # need integer type, normally included by types.pm but put here in case we don't use types.pm

# [[[ TYPE CHECKING ]]]
our void $string__CHECK = sub {
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
our void $string__CHECKTRACE = sub {
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

# [[[ OPERATIONS & DATA TYPES REPORTING ]]]
our integer $string__OPS_TYPES_ID = 0;    # PERLOPS_PERLTYPES is 0
our string $string__ops = sub { return ('PERL'); };
our string $string__types = sub { return ('PERL'); };

# [[[ STRINGIFY ]]]
our string $string__stringify = sub {
    ( my string $input_string ) = @_;

    #    string__CHECK($input_string);
    string__CHECKTRACE( $input_string, '$input_string',
        'string__stringify()' );
    print
        "in PERLOPS_PERLTYPES string__stringify(), received \$input_string =\n$input_string\n\n"
        or croak();
    $input_string =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
    $input_string =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
    $input_string = "'$input_string'";

    print
        "in PERLOPS_PERLTYPES string__stringify(), bottom of subroutine, returning possibly-modified \$input_string =\n$input_string\n\n"
        or croak();

    return ($input_string);
};

# [[[ TYPE TESTING ]]]
our string $string__typetest0 = sub {
    my string $retval = 'Spice PERLOPS_PERLTYPES';
    print
        "in PERLOPS_PERLTYPES string__typetest0(), have \$retval = '$retval'\n"
        or croak();
    return ($retval);
};
our string $string__typetest1 = sub {
    ( my string $lucky_string ) = @_;

    #    string__CHECK($lucky_string);
    string__CHECKTRACE( $lucky_string, '$lucky_string',
        'string__typetest1()' );
    print
        "in PERLOPS_PERLTYPES string__typetest1(), received \$lucky_string = '$lucky_string'\n"
        or croak();
    return ( string__stringify($lucky_string) . ' PERLOPS_PERLTYPES' );
};

1;
