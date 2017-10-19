# [[[ HEADER ]]]
#use RPerl;
package RPerl::DataStructure::GSLMatrix;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
# OO (non-procedural) data structure
#use parent qw(Math::GSL::Matrix RPerl::DataStructure::Array::Reference);  # NEED UPGRADE, CORRELATION #rp023: Inline::CPP support for multiple inheritance
use parent qw(Math::GSL::Matrix);
use Math::GSL::Matrix qw(:all);  # we still actually use GSL in PERLOPS_PERLTYPES mode, albeit indirectly via Math::GSL::Matrix
#use RPerl::DataStructure::Array::Reference;  # NEED ANSWER: do we actually inherit or use any part of Array::Reference?  is this inheritance actually correct logically?

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names
## no critic qw(ProhibitAutomaticExportation)  # SYSTEM SPECIAL 14: allow global exports from Config.pm & elsewhere

# [[[ EXPORTS ]]]
use RPerl::Exporter 'import';
our @EXPORT = qw(
    gsl_matrix_CHECK
    gsl_matrix_CHECKTRACE
    gsl_matrix_to_number_arrayref
    gsl_matrix_to_number_arrayref_arrayref
    gsl_matrix_to_string
    number_arrayref_to_gsl_matrix
);

# [[[ INCLUDES ]]]
use RPerl::Operation::Expression::Operator::GSLFunctions;

# [[[ SUB-TYPES ]]]

# non-OO (procedural) data structure
package    # hide from PAUSE indexing
    gsl_matrix;
use strict;
use warnings;
#use parent qw(Math::GSL::Matrix::gsl_matrix);  # there is no such file as Math/GSL/Matrix/gsl_matrix.pm
our @ISA = qw(Math::GSL::Matrix::gsl_matrix);

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE ]]]
package RPerl::DataStructure::GSLMatrix;
use strict;
use warnings;

# [[[ TYPE-CHECKING ]]]
sub gsl_matrix_CHECK {
    { my void $RETURN_TYPE };
    ( my $possible_gsl_matrix ) = @ARG;

    RPerl::diag("in PERLOPS_PERLTYPES gsl_matrix_CHECK(), top of subroutine\n");

    if ( not( defined $possible_gsl_matrix ) ) {
        die( "\nERROR EMAV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ngsl_matrix external wrapper value expected but undefined/null value found,\ndying\n" );
    }
    if ( not( main::RPerl_SvHROKp($possible_gsl_matrix) ) ) {
        die("\nERROR EMAV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ngsl_matrix external wrapper value expected but non-hashref value found,\ndying\n");
    }
    my string $classname = main::class($possible_gsl_matrix);
    if ( not defined $classname ) {
        die( "\nERROR EMAV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ngsl_matrix external wrapper value expected but non-object (blessed hashref) value found,\ndying\n" );
    }
    if ( not( UNIVERSAL::isa( $possible_gsl_matrix, 'Math::GSL::Matrix::gsl_matrix' ) ) ) {
        die( "\nERROR EMAV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ngsl_matrix external wrapper value expected but non-Math::GSL::Matrix::gsl_matrix-derived object value found,\ndying\n" );
    }
    if ( $classname ne 'Math::GSL::Matrix::gsl_matrix' ) {
        die( "\nERROR EMAV04, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ngsl_matrix external wrapper value expected but non-Math::GSL::Matrix::gsl_matrix object value found,\ndying" );
    }

#    RPerl::diag("in PERLOPS_PERLTYPES gsl_matrix_CHECK(), bottom of subroutine\n");
    return;
}

sub gsl_matrix_CHECKTRACE {
    { my void $RETURN_TYPE };
    ( my $possible_gsl_matrix, my $variable_name, my $subroutine_name ) = @ARG;

    RPerl::diag("in PERLOPS_PERLTYPES gsl_matrix_CHECKTRACE(), top of subroutine\n");
    RPerl::diag('in PERLOPS_PERLTYPES gsl_matrix_CHECKTRACE(), received $variable_name = ' . $variable_name . "\n");
    RPerl::diag('in PERLOPS_PERLTYPES gsl_matrix_CHECKTRACE(), received $subroutine_name = ' . $subroutine_name . "\n");

    if ( not( defined $possible_gsl_matrix ) ) {
        die( "\nERROR EMAV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ngsl_matrix external wrapper value expected but undefined/null value found,\nin variable " . $variable_name . " from subroutine " . $subroutine_name . ",\ndying\n" );
    }
    if ( not( main::RPerl_SvHROKp($possible_gsl_matrix) ) ) {
        die("\nERROR EMAV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ngsl_matrix external wrapper value expected but non-hashref value found,\nin variable " . $variable_name . " from subroutine " . $subroutine_name . ",\ndying\n" );
    }
    my string $classname = main::class($possible_gsl_matrix);
    if ( not defined $classname ) {
        die( "\nERROR EMAV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ngsl_matrix external wrapper value expected but non-object (blessed hashref) value found,\nin variable " . $variable_name . " from subroutine " . $subroutine_name . ",\ndying\n" );
    }
    if ( not( UNIVERSAL::isa( $possible_gsl_matrix, 'Math::GSL::Matrix::gsl_matrix' ) ) ) {
        die( "\nERROR EMAV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ngsl_matrix external wrapper value expected but non-Math::GSL::Matrix::gsl_matrix-derived object value found,\nin variable " . $variable_name . " from subroutine " . $subroutine_name . ",\ndying\n" );
    }
    if ( $classname ne 'Math::GSL::Matrix::gsl_matrix' ) {
        die( "\nERROR EMAV04, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ngsl_matrix external wrapper value expected but non-Math::GSL::Matrix::gsl_matrix object value found,\nin variable " . $variable_name . " from subroutine " . $subroutine_name . ",\ndying\n" );
    }

#    RPerl::diag("in PERLOPS_PERLTYPES gsl_matrix_CHECKTRACE(), bottom of subroutine\n");
    return;
}

