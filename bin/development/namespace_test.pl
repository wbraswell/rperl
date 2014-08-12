#!/usr/bin/perl
# [[[ HEADER ]]]
use strict;
use warnings;
our $VERSION = 0.002_000;
use Carp;
use RPerl;


# [[[ CRITIC, INCLUDES, CONSTANTS ]]]
# USER DEFAULT 1: allow numeric values and print operator
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)
use RPerl::Inline;

# [[[ RPERL DRIVER BOILERPLATE ]]]
BEGIN { package main; our $RPERL_INCLUDE_PATH = 'blib/lib'; } # NEED REMOVE hard-coded path

BEGIN {
    use parent ('RPerl');
    $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH;
}                                                        # RPerl system files

BEGIN {
    use Data::Dumper;
    our $AUTOLOAD;

    sub AUTOLOAD {
        croak(
            "AUTOLOAD purposefully disabled for debugging, have \$AUTOLOAD = '$AUTOLOAD' and \@_ = \n"
                . Dumper( \@_ )
                . ', croaking' );
    }
}

BEGIN { print "[[[ BEGIN 'use Inline' STAGE for 'DATA' ]]]\n" x 3; }
use Inline (
    CPP      => 'DATA',
    @RPerl::Inline::ARGS,
);
print "[[[ END 'use Inline' STAGE for 'DATA' ]]]\n" x 3;

#my $myobject = MyClass->new();
my $myobject = Foo::Bar::MyClass->new();
#my $myobject = Foo::Bar::Foo__Bar__MyClass->new();
#my $myobject = Foo__Bar__MyClass->new();

my $string_retval = $myobject->mymethod('HOWDY INPUT!');
print {*STDERR} "in namespace_test.pl received mymethod() \$string_retval = '$string_retval'\n";
    
my $yourobject = Foo::Bar::YourClass->new();
$string_retval = $yourobject->yourmethod('AHOY INPUT!');
print {*STDERR} "in namespace_test.pl received yourmethod() \$string_retval = '$string_retval'\n";
    

__DATA__
__CPP__

using std::cout;  using std::cerr;
typedef std::string string;

#include <rperltypes.h>  // for data types and structures
#include <RPerl/HelperFunctions.cpp>		// -> HelperFunctions.h

//class MyClass
class Foo__Bar__MyClass
{
public:
    string mymethod(string myinput);

//    MyClass() {}
//    ~MyClass() {}
    Foo__Bar__MyClass() {}
    ~Foo__Bar__MyClass() {}
};

//string MyClass::mymethod(string myinput) {
string Foo__Bar__MyClass::mymethod(string myinput) {
    cout << "Namespace Hack, received myinput = '" << myinput << "'\n";
	string retval = "Namespace Hack retval, Armstrong CPPOPS_CPPTYPES";
	return(retval);
}

class Foo__Bar__YourClass
{
public:
    string yourmethod(string yourinput);

    Foo__Bar__YourClass() {}
    ~Foo__Bar__YourClass() {}
};

string Foo__Bar__YourClass::yourmethod(string yourinput) {
    cout << "Namespace Hack, received yourinput = '" << yourinput << "'\n";
	string retval = "Namespace Hack retval, Aldrin CPPOPS_CPPTYPES";
	return(retval);
}
