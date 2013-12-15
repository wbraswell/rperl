## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted sigils
## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
## no critic qw(ProhibitMultiplePackages)  ## RPERL SYSTEM types, allow multiple packages
## no critic qw(Capitalization)  ## RPERL SYSTEM types, allow lowercase packages
package RPerl::DataType::Number;
use strict;
use warnings;
use version; our $VERSION = qv('0.3.0');
use Carp;

# [[[ SUB-TYPES BEFORE SETUP ]]]
# DEV NOTE:
# a number is any numeric value, meaning either an integer or a floating-point number;
# Integer and Float are both sub-classes of Number;
# the hidden Perl semantics are SvIOKp() for ints, and SvNOKp() for numbers;
# these numbers appear to act as C long doubles and are implemented as such in RPerl;
# there is no SvFOKp() for floats, so float currently inherits everything from number,
# and we generate C long doubles instead of C floats;
# in the future, this can be optimized (for at least memory usage) by implementing full Float semantics
package number;
use parent ('RPerl::DataType::Number');

# number with const value
package const_number;
use parent -norequire, qw(number const);

# ref to number
package number_ref;
use parent -norequire, ('ref');

# ref to (number with const value)
package const_number_ref;
use parent -norequire, ('ref');

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE ]]]
package RPerl::DataType::Number;

# [[[ SETUP ]]]
use parent ('RPerl::DataType::Scalar');
use RPerl::DataType::Scalar;
use RPerl::DataType::String;    # need string type
use RPerl::DataType::Integer; # need integer type, normally included by types.pm but put here in case we don't use types.pm

# [[[ TYPE-CHECKING ]]]
our void $number__CHECK = sub {
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
our void $number__CHECKTRACE = sub {
    ( my $possible_number, my $variable_name, my $subroutine_name ) = @_;
    if ( not( defined $possible_number ) ) {
        croak(
            "\nERROR ENV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }
    if (not(   main::RPerl_SvNOKp($possible_number)
            || main::RPerl_SvIOKp($possible_number) )
        )
    {
        croak(
            "\nERROR ENV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber value expected but non-number value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }
};

# [[[ OPERATIONS & DATA TYPES REPORTING ]]]
our integer $number__OPS_TYPES_ID = 0;    # PERLOPS_PERLTYPES is 0
our string $number__ops = sub { return ('PERL'); };
our string $number__types = sub { return ('PERL'); };

# [[[ STRINGIFY ]]]
our string $number__stringify = sub {
    ( my $input_number ) = @_;

    #    number__CHECK($input_number);
    number__CHECKTRACE( $input_number, '$input_number',
        'number__stringify()' );
    print
        "in PERLOPS_PERLTYPES number__stringify(), bottom of subroutine, received \$input_number = $input_number\n"
        or croak();
    return ("$input_number");
};

# [[[ TYPE TESTING ]]]
our number $number__typetest0 = sub {
    my number $retval = ( 22 / 7 ) + $number__OPS_TYPES_ID; # return floating-point number value
    print
        "in PERLOPS_PERLTYPES number__typetest0(), have \$retval = $retval\n"
        or croak();
    return ($retval);
};
our number $number__typetest1 = sub {
    ( my number $lucky_number ) = @_;

    #    number__CHECK($lucky_number);
    number__CHECKTRACE( $lucky_number, '$lucky_number',
        'number__typetest1()' );
    print
        'in PERLOPS_PERLTYPES number__typetest1(), received $lucky_number = '
        . number__stringify($lucky_number) . "\n"
        or croak();
    return ( ( $lucky_number * 2 ) + $number__OPS_TYPES_ID );
};

1;
