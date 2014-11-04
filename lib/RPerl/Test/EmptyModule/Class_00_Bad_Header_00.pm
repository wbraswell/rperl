# [[[ TEST : "ERROR ECVPAPC02" ]]]
# [[[ TEST : "Perl::Critic::Policy::Modules::RequireExplicitPackage" ]]]
# [[[ TEST : "Perl::Critic::Policy::TestingAndDebugging::RequireUseStrict" ]]]
# [[[ TEST : "Perl::Critic::Policy::TestingAndDebugging::RequireUseWarnings" ]]]
# [[[ HEADER ]]]
packaged RPerl::Test::EmptyModule::Class_00_Bad_Header_00;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ OO PROPERTIES ]]]
our %properties = ( ## no critic qw(ProhibitPackageVars)  # USER DEFAULT 2: allow OO properties
    empty_property => my integer $TYPED_empty_property = 2
);

# [[[ OO METHODS ]]]
our void__method $empty_method = sub { 2; };

1;
1;                  # CODE SEPARATOR: end of class

