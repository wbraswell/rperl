package Ball;    ## no critic (package)  # SYSTEM EXTERNAL 1: originally from Inline::CPP, invalid syntax?

use strict;
use warnings;
use English qw(-no_match_vars);

my $foo__bar__myclass = <<'EOCPP';
class MyClass {
  private:
    int a;
  public:
    MyClass() :a(10) {}
    int fetch () { return a; }
};
EOCPP

my $foo__qux__myclass = <<'EOCPP';
#include "/tmp/Foo__Bar__MyClass.c"
class MyClass {
  private:
    int a;
  public:
    MyClass() :a(20) {}
    int fetch () { return a; }
    int other_fetch () { MyClass mybar; return mybar.fetch(); }
};
EOCPP

open( my $FILEHANDLE, '>', '/tmp/Foo__Bar__MyClass.c' )
    or die "Can't open file '/tmp/Foo__Bar__MyClass.c' for writing $OS_ERROR";
print $FILEHANDLE $foo__bar__myclass;
close $FILEHANDLE;

open( $FILEHANDLE, '>', '/tmp/Foo__Qux__MyClass.c' )
    or die "Can't open file '/tmp/Foo__Qux__MyClass.c' for writing $OS_ERROR";
print $FILEHANDLE $foo__qux__myclass;
close $FILEHANDLE;

# C++ class conflict modes; run in order 1, 2, 3
# 1. disabled test mode: comment use, comment __DATA__
# 2. enabled init mode: comment use, uncomment __DATA__
# 3. enabled run mode: uncomment use, uncomment __DATA__
#use Inline CPP => '/tmp/Foo__Qux__MyClass.c' => namespace => 'Foo::Qux';
#__DATA__

package main;
use Test::More skip_all => "Tests disabled to avoid saving files to /tmp, and compiler errors causing test failure";

done_testing();
