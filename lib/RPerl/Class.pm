package RPerl::Class;
use strict;  use warnings;

#our %properties = ();  # this base class doesn't actually have any properties

# RPerl object constructor, shorthand
sub new { no strict; return bless({%{$_[0] . '::properties'}}, $_[0]); }

# RPerl function/method autoloader, shorthand; allows syntax for typed functions/methods
our $AUTOLOAD;  sub AUTOLOAD { return eval('&$' . $AUTOLOAD . '(@_);'); }  ## no critic, suppress 'expression form of eval' warning
$SIG{__WARN__} = sub { return if $_[0] =~ /^Use of inherited AUTOLOAD for non-method /; warn @_; };  # suppress deprecated feature warning

=UNUSED_CODE
# RPerl function/method autoloader, longhand; allows syntax for typed functions/methods
use Data::Dumper;  # don't depend on RPerl::DUMPER
our $AUTOLOAD;
sub AUTOLOAD
{
	print "IN AUTOLOAD, have \$AUTOLOAD = '$AUTOLOAD', and \@_ =\n" . Dumper(\@_) . "\n";
	if ($AUTOLOAD =~ /main::/)
	{
#		my $foo_func_ref = eval("\${$AUTOLOAD}");
#		print "IN AUTOLOAD, have \$foo_func_ref =\n" . Dumper($foo_func_ref) . "\n";
#		return &$foo_func_ref(@_);

		my $eval_string = '&$' . $AUTOLOAD . '(@_);';
		print "IN AUTOLOAD, have \$eval_string = '$eval_string'\n";
		return eval($eval_string);  ## no critic
	}
	else
	{
		no strict;
		return &${$AUTOLOAD}(@_);
	}
}
=cut

=UNUSED_CODE
# RPerl object constructor, longhand
#sub new($class_name_const_str)
sub new_longhand
{
	(my $class_name_const_str) = @_;
print "in Class.pm, have \$class_name_const_str = '$class_name_const_str'\n";
	my $properties_name_const_str = $class_name_const_str . '::properties';
print "in Class.pm, have \$properties_name_const_str = '$properties_name_const_str'\n";
	my %properties = %{$properties_name_const_str};
print "in Class.pm, have \%properties =\n" . Dumper(\%properties) . "\n";
#	my $new_obj = bless({%{$class_name_const_str . '::properties'}}, $class_name_const_str);
	my $new_obj = bless({%properties}, $class_name_const_str);
print "in Class.pm, have \$new_obj =\n" . Dumper($new_obj) . "\n";
	return $new_obj;
}
=cut

sub DESTROY {}

1;