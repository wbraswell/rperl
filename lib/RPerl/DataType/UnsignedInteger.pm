# [[[ HEADER ]]]
package RPerl::DataType::UnsignedInteger;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.003_100;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::DataType::Scalar);
use RPerl::DataType::Scalar;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ SUB-TYPES ]]]
# an unsigned_integer is a whole number greater or equal to zero, it has no floating-pointer (fractional/decimal) component or negative value
package    # hide from PAUSE indexing
    unsigned_integer;
use strict;
use warnings;
use parent qw(RPerl::DataType::UnsignedInteger);

package    # hide from PAUSE indexing
    constant_unsigned_integer;
use strict;
use warnings;
use parent qw(RPerl::DataType::UnsignedInteger);

# [[[ PRE-DECLARED TYPES ]]]
package    # hide from PAUSE indexing
    boolean;
package     # hide from PAUSE indexing
    integer;
package    # hide from PAUSE indexing
    number;
package    # hide from PAUSE indexing
    character;
package    # hide from PAUSE indexing
    string;

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE ]]]
package RPerl::DataType::UnsignedInteger;
use strict;
use warnings;

# [[[ EXPORTS ]]]
use Exporter 'import';
our @EXPORT = qw(unsigned_integer_to_boolean unsigned_integer_to_integer unsigned_integer_to_number unsigned_integer_to_character unsigned_integer_to_string);

# [[[ TYPE-CHECKING ]]]
#our void $unsigned_integer_CHECK = sub {
sub unsigned_integer_CHECK {
    ( my $possible_unsigned_integer ) = @_;
    if ( not( defined $possible_unsigned_integer ) ) {
        croak("\nERROR EIV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nunsigned_integer value expected but undefined/null value found,\ncroaking");
    }
    if ( not( main::RPerl_SvUIOKp($possible_unsigned_integer) ) ) {
        croak("\nERROR EIV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nunsigned_integer value expected but non-unsigned_integer value found,\ncroaking");
    }
}
#our void $unsigned_integer_CHECKTRACE = sub {
sub unsigned_integer_CHECKTRACE {
    ( my $possible_unsigned_integer, my $variable_name, my $subroutine_name ) = @_;
    if ( not( defined $possible_unsigned_integer ) ) {
        croak(
            "\nERROR EIV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nunsigned_integer value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }
    if ( not( main::RPerl_SvUIOKp($possible_unsigned_integer) ) ) {
        croak(
            "\nERROR EIV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nunsigned_integer value expected but non-unsigned_integer value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }
}

# [[[ BOOLEANIFY ]]]
#our boolean $unsigned_integer_to_boolean = sub {
sub unsigned_integer_to_boolean {
    ( my unsigned_integer $input_unsigned_integer ) = @_;
#    unsigned_integer_CHECK($input_unsigned_integer);
    unsigned_integer_CHECKTRACE( $input_unsigned_integer, '$input_unsigned_integer', 'unsigned_integer_to_boolean()' );
    if   ( $input_unsigned_integer == 0 ) { return 0; }
    else                                  { return 1; }
}

# [[[ INTEGERIFY ]]]
#our integer $unsigned_integer_to_integer = sub {
sub unsigned_integer_to_integer {
    ( my unsigned_integer $input_unsigned_integer ) = @_;
#    unsigned_integer_CHECK($input_unsigned_integer);
    unsigned_integer_CHECKTRACE( $input_unsigned_integer, '$input_unsigned_integer', 'unsigned_integer_to_integer()' );
    return $input_unsigned_integer;
}

# [[[ NUMBERIFY ]]]
#our number $unsigned_integer_to_number = sub {
sub unsigned_integer_to_number {
    ( my unsigned_integer $input_unsigned_integer ) = @_;
#    unsigned_integer_CHECK($input_unsigned_integer);
    unsigned_integer_CHECKTRACE( $input_unsigned_integer, '$input_unsigned_integer', 'unsigned_integer_to_number()' );
    return $input_unsigned_integer * 1.0;
}

# [[[ CHARACTERIFY ]]]
#our character $unsigned_integer_to_character = sub {
sub unsigned_integer_to_character {
    ( my unsigned_integer $input_unsigned_integer ) = @_;
#    unsigned_integer_CHECK($input_unsigned_integer);
    unsigned_integer_CHECKTRACE( $input_unsigned_integer, '$input_unsigned_integer', 'unsigned_integer_to_character()' );
    my string $tmp_string = unsigned_integer_to_string($input_unsigned_integer);
    if   ( $tmp_string eq q{} ) { return q{}; }
    else                        { return substr $tmp_string, 0, 1; }
}

# [[[ STRINGIFY ]]]
#our string $unsigned_integer_to_string = sub {
sub unsigned_integer_to_string {
    ( my unsigned_integer $input_unsigned_integer ) = @_;
#    unsigned_integer_CHECK($input_unsigned_integer);
    unsigned_integer_CHECKTRACE( $input_unsigned_integer, '$input_unsigned_integer', 'unsigned_integer_to_string()' );

    #    RPerl::diag("in PERLOPS_PERLTYPES unsigned_integer_to_string(), received \$input_unsigned_integer = $input_unsigned_integer\n");
    #    RPerl::diag("in PERLOPS_PERLTYPES unsigned_integer_to_string()...\n");

    # DEV NOTE: disable old stringify w/out underscores
    #    return "$input_unsigned_integer";

    my string $retval = reverse "$input_unsigned_integer";
    $retval =~ s/(\d{3})/$1_/gxms;
    if ( ( substr $retval, -1, 1 ) eq '_' ) { chop $retval; }
    $retval = reverse $retval;

    #    RPerl::diag('in PERLOPS_PERLTYPES unsigned_integer_to_string(), have $retval = ' . q{'} . $retval . q{'} . "\n");
    return $retval;
}

# [[[ TYPE TESTING ]]]
#our unsigned_integer $unsigned_integer__typetest0 = sub {
sub unsigned_integer__typetest0 {
    my unsigned_integer $retval = ( 21 / 7 ) + main::RPerl__DataType__UnsignedInteger__MODE_ID(); # return unsigned_integer (not number) value, don't do (22 / 7) etc.

    #    RPerl::diag("in PERLOPS_PERLTYPES unsigned_integer__typetest0(), have \$retval = $retval\n");
    return ($retval);
}

#our unsigned_integer $unsigned_integer__typetest1 = sub {
sub unsigned_integer__typetest1 {
    ( my unsigned_integer $lucky_unsigned_integer ) = @_;
#    unsigned_integer_CHECK($lucky_unsigned_integer);
    unsigned_integer_CHECKTRACE( $lucky_unsigned_integer, '$lucky_unsigned_integer', 'unsigned_integer__typetest1()' );

#    RPerl::diag('in PERLOPS_PERLTYPES unsigned_integer__typetest1(), received $lucky_unsigned_integer = ' . unsigned_integer_to_string($lucky_unsigned_integer) . "\n");
    return ( ( $lucky_unsigned_integer * 2 ) + main::RPerl__DataType__UnsignedInteger__MODE_ID() );
}

1;    # end of class
