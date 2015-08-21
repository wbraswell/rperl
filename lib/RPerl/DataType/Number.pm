# [[[ HEADER ]]]
package RPerl::DataType::Number;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.005_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::DataType::Scalar);
use RPerl::DataType::Scalar;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ SUB-TYPES ]]]
# DEV NOTE, CORRELATION #rp07:
# a number is any numeric value, meaning either an integer or a floating-point number;
# Integer and Float are both sub-classes of Number;
# the hidden Perl semantics are SvIOKp() for ints, and SvNOKp() for numbers;
# these numbers appear to act as C doubles and are implemented as such in RPerl;
# there is no SvFOKp() for floats, so float currently inherits everything from number,
# and we generate C doubles instead of C floats;
# in the future, this can be optimized (for at least memory usage) by implementing full Float semantics
package  # hide from PAUSE indexing
    number;
use strict;
use warnings;
use parent qw(RPerl::DataType::Number);

package  # hide from PAUSE indexing
    constant_number;
use strict;
use warnings;
use parent qw(RPerl::DataType::Number);

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE ]]]
package RPerl::DataType::Number;
use strict;
use warnings;

# [[[ INCLUDES ]]]
use RPerl::DataType::String;    # need string type
use RPerl::DataType::Integer; # need integer type, normally included by rperltypes.pm but put here in case we don't use rperltypes.pm

# [[[ TYPE-CHECKING ]]]
our void $number_CHECK = sub {
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
our void $number_CHECKTRACE = sub {
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

# [[[ STRINGIFY ]]]
our string $number_to_string = sub {
    ( my $input_number ) = @_;

    #    number_CHECK($input_number);
    number_CHECKTRACE( $input_number, '$input_number', 'number_to_string()' );

#    RPerl::diag("in PERLOPS_PERLTYPES number_to_string(), received \$input_number = $input_number\n");
#    RPerl::diag("in PERLOPS_PERLTYPES number_to_string()...\n");

    # DEV NOTE: disable old stringify w/out underscores
#    return "$input_number";

    # NEED FIX: if using RPerl data types here, causes errors for `perl -e 'use RPerl::DataType::Integer;'`
    my integer $is_negative = 0;
#    my $is_negative = 0;
    if ($input_number < 0) { $is_negative = 1; }
    my string $retval;
#    my $retval;
    my $split_parts = [ split /[.]/xms, "$input_number" ];   # string_arrayref

    if ( exists $split_parts->[0] ) {
        $retval = reverse $split_parts->[0];
        if ($is_negative) { chop $retval; }  # remove negative sign
        $retval =~ s/(\d{3})/$1_/gxms;
        if ((substr $retval, -1, 1) eq '_') { chop $retval; }
        $retval = reverse $retval;
    }
    else {
        $retval = '0';
    }

    if ( exists $split_parts->[1] ) {
        $split_parts->[1] =~ s/(\d{3})/$1_/gxms;
        if ((substr $split_parts->[1], -1, 1) eq '_') { chop $split_parts->[1]; }
        $retval .= '.' . $split_parts->[1];
    }

    if ($is_negative) { $retval = q{-} . $retval; }

#    RPerl::diag('in PERLOPS_PERLTYPES number_to_string(), have $retval = ' . q{'} . $retval . q{'} . "\n");
    return $retval;
};

# [[[ TYPE TESTING ]]]
our number $number__typetest0 = sub {
    my number $retval
        = ( 22 / 7 ) + main::RPerl__DataType__Number__MODE_ID(); # return floating-point number value

#    RPerl::diag("in PERLOPS_PERLTYPES number__typetest0(), have \$retval = $retval\n");
    return ($retval);
};
our number $number__typetest1 = sub {
    ( my number $lucky_number ) = @_;

    #    number_CHECK($lucky_number);
    number_CHECKTRACE( $lucky_number, '$lucky_number',
        'number__typetest1()' );

#    RPerl::diag('in PERLOPS_PERLTYPES number__typetest1(), received $lucky_number = ' . number_to_string($lucky_number) . "\n");
    return (
        ( $lucky_number * 2 ) + main::RPerl__DataType__Number__MODE_ID() );
};

1;  # end of class
