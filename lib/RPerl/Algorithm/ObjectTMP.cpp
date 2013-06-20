#!/usr/bin/perl
use lib '/home/wbraswell/austin_perl_mongers/compiler/RPerl/RPerl-latest/lib';  # RPerl system files  # NEED REMOVE hard-coded path
use strict;  use warnings;  use RPerl;  our @ISA = ('RPerl');

use lib '/home/wbraswell/austin_perl_mongers/compiler/RPerl/RPerl-latest/lib/CPAN';  # RPerl's MyConfig.pm  # NEED REMOVE hard-coded path
use MyConfig;


no strict;
use Inline CPP;

my $plane = new Airplane;
$plane->print;
if ($plane->isa("Object")) { print "Plane is an Object!\n"; }
unless ($plane->can("fly")) { print "This plane sucks!\n"; }

__END__
__CPP__

using namespace std;

/* Abstract class (interface) */
class Object {
public:
  virtual void print() { cout << "Object (" << this << ")" << endl; }
  virtual void info() = 0;
  virtual bool isa(char *klass) = 0;
  virtual bool can(char *method) = 0;
  
  virtual void fly() { printf("[[[ FLYIN' ]]]\n"); }
};

class Airplane : public Object {
public:
  Airplane() {}
  ~Airplane() {}

  virtual void info() { print(); }
  virtual bool isa(char *klass) { return strcmp(klass, "Object")==0; }
  virtual bool can(char *method) {
    bool yes = false;
    yes |= strcmp(method, "print")==0;
    yes |= strcmp(method, "info")==0;
    yes |= strcmp(method, "isa")==0;
    yes |= strcmp(method, "can")==0;
    yes |= strcmp(method, "fly")==0;
    return yes;
  }
};