# [[[ HEADER ]]]
package RPerl::DataType::GMPInteger;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(Math::BigInt RPerl::DataType::Scalar);  # DEV NOTE: multiple inheritance!
use Math::BigInt lib => 'GMP';  # we still actually use GMP in PERLOPS_PERLTYPES mode, albeit indirectly via Math::BigInt::GMP
use RPerl::DataType::Scalar;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ SUB-TYPES ]]]
# a gmp_integer is multi-precision integer using the GMP library
package  # hide from PAUSE indexing
    gmp_integer;
use strict;
use warnings;
use parent qw(RPerl::DataType::GMPInteger);

# [[[ PRE-DECLARED TYPES ]]]
package    # hide from PAUSE indexing
    bool;
package    # hide from PAUSE indexing
    unsigned_integer;
package    # hide from PAUSE indexing
    integer;
package    # hide from PAUSE indexing
    number;
package    # hide from PAUSE indexing
    char;
package    # hide from PAUSE indexing
    string;

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE ]]]
package RPerl::DataType::GMPInteger;
use strict;
use warnings;

# [[[ EXPORTS ]]]
use Exporter 'import';
our @EXPORT = qw(
    gmp_integer_to_bool gmp_integer_to_unsigned_integer gmp_integer_to_integer gmp_integer_to_number gmp_integer_to_char gmp_integer_to_string
    bool_to_gmp_integer integer_to_gmp_integer unsigned_integer_to_gmp_integer number_to_gmp_integer char_to_gmp_integer string_to_gmp_integer
);

# [[[ TYPE-CHECKING ]]]
our void $gmp_integer_CHECK = sub {
    ( my $possible_gmp_integer ) = @_;
    RPerl::diag("in PERLOPS_PERLTYPES gmp_integer(), top of subroutine\n");
    if (not(defined $possible_gmp_integer)) { croak( "\nERROR EGIV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ngmp_integer external wrapper value expected but undefined/null value found,\ncroaking" ); }
    if (not(RPerl_SvHROKp($possible_gmp_integer))) { croak( "\nERROR EGIV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ngmp_integer external wrapper value expected but non-hashref value found,\ncroaking" ); }
    my string $classname = class($possible_gmp_integer);
    if (not defined $classname) { croak( "\nERROR EGIV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ngmp_integer external wrapper value expected but non-object (blessed hashref) value found,\ncroaking" ); }
    if (not(UNIVERSAL::isa($possible_gmp_integer, 'Math::BigInt'))) { croak( "\nERROR EGIV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ngmp_integer external wrapper value expected but non-Math::BigInt-derived object value found,\ncroaking" ); }
#    if ($classname ne 'gmp_integer') { croak( "\nERROR EGIV04, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ngmp_integer external wrapper value expected but non-gmp_integer object value found,\ncroaking" ); }
    if (not exists $possible_gmp_integer->{value}) { croak( "\nERROR EGIV05, MISSING HASH ENTRY, PERLOPS_PERLTYPES:\ngmp_integer internal wrapped object in hash entry expected at key 'value' but no hash entry exists,\ncroaking" ); }
    if (not defined $possible_gmp_integer->{value}) { croak( "\nERROR EGIV06, MISSING HASH ENTRY, PERLOPS_PERLTYPES:\ngmp_integer internal wrapped object in hash entry expected at key 'value' but no hash entry defined;\nOR\nERROR EGIV07, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ngmp_integer internal wrapped value expected but undefined/null value found,\ncroaking" ); }
    if (not defined class($possible_gmp_integer->{value})) { croak( "\nERROR EGIV08, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ngmp_integer internal wrapped value expected but non-object (blessed hashref) value found,\ncroaking" ); }
    if (not(UNIVERSAL::isa($possible_gmp_integer->{value}, 'Math::BigInt::GMP'))) { croak( "\nERROR EGIV09, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ngmp_integer internal wrapped value expected but non-Math::BigInt::GMP object value found,\ncroaking" ); }
    RPerl::diag("in PERLOPS_PERLTYPES gmp_integer(), bottom of subroutine\n");
};

