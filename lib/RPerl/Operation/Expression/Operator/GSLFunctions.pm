# [[[ PREPROCESSOR ]]]
# <<< TYPE_CHECKING: TRACE >>>  # must explicitly enable type-checking because we have implemented our own gsl_matrix_rows() and gsl_matrix_cols() below

# [[[ HEADER ]]]
package RPerl::Operation::Expression::Operator::GSLFunctions;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::Operator);
use RPerl::Operation::Expression::Operator;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitAutomaticExportation)  # SYSTEM SPECIAL 14: allow global exports from Config.pm & elsewhere

# [[[ PRE-DECLARED TYPES ]]]
# DEV NOTE: avoid 'use RPerl::DataStructure::GSLMatrix;' and possible circular dependencies
package    # hide from PAUSE indexing
    gsl_matrix;

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE ]]]
package RPerl::Operation::Expression::Operator::GSLFunctions;
use strict;
use warnings;

# [[[ EXPORTS ]]]
use RPerl::Exporter 'import';
our @EXPORT = qw(
    gsl_matrix_rows
    gsl_matrix_cols
);

# [[[ INCLUDES ]]]
use Math::GSL::Matrix qw(:all);

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

# DEV NOTE, CORRELATION #rp052: gsl_matrix_to_*() and gsl_matrix_rows() and gsl_matrix_cols() are RPerl subroutines
sub gsl_matrix_rows {
    { my integer $RETURN_TYPE };
    ( my gsl_matrix $m ) = @ARG;
    return Math::GSL::Matrix->new($m)->rows();
}

sub gsl_matrix_cols {
    { my integer $RETURN_TYPE };
    ( my gsl_matrix $m ) = @ARG;
    return Math::GSL::Matrix->new($m)->cols();
}

1;    # end of class
