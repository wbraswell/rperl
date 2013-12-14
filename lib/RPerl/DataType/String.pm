## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted sigils
## no critic qw(ProhibitMultiplePackages)  ## RPERL SYSTEM types, allow multiple packages
## no critic qw(Capitalization)  ## RPERL SYSTEM types, allow lowercase packages
package RPerl::DataType::String;
use strict;
use warnings;
use version; our $VERSION = qv('0.2.5');
use Carp;

# [[[ SETUP ]]]
use base ('RPerl::DataType::Scalar');
use RPerl::DataType::Scalar;

# [[[ SUB-TYPES ]]]
# a string is 0 or more letters, digits, or other ASCII (Unicode???) symbols
package string;
use base ('RPerl::DataType::String');

# string with const value
package const_string;
use base qw(string const);

# ref to string
package string_ref;
use base ('ref');

# ref to (string with const value)
package const_string_ref;
use base ('ref');

# [[[ SWITCH CONTEXT TO MAIN PACKAGE, THUS EXPORTING TYPE-CHECKING ]]]
package main;

# [[[ TYPE CHECKING ]]]
our void $CHECK_STRING = sub {
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
our void $CHECKTRACE_STRING = sub {
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

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE ]]]
package RPerl::DataType::String;

# [[[ OPERATIONS & DATA TYPES REPORTING ]]]
#our integer $OPS_TYPES_ID = 0;                        # DEV NOTE: Integer type declared as a sub-type of Number, disable for now, re-enable later?
our $OPS_TYPES_ID = 0;    # PERLOPS_PERLTYPES is 0
our string $ops_string   = sub { return ('PERL'); };
our string $types_string = sub { return ('PERL'); };

# [[[ STRINGIFY ]]]
our string $stringify_string = sub {
    ( my string $input_string ) = @_;

    #    ::CHECK_STRING($input_string);
    ::CHECKTRACE_STRING( $input_string, '$input_string',
        'stringify_string()' );
    print
        "in PERLOPS_PERLTYPES String::stringify_string(), received \$input_string =\n$input_string\n\n"
        or croak();
    $input_string =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
    $input_string =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
    $input_string = "'$input_string'";

    print
        "in PERLOPS_PERLTYPES String::stringify_string(), bottom of subroutine, returning possibly-modified \$input_string =\n$input_string\n\n"
        or croak();

    return ($input_string);
};

# [[[ TYPE TESTING ]]]
our string $typetest___void__in___string__out = sub {
    my string $retval = 'Spice PERLOPS_PERLTYPES';
    print
        "in PERLOPS_PERLTYPES String::typetest___void__in___string__out(), have \$retval = '$retval'\n"
        or croak();
    return ($retval);
};
our string $typetest___string__in___string__out = sub {
    ( my string $lucky_string ) = @_;

    #    ::CHECK_STRING($lucky_string);
    ::CHECKTRACE_STRING( $lucky_string, '$lucky_string',
        'typetest___string__in___string__out()' );
    print
        "in PERLOPS_PERLTYPES String::typetest___string__in___string__out(), received \$lucky_string = '$lucky_string'\n"
        or croak();
    return ( stringify_string($lucky_string) . ' PERLOPS_PERLTYPES' );
};

1;
