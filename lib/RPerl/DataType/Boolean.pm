# [[[ HEADER ]]]
package RPerl::DataType::Boolean;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.009_000;

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
    void;
package    # hide from PAUSE indexing
    unsigned_integer;
package     # hide from PAUSE indexing
    integer;
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
use RPerl::Exporter 'import';
our @EXPORT = qw(boolean_CHECK boolean_CHECKTRACE boolean_to_unsigned_integer boolean_to_integer boolean_to_number boolean_to_character boolean_to_string);
our @EXPORT_OK = qw(boolean_typetest0 boolean_typetest1);

# [[[ TYPE-CHECKING ]]]
sub boolean_CHECK {
    { my void $RETURN_TYPE };
    ( my $possible_boolean ) = @ARG;
    if ( not( defined $possible_boolean ) ) {
#        croak( "\nERROR EBV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nboolean value expected but undefined/null value found,\ncroaking" );
        die( "\nERROR EBV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nboolean value expected but undefined/null value found,\ndying\n" );
    }
    if ( not( main::RPerl_SvBOKp($possible_boolean) ) ) {
#        croak( "\nERROR EBV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nboolean value expected but non-boolean value found,\ncroaking" );
        die( "\nERROR EBV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nboolean value expected but non-boolean value found,\ndying\n" );
    }
    return;
}
sub boolean_CHECKTRACE {
    { my void $RETURN_TYPE };
    ( my $possible_boolean, my $variable_name, my $subroutine_name ) = @ARG;
    if ( not( defined $possible_boolean ) ) {
#        croak( "\nERROR EBV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nboolean value expected but undefined/null value found,\nin variable " . $variable_name . " from subroutine " . $subroutine_name . ",\ncroaking" );
        die( "\nERROR EBV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nboolean value expected but undefined/null value found,\nin variable " . $variable_name . " from subroutine " . $subroutine_name . ",\ndying\n" );
    }
    if ( not( main::RPerl_SvBOKp($possible_boolean) ) ) {
#        croak( "\nERROR EBV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nboolean value expected but non-boolean value found,\nin variable " . $variable_name . " from subroutine " . $subroutine_name . ",\ncroaking" );
        die( "\nERROR EBV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nboolean value expected but non-boolean value found,\nin variable " . $variable_name . " from subroutine " . $subroutine_name . ",\ndying\n" );
    }
    return;
}

# [[[ UNSIGNED INTEGERIFY ]]]
sub boolean_to_unsigned_integer {
    { my unsigned_integer $RETURN_TYPE };
    (my boolean $input_boolean) = @ARG;
#    boolean_CHECK($input_boolean);
    boolean_CHECKTRACE( $input_boolean, '$input_boolean', 'boolean_to_unsigned_integer()' );
    return $input_boolean;
}

# [[[ INTEGERIFY ]]]
sub boolean_to_integer {
    { my integer $RETURN_TYPE };
    (my boolean $input_boolean) = @ARG;
#    boolean_CHECK($input_boolean);
    boolean_CHECKTRACE( $input_boolean, '$input_boolean', 'boolean_to_integer()' );
    return $input_boolean;
}

# [[[ NUMBERIFY ]]]
sub boolean_to_number {
    { my number $RETURN_TYPE };
    (my boolean $input_boolean) = @ARG;
#    boolean_CHECK($input_boolean);
    boolean_CHECKTRACE( $input_boolean, '$input_boolean', 'boolean_to_number()' );
    return $input_boolean * 1.0;
}

# [[[ CHARACTERIFY ]]]
sub boolean_to_character {
    { my character $RETURN_TYPE };
    (my boolean $input_boolean) = @ARG;
#    boolean_CHECK($input_boolean);
    boolean_CHECKTRACE( $input_boolean, '$input_boolean', 'boolean_to_character()' );
    my string $tmp_string = boolean_to_string($input_boolean);
    return substr $tmp_string, 0, 1;
}

# [[[ STRINGIFY ]]]
sub boolean_to_string {
    { my string $RETURN_TYPE };
    ( my $input_boolean ) = @ARG;
#    boolean_CHECK($input_boolean);
    boolean_CHECKTRACE( $input_boolean, '$input_boolean', 'boolean_to_string()' );
    return "$input_boolean";
}

# [[[ TYPE TESTING ]]]
sub boolean_typetest0 {
    { my boolean $RETURN_TYPE };
    # DEV NOTE: maintain independence from Integer data type, re-implement integer_to_boolean() here
#    my boolean $retval = integer_to_boolean(main::RPerl__DataType__Boolean__MODE_ID());
    my boolean $retval = 1;
    if (main::RPerl__DataType__Boolean__MODE_ID() == 0) { $retval = 0; }
#    RPerl::diag("in PERLOPS_PERLTYPES boolean_typetest0(), have \$retval = $retval\n");
    return $retval;
}
sub boolean_typetest1 {
    { my boolean $RETURN_TYPE };
    ( my boolean $lucky_boolean ) = @ARG;
#    boolean_CHECK($lucky_boolean);
    boolean_CHECKTRACE( $lucky_boolean, '$lucky_boolean', 'boolean_typetest1()' );
#    RPerl::diag('in PERLOPS_PERLTYPES boolean_typetest1(), received $lucky_boolean = ' . boolean_to_string($lucky_boolean) . "\n");
    # DEV NOTE: maintain independence from Integer data type, re-implement integer_to_boolean() here
    my boolean $retval = 1;
    if (($lucky_boolean + main::RPerl__DataType__Boolean__MODE_ID()) == 0) { $retval = 0; }
#    RPerl::diag("in PERLOPS_PERLTYPES boolean_typetest1(), have \$retval = $retval\n");
    return $retval;
#    return integer_to_boolean( $lucky_boolean + main::RPerl__DataType__Boolean__MODE_ID() );
}

1;  # end of class
