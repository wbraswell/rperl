# [[[ HEADER ]]]
package RPerl::DataType::UnsignedInteger;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.006_000;

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
use RPerl::Exporter 'import';
our @EXPORT = qw(unsigned_integer_CHECK unsigned_integer_CHECKTRACE unsigned_integer_to_boolean unsigned_integer_to_integer unsigned_integer_to_number unsigned_integer_to_character unsigned_integer_to_string);

# [[[ TYPE-CHECKING ]]]
sub unsigned_integer_CHECK {
    { my void $RETURN_TYPE };
    ( my $possible_unsigned_integer ) = @ARG;
    if ( not( defined $possible_unsigned_integer ) ) {
#        croak("\nERROR EIV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nunsigned_integer value expected but undefined/null value found,\ncroaking");
        die("\nERROR EIV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nunsigned_integer value expected but undefined/null value found,\ndying\n");
    }
    if ( not( main::RPerl_SvUIOKp($possible_unsigned_integer) ) ) {
#        croak("\nERROR EIV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nunsigned_integer value expected but non-unsigned_integer value found,\ncroaking");
        dying("\nERROR EIV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nunsigned_integer value expected but non-unsigned_integer value found,\ndying\n");
    }
    return;
}
sub unsigned_integer_CHECKTRACE {
    { my void $RETURN_TYPE };
    ( my $possible_unsigned_integer, my $variable_name, my $subroutine_name ) = @ARG;
    if ( not( defined $possible_unsigned_integer ) ) {
#        croak( "\nERROR EIV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nunsigned_integer value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
        dying( "\nERROR EIV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nunsigned_integer value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ndying\n" );
    }
    if ( not( main::RPerl_SvUIOKp($possible_unsigned_integer) ) ) {
#        croak( "\nERROR EIV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nunsigned_integer value expected but non-unsigned_integer value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
        dying( "\nERROR EIV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nunsigned_integer value expected but non-unsigned_integer value found,\nin variable $variable_name from subroutine $subroutine_name,\ndying\n" );
    }
    return;
}

# [[[ BOOLEANIFY ]]]
sub unsigned_integer_to_boolean {
    { my boolean $RETURN_TYPE };
    ( my unsigned_integer $input_unsigned_integer ) = @ARG;
#    unsigned_integer_CHECK($input_unsigned_integer);
    unsigned_integer_CHECKTRACE( $input_unsigned_integer, '$input_unsigned_integer', 'unsigned_integer_to_boolean()' );
    if   ( $input_unsigned_integer == 0 ) { return 0; }
    else                                  { return 1; }
    return;
}

# [[[ INTEGERIFY ]]]
sub unsigned_integer_to_integer {
    { my integer $RETURN_TYPE };
    ( my unsigned_integer $input_unsigned_integer ) = @ARG;
#    unsigned_integer_CHECK($input_unsigned_integer);
    unsigned_integer_CHECKTRACE( $input_unsigned_integer, '$input_unsigned_integer', 'unsigned_integer_to_integer()' );
    return $input_unsigned_integer;
}

# [[[ NUMBERIFY ]]]
sub unsigned_integer_to_number {
    { my number $RETURN_TYPE };
    ( my unsigned_integer $input_unsigned_integer ) = @ARG;
#    unsigned_integer_CHECK($input_unsigned_integer);
    unsigned_integer_CHECKTRACE( $input_unsigned_integer, '$input_unsigned_integer', 'unsigned_integer_to_number()' );
    return $input_unsigned_integer * 1.0;
}

# [[[ CHARACTERIFY ]]]
sub unsigned_integer_to_character {
    { my character $RETURN_TYPE };
    ( my unsigned_integer $input_unsigned_integer ) = @ARG;
#    unsigned_integer_CHECK($input_unsigned_integer);
    unsigned_integer_CHECKTRACE( $input_unsigned_integer, '$input_unsigned_integer', 'unsigned_integer_to_character()' );
    my string $tmp_string = unsigned_integer_to_string($input_unsigned_integer);
    if   ( $tmp_string eq q{} ) { return q{}; }
    else                        { return substr $tmp_string, 0, 1; }
    return;
}

# [[[ STRINGIFY ]]]
sub unsigned_integer_to_string {
    { my string $RETURN_TYPE };
    ( my unsigned_integer $input_unsigned_integer ) = @ARG;
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
sub unsigned_integer__typetest0 {
    { my unsigned_integer $RETURN_TYPE };
    my unsigned_integer $retval = ( 21 / 7 ) + main::RPerl__DataType__UnsignedInteger__MODE_ID(); # return unsigned_integer (not number) value, don't do (22 / 7) etc.

    #    RPerl::diag("in PERLOPS_PERLTYPES unsigned_integer__typetest0(), have \$retval = $retval\n");
    return ($retval);
}

sub unsigned_integer__typetest1 {
    { my unsigned_integer $RETURN_TYPE };
    ( my unsigned_integer $lucky_unsigned_integer ) = @ARG;
#    unsigned_integer_CHECK($lucky_unsigned_integer);
    unsigned_integer_CHECKTRACE( $lucky_unsigned_integer, '$lucky_unsigned_integer', 'unsigned_integer__typetest1()' );

#    RPerl::diag('in PERLOPS_PERLTYPES unsigned_integer__typetest1(), received $lucky_unsigned_integer = ' . unsigned_integer_to_string($lucky_unsigned_integer) . "\n");
    return ( ( $lucky_unsigned_integer * 2 ) + main::RPerl__DataType__UnsignedInteger__MODE_ID() );
}

1;    # end of class
