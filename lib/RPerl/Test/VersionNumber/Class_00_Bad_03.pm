# [[[ PREPROCESSOR ]]]
# <<< COMPILE_ERROR: 'ERROR ECVPARP00' >>>

# [[[ HEADER ]]]
package RPerl::Test::VersionNumber::Class_00_Bad_03;
use strict;
use warnings;
use RPerl;
our $VERSION = 100.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ OO PROPERTIES ]]]
our hash_ref $properties
    = { empty_property => my integer $TYPED_empty_property = 2 };

# [[[ OO METHODS ]]]
our void__method $empty_method = sub { return 2; };

1;                  # end of class
