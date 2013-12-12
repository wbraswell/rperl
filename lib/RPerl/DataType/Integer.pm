## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted sigils
## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
## no critic qw(ProhibitMultiplePackages)  ## RPERL SYSTEM types, allow multiple packages
## no critic qw(Capitalization)  ## RPERL SYSTEM types, allow lowercase packages
package RPerl::DataType::Integer;
use strict;
use warnings;
use version; our $VERSION = qv('0.2.2');
use Carp;
use base ('RPerl::DataType::Number');
use RPerl::DataType::Number;

# an integer is a whole number, it has no floating-pointeger (fractional/decimal) component
package integer;
use base ('RPerl::DataType::Integer');

# integer with const value
package const_integer;
use base qw(integer const);

# ref to integer
package integer_ref;
use base ('ref');

# ref to (integer with const value)
package const_integer_ref;
use base ('ref');

# [[[ SWITCH CONTEXT BACK TO MAIN PACKAGE ]]]
package RPerl::DataType::Integer;

# [[[ OPERATIONS & DATA TYPES REPORTING ]]]
our integer $OPS_TYPES_ID = 0;                        # PERLOPS_PERLTYPES is 0
our string $ops_integer   = sub { return ('PERL'); };
our string $types_integer = sub { return ('PERL'); };

# [[[ TYPE-CHECKING ]]]
our void $check_integer = sub {
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
our void $check_integer_trace = sub {
    ( my $possible_integer, my $variable_name, my $subroutine_name ) = @_;
    if ( not( defined $possible_integer ) ) {
        croak(
            "\nERROR EIV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger value expected but undefined/null value found,\nin variable '$variable_name' from subroutine '$subroutine_name',\ncroaking"
        );
    }
    if ( not( main::RPerl_SvIOKp($possible_integer) ) ) {
        croak(
            "\nERROR EIV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger value expected but non-integer value found,\nin variable '$variable_name' from subroutine '$subroutine_name',\ncroaking"
        );
    }
};

# [[[ STRINGIFY ]]]
our string $stringify_integer = sub {
    ( my $input_integer ) = @_;

    #    check_integer($input_integer);
    check_integer_trace( $input_integer, '$input_integer',
        'stringify_integer()' );
    print
        "in PERLOPS_PERLTYPES Integer::stringify_integer(), bottom of subroutine, received \$input_integer = $input_integer\n"
        or croak();
    return ("$input_integer");
};

# [[[ TYPE TESTING ]]]
our integer $typetest___void__in___integer__out = sub {
    my integer $retval = ( 21 / 7 ) + $OPS_TYPES_ID; # return integer (not number) value, don't do (22 / 7) etc.
    print
        "in PERLOPS_PERLTYPES Integer::typetest___void__in___integer__out(), have \$retval = $retval\n"
        or croak();
    return ($retval);
};
our integer $typetest___integer__in___integer__out = sub {
    ( my integer $lucky_integer ) = @_;

    #    check_integer($lucky_integer);
    check_integer_trace( $lucky_integer, '$lucky_integer',
        'typetest___integer__in___integer__out()' );
    print
        'in PERLOPS_PERLTYPES Integer::typetest___integer__in___integer__out(), received $lucky_integer = '
        . stringify_integer($lucky_integer) . "\n"
        or croak();
    return ( ( $lucky_integer * 2 ) + $OPS_TYPES_ID );
};

1;
