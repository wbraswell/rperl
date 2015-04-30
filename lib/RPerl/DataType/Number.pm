# [[[ HEADER ]]]
package RPerl::DataType::Number;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.003_040;

# [[[ OO INHERITANCE ]]]
use parent ('RPerl::DataType::Scalar');
use RPerl::DataType::Scalar;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ SUB-TYPES BEFORE INCLUDES ]]]
# DEV NOTE, CORRELATION #7:
# a number is any numeric value, meaning either an integer or a floating-point number;
# Integer and Float are both sub-classes of Number;
# the hidden Perl semantics are SvIOKp() for ints, and SvNOKp() for numbers;
# these numbers appear to act as C doubles and are implemented as such in RPerl;
# there is no SvFOKp() for floats, so float currently inherits everything from number,
# and we generate C doubles instead of C floats;
# in the future, this can be optimized (for at least memory usage) by implementing full Float semantics
package number;
use parent ('RPerl::DataType::Number');

# number with const value
package const_number;
use parent -norequire, qw(number const);

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE ]]]
package RPerl::DataType::Number;

# [[[ OO INHERITANCE ]]]
use parent ('RPerl::DataType::Scalar');
use RPerl::DataType::Scalar;

# [[[ INCLUDES ]]]
use RPerl::DataType::String;    # need string type
use RPerl::DataType::Integer; # need integer type, normally included by rperltypes.pm but put here in case we don't use rperltypes.pm

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

# BUG BOUNTY #000, 50 CodeCoin: modify all ::number*__to_string() to output underscores, to match LITERAL_NUMBER grammar token input

# [[[ STRINGIFY ]]]
our string $number__to_string = sub {
    ( my $input_number ) = @_;

    #    number__CHECK($input_number);
    number__CHECKTRACE( $input_number, '$input_number',
        'number__to_string()' );

#    RPerl::diag "in PERLOPS_PERLTYPES number__to_string(), bottom of subroutine, received \$input_number = $input_number\n" or croak();
    return ("$input_number");
};

# [[[ TYPE TESTING ]]]
our number $number__typetest0 = sub {
    my number $retval = ( 22 / 7 ) + main::RPerl__DataType__Number__MODE_ID(); # return floating-point number value

#    RPerl::diag "in PERLOPS_PERLTYPES number__typetest0(), have \$retval = $retval\n" or croak();
    return ($retval);
};
our number $number__typetest1 = sub {
    ( my number $lucky_number ) = @_;

    #    number__CHECK($lucky_number);
    number__CHECKTRACE( $lucky_number, '$lucky_number',
        'number__typetest1()' );

#    RPerl::diag 'in PERLOPS_PERLTYPES number__typetest1(), received $lucky_number = ' . number__to_string($lucky_number) . "\n" or croak();
    return ( ( $lucky_number * 2 ) + main::RPerl__DataType__Number__MODE_ID() );
};

1;
