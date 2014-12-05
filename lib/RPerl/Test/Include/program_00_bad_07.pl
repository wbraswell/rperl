use RPerl::Test::Foo;
#!/usr/bin/perl
# [[[ TEST : 'ERROR ECVPAPC02' ]]]
# [[[ TEST : 'Perl::Critic::Policy::Modules::RequireExplicitPackage' ]]]
# [[[ TEST : 'Perl::Critic::Policy::Modules::RequireEndWithOne' ]]]
# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ INCLUDES ]]]
use RPerl::Test::Bar;

# [[[ OPERATIONS ]]]
my integer $i = 2 + 2;