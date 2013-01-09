package RPerl::Class;
use strict;  use warnings;  use RPerl;
our @ISA = ('RPerl');  # need to inherit function/method autoloader

#our %properties = ();  # this base class doesn't actually have any properties

# RPerl object constructor, shorthand
sub new { no strict; return bless({%{$_[0] . '::properties'}}, $_[0]); }

=UNUSED_CODE
# RPerl object constructor, longhand
#sub new($class_name_const_str)
sub new_longhand
{
	(my $class_name_const_str) = @_;
print "in Class.pm, have \$class_name_const_str = '$class_name_const_str'\n" if $RPerl::DEBUG;
	my $properties_name_const_str = $class_name_const_str . '::properties';
print "in Class.pm, have \$properties_name_const_str = '$properties_name_const_str'\n" if $RPerl::DEBUG;
	my %properties = %{$properties_name_const_str};
print "in Class.pm, have \%properties =\n" . Dumper(\%properties) . "\n" if $RPerl::DEBUG;
#	my $new_obj = bless({%{$class_name_const_str . '::properties'}}, $class_name_const_str);
	my $new_obj = bless({%properties}, $class_name_const_str);
print "in Class.pm, have \$new_obj =\n" . Dumper($new_obj) . "\n" if $RPerl::DEBUG;
	return $new_obj;
}
=cut

sub DESTROY {}

1;