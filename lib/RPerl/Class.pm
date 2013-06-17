package RPerl::Class;
use strict;  use warnings;

#our %properties = ();  # this base class doesn't actually have any properties

# RPerl object constructor, shorthand
sub new { no strict; return bless({%{$_[0] . '::properties'}}, $_[0]); }

# suppress deprecated feature warning
$SIG{__WARN__} = sub { return if $_[0] =~ /^Use of inherited AUTOLOAD for non-method /; warn @_; };

#=UNUSED_CODE
# RPerl function/method autoloader, longhand; allows syntax for typed functions/methods and automates get/set accessors/mutators for object properties;
# creates real subroutines to avoid AUTOLOADing any function/method more than once, performs operation inside AUTOLOAD that one time
use Data::Dumper;  # don't depend on RPerl::DUMPER
our $AUTOLOAD;
sub AUTOLOAD
{
#	print "IN AUTOLOAD, top of subroutine, received \$AUTOLOAD = '$AUTOLOAD', and \@_ =\n" . Dumper(\@_) . "\n";
	no strict;
	my $retval;

	if ($AUTOLOAD =~ /^([\w+::]*)(get|set)_(\w+)$/)
	{
#		print "IN AUTOLOAD, accessor/mutator MODE, have \$1 = '$1', \$2 = '$2', \$3 = '$3'\n";
		if ($2 eq 'get')	
		{
#			print "IN AUTOLOAD, accessor MODE\n";
			eval("\*\{$AUTOLOAD\} \= sub \{ return \$\_\[0\]\-\>\{$3\}\; \}\;");  ## no critic
#			eval("\*\{$AUTOLOAD\} \= sub \{ print \"IN POST\-AUTOLOAD\, accessor MODE $AUTOLOAD\\n\"\; return \$\_\[0\]\-\>\{$3\}\; \}\;");  ## no critic
			$retval = $_[0]->{$3};
		}
		else  # ($2 eq 'set')
		{
#			print "IN AUTOLOAD, mutator MODE\n";
			eval("\*\{$AUTOLOAD\} \= sub \{ \$\_\[0\]\-\>\{$3\} \= \$\_\[1\]\; return \$\_\[0\]\-\>\{$3\}\; \}\;");  ## no critic
#			eval("\*\{$AUTOLOAD\} \= sub \{ print \"IN POST\-AUTOLOAD\, mutator MODE $AUTOLOAD\\n\"\; \$\_\[0\]\-\>\{$3\} \= \$\_\[1\]\; return \$\_\[0\]\-\>\{$3\}\; \}\;");  ## no critic
			$_[0]->{$3} = $_[1];
			$retval = $_[0]->{$3};
		}
	}
	else
	{
#		print "IN AUTOLOAD, direct call MODE\n";
		eval("\*\{$AUTOLOAD\} \= sub \{ return \&\$\{$AUTOLOAD\}\(\@\_\)\; \}\;");  ## no critic  # NEED UPGRADE: how can I do this w/out a subroutine?
#		eval("\*\{$AUTOLOAD\} \= sub \{ print \"IN POST\-AUTOLOAD\, direct call MODE $AUTOLOAD\\n\"\; return \&\$\{$AUTOLOAD\}\(\@\_\)\; \}\;");  ## no critic  # NEED UPGRADE: how can I do this w/out a subroutine?
		$retval = &${$AUTOLOAD}(@_);
	}
=SNIP
	## NEED ANSWER: is there any reason to encapsulate calls in an eval() to trap their errors???
	else
	{
		my $eval_string = '&$' . $AUTOLOAD . '(@_);';
		print "IN AUTOLOAD, eval call MODE, have \$eval_string = '$eval_string'\n";
		$retval = eval($eval_string);  ## no critic
	}
=cut

	die($@) if ($@);  # suppress '...propagated at RPerl/Class.pm' appended exception	
#	die if ($@);  # allow '...propagated at RPerl/Class.pm' appended exception	
	
#	print "IN AUTOLOAD, bottom of subroutine, about to return \$retval = '$retval'\n";
	return $retval;
}
#=cut

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