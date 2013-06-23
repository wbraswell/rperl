package RPerl::Parser;
use strict;  use warnings;

our @ISA = ('RPerl::Class');
use RPerl::Class;  use RPerl;

our %properties =
(
	foo => my const_string $KEY_foo = 'baz',
	bar => my const_int $KEY_bar = 23,
	bat => my scalar__array_ref $KEY_bat = [21, 12, 'starman'],
	baz => my scalar__hash_ref $KEY_baz = {one_const_int => 21, two_const_int => 12, name_const_str => 'starman'}
);

our float $foo_method = sub { (my object $self, my string $arg) = @_;  print "HOWDY FROM foo_method(), HAVE \$arg = '$arg' and \$self =\n" . RPerl::DUMPER($self) . "\n"; };
