## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted sigils
## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
## no critic qw(ProhibitMultiplePackages)  ## RPERL SYSTEM types, allow multiple packages
## no critic qw(Capitalization)  ## RPERL SYSTEM types, allow lowercase packages
package RPerl::DataType::Number;
use strict;
use warnings;
use version; our $VERSION = qv('0.2.4');
use Carp;

# [[[ SETUP ]]]
use parent ('RPerl::DataType::Scalar');
use RPerl::DataType::Scalar;
#use RPerl::DataType::String;

# [[[ SUB-TYPES ]]]
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
#package RPerl::DataType::Number;
package number;  # NEED FIX: BROKEN INHERITANCE
use Carp;

# [[[ TYPE-CHECKING ]]]
our void__method $CHECK = sub {
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
our void__method $CHECKTRACE = sub {
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
#our integer $OPS_TYPES_ID = 0;                        # DEV NOTE: Integer type declared as a sub-type of Number, must disable here
our $OPS_TYPES_ID = 0;    # PERLOPS_PERLTYPES is 0
our string__method $ops   = sub { return ('PERL'); };
our string__method $types = sub { return ('PERL'); };

# [[[ STRINGIFY ]]]
our string__method $stringify = sub {
    ( my $input_number ) = @_;

    #    number::CHECK($input_number);
    number::CHECKTRACE( $input_number, '$input_number',
        'number::stringify()' );
    print
        "in PERLOPS_PERLTYPES number::stringify(), bottom of subroutine, received \$input_number = $input_number\n"
        or croak();
    return ("$input_number");
};

# [[[ TYPE TESTING ]]]
our number__method $typetest___void__in = sub {
    my number $retval = ( 22 / 7 ) + $OPS_TYPES_ID; # return floating-point number value
    print
        "in PERLOPS_PERLTYPES number::typetest___void__in(), have \$retval = $retval\n"
        or croak();
    return ($retval);
};
our number__method $typetest___number__in = sub {
    ( my number $lucky_number ) = @_;

    #    number::CHECK($lucky_number);
    number::CHECKTRACE( $lucky_number, '$lucky_number',
        'number::typetest___number__in()' );
    print
        'in PERLOPS_PERLTYPES number::typetest___number__in(), received $lucky_number = '
        . number::stringify($lucky_number) . "\n"
        or croak();
    return ( ( $lucky_number * 2 ) + $OPS_TYPES_ID );
};

1;
