# [[[ HEADER ]]]
package RPerl::DataType::Boolean;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.004_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::DataType::Scalar);
use RPerl::DataType::Scalar;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ SUB-TYPES ]]]
# a boolean is a binary boolean value, the only valid values are 0 (false) or 1 (true)
package  # hide from PAUSE indexing
    boolean;
use strict;
use warnings;
use parent qw(RPerl::DataType::Boolean);

# [[[ PRE-DECLARED TYPES ]]]
package    # hide from PAUSE indexing
    unsigned_integer;
package     # hide from PAUSE indexing
    integer;
package    # hide from PAUSE indexing
    gmp_integer;
package    # hide from PAUSE indexing
    number;
package    # hide from PAUSE indexing
    character;
package    # hide from PAUSE indexing
    string;

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE ]]]
package RPerl::DataType::Boolean;
use strict;
use warnings;

# [[[ EXPORTS ]]]
use Exporter 'import';
our @EXPORT = qw(boolean_to_unsigned_integer boolean_to_integer boolean_to_number boolean_to_character boolean_to_string);

# [[[ TYPE-CHECKING ]]]
our void $boolean_CHECK = sub {
    ( my $possible_boolean ) = @_;
    if ( not( defined $possible_boolean ) ) { croak( "\nERROR EBV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nboolean value expected but undefined/null value found,\ncroaking" ); }
    if ( not( main::RPerl_SvBOKp($possible_boolean) ) ) { croak( "\nERROR EBV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nboolean value expected but non-boolean value found,\ncroaking" ); }
};
our void $boolean_CHECKTRACE = sub {
    ( my $possible_boolean, my $variable_name, my $subroutine_name ) = @_;
    if ( not( defined $possible_boolean ) ) { croak( "\nERROR EBV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nboolean value expected but undefined/null value found,\nin variable " . $variable_name . " from subroutine " . $subroutine_name . ",\ncroaking" ); }
    if ( not( main::RPerl_SvBOKp($possible_boolean) ) ) { croak( "\nERROR EBV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nboolean value expected but non-boolean value found,\nin variable " . $variable_name . " from subroutine " . $subroutine_name . ",\ncroaking" ); }
};

# [[[ UNSIGNED INTEGERIFY ]]]
#our unsigned_integer $boolean_to_unsigned_integer = sub {
sub boolean_to_unsigned_integer {
    (my boolean $input_boolean) = @_;
#    boolean_CHECK($input_boolean);
    boolean_CHECKTRACE( $input_boolean, '$input_boolean', 'boolean_to_unsigned_integer()' );
    return $input_boolean;
}

# [[[ INTEGERIFY ]]]
#our integer $boolean_to_integer = sub {
sub boolean_to_integer {
    (my boolean $input_boolean) = @_;
#    boolean_CHECK($input_boolean);
    boolean_CHECKTRACE( $input_boolean, '$input_boolean', 'boolean_to_integer()' );
    return $input_boolean;
}

# [[[ NUMBERIFY ]]]
#our number $boolean_to_number = sub {
sub boolean_to_number {
    (my boolean $input_boolean) = @_;
#    boolean_CHECK($input_boolean);
    boolean_CHECKTRACE( $input_boolean, '$input_boolean', 'boolean_to_number()' );
    return $input_boolean * 1.0;
}

# [[[ CHARACTERIFY ]]]
#our character $boolean_to_character = sub {
sub boolean_to_character {
    (my boolean $input_boolean) = @_;
#    boolean_CHECK($input_boolean);
    boolean_CHECKTRACE( $input_boolean, '$input_boolean', 'boolean_to_character()' );
    my string $tmp_string = boolean_to_string($input_boolean);
    return substr $tmp_string, 0, 1;
}

# [[[ STRINGIFY ]]]
#our string $boolean_to_string = sub {
sub boolean_to_string {
    ( my $input_boolean ) = @_;
#    boolean_CHECK($input_boolean);
    boolean_CHECKTRACE( $input_boolean, '$input_boolean', 'boolean_to_string()' );
    return "$input_boolean";
}

# [[[ TYPE TESTING ]]]
our boolean $boolean__typetest0 = sub {
    # DEV NOTE, CORRELATION #rp12: maintain independence from Integer data type, re-implement integer_to_boolean() here
#    my boolean $retval = integer_to_boolean(main::RPerl__DataType__Boolean__MODE_ID());
    my boolean $retval = 1;
    if (main::RPerl__DataType__Boolean__MODE_ID() == 0) { $retval = 0; }
#    RPerl::diag("in PERLOPS_PERLTYPES boolean__typetest0(), have \$retval = $retval\n");
    return $retval;
};
our boolean $boolean__typetest1 = sub {
    ( my boolean $lucky_boolean ) = @_;
#    boolean_CHECK($lucky_boolean);
    boolean_CHECKTRACE( $lucky_boolean, '$lucky_boolean', 'boolean__typetest1()' );
#    RPerl::diag('in PERLOPS_PERLTYPES boolean__typetest1(), received $lucky_boolean = ' . boolean_to_string($lucky_boolean) . "\n");
    # DEV NOTE, CORRELATION #rp12: maintain independence from Integer data type, re-implement integer_to_boolean() here
    my boolean $retval = 1;
    if (($lucky_boolean + main::RPerl__DataType__Boolean__MODE_ID()) == 0) { $retval = 0; }
#    RPerl::diag("in PERLOPS_PERLTYPES boolean__typetest1(), have \$retval = $retval\n");
    return $retval;
#    return integer_to_boolean( $lucky_boolean + main::RPerl__DataType__Boolean__MODE_ID() );
};

1;  # end of class
