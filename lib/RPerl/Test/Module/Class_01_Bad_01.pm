# [[[ PREPROCESSOR ]]]
# <<< GENERATE_ERROR: 'ERROR ECOGEASRP37' >>>
# <<< GENERATE_ERROR: 'Class Class_01_Bad_01 inherits OO functionality from parent class RPerl::Test::Module::Class_01_Bad_01 but is attempting to inherit OO properties from non-matching class RPerl::Test' >>>

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::Module::Class_01_Bad_01;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ CRITICS ]]]
## no critic qw(ProhibitMultiplePackages ProhibitReusedNames ProhibitPackageVars)  # USER DEFAULT 8: allow additional packages

# [[[ OO PROPERTIES ]]]
our hashref $properties
    = { empty_property => my integer $TYPED_empty_property = 2 };

# [[[ OO METHODS & SUBROUTINES ]]]
our void::method $empty_method = sub {
    return 2;
};

1;    # end of class


# [[[ SHORTHAND CLASSES ]]]

# [[[ HEADER ]]]
use RPerl;
package Class_01_Bad_01;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test::Module::Class_01_Bad_01);
require RPerl::Test::Module::Class_01_Bad_01;

# [[[ OO PROPERTIES ]]]
our hashref $properties = $RPerl::Test::properties;

1;    # end of class

