# [[[ HEADER ]]]
package  # hide from PAUSE indexing
    rperlsse; ## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ INCLUDES ]]]
use RPerl::DataStructure::SSENumberPair;
use RPerl::Operation::Expression::Operator::SSEIntrinsics;

# [[[ EXPORTS ]]]
use Exporter 'import';
our @EXPORT = qw(sse_recip_sqrt_32bit_on_64bit);

1;  # end of package
