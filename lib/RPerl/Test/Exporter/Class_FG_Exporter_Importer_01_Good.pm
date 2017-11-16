# [[[ PREPROCESSOR ]]]
# <<< TYPE_CHECKING: TRACE >>>

# [[[ HEADER ]]]
use RPerl;

package RPerl::Test::Exporter::Class_FG_Exporter_Importer_01_Good;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names
## no critic qw(ProhibitAutomaticExportation)  # SYSTEM SPECIAL 14: allow global exports from Config.pm & elsewhere

# [[[ EXPORTS ]]]
use RPerl::Exporter qw(import);
our @EXPORT = qw(multiply_return_FG);

# [[[ OO PROPERTIES ]]]
our hashref $properties = { bax => my integer $TYPED_bax = 123 };

# [[[ SUBROUTINES & OO METHODS ]]]

sub multiply_bax_FG {
    { my void::method $RETURN_TYPE };
    ( my RPerl::Test::Exporter::Class_FG_Exporter_Importer_01_Good $self, my integer $multiplier ) = @ARG;
    $self->{bax} = $self->{bax} * $multiplier;
    return;
}

sub multiply_return_FG {
    { my number $RETURN_TYPE };
    ( my integer $multiplicand, my number $multiplier ) = @ARG;
    return $multiplicand * $multiplier;
}

1;    # end of class


use RPerl;
package RPerl::Test::Exporter::Class_F_Exporter_Importer_01_Good;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent -norequire, qw(RPerl::Test::Exporter::Class_FG_Exporter_Importer_01_Good);
INIT { RPerl::Test::Exporter::Class_FG_Exporter_Importer_01_Good->import(); }

# [[[ EXPORTS ]]]
use RPerl::Exporter qw(import);
our @EXPORT_OK = qw(multiply_return_FG multiply_return_F);

# [[[ OO PROPERTIES ]]]
our hashref $properties = { xab => my integer $TYPED_xab = 321 };

# [[[ SUBROUTINES & OO METHODS ]]]

sub multiply_bax_F {
    { my void::method $RETURN_TYPE };
    ( my RPerl::Test::Exporter::Class_F_Exporter_Importer_01_Good $self, my integer $multiplier ) = @ARG;
    $self->{bax} = $self->{bax} * $multiplier;
    return;
}

sub multiply_return_F {
    { my number $RETURN_TYPE };
    ( my integer $multiplicand, my number $multiplier ) = @ARG;
    return $multiplicand * $multiplier;
}

1;    # end of class


use RPerl;
package RPerl::Test::Exporter::Class_G_Importer_01_Good;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent -norequire, qw(RPerl::Test::Exporter::Class_F_Exporter_Importer_01_Good);
INIT { RPerl::Test::Exporter::Class_F_Exporter_Importer_01_Good->import(qw(multiply_return_FG multiply_return_F)); }

# [[[ OO PROPERTIES ]]]
our hashref $properties = { xba => my integer $TYPED_xba = 312 };

# [[[ SUBROUTINES & OO METHODS ]]]

sub multiply_bax_G {
    { my void::method $RETURN_TYPE };
    ( my RPerl::Test::Exporter::Class_G_Importer_01_Good $self, my integer $multiplier ) = @ARG;
    $self->{bax} = $self->{bax} * $multiplier;
    return;
}

sub multiply_return_G {
    { my number $RETURN_TYPE };
    ( my integer $multiplicand, my number $multiplier ) = @ARG;
    return $multiplicand * $multiplier;
}

1;    # end of class
