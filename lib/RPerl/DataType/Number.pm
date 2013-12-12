## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted sigils
## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
## no critic qw(ProhibitMultiplePackages)  ## RPERL SYSTEM types, allow multiple packages
## no critic qw(Capitalization)  ## RPERL SYSTEM types, allow lowercase packages
package RPerl::DataType::Number;
use strict;
use warnings;
use version; our $VERSION = qv('0.2.2');
use Carp;
use base ('RPerl::DataType::Scalar');
use RPerl::DataType::Scalar;
use RPerl::DataType::String;

# DEV NOTE:
# a number is any numeric value, meaning either an integer or a floating-point number;
# Integer and Float are both sub-classes of Number;
# the hidden Perl semantics are SvIOKp() for ints, and SvNOKp() for numbers;
# these numbers appear to act as C long doubles and are implemented as such in RPerl;
# there is no SvFOKp() for floats, so float currently inherits everything from number,
# and we generate C long doubles instead of C floats;
# in the future, this can be optimized (for at least memory usage) by implementing full Float semantics
package number;
use base ('RPerl::DataType::Number');

# number with const value
package const_number;
use base qw(number const);

# ref to number
package number_ref;
use base ('ref');

# ref to (number with const value)
package const_number_ref;
use base ('ref');

# [[[ SWITCH CONTEXT BACK TO MAIN PACKAGE ]]]
package RPerl::DataType::Number;

# [[[ OPERATIONS & DATA TYPES REPORTING ]]]
#our integer $OPS_TYPES_ID = 0;                        # DEV NOTE: Integer type declared as a sub-type of Number, must disable here
our $OPS_TYPES_ID = 0;    # PERLOPS_PERLTYPES is 0
our string $ops_number   = sub { return ('PERL'); };
our string $types_number = sub { return ('PERL'); };

# [[[ TYPE-CHECKING ]]]
our void $check_number = sub {
    ( my $possible_number ) = @_;
    if ( not( defined $possible_number ) ) {
        croak(
            "\nERROR ENV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber value expected but undefined/null value found,\ncroaking"
        );
    }
    if (not(   main::RPerl_SvNOKp($possible_number)
            || main::RPerl_SvIOKp($possible_number) )
        )
    {
        croak(
            "\nERROR ENV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber value expected but non-number value found,\ncroaking"
        );
    }
};

our void $check_number_trace = sub {
    ( my $possible_number, my $variable_name, my $subroutine_name ) = @_;
    if ( not( defined $possible_number ) ) {
        croak(
            "\nERROR ENV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber value expected but undefined/null value found,\nin variable '$variable_name' from subroutine '$subroutine_name',\ncroaking"
        );
    }
    if (not(   main::RPerl_SvNOKp($possible_number)
            || main::RPerl_SvIOKp($possible_number) )
        )
    {
        croak(
            "\nERROR ENV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber value expected but non-number value found,\nin variable '$variable_name' from subroutine '$subroutine_name',\ncroaking"
        );
    }
};

# [[[ STRINGIFY ]]]
our string $stringify_number = sub {
    ( my $input_number ) = @_;

    #    check_number($input_number);
    check_number_trace( $input_number, '$input_number',
        'stringify_number()' );
    print
        "in PERLOPS_PERLTYPES Number::stringify_number(), bottom of subroutine, received \$input_number = $input_number\n"
        or croak();
    return ("$input_number");
};

# [[[ TYPE TESTING ]]]
our number $typetest___void__in___number__out = sub {
    my number $retval = ( 22 / 7 ) + $OPS_TYPES_ID; # return floating-point number value
    print
        "in PERLOPS_PERLTYPES Number::typetest___void__in___number__out(), have \$retval = $retval\n"
        or croak();
    return ($retval);
};
our number $typetest___number__in___number__out = sub {
    ( my number $lucky_number ) = @_;

    #    check_number($lucky_number);
    check_number_trace( $lucky_number, '$lucky_number',
        'typetest___number__in___number__out()' );
    print
        'in PERLOPS_PERLTYPES Number::typetest___number__in___number__out(), received $lucky_number = '
        . stringify_number($lucky_number) . "\n"
        or croak();
    return ( ( $lucky_number * 2 ) + $OPS_TYPES_ID );
};

1;
