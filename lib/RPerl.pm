package RPerl;
use strict;  use warnings;

# <<<=== DECREASE MAGIC ===>>>

#no magic;  # require data types, full declarations, other non-magic
use types;


# <<<=== PSEUDO-EXPORTED VARIABLES AND FUNCTIONS ===>>>

our $DEBUG = 1;

# TODO: replace Data::Dumper with pure-RPerl equivalent?
use Data::Dumper;
sub DUMPER {return Dumper(@_);}

# RPerl function/method autoloader, shorthand; allows syntax for typed functions/methods
our $AUTOLOAD;  sub AUTOLOAD { return eval('&$' . $AUTOLOAD . '(@_);'); }  ## no critic, suppress 'expression form of eval' warning
$SIG{__WARN__} = sub { return if $_[0] =~ /^Use of inherited AUTOLOAD for non-method /; warn @_; };  # suppress deprecated feature warning

=UNUSED_CODE
# RPerl function/method autoloader, longhand; allows syntax for typed functions/methods
our $AUTOLOAD;
sub AUTOLOAD
{
	print "IN AUTOLOAD, have \$AUTOLOAD = '$AUTOLOAD', and \@_ =\n" . RPerl::DUMPER(\@_) . "\n";
	if ($AUTOLOAD =~ /main::/)
	{
#		my $foo_func_ref = eval("\${$AUTOLOAD}");
#		print "IN AUTOLOAD, have \$foo_func_ref =\n" . RPerl::DUMPER($foo_func_ref) . "\n";
#		return &$foo_func_ref(@_);

		my $eval_string = '&$' . $AUTOLOAD . '(@_);';
		print "IN AUTOLOAD, have \$eval_string = '$eval_string'\n";
		return eval($eval_string);
	}
	else
	{
		no strict;
		return &${$AUTOLOAD}(@_);
	}
}
=cut


# <<<=== INCREASE RUNTIME PERFORMANCE ===>>>

# parse

# compile

# parallelize

1;