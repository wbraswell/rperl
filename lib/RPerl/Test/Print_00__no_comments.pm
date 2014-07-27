package RPerl::Test::Print_00;
use strict;
use warnings;
our $VERSION = 0.003_001;
use Carp;
use RPerl;

our void $greet_planet = sub {

    ( my integer $arg0 ) = @_;

    print {*STDERR} 'Hello, world! comma ', $arg0, ' and ', 42, "\n";

    print "Goodbye from PERLOPS_PERLTYPES\n";
};

1;1;
