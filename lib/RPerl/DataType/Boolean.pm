# [[[ HEADER ]]]
package RPerl::DataType::Boolean;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_001;

# [[[ OO INHERITANCE ]]]
use parent ('RPerl::DataType::Scalar');
use RPerl::DataType::Scalar;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ SUB-TYPES ]]]
# a bool is a binary boolean value, the only valid values are 0 (false) or 1 (true)
package bool;
use parent ('RPerl::DataType::Boolean');

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE ]]]
package RPerl::DataType::Boolean;

# [[[ INCLUDES ]]]
use RPerl::DataType::String;    # need string type

# NEED UPGRADE: using SvIOKp() integer type check for boolean type check, need implement SvBOKp() and full bool semantics

# [[[ TYPE-CHECKING ]]]
our void $bool_CHECK = sub {
    ( my $possible_bool ) = @_;
    if ( not( defined $possible_bool ) ) {
        croak(
            "\nERROR EIV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nbool value expected but undefined/null value found,\ncroaking"
        );
    }
    if ( not( main::RPerl_SvIOKp($possible_bool) ) ) {
        croak(
            "\nERROR EIV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nbool value expected but non-bool value found,\ncroaking"
        );
    }
};
our void $bool_CHECKTRACE = sub {
    ( my $possible_bool, my $variable_name, my $subroutine_name ) = @_;
    if ( not( defined $possible_bool ) ) {
        croak(
            "\nERROR EIV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nbool value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }
    if ( not( main::RPerl_SvIOKp($possible_bool) ) ) {
        croak(
            "\nERROR EIV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nbool value expected but non-bool value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }
};

# [[[ STRINGIFY ]]]
our string $bool_to_string = sub {
    ( my $input_bool ) = @_;

    #    bool_CHECK($input_bool);
    bool_CHECKTRACE( $input_bool, '$input_bool',
        'bool_to_string()' );

#    RPerl::diag("in PERLOPS_PERLTYPES bool_to_string(), received \$input_bool = $input_bool\n");
#    RPerl::diag("in PERLOPS_PERLTYPES bool_to_string()...\n");

    # DEV NOTE: disable old stringify w/out underscores
    #    return "$input_bool";

    my bool $is_negative = 0;
    if ( $input_bool < 0 ) { $is_negative = 1; }
    my string $retval = reverse "$input_bool";
    if ($is_negative) { chop $retval; }    # remove negative sign
    $retval =~ s/(\d{3})/$1_/gxms;
    if ( ( substr $retval, -1, 1 ) eq '_' ) { chop $retval; }
    $retval = reverse $retval;

    if ($is_negative) { $retval = q{-} . $retval; }

#    RPerl::diag('in PERLOPS_PERLTYPES bool_to_string(), have $retval = ' . q{'} . $retval . q{'} . "\n");
    return $retval;
};

# [[[ TYPE TESTING ]]]
our bool $bool__typetest0 = sub {
    my bool $retval
        = ( 21 / 7 ) + main::RPerl__DataType__Boolean__MODE_ID(); # return bool (not number) value, don't do (22 / 7) etc.

#    RPerl::diag("in PERLOPS_PERLTYPES bool__typetest0(), have \$retval = $retval\n");
    return ($retval);
};
our bool $bool__typetest1 = sub {
    ( my bool $lucky_bool ) = @_;

    #    bool_CHECK($lucky_bool);
    bool_CHECKTRACE( $lucky_bool, '$lucky_bool',
        'bool__typetest1()' );

#    RPerl::diag('in PERLOPS_PERLTYPES bool__typetest1(), received $lucky_bool = ' . bool_to_string($lucky_bool) . "\n");
    return (
        ( $lucky_bool * 2 ) + main::RPerl__DataType__Boolean__MODE_ID() );
};

1;
