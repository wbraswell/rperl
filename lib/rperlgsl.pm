# [[[ HEADER ]]]
package  # hide from PAUSE indexing
    rperlgsl; ## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ INCLUDES ]]]
use RPerl::DataStructure::GSLMatrix;
use RPerl::Operation::Expression::Operator::GSLFunctions;
use Math::GSL::Matrix qw(:all);

# [[[ EXPORTS ]]]
use RPerl::Exporter 'import';
our @EXPORT = (
    @RPerl::DataStructure::GSLMatrix::EXPORT,
    @RPerl::Operation::Expression::Operator::GSLFunctions::EXPORT,
    @Math::GSL::Matrix::EXPORT,
    @Math::GSL::Matrix::EXPORT_OK,  # DEV NOTE: force export all allowed exports gsl_matrix_*(), so RPerl users only have to say 'use rperlgsl;' w/out the 'qw(:all)'
);
our @EXPORT_OK = (
    @RPerl::DataStructure::GSLMatrix::EXPORT_OK,
    @RPerl::Operation::Expression::Operator::GSLFunctions::EXPORT_OK,
    @Math::GSL::Matrix::EXPORT_OK,
);

# DEV NOTE: must hard-code type-checking here because RPerl::Exporter doesn't handle this type of thing just yet
*rperltypes::gsl_matrix_CHECK = \&RPerl::DataStructure::GSLMatrix::gsl_matrix_CHECK;
*rperltypes::gsl_matrix_CHECKTRACE = \&RPerl::DataStructure::GSLMatrix::gsl_matrix_CHECKTRACE;

1;  # end of package
