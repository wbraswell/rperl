## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted sigils
## no critic qw(ProhibitMultiplePackages)  ## RPERL SYSTEM types, allow multiple packages
## no critic qw(Capitalization)  ## RPERL SYSTEM types, allow lowercase packages
package RPerl::DataType::String;
use strict;
use warnings;
use version; our $VERSION = qv('0.2.2');
use Carp;
use base ('RPerl::DataType::Scalar');
use RPerl::DataType::Scalar;

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

# [[[ SWITCH CONTEXT BACK TO MAIN PACKAGE ]]]
package RPerl::DataType::String;

# [[[ OPERATIONS & DATA TYPES REPORTING ]]]
#our integer $OPS_TYPES_ID = 0;                        # DEV NOTE: Integer type declared as a sub-type of Number, disable for now, re-enable later?
our $OPS_TYPES_ID = 0;    # PERLOPS_PERLTYPES is 0
our string $ops_string   = sub { return ('PERL'); };
our string $types_string = sub { return ('PERL'); };

# [[[ TYPE CHECKING ]]]
our void $check_string = sub {
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
our void $check_string_trace = sub {
    ( my $possible_string, my $variable_name, my $subroutine_name ) = @_;
    if ( not( defined $possible_string ) ) {
        croak(
            "\nERROR EPV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring value expected but undefined/null value found,\nin variable '$variable_name' from subroutine '$subroutine_name',\ncroaking"
        );
    }
    if ( not( main::RPerl_SvPOKp($possible_string) ) ) {
        croak(
            "\nERROR EPV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring value expected but non-string value found,\nin variable '$variable_name' from subroutine '$subroutine_name',\ncroaking"
        );
    }
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

    #    check_string($lucky_string);
    check_string_trace( $lucky_string, '$lucky_string',
        'typetest___string__in___string__out()' );
    print
        "in PERLOPS_PERLTYPES String::typetest___string__in___string__out(), received \$lucky_string = '$lucky_string'\n"
        or croak();
    return ( $lucky_string . ' PERLOPS_PERLTYPES' );
};

1;
