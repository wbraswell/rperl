# [[[ HEADER ]]]
package RPerl::DataType::Number;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.013_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::DataType::Scalar);
use RPerl::DataType::Scalar;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ SUB-TYPES ]]]
# DEV NOTE, CORRELATION #rp007:
# a number is any numeric value, meaning either an integer or a floating-point number;
# Boolean, Unsigned Integer, and Integer are all sub-classes of Number;
# the hidden Perl semantics are SvIOKp() for ints, and SvNOKp() for numbers;
# these numbers appear to act as C doubles and are implemented as such in RPerl;
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

# [[[ PRE-DECLARED TYPES ]]]
package    # hide from PAUSE indexing
    boolean;
package    # hide from PAUSE indexing
    unsigned_integer;
package     # hide from PAUSE indexing
    integer;
package    # hide from PAUSE indexing
    character;
package    # hide from PAUSE indexing
    string;

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE ]]]
package RPerl::DataType::Number;
use strict;
use warnings;

# [[[ INCLUDES ]]]
use POSIX qw(floor);

# [[[ EXPORTS ]]]
use RPerl::Exporter 'import';
our @EXPORT = qw(number_CHECK number_CHECKTRACE number_to_boolean number_to_unsigned_integer number_to_integer number_to_character number_to_string);
our @EXPORT_OK = qw(number__typetest0 number__typetest1);

# [[[ TYPE-CHECKING ]]]
sub number_CHECK {
    { my void $RETURN_TYPE };
    ( my $possible_number ) = @ARG;
    if ( not( defined $possible_number ) ) {
#        croak( "\nERROR ENV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber value expected but undefined/null value found,\ncroaking" );
        die( "\nERROR ENV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber value expected but undefined/null value found,\ndying\n" );
    }
    if (not(   main::RPerl_SvNOKp($possible_number)
            || main::RPerl_SvIOKp($possible_number) ) )
    {
#        croak( "\nERROR ENV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber value expected but non-number value found,\ncroaking" );
        die( "\nERROR ENV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber value expected but non-number value found,\ndying\n" );
    }
    return;
}
sub number_CHECKTRACE {
    { my void $RETURN_TYPE };
    ( my $possible_number, my $variable_name, my $subroutine_name ) = @ARG;
    if ( not( defined $possible_number ) ) {
#        croak( "\nERROR ENV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
        die( "\nERROR ENV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ndying\n" );
    }
    if (not(   main::RPerl_SvNOKp($possible_number)
            || main::RPerl_SvIOKp($possible_number) )
        )
    {
#        croak( "\nERROR ENV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber value expected but non-number value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
        die( "\nERROR ENV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber value expected but non-number value found,\nin variable $variable_name from subroutine $subroutine_name,\ndying\n" );
    }
    return;
}

# [[[ BOOLEANIFY ]]]
sub number_to_boolean {
    { my boolean $RETURN_TYPE };
    (my number $input_number) = @ARG;
#    number_CHECK($input_number);
    number_CHECKTRACE( $input_number, '$input_number', 'number_to_boolean()' );
    if ($input_number == 0) { return 0; }
    else { return 1; }
    return;
}

# [[[ UNSIGNED INTEGERIFY ]]]
sub number_to_unsigned_integer {
    { my unsigned_integer $RETURN_TYPE };
    (my number $input_number) = @ARG;
#    number_CHECK($input_number);
    number_CHECKTRACE( $input_number, '$input_number', 'number_to_unsigned_integer()' );
    return floor abs $input_number;
}

# [[[ INTEGERIFY ]]]
sub number_to_integer {
    { my integer $RETURN_TYPE };
    (my number $input_number) = @ARG;
#    number_CHECK($input_number);
    number_CHECKTRACE( $input_number, '$input_number', 'number_to_integer()' );
    return floor $input_number;
}

# [[[ CHARACTERIFY ]]]
sub number_to_character {
    { my character $RETURN_TYPE };
    (my number $input_number) = @ARG;
#    number_CHECK($input_number);
    number_CHECKTRACE( $input_number, '$input_number', 'number_to_character()' );
    my string $tmp_string = number_to_string($input_number);
    if ($tmp_string eq q{}) { return q{}; }
    else { return substr $tmp_string, 0, 1; }
}

# [[[ STRINGIFY ]]]
sub number_to_string {
    { my string $RETURN_TYPE };
    { my string $RETURN_TYPE };
    ( my number $input_number ) = @ARG;
#    number_CHECK($input_number);
    number_CHECKTRACE( $input_number, '$input_number', 'number_to_string()' );

#    RPerl::diag("in PERLOPS_PERLTYPES number_to_string(), received \$input_number = $input_number\n");
#    RPerl::diag("in PERLOPS_PERLTYPES number_to_string()...\n");
#    die 'TMP DEBUG';

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
#        if ((substr $split_parts->[1], 0, 1) eq '_') { chop $split_parts->[1]; }  # should not be necessary
        $retval .= '.' . $split_parts->[1];
    }

    if ($is_negative) { $retval = q{-} . $retval; }

#    RPerl::diag('in PERLOPS_PERLTYPES number_to_string(), have $retval = ' . q{'} . $retval . q{'} . "\n");
    return $retval;
}

# [[[ TYPE TESTING ]]]
sub number__typetest0 {
    { my number $RETURN_TYPE };
    my number $retval
        = ( 22 / 7 ) + main::RPerl__DataType__Number__MODE_ID(); # return floating-point number value

#    RPerl::diag("in PERLOPS_PERLTYPES number__typetest0(), have \$retval = $retval\n");
    return ($retval);
}
sub number__typetest1 {
    { my number $RETURN_TYPE };
    ( my number $lucky_number ) = @ARG;
#    number_CHECK($lucky_number);
    number_CHECKTRACE( $lucky_number, '$lucky_number',
        'number__typetest1()' );

#    RPerl::diag('in PERLOPS_PERLTYPES number__typetest1(), received $lucky_number = ' . number_to_string($lucky_number) . "\n");
    return ( ( $lucky_number * 2 ) + main::RPerl__DataType__Number__MODE_ID() );
}

1;  # end of class
