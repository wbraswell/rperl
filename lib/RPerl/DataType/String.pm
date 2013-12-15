## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted sigils
## no critic qw(ProhibitMultiplePackages)  ## RPERL SYSTEM types, allow multiple packages
## no critic qw(Capitalization)  ## RPERL SYSTEM types, allow lowercase packages
package RPerl::DataType::String;
use strict;
use warnings;
use version; our $VERSION = qv('0.2.5');
use Carp;

# [[[ SETUP ]]]
use parent ('RPerl::DataType::Scalar');
use RPerl::DataType::Scalar;

# [[[ SUB-TYPES ]]]
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
#package RPerl::DataType::String;
package string;  # NEED FIX: BROKEN INHERITANCE
use Carp;

# [[[ TYPE CHECKING ]]]
our void__method $CHECK = sub {
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
our void__method $CHECKTRACE = sub {
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
#our integer $OPS_TYPES_ID = 0;                        # DEV NOTE: Integer type declared as a sub-type of Number, disable for now, re-enable later?
our $OPS_TYPES_ID = 0;    # PERLOPS_PERLTYPES is 0
our string__method $ops   = sub { return ('PERL'); };
our string__method $types = sub { return ('PERL'); };

# [[[ STRINGIFY ]]]
our string__method $stringify = sub {
    ( my string $input_string ) = @_;

    #    string::CHECK($input_string);
    string::CHECKTRACE( $input_string, '$input_string',
        'string::stringify()' );
    print
        "in PERLOPS_PERLTYPES string::stringify(), received \$input_string =\n$input_string\n\n"
        or croak();
    $input_string =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
    $input_string =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
    $input_string = "'$input_string'";

    print
        "in PERLOPS_PERLTYPES string::stringify(), bottom of subroutine, returning possibly-modified \$input_string =\n$input_string\n\n"
        or croak();

    return ($input_string);
};

# [[[ TYPE TESTING ]]]
our string__method $typetest___void__in = sub {
    my string $retval = 'Spice PERLOPS_PERLTYPES';
    print
        "in PERLOPS_PERLTYPES string::typetest___void__in(), have \$retval = '$retval'\n"
        or croak();
    return ($retval);
};
our string__method $typetest___string__in = sub {
    ( my string $lucky_string ) = @_;

    #    string::CHECK($lucky_string);
    string::CHECKTRACE( $lucky_string, '$lucky_string',
        'string::typetest___string__in()' );
    print
        "in PERLOPS_PERLTYPES string::typetest___string__in(), received \$lucky_string = '$lucky_string'\n"
        or croak();
    return ( string::stringify($lucky_string) . ' PERLOPS_PERLTYPES' );
};

1;
