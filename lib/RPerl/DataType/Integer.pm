# [[[ HEADER ]]]
package RPerl::DataType::Integer;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.014_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::DataType::Scalar);
use RPerl::DataType::Scalar;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ SUB-TYPES ]]]

# an integer is a whole number, it has no floating-pointer (fractional/decimal) component
package    # hide from PAUSE indexing
    integer;
use strict;
use warnings;
use parent qw(RPerl::DataType::Integer);

# method with integer return type
package  # hide from PAUSE indexing
    integer::method;
use strict;
use warnings;
use parent -norequire, qw(method);

package    # hide from PAUSE indexing
    constant_integer;
use strict;
use warnings;
use parent qw(RPerl::DataType::Integer);

# [[[ PRE-DECLARED TYPES ]]]
package    # hide from PAUSE indexing
    boolean;
package    # hide from PAUSE indexing
    unsigned_integer;
package    # hide from PAUSE indexing
    number;
package    # hide from PAUSE indexing
    character;
package    # hide from PAUSE indexing
    string;

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE ]]]
package RPerl::DataType::Integer;
use strict;
use warnings;

# [[[ EXPORTS ]]]
use RPerl::Exporter 'import';
our @EXPORT = qw(integer_CHECK integer_CHECKTRACE integer_to_boolean integer_to_unsigned_integer integer_to_number integer_to_character integer_to_string);
our @EXPORT_OK = qw(integer_typetest0 integer_typetest1);

# [[[ TYPE-CHECKING ]]]
sub integer_CHECK {
    { my void $RETURN_TYPE };
    ( my $possible_integer ) = @ARG;
    if ( not( defined $possible_integer ) ) {
#        croak("\nERROR EIV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger value expected but undefined/null value found,\ncroaking");
        die("\nERROR EIV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger value expected but undefined/null value found,\ndying\n");
    }
    if ( not( main::RPerl_SvIOKp($possible_integer) ) ) {
#        croak("\nERROR EIV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger value expected but non-integer value found,\ncroaking");
        die("\nERROR EIV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger value expected but non-integer value found,\ndying\n");
    }
    return;
}


sub integer_CHECKTRACE {
    { my void $RETURN_TYPE };
    ( my $possible_integer, my $variable_name, my $subroutine_name ) = @ARG;
#    RPerl::diag('in RPerl::DataType::Integer::integer_CHECKTRACE(), received $possible_integer = ' . $possible_integer . "\n");
#    RPerl::diag('in RPerl::DataType::Integer::integer_CHECKTRACE(), received $variable_name = ' . $variable_name . "\n");
#    RPerl::diag('in RPerl::DataType::Integer::integer_CHECKTRACE(), received $subroutine_name = ' . $subroutine_name . "\n");

    if ( not( defined $possible_integer ) ) {
#        RPerl::diag('in RPerl::DataType::Integer::integer_CHECKTRACE(), about to croak due to undefined input' . "\n");
#        croak( "\nERROR EIV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
        die( "\nERROR EIV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ndying\n" );
    }
    if ( not( main::RPerl_SvIOKp($possible_integer) ) ) {
#        RPerl::diag('in RPerl::DataType::Integer::integer_CHECKTRACE(), about to croak due to non-integer input' . "\n");
#        croak( "\nERROR EIV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger value expected but non-integer value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
        die( "\nERROR EIV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger value expected but non-integer value found,\nin variable $variable_name from subroutine $subroutine_name,\ndying\n" );
    }
    return;
}

# [[[ BOOLEANIFY ]]]
sub integer_to_boolean {
    { my boolean $RETURN_TYPE };
    ( my integer $input_integer ) = @ARG;
#    integer_CHECK($input_integer);
    integer_CHECKTRACE( $input_integer, '$input_integer', 'integer_to_boolean()' );
    if   ( $input_integer == 0 ) { return 0; }
    else                         { return 1; }
    return;
}

# [[[ UNSIGNED INTEGERIFY ]]]
sub integer_to_unsigned_integer {
    { my unsigned_integer $RETURN_TYPE };
    ( my integer $input_integer ) = @ARG;
#    integer_CHECK($input_integer);
    integer_CHECKTRACE( $input_integer, '$input_integer', 'integer_to_unsigned_integer()' );
    return abs $input_integer;
}

# [[[ NUMBERIFY ]]]
sub integer_to_number {
    { my number $RETURN_TYPE };
    ( my integer $input_integer ) = @ARG;
#    integer_CHECK($input_integer);
    integer_CHECKTRACE( $input_integer, '$input_integer', 'integer_to_number()' );
    return $input_integer * 1.0;
}

# [[[ CHARACTERIFY ]]]
sub integer_to_character {
    { my character $RETURN_TYPE };
    ( my integer $input_integer ) = @ARG;
#    integer_CHECK($input_integer);
    integer_CHECKTRACE( $input_integer, '$input_integer', 'integer_to_character()' );
    my string $tmp_string = integer_to_string($input_integer);
    if   ( $tmp_string eq q{} ) { return q{}; }
    else                        { return substr $tmp_string, 0, 1; }
    return;
}

# [[[ STRINGIFY ]]]
sub integer_to_string {
    { my string $RETURN_TYPE };
    { my string $RETURN_TYPE };
    ( my integer $input_integer ) = @ARG;
#    integer_CHECK($input_integer);
    integer_CHECKTRACE( $input_integer, '$input_integer', 'integer_to_string()' );

    #    RPerl::diag("in PERLOPS_PERLTYPES integer_to_string(), received \$input_integer = $input_integer\n");
    #    RPerl::diag("in PERLOPS_PERLTYPES integer_to_string()...\n");

    # DEV NOTE: disable old stringify w/out underscores
    #    return "$input_integer";

    my integer $is_negative = 0;
    if ( $input_integer < 0 ) { $is_negative = 1; }
    my string $retval = reverse "$input_integer";
    if ($is_negative) { chop $retval; }    # remove negative sign
    $retval =~ s/(\d{3})/$1_/gxms;
    if ( ( substr $retval, -1, 1 ) eq '_' ) { chop $retval; }
    $retval = reverse $retval;

    if ($is_negative) { $retval = q{-} . $retval; }

    #    RPerl::diag('in PERLOPS_PERLTYPES integer_to_string(), have $retval = ' . q{'} . $retval . q{'} . "\n");
    return $retval;
}

# [[[ TYPE TESTING ]]]
sub integer_typetest0 {
    { my integer $RETURN_TYPE };
    my integer $retval = ( 21 / 7 ) + main::RPerl__DataType__Integer__MODE_ID();    # return integer (not number) value, don't do (22 / 7) etc.

    #    RPerl::diag("in PERLOPS_PERLTYPES integer_typetest0(), have \$retval = $retval\n");
    return ($retval);
}
sub integer_typetest1 {
    { my integer $RETURN_TYPE };
    ( my integer $lucky_integer ) = @ARG;
#    integer_CHECK($lucky_integer);
    integer_CHECKTRACE( $lucky_integer, '$lucky_integer', 'integer_typetest1()' );

    #    RPerl::diag('in PERLOPS_PERLTYPES integer_typetest1(), received $lucky_integer = ' . integer_to_string($lucky_integer) . "\n");
    return ( ( $lucky_integer * 2 ) + main::RPerl__DataType__Integer__MODE_ID() );
}

1;    # end of class
