package Foo;

#use Inline CPP => config => namespace => '' => classes => { 'Foo' => 'MyFoo'};
use Inline CPP => config => namespace => '';

use Inline CPP => 'class Foo { public: Foo() {} };';

1;

package main;

#my $f = MyFoo->new();
my $f = Foo->new();

print q{have ref($f) = '}, ref($f), "'\n";