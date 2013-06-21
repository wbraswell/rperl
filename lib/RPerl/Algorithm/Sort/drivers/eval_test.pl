#!/usr/bin/perl
use strict;  use warnings;
use Data::Dumper;


my $eval_string = <<'EOF';
package Foo;
our $foo_property = 23;
sub new { return bless ({ foo_property => $foo_property }, 'Foo'); }
1;

package Foo::Bar;
our $bar_property = [21, 12];
1;

package Foo;
our @ISA = ('some__cpp__lib__longname');
sub foo_method { my $self = shift;  my $person = shift;  print "in Foo->foo_method(), howdy \$person = $person!\n"; }
1;

package Foo::Bar;
our @ISA = ('Foo', 'some__other__lib__longname');
sub new { return bless ({ bar_property => $bar_property }, 'Foo::Bar'); }
1;
EOF

print "have \$eval_string =\n<<<BEGIN EVAL STRING>>>\n" . $eval_string . "<<<END EVAL STRING>>>\n";
my $eval_retval = eval($eval_string);  ## no critic
die (@_) if (@_);

print "have \$eval_retval = '$eval_retval'\n";

my $foo_obj = Foo->new();
print "have \$foo_obj =\n" . Dumper($foo_obj) . "\n";
$foo_obj->foo_method('Wolvie');

my $bar_obj = Foo::Bar->new();
print "have \$bar_obj =\n" . Dumper($bar_obj) . "\n";
$bar_obj->foo_method('Wolverine');