our void $gmp_integer_CHECKTRACE = sub {
    ( my $possible_gmp_integer, my $variable_name, my $subroutine_name ) = @_;
    RPerl::diag("in PERLOPS_PERLTYPES gmp_integer_CHECKTRACE(), top of subroutine\n");
    if (not(defined $possible_gmp_integer)) { croak( "\nERROR EGIV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ngmp_integer external wrapper value expected but undefined/null value found,\nin variable " . $variable_name . " from subroutine " . $subroutine_name . ",\ncroaking" ); }
    if (not(RPerl_SvHROKp($possible_gmp_integer))) { croak( "\nERROR EGIV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ngmp_integer external wrapper value expected but non-hashref value found,\nin variable " . $variable_name . " from subroutine " . $subroutine_name . ",\ncroaking" ); }
    my string $classname = class($possible_gmp_integer);
    if (not defined $classname) { croak( "\nERROR EGIV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ngmp_integer external wrapper value expected but non-object (blessed hashref) value found,\nin variable " . $variable_name . " from subroutine " . $subroutine_name . ",\ncroaking" ); }
    if (not(UNIVERSAL::isa($possible_gmp_integer, 'Math::BigInt'))) { croak( "\nERROR EGIV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ngmp_integer external wrapper value expected but non-Math::BigInt-derived object value found,\nin variable " . $variable_name . " from subroutine " . $subroutine_name . ",\ncroaking" ); }
#    if ($classname ne 'gmp_integer') { croak( "\nERROR EGIV04, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ngmp_integer external wrapper value expected but non-gmp_integer object value found,\nin variable " . $variable_name . " from subroutine " . $subroutine_name . ",\ncroaking" ); }
    if (not exists $possible_gmp_integer->{value}) { croak( "\nERROR EGIV05, MISSING HASH ENTRY, PERLOPS_PERLTYPES:\ngmp_integer internal wrapped object in hash entry expected at key 'value' but no hash entry exists,\nin variable " . $variable_name . " from subroutine " . $subroutine_name . ",\ncroaking" ); }
    if (not defined $possible_gmp_integer->{value}) { croak( "\nERROR EGIV06, MISSING HASH ENTRY, PERLOPS_PERLTYPES:\ngmp_integer internal wrapped object in hash entry expected at key 'value' but no hash entry defined;\nOR\nERROR EGIV07, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ngmp_integer internal wrapped value expected but undefined/null value found,\nin variable " . $variable_name . " from subroutine " . $subroutine_name . ",\ncroaking" ); }
    if (not defined class($possible_gmp_integer->{value})) { croak( "\nERROR EGIV08, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ngmp_integer internal wrapped value expected but non-object (blessed hashref) value found,\nin variable " . $variable_name . " from subroutine " . $subroutine_name . ",\ncroaking" ); }
    if (not(UNIVERSAL::isa($possible_gmp_integer->{value}, 'Math::BigInt::GMP'))) { croak( "\nERROR EGIV09, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ngmp_integer internal wrapped value expected but non-Math::BigInt::GMP object value found,\nin variable " . $variable_name . " from subroutine " . $subroutine_name . ",\ncroaking" ); }
    RPerl::diag("in PERLOPS_PERLTYPES gmp_integer_CHECKTRACE(), bottom of subroutine\n");
};

# [[[ BOOLIFY ]]]
#our bool $gmp_integer_to_bool = sub {
sub gmp_integer_to_bool {
    ( my gmp_integer $input_gmp_integer ) = @_;
    if   ( $input_gmp_integer->is_zero() ) { return 0; }
    else                         { return 1; }
}

# [[[ UNSIGNED INTEGERIFY ]]]
#our unsigned_integer $gmp_integer_to_unsigned_integer = sub {
sub gmp_integer_to_unsigned_integer {
    ( my gmp_integer $input_gmp_integer ) = @_;
    return abs $input_gmp_integer->numify();
}

# [[[ INTEGERIFY ]]]
#our integer $gmp_integer_to_integer = sub {
sub gmp_integer_to_integer {
    ( my gmp_integer $input_gmp_integer ) = @_;
    return $input_gmp_integer->numify();
}

# [[[ NUMBERIFY ]]]
#our number $gmp_integer_to_number = sub {
sub gmp_integer_to_number {
    ( my gmp_integer $input_gmp_integer ) = @_;
    return $input_gmp_integer->numify() * 1.0;
}

# [[[ CHARIFY ]]]
#our char $gmp_integer_to_char = sub {
sub gmp_integer_to_char {
    ( my gmp_integer $input_gmp_integer ) = @_;
    my string $tmp_string = gmp_integer_to_string($input_gmp_integer);
    if   ( $tmp_string eq q{} ) { return q{}; }
    else                        { return substr $tmp_string, 0, 1; }
}

