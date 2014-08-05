#!/usr/bin/perl
# [[[ HEADER ]]]
use strict;
use warnings;
our $VERSION = 0.001_000;
use Carp;

#use RPerl;

# [[[ CRITIC, INCLUDES, CONSTANTS ]]]
# USER DEFAULT 1: allow numeric values and print operator
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)

BEGIN { print "[[[ BEGIN 'use Inline' STAGE for 'DATA' ]]]\n" x 3; }
use Inline (
    CPP      => 'DATA',
    TYPEMAPS => 'blib/lib/typemap.rperl',
    CCFLAGSEX =>
        '-DNO_XSLOCKS -Wno-deprecated -std=c++0x -Wno-reserved-user-defined-literal -Wno-literal-suffix',
    BUILD_NOISY       => 1,
    CLEAN_AFTER_BUILD => 0,    # cache it
    WARNINGS          => 1,

    #  NAMESPACE => 'Foo::Bar',
    #  CLASS => 'MyClass'
);
print "[[[ END 'use Inline' STAGE for 'DATA' ]]]\n" x 3;

#my $myobject = MyClass->new();
#my $myobject = Foo::Bar::MyClass->new();
my $myobject = Foo__Bar__MyClass->new();

my $string_retval = $myobject->mymethod('HOWDY INPUT!');
print {*STDERR}
    "in namespace_test.pl have \$string_retval = '$string_retval'\n";

__DATA__
__CPP__

using std::cout;  using std::cerr;
typedef std::string string;

//class MyClass
class Foo__Bar__MyClass
{
public:
    void mymethod(string myinput);

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
