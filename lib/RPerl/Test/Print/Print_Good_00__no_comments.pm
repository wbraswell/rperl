package RPerl::Test::Print_00;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.003_002;

our void $greet_planet = sub {

    ( my integer $arg0 ) = @_;

    RPerl::diag 'Hello, world! comma ', $arg0, ' and ', 42, "\n";

    print "Goodbye from PERLOPS_PERLTYPES\n";
};

1;1;
