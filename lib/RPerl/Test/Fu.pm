# [[[ HEADER ]]]
package RPerl::Test::Fu;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
#use RPerl::Test;
#use RPerl::Test qw(mode_tagline);
#use RPerl::Test qw(mode_tagline mode_description);
use RPerl::Test qw(mode_tagline mode_description mode_enable);

# [[[ OO PROPERTIES ]]]
our hash_ref $properties = {};

1;    # end of class