# [[[ STRINGIFY ]]]
#our string $gmp_integer_to_string = sub {
sub gmp_integer_to_string {
    ( my gmp_integer $input_gmp_integer ) = @_;

    #    gmp_integer_CHECK($input_gmp_integer);
    gmp_integer_CHECKTRACE( $input_gmp_integer, '$input_gmp_integer', 'gmp_integer_to_string()' );

    #    RPerl::diag("in PERLOPS_PERLTYPES gmp_integer_to_string(), received \$input_gmp_integer = $input_gmp_integer\n");

    my integer $is_negative = $input_gmp_integer->is_neg();
    my string $retval = reverse $input_gmp_integer->bstr();
    if ($is_negative) { chop $retval; }    # remove negative sign
    $retval =~ s/(\d{3})/$1_/gxms;
    if ( ( substr $retval, -1, 1 ) eq '_' ) { chop $retval; }
    $retval = reverse $retval;

    if ($is_negative) { $retval = q{-} . $retval; }

    #    RPerl::diag('in PERLOPS_PERLTYPES gmp_integer_to_string(), have $retval = ' . q{'} . $retval . q{'} . "\n");
    return $retval;
}

# [[[ GMP INTEGERIFY ]]]
# DEV NOTE: keep all these *_to_gmp_integer() conversion subroutines here instead of spread throughout the other RPerl/DataType/*.pm files,
# so that loading will all be controlled by the 'use rperlgmp;' directive

#our gmp_integer $bool_to_gmp_integer = sub {
sub bool_to_gmp_integer {
    ( my bool $input_bool ) = @_;
    my gmp_integer $output_gmp_integer = gmp_integer->new($input_bool);
    return $output_gmp_integer;
}

#our gmp_integer $integer_to_gmp_integer = sub {
sub integer_to_gmp_integer {
    ( my integer $input_integer ) = @_;
    my gmp_integer $output_gmp_integer = gmp_integer->new($input_integer);
    return $output_gmp_integer;
}

#our gmp_integer $unsigned_integer_to_gmp_integer = sub {
sub unsigned_integer_to_gmp_integer {
    ( my unsigned_integer $input_unsigned_integer ) = @_;
    my gmp_integer $output_gmp_integer = gmp_integer->new($input_unsigned_integer);
    return $output_gmp_integer;
}

#our gmp_integer $number_to_gmp_integer = sub {
sub number_to_gmp_integer {
    ( my number $input_number ) = @_;
    my gmp_integer $output_gmp_integer = gmp_integer->new(number_to_integer($input_number));
    return $output_gmp_integer;
}

#our gmp_integer $char_to_gmp_integer = sub {
sub char_to_gmp_integer {
    ( my char $input_char ) = @_;
    my gmp_integer $output_gmp_integer = gmp_integer->new(char_to_integer($input_char));
    return $output_gmp_integer;
}

#our gmp_integer $string_to_gmp_integer = sub {
sub string_to_gmp_integer {
    ( my string $input_string ) = @_;
    my gmp_integer $output_gmp_integer = gmp_integer->new(string_to_integer($input_string));
    return $output_gmp_integer;
}

# [[[ TYPE TESTING ]]]
our gmp_integer $gmp_integer__typetest0 = sub {
    my gmp_integer $retval = ( 21 / 7 ) + main::RPerl__DataType__Integer__MODE_ID();    # return gmp_integer (not number) value, don't do (22 / 7) etc.

    #    RPerl::diag("in PERLOPS_PERLTYPES gmp_integer__typetest0(), have \$retval = $retval\n");
    return ($retval);
};
our gmp_integer $gmp_integer__typetest1 = sub {
    ( my gmp_integer $lucky_gmp_integer ) = @_;

    #    gmp_integer_CHECK($lucky_gmp_integer);
    gmp_integer_CHECKTRACE( $lucky_gmp_integer, '$lucky_gmp_integer', 'gmp_integer__typetest1()' );

    #    RPerl::diag('in PERLOPS_PERLTYPES gmp_integer__typetest1(), received $lucky_gmp_integer = ' . gmp_integer_to_string($lucky_gmp_integer) . "\n");
    return ( ( $lucky_gmp_integer * 2 ) + main::RPerl__DataType__Integer__MODE_ID() );
};

1;  # end of class
