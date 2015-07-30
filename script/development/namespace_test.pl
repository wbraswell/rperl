#!/usr/bin/perl
# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl::AfterFilter;
our $VERSION = 0.004_001;

# [[[ CRITICS, INCLUDES ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
use RPerl::Inline;
use Inline ( CPP => 'DATA', %RPerl::Inline::ARGS );

# [[[ OPERATIONS ]]]
my $myobject      = Foo::Bar::MyClass->new();
my $string_retval = $myobject->mymethod('HOWDY INPUT!');
print
    "in namespace_test.pl, received mymethod() \$string_retval = '$string_retval'\n";

my $yourobject = Foo::Bar::YourClass->new();
$string_retval = $yourobject->yourmethod('AHOY INPUT!');
print
    "in namespace_test.pl, received yourmethod() \$string_retval = '$string_retval'\n";

__DATA__
__CPP__

using std::cout;  using std::cerr;
typedef std::string string;
#include <rperltypes.h>  // for data types and structures
#include <RPerl/HelperFunctions.cpp>		// -> HelperFunctions.h

class Foo__Bar__MyClass
{
public:
    string mymethod(string myinput);

    Foo__Bar__MyClass() {}
    ~Foo__Bar__MyClass() {}
};

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
