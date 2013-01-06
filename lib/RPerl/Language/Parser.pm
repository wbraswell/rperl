package RPerl::Language::Parser;
use strict;  use warnings;

our @ISA = ('RPerl::Class');
use RPerl::Class;

our %properties =
(
	foo_const_str => 'baz',
	bar_const_int => 23,
	bat_array_ref => [21, 12, 'starman'],
	baz_hash_ref => {one_const_int => 21, two_const_int => 12, name_const_str => 'starman'}
);

#sub foo_str($self_obj, $poin_int, $dexter_num)
sub foo_str
{
	my $self_obj = shift;
	my $poin_int = shift;
	my $dexter_num = shift;
	print ($poin_int * $dexter_num);
	print $self_obj->{foo_const_str} . "\n";  # should print 'baz'
	print $self_obj->{bar_const_int} . "\n";  # should print 23
	return "howdy\n";
}

#sub bar_array_ref($self_obj)
sub bar_array_ref
{
	my $self_obj = shift;
	return $self_obj->{bat_array_ref};
}