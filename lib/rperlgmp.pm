# [[[ HEADER ]]]
package  # hide from PAUSE indexing
    rperlgmp; ## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ INCLUDES ]]]
use RPerl::DataType::GMPInteger;
use RPerl::Operation::Expression::Operator::GMPFunctions;

# [[[ EXPORTS ]]]
#use Exporter 'import';
#our @EXPORT = qw(gmp_FOO);  # NEED ADDRESS: should we be exporting anything?

1;  # end of package
