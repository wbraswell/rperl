package RPerl::Class;
use strict;  use warnings;
use Data::Dumper;  # don't depend on RPerl::DUMPER

#our %properties = ();  # this base class doesn't actually have any properties

# after compiling but before runtime: create symtab entries for all RPerl functions/methods, and accessors/mutators for all RPerl class properties
INIT
{
#	print "in Class.pm INIT block, have \%INC =\n" . Dumper(\%INC) . "\n";

	my $module_file_long;
	my $package_name;
	my %class_properties;
	my $subroutine_type;
	my $subroutine_name;
	
	foreach my $module_file_short (sort(keys %INC))
	{
		$package_name = '';
		if ($module_file_short =~ /^RPerl/)
		{
#			print "in Class.pm INIT block, have \$module_file_short = '$module_file_short'\n";
			$module_file_long = $INC{$module_file_short};			
#			print "in Class.pm INIT block, have \$module_file_long = '$module_file_long'\n";
			
			open MODULE_FILE, "<", $module_file_long or die $!;  ## no critic
			while (my $module_file_line = <MODULE_FILE>)
			{
				chomp $module_file_line;
#				print "in Class.pm INIT block, have \$module_file_line =\n$module_file_line\n";
				
				# skip single-line comments
				next if ($module_file_line =~ /^\s*\#/);
				
				# skip multi-line comments
				if ($module_file_line =~ /^\=\w+/)
				{
					$module_file_line = <MODULE_FILE>;
					while ($module_file_line !~ /^\=cut/) { $module_file_line = <MODULE_FILE>; }
					next;
				}

				if ($module_file_line =~ /^\s*package\s+(\w+(::\w+)*)\;$/)
				{
					$package_name = $1;
					print "in Class.pm INIT block, have \$package name = '$package_name'\n";
					%class_properties = eval("\%$package_name\:\:properties");  ## no critic
					
					foreach my $class_property_name (sort(keys %class_properties))
					{
						print "in Class.pm INIT block, have \$class_property_name = '$class_property_name'\n";
						eval("\*\{$package_name\:\:get_$class_property_name\} \= sub \{ return \$\_\[0\]\-\>\{$class_property_name\}\; \}\;");  ## no critic
#						eval("\*\{$package_name\:\:get_$class_property_name\} \= sub \{ print \"IN POST\-INIT\, accessor MODE $package_name\:\:get_$class_property_name\\n\"\; return \$\_\[0\]\-\>\{$class_property_name\}\; \}\;");  ## no critic
						eval("\*\{$package_name\:\:set_$class_property_name\} \= sub \{ \$\_\[0\]\-\>\{$class_property_name\} \= \$\_\[1\]\; return \$\_\[0\]\-\>\{$class_property_name\}\; \}\;");  ## no critic
#						eval("\*\{$package_name\:\:set_$class_property_name\} \= sub \{ print \"IN POST\-INIT\, mutator MODE $package_name\:\:set_$class_property_name\\n\"\; \$\_\[0\]\-\>\{$class_property_name\} \= \$\_\[1\]\; return \$\_\[0\]\-\>\{$class_property_name\}\; \}\;");  ## no critic
					}
				}
				
				if ($module_file_line =~ /^\s*our\s+(\w+)\s+\$(\w+)\s+\=\s+sub\s+\{/)
				{
					$subroutine_type = $1;
					$subroutine_name = $2;
					print "in Class.pm INIT block, have \$subroutine_type = '$subroutine_type', and \$subroutine_name = '$subroutine_name'\n";
					
					if ($subroutine_type =~ /\_\_method$/)
					{
						print "in Class.pm INIT block, have method'\n";
#						eval("\*\{$package_name\:\:$subroutine_name\} \= sub \{ return \&\$\{$package_name\:\:$subroutine_name\}\(\@\_\)\; \}\;");  ## no critic  # NEED UPGRADE: how can I do this w/out a subroutine?
						eval("\*\{$package_name\:\:$subroutine_name\} \= sub \{ print \"IN POST\-INIT\, method direct call MODE $package_name\:\:$subroutine_name\\n\"\; return \&\$\{$package_name\:\:$subroutine_name\}\(\@\_\)\; \}\;");  ## no critic  # NEED UPGRADE: how can I do this w/out a subroutine?
					}
					else
					{
						print "in Class.pm INIT block, have subroutine'\n";
						if (eval("defined\(\&main\:\:$subroutine_name\)"))  ## no critic
							{ die "Attempt by package '$package_name' to re-define shared global subroutine '$subroutine_name', please re-name your subroutine or make it a method, dying"; }
						# DEV NOTE: must load into both main:: and $package_name:: namespaces, in order to call subroutines w/out class prefix from within class file (package) itself, and not to use AUTOLOAD
#						eval("\*\{main\:\:$subroutine_name\} \= sub \{ return \&\$\{$package_name\:\:$subroutine_name\}\(\@\_\)\; \}\;");  ## no critic  # NEED UPGRADE: how can I do this w/out a subroutine?
						eval("\*\{main\:\:$subroutine_name\} \= sub \{ print \"IN POST\-INIT\, subroutine direct call MODE main\:\:$subroutine_name\\n\"\; return \&\$\{$package_name\:\:$subroutine_name\}\(\@\_\)\; \}\;");  ## no critic  # NEED UPGRADE: how can I do this w/out a subroutine?
#						eval("\*\{$package_name\:\:$subroutine_name\} \= sub \{ return \&\$\{$package_name\:\:$subroutine_name\}\(\@\_\)\; \}\;");  ## no critic  # NEED UPGRADE: how can I do this w/out a subroutine?
						eval("\*\{$package_name\:\:$subroutine_name\} \= sub \{ print \"IN POST\-INIT\, subroutine direct call MODE $package_name\:\:$subroutine_name\\n\"\; return \&\$\{$package_name\:\:$subroutine_name\}\(\@\_\)\; \}\;");  ## no critic  # NEED UPGRADE: how can I do this w/out a subroutine?
					}
				}
			}
			close (MODULE_FILE); 
		}
	}
}

# RPerl object constructor, shorthand
sub new { no strict; return bless({%{$_[0] . '::properties'}}, $_[0]); }

# suppress deprecated feature warning
$SIG{__WARN__} = sub { return if $_[0] =~ /^Use of inherited AUTOLOAD for non-method /; warn @_; };

#=UNUSED_CODE
# RPerl function/method autoloader, longhand; allows syntax for typed functions/methods and automates get/set accessors/mutators for object properties;
# creates real subroutines to avoid AUTOLOADing any function/method more than once, performs operation inside AUTOLOAD that one time
# mostly deprecated in favor of INIT block above
our $AUTOLOAD;
sub AUTOLOAD
{
	print "IN AUTOLOAD, top of subroutine, received \$AUTOLOAD = '$AUTOLOAD', and \@_ =\n" . Dumper(\@_) . "\n";
	no strict;
	my $retval;
	
	# DISABLE RUNTIME ACCESSOR/MUTATOR BEHAVIOR
#	if ($AUTOLOAD =~ /^([\w+::]*)(get|set)_(\w+)$/)
	if (0)
	{
		print "IN AUTOLOAD, accessor/mutator MODE, have \$1 = '$1', \$2 = '$2', \$3 = '$3'\n";
		if ($2 eq 'get')	
		{
			print "IN AUTOLOAD, accessor MODE\n";
#			eval("\*\{$AUTOLOAD\} \= sub \{ return \$\_\[0\]\-\>\{$3\}\; \}\;");  ## no critic
			eval("\*\{$AUTOLOAD\} \= sub \{ print \"IN POST\-AUTOLOAD\, accessor MODE $AUTOLOAD\\n\"\; return \$\_\[0\]\-\>\{$3\}\; \}\;");  ## no critic
			$retval = $_[0]->{$3};
		}
		else  # ($2 eq 'set')
		{
			print "IN AUTOLOAD, mutator MODE\n";
#			eval("\*\{$AUTOLOAD\} \= sub \{ \$\_\[0\]\-\>\{$3\} \= \$\_\[1\]\; return \$\_\[0\]\-\>\{$3\}\; \}\;");  ## no critic
			eval("\*\{$AUTOLOAD\} \= sub \{ print \"IN POST\-AUTOLOAD\, mutator MODE $AUTOLOAD\\n\"\; \$\_\[0\]\-\>\{$3\} \= \$\_\[1\]\; return \$\_\[0\]\-\>\{$3\}\; \}\;");  ## no critic
			$_[0]->{$3} = $_[1];
			$retval = $_[0]->{$3};
		}
	}
	else
	{
		print "IN AUTOLOAD, direct call MODE\n";
		# disable creating symtab entries here to avoid redefining subroutines in INIT block above;
		# still need direct call mode here in case we want to call an RPerl function/method before the INIT block executes,
		# such as when an RPerl class calls one of it's own functions/methods during compile time
#		eval("\*\{$AUTOLOAD\} \= sub \{ return \&\$\{$AUTOLOAD\}\(\@\_\)\; \}\;");  ## no critic  # NEED UPGRADE: how can I do this w/out a subroutine?
#		eval("\*\{$AUTOLOAD\} \= sub \{ print \"IN POST\-AUTOLOAD\, direct call MODE $AUTOLOAD\\n\"\; return \&\$\{$AUTOLOAD\}\(\@\_\)\; \}\;");  ## no critic  # NEED UPGRADE: how can I do this w/out a subroutine?
		if (defined(${$AUTOLOAD})) { $retval = &${$AUTOLOAD}(@_); }
		else { die "Attempt to AUTOLOAD undefined subroutine '$AUTOLOAD', dying"; }
	}
=SNIP
	# is there any reason to encapsulate calls in an eval() to trap their errors???
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