# [[[ ARRAYIFY ]]]

# DEV NOTE, CORRELATION #rp052: gsl_matrix_to_*() and gsl_matrix_rows() and gsl_matrix_cols() are RPerl subroutines
sub gsl_matrix_to_number_arrayref {
    { my number_arrayref $RETURN_TYPE };
    ( my gsl_matrix $input_gsl_matrix ) = @ARG;

#    gsl_matrix_CHECK($input_gsl_matrix);
    gsl_matrix_CHECKTRACE( $input_gsl_matrix, '$input_gsl_matrix', 'gsl_matrix_to_number_arrayref()' );

    die 'DUMMY CODE STUB, NEED REAL CODE!' . "\n" . 'dying';
}

sub gsl_matrix_to_number_arrayref_arrayref {
    { my number_arrayref_arrayref $RETURN_TYPE };
    ( my gsl_matrix $input_gsl_matrix ) = @ARG;

#    gsl_matrix_CHECK($input_gsl_matrix);
    gsl_matrix_CHECKTRACE( $input_gsl_matrix, '$input_gsl_matrix', 'gsl_matrix_to_number_arrayref_arrayref()' );

    die 'DUMMY CODE STUB, NEED REAL CODE!' . "\n" . 'dying';
}

# [[[ STRINGIFY ]]]

sub gsl_matrix_to_string {
    { my string $RETURN_TYPE };
    ( my gsl_matrix $input_gsl_matrix ) = @ARG;
    
#    gsl_matrix_CHECK($input_gsl_matrix);
    gsl_matrix_CHECKTRACE( $input_gsl_matrix, '$input_gsl_matrix', 'gsl_matrix_to_string()' );

    my string $retval = q{};
    for my integer $i (0 .. (gsl_matrix_rows($input_gsl_matrix) - 1)) { 
        for my integer $j (0 .. (gsl_matrix_cols($input_gsl_matrix) - 1)) {
            $retval .= gsl_matrix_get($input_gsl_matrix, $i, $j) . "\t";
        } 
        $retval .= "\n";
    }
    $retval .= "\n";
    return $retval;
}

# [[[ GSL MATRIXIFY ]]]
# DEV NOTE: keep all these *_to_gsl_matrix() conversion subroutines here instead of spread throughout the other RPerl/Data*/*.pm files,
# so that loading will all be controlled by the 'use rperlgsl;' directive

sub number_arrayref_to_gsl_matrix {
    { my gsl_matrix $RETURN_TYPE };
    ( my number_arrayref $input_number_arrayref, my integer $rows, my integer $cols ) = @ARG;

#    ::number_arrayref_CHECK($input_number_arrayref);
    ::number_arrayref_CHECKTRACE( $input_number_arrayref, '$input_number_arrayref', 'number_arrayref_to_gsl_matrix()' );

#    print 'in number_arrayref_to_gsl_matrix(), received $rows = ', $rows, ', $cols = ', $cols, "\n";

    my gsl_matrix $retval = gsl_matrix_alloc($rows, $cols);

    for my integer $i (0 .. ($rows - 1)) {
        for my integer $j (0 .. ($cols - 1)) {
            gsl_matrix_set($retval, $i, $j, $input_number_arrayref->[($i * $cols) + $j]);
        }
    }
    return $retval;
}

# [[[ TYPE TESTING ]]]

sub gsl_matrix__typetest0 {
    { my gsl_matrix $RETURN_TYPE };
    my gsl_matrix $retval = gsl_matrix_alloc(1, 1);
    gsl_matrix_set($retval, 0, 0, main::RPerl__DataType__Integer__MODE_ID());

    RPerl::diag('in PERLOPS_PERLTYPES gsl_matrix__typetest0(), have $retval = ' . Dumper($retval) . "\n");
    return ($retval);
}

sub gsl_matrix__typetest1 {
    { my gsl_matrix $RETURN_TYPE };
    ( my gsl_matrix $lucky_gsl_matrix ) = @ARG;

#    ::gsl_matrix_CHECK($lucky_gsl_matrix);
    ::gsl_matrix_CHECKTRACE( $lucky_gsl_matrix, '$lucky_gsl_matrix', 'gsl_matrix__typetest1()' );

    RPerl::diag('in PERLOPS_PERLTYPES gsl_matrix__typetest1(), received $lucky_gsl_matrix = ' . gsl_matrix_to_string($lucky_gsl_matrix) . "\n");
    return gsl_matrix_add_constant($lucky_gsl_matrix, main::RPerl__DataType__Integer__MODE_ID());
}

1;    # end of class
