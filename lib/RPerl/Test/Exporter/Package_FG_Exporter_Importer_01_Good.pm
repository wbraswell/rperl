# [[[ PREPROCESSOR ]]]
# <<< TYPE_CHECKING: TRACE >>>

# [[[ HEADER ]]]
use RPerl;

package RPerl::Test::Exporter::Package_FG_Exporter_Importer_01_Good;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names
## no critic qw(ProhibitAutomaticExportation)  # SYSTEM SPECIAL 14: allow global exports from Config.pm & elsewhere

# [[[ EXPORTS ]]]
use RPerl::Exporter qw(import);
our @EXPORT = qw(multiply_return_FG);

# [[[ SUBROUTINES ]]]

sub multiply_return_FG {
    { my number $RETURN_TYPE };
    ( my integer $multiplicand, my number $multiplier ) = @ARG;
#    print 'in multiply_return_FG(), about to return', "\n";
    return $multiplicand * $multiplier;
}

1;    # end of class


use RPerl;
package RPerl::Test::Exporter::Package_F_Exporter_Importer_01_Good;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ EXPORTS ]]]
use RPerl::Exporter qw(import);
our @EXPORT_OK = qw(multiply_return_FG multiply_return_F);

# [[[ INCLUDES ]]]
INIT { RPerl::Test::Exporter::Package_FG_Exporter_Importer_01_Good->import(); }

# [[[ SUBROUTINES ]]]

sub multiply_return_F {
    { my number $RETURN_TYPE };
    ( my integer $multiplicand, my number $multiplier ) = @ARG;
    return $multiplicand * $multiplier;
}

1;    # end of class


use RPerl;
package RPerl::Test::Exporter::Package_G_Importer_01_Good;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ INCLUDES ]]]
INIT { RPerl::Test::Exporter::Package_F_Exporter_Importer_01_Good->import(qw(multiply_return_FG multiply_return_F)); }

# [[[ SUBROUTINES ]]]

sub multiply_return_G {
    { my number $RETURN_TYPE };
    ( my integer $multiplicand, my number $multiplier ) = @ARG;
    return $multiplicand * $multiplier;
}

1;    # end of class
