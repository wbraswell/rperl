## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted sigils
## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
## no critic qw(ProhibitMultiplePackages)  ## RPERL SYSTEM types, allow multiple packages
## no critic qw(Capitalization)  ## RPERL SYSTEM types, allow lowercase packages
package RPerl::DataType::Integer;
use strict;
use warnings;
use version; our $VERSION = 0.003002;
use Carp;

# [[[ SUB-TYPES BEFORE SETUP ]]]
# an integer is a whole number, it has no floating-pointeger (fractional/decimal) component
package integer;
use parent ('RPerl::DataType::Integer');

# integer with const value
package const_integer;
use parent -norequire, qw(integer const);

# ref to integer
package integer_ref;
use parent -norequire, ('ref');

# ref to (integer with const value)
package const_integer_ref;
use parent -norequire, ('ref');

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE ]]]
package RPerl::DataType::Integer;

# [[[ SETUP ]]]
use parent ('RPerl::DataType::Number');
use RPerl::DataType::Number;

# [[[ TYPE-CHECKING ]]]
our void $integer__CHECK = sub {
    ( my $possible_integer ) = @_;
    if ( not( defined $possible_integer ) ) {
        croak(
            "\nERROR EIV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger value expected but undefined/null value found,\ncroaking"
        );
    }
    if ( not( main::RPerl_SvIOKp($possible_integer) ) ) {
        croak(
            "\nERROR EIV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger value expected but non-integer value found,\ncroaking"
        );
    }
};
our void $integer__CHECKTRACE = sub {
    ( my $possible_integer, my $variable_name, my $subroutine_name ) = @_;
    if ( not( defined $possible_integer ) ) {
        croak(
            "\nERROR EIV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }
    if ( not( main::RPerl_SvIOKp($possible_integer) ) ) {
        croak(
            "\nERROR EIV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger value expected but non-integer value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }
};

# [[[ OPERATIONS & DATA TYPES REPORTING ]]]
our integer $integer__OPS_TYPES_ID = 0;    # PERLOPS_PERLTYPES is 0
our string $integer__ops = sub { return ('PERL'); };
our string $integer__types = sub { return ('PERL'); };

# [[[ STRINGIFY ]]]
our string $integer__stringify = sub {
    ( my $input_integer ) = @_;

    #    integer__CHECK($input_integer);
    integer__CHECKTRACE( $input_integer, '$input_integer',
        'integer__stringify()' );
    print
        "in PERLOPS_PERLTYPES integer__stringify(), bottom of subroutine, received \$input_integer = $input_integer\n"
        or croak();
    return ("$input_integer");
};

# [[[ TYPE TESTING ]]]
our integer $integer__typetest0 = sub {
    my integer $retval = ( 21 / 7 ) + $integer__OPS_TYPES_ID; # return integer (not number) value, don't do (22 / 7) etc.
    print
        "in PERLOPS_PERLTYPES integer__typetest0(), have \$retval = $retval\n"
        or croak();
    return ($retval);
};
our integer $integer__typetest1 = sub {
    ( my integer $lucky_integer ) = @_;

    #    integer__CHECK($lucky_integer);
    integer__CHECKTRACE( $lucky_integer, '$lucky_integer',
        'integer__typetest1()' );
    print
        'in PERLOPS_PERLTYPES integer__typetest1(), received $lucky_integer = '
        . integer__stringify($lucky_integer) . "\n"
        or croak();
    return ( ( $lucky_integer * 2 ) + $integer__OPS_TYPES_ID );
};

1;
