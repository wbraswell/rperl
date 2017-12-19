# [[[ HEADER ]]]
package RPerl::Support::MongoDB;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ INCLUDES ]]]
#use RPerl::DataStructure::MongoFooType;
#use RPerl::Operation::Expression::Operator::MongoDBFunctions;
use MongoDB;

# [[[ EXPORTS ]]]
use RPerl::Exporter 'import';
our @EXPORT = (
#    @RPerl::DataStructure::MongoFooType::EXPORT,
#    @RPerl::Operation::Expression::Operator::MongoDBFunctions::EXPORT,
    @MongoDB::EXPORT,
#    @MongoDB::EXPORT_OK,  # DEV NOTE: force export all allowed exports FOO_*(), so RPerl users only have to say 'use RPerl::Support::MongoDB;' w/out the 'qw(:all)'
);
our @EXPORT_OK = (
#    @RPerl::DataStructure::MongoFooType::EXPORT_OK,
#    @RPerl::Operation::Expression::Operator::MongoDBFunctions::EXPORT_OK,
    @MongoDB::EXPORT_OK,
);

1;  # end of package
