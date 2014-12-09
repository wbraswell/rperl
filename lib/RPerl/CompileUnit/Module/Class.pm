package RPerl::CompileUnit::Module::Class;
use strict;
use warnings;
use RPerl::Config;    # get Dumper, Carp, English without 'use RPerl;'
our $VERSION = 0.014_000;

## no critic qw(ProhibitStringyEval) # SYSTEM DEFAULT 1: allow eval()
## no critic qw(ProhibitAutoloading RequireArgUnpacking)  # SYSTEM SPECIAL 2: allow Autoload & read-only @_
## no critic qw(ProhibitExcessComplexity)  # SYSTEM SPECIAL 6: allow complex code inside subroutines, must be after line 1
## no critic qw(ProhibitDeepNests)  # SYSTEM SPECIAL 8: allow deeply-nested code
## no critic qw(ProhibitNoStrict)  # SYSTEM SPECIAL 9: allow no strict
## no critic qw(RequireBriefOpen)  # SYSTEM SPECIAL 10: allow complex processing with open filehandle

#our %properties = ();  # this base class doesn't actually have any properties

# after compiling but before runtime: create symtab entries for all RPerl functions/methods, and accessors/mutators for all RPerl class properties
INIT {
#	RPerl::diag "in Class.pm INIT block, have \%INC =\n" . Dumper(\%INC) . "\n";

    my $module_file_long;             # string
    my $package_name;                 # string
    my %class_properties;             # hash
    my $subroutine_type;              # string
    my $subroutine_name;              # string
    my $CHECK;                        # string
    my $inside_subroutine;            # bool
    my $subroutine_arguments_line;    # string

    foreach my $module_file_short ( sort keys %INC ) {
        $package_name = q{};
        $CHECK = $RPerl::CHECK; # reset data type checking to RPerl default for every file
        $inside_subroutine         = 0;
        $subroutine_arguments_line = q{};

# DEV NOTE: for now, only scan for RPerl subroutines in files or dirs that start with RPerl or rperl
        if (   ( $module_file_short =~ /^RPerl/xms )
            || ( $module_file_short =~ /^rperl/xms ) )
        {
#			RPerl::diag "in Class.pm INIT block, have \$module_file_short = '$module_file_short'\n";
            $module_file_long = $INC{$module_file_short};

#			RPerl::diag "in Class.pm INIT block, have \$module_file_long = '$module_file_long'\n";

            open my $MODULE_FILE, '<', $module_file_long or croak $OS_ERROR;
            while ( my $module_file_line = <$MODULE_FILE> ) {
                chomp $module_file_line;

#				RPerl::diag "in Class.pm INIT block, have \$module_file_line =\n$module_file_line\n";

                # set data type checking mode
                if ( $module_file_line
                    =~ /^\s*\#\s*\<\<\<\s*TYPE_CHECKING\s*\:\s*(\w+)\s*\>\>\>/xms )
                {
#                    RPerl::diag( "in Class.pm INIT block, have \$module_file_long = '$module_file_long'\n" );
                    if ($inside_subroutine) {
                        RPerl::diag(
                                  'in Class.pm INIT block, found <<< TYPE_CHECKING: '
                                . $1
                                . ' >>> while inside subroutine '
                                . $subroutine_name
                                . '(), aborting RPerl activation of entire file'
                                . "\n" );
                        last;
                    }
                    else {
#                        RPerl::diag( 'in Class.pm INIT block, found <<< TYPE_CHECKING: ' . $1 . " >>>\n" );
                        $CHECK = $1;
                    }
                }

                # skip single-line comments
                next if ( $module_file_line =~ /^\s*\#/xms );

                # skip multi-line POD comments
                if ( $module_file_line =~ /^\=(\w+)/xms ) {

#					RPerl::diag "in Class.pm INIT block, skipping multi-line POD comment, have \$1 = '$1'\n";
                    $module_file_line = <$MODULE_FILE>;
                    if ( not defined $module_file_line ) {
                        croak
                            "End of file '$module_file_long' reached without finding '=cut' end of multi-line POD comment '=$1', croaking";
                    }
                    while ( $module_file_line !~ /^\=cut/xms ) {
                        if ( not defined $module_file_line ) {
                            croak
                                "End of file '$module_file_long' reached without finding '=cut' end of multi-line POD comment '=$1', croaking";
                        }
                        $module_file_line = <$MODULE_FILE>;
                    }
                    next;
                }

                # skip multi-line heredocs
                if (( $module_file_line =~ /\=\s*\<\<\s*(\w+)\s*\;\s*$/xms )
                    or ( $module_file_line
                        =~ /\=\s*\<\<\s*\'(\w+)\'\s*\;\s*$/xms )
                    or ( $module_file_line
                        =~ /\=\s*\<\<\s*\"(\w+)\"\s*\;\s*$/xms )
                    )
                {
#					RPerl::diag "in Class.pm INIT block, skipping multi-line heredoc, have \$1 = '$1'\n";
                    $module_file_line = <$MODULE_FILE>;
                    if ( not defined $module_file_line ) {
                        croak
                            "End of file '$module_file_long' reached without finding '$1' end of multi-line heredoc string, croaking";
                    }
                    while ( $module_file_line !~ /^$1/xms ) {
                        $module_file_line = <$MODULE_FILE>;
                        if ( not defined $module_file_line ) {
                            croak
                                "End of file '$module_file_long' reached without finding '$1' end of multi-line heredoc string, croaking";
                        }
                    }
                    next;
                }

                # skip __DATA__ footer
                if ( $module_file_line eq '__DATA__' ) {
                    if ($inside_subroutine) {
                        RPerl::diag(
                            'in Class.pm INIT block, skipping __DATA__ footer while inside subroutine '
                                . $subroutine_name
                                . '(), aborting RPerl activation of entire file'
                                . "\n" );
                    }

#                    else { RPerl::diag 'in Class.pm INIT block, skipping __DATA__ footer' . "\n"; }
                    last;
                }

                # skip __END__ footer
                if ( $module_file_line eq '__END__' ) {
                    if ($inside_subroutine) {
                        RPerl::diag(
                            'in Class.pm INIT block, skipping __END__ footer while inside subroutine '
                                . $subroutine_name
                                . '(), aborting RPerl activation of entire file'
                                . "\n" );
                    }

#                    else { RPerl::diag 'in Class.pm INIT block, skipping __END__ footer' . "\n"; }
                    last;
                }

                # create accessor/mutator methods for each class
                if ( $module_file_line
                    =~ /^\s*package\s+(\w+(::\w+)*)\;.*$/xms )
                {
                    $package_name = $1;

                    if ($inside_subroutine) {
                        RPerl::diag(
                            'in Class.pm INIT block, have $package name = '
                                . $package_name
                                . 'while inside subroutine '
                                . $subroutine_name
                                . '(), aborting RPerl activation of entire file'
                                . "\n" );
                        last;
                    }

#                    else { RPerl::diag 'in Class.pm INIT block, have $package name = ' . $package_name . "\n"; }

                    %class_properties = eval "\%$package_name\:\:properties";

                    foreach my $class_property_name (
                        sort keys %class_properties )
                    {
#						RPerl::diag "in Class.pm INIT block, have \$class_property_name = '$class_property_name'\n";
# DEV NOTE, CORRELATION #03: avoid re-defining class accessor/mutator methods; so far only triggered by RPerl::CodeBlock::Subroutine
# becuase it has a special BEGIN{} block with multiple package names including it's own package name
#                        if (not eval "defined *\{$package_name\:\:get_$class_property_name\}" )
                        if (not eval(
                                      'defined *{'
                                    . $package_name
                                    . '::get_'
                                    . $class_property_name . '}'
                            )
                            )
                        {
#                            eval "\*\{$package_name\:\:get_$class_property_name\} \= sub \{ return \$\_\[0\]\-\>\{$class_property_name\}\; \}\;"
                            eval(     '*{'
                                    . $package_name
                                    . '::get_'
                                    . $class_property_name
                                    . '} = sub { return $_[0]->{'
                                    . $class_property_name
                                    . '}; };' )
                                or croak( $OS_ERROR . "\n" . $EVAL_ERROR );
                            if ($EVAL_ERROR) { croak($EVAL_ERROR); }

#eval "\*\{$package_name\:\:get_$class_property_name\} \= sub \{ RPerl::diag \"IN POST\-INIT\, accessor MODE $package_name\:\:get_$class_property_name\\n\"\; return \$\_\[0\]\-\>\{$class_property_name\}\; \}\;";
                        }

#                        if (not eval "defined *\{$package_name\:\:set_$class_property_name\}" )
                        if (not eval(
                                      'defined *{'
                                    . $package_name
                                    . '::set_'
                                    . $class_property_name . '}'
                            )
                            )
                        {
#                            eval "\*\{$package_name\:\:set_$class_property_name\} \= sub \{ \$\_\[0\]\-\>\{$class_property_name\} \= \$\_\[1\]\; return \$\_\[0\]\-\>\{$class_property_name\}\; \}\;"
                            eval(     '*{'
                                    . $package_name
                                    . '::set_'
                                    . $class_property_name
                                    . '} = sub { $_[0]->{'
                                    . $class_property_name
                                    . '} = $_[1]; return $_[0]->{'
                                    . $class_property_name
                                    . '}; };' )
                                or croak( $OS_ERROR . "\n" . $EVAL_ERROR );
                            if ($EVAL_ERROR) { croak($EVAL_ERROR); }

#eval "\*\{$package_name\:\:set_$class_property_name\} \= sub \{ RPerl::diag \"IN POST\-INIT\, mutator MODE $package_name\:\:set_$class_property_name\\n\"\; \$\_\[0\]\-\>\{$class_property_name\} \= \$\_\[1\]\; return \$\_\[0\]\-\>\{$class_property_name\}\; \}\;";
                        }
                    }
                    next;
                }

# create symbol table entries for methods and plain-old non-method subroutines
                if ( $module_file_line
                    =~ /^\s*our\s+(\w+)\s+\$(\w+)\s+\=\s+sub\s+\{/xms )
                {
                    if ($inside_subroutine) {
                        RPerl::diag(
                            q{in Class.pm INIT block, have $subroutine_type = }
                                . $1
                                . q{, and $subroutine_name = }
                                . $2
                                . '() while inside subroutine '
                                . $subroutine_name
                                . '(), aborting RPerl activation of entire file'
                                . "\n" );
                        last;
                    }
                    else {
                        $subroutine_type = $1;
                        $subroutine_name = $2;
#                        RPerl::diag( q{in Class.pm INIT block, have $subroutine_type = } . $subroutine_type . q{, and $subroutine_name = } . $subroutine_name . "()\n" );
#                        RPerl::diag( q{in Class.pm INIT block, have $CHECK = '} . $CHECK . "'\n" );
                    }

                    if ( $CHECK eq 'OFF' ) {
                        activate_subroutine($package_name, $subroutine_name, $subroutine_type, q{});
                    }
                    elsif ( ( $CHECK ne 'ON' ) and ( $CHECK ne 'TRACE' ) ) {
                        croak(    'Received invalid value '
                                . $CHECK
                                . ' for RPerl preprocessor directive CHECK to control data type checking, valid values are OFF, ON, and TRACE, croaking'
                        );
                    }
                    else {
                        $inside_subroutine = 1;
                    }
                    next;
                }

                if ($inside_subroutine) {
#                    RPerl::diag( q{in Class.pm INIT block, have $inside_subroutine = 1} . "\n" );
                    $subroutine_arguments_line .= $module_file_line;
                    if ( $subroutine_arguments_line =~ /\@\_\;/xms ) { # @_; found
                        if (not( $subroutine_arguments_line =~ /\@\_\;$/xms )
                            )
                        {    # @_; found not at end-of-line
                            RPerl::diag(
                                q{in Class.pm INIT block, found @_; NOT at end-of-line while inside subroutine }
                                    . $subroutine_name
                                    . '(), have $subroutine_arguments_line = '
                                    . "\n"
                                    . $subroutine_arguments_line . "\n\n"
                                    . 'aborting RPerl activation of entire file'
                                    . "\n" );
                            last;
                        }

#                        RPerl::diag( q{in Class.pm INIT block, found @_; at end-of-line while inside subroutine } . $subroutine_name . '(), have $subroutine_arguments_line = ' . "\n" . $subroutine_arguments_line . "\n" );

                        my $subroutine_arguments = [];    # string__array_ref__array_ref

                        # loop once per subroutine argument
                        while ( $subroutine_arguments_line
                            =~ m/my\s+(\w+)\s+\$(\w+)/g )
                        {
                            push @{$subroutine_arguments}, [$1, $2];
#                            RPerl::diag( q{in Class.pm INIT block, have subroutine argument type = } . $1 . q{ and subroutine argument name = } . $2 . "\n" );
                        }

#                        RPerl::diag( q{in Class.pm INIT block, have $subroutine_arguments = } . "\n" . Dumper($subroutine_arguments) . "\n" );

                        my $subroutine_arguments_check_code = "\n";    # string

                        if ( $CHECK eq 'ON' ) {
#                            RPerl::diag( 'in Class.pm INIT block, CHECK IS ON' . "\n" );
                            my $i = 0;  # integer
                            foreach my $subroutine_argument ( @{$subroutine_arguments} )
                            {
                                $subroutine_arguments_check_code
                                    .= q{    } . '::'
                                    . $subroutine_argument->[0]
                                    . '__CHECK( $_['
                                    . $i
                                    . '] );'
                                    . "\n";
                                $i++;
                            }
                            activate_subroutine($package_name, $subroutine_name, $subroutine_type, $subroutine_arguments_check_code);
                            $inside_subroutine         = 0;
                            $subroutine_arguments_line = q{};
                        }
                        elsif ( $CHECK eq 'TRACE' ) {
#                            RPerl::diag( 'in Class.pm INIT block, CHECK IS TRACE' . "\n" );
                            my $i = 0;  # integer
                            foreach my $subroutine_argument ( @{$subroutine_arguments} )
                            {
                                $subroutine_arguments_check_code
                                    .= q{    } . '::'
                                    . $subroutine_argument->[0]
                                    . '__CHECKTRACE( $_['
                                    . $i
                                    . q{], '$}
                                    . $subroutine_argument->[1] . q{', '}
                                    . $subroutine_name
                                    . q{()' );} . "\n";
                                $i++;
                            }
                            activate_subroutine($package_name, $subroutine_name, $subroutine_type, $subroutine_arguments_check_code);
                            $inside_subroutine         = 0;
                            $subroutine_arguments_line = q{};
                        }
                        else {
                            croak(    'Received invalid value '
                                    . $CHECK
                                    . ' for RPerl preprocessor directive CHECK to control data type checking, valid values are OFF, ON, and TRACE, croaking'
                            );
                        }
#                        RPerl::diag( 'in Class.pm INIT block, have $subroutine_arguments_check_code =' . "\n" . $subroutine_arguments_check_code . "\n" );
                        next;
                    }
                }
            }
            close $MODULE_FILE or croak $OS_ERROR;
        }
    }
}

# create Perl symbol table entries for RPerl subroutines and methods
sub activate_subroutine {
    ( my $package_name, my $subroutine_name, my $subroutine_type, my $subroutine_arguments_check_code ) = @_;
    my $subroutine_definition_code;    # string
    my $subroutine_definition_diag_code = q{};    # string
    if ( $subroutine_type =~ /\_\_method$/xms ) {

#        $subroutine_definition_diag_code = "\n" . q{RPerl::diag "IN POST-INIT, method direct call MODE } . $package_name . '::' . $subroutine_name . q{\n"; } . "\n";
#        RPerl::diag("in Class::activate_subroutine(), $subroutine_name is a method\n");
# NEED UPGRADE: is it possible to activate non-type-checked RPerl subroutines & methods w/out creating new subroutines?
        $subroutine_definition_code
            = '*{'
            . $package_name . '::'
            . $subroutine_name
            . '} = sub { '
            . $subroutine_definition_diag_code
            . $subroutine_arguments_check_code
            . 'return &${'
            . $package_name . '::'
            . $subroutine_name
            . '}(@_); };';
#        if ($subroutine_arguments_check_code ne q{}) { RPerl::diag('in Class::activate_subroutine(), have method $subroutine_definition_code =' . "\n" . $subroutine_definition_code . "\n"); }
        eval($subroutine_definition_code)
            or croak( $OS_ERROR . "\n" . $EVAL_ERROR );
        if ($EVAL_ERROR) { croak($EVAL_ERROR); }
    }
    else {
#		 RPerl::diag("in Class::activate_subroutine(), $subroutine_name is a non-method subroutine\n");
        if ( eval( 'defined(&main::' . $subroutine_name . ')' ) ) {
            croak
                "Attempt by package '$package_name' to re-define shared global subroutine '$subroutine_name', please re-name your subroutine or make it a method, dying";
        }

# DEV NOTE: must load into both main:: and $package_name:: namespaces,
# in order to call subroutines w/out class prefix from within class file (package) itself, and not to use AUTOLOAD
#        $subroutine_definition_diag_code = "\n" . q{RPerl::diag "IN POST-INIT, subroutine direct call MODE main::} . $subroutine_name . q{\n"; } . "\n";
        $subroutine_definition_code
            = '*{main::'
            . $subroutine_name
            . '} = sub { '
            . $subroutine_definition_diag_code
            . $subroutine_arguments_check_code
            . 'return &${'
            . $package_name . '::'
            . $subroutine_name
            . '}(@_); };';
#        if ($subroutine_arguments_check_code ne q{}) { RPerl::diag('in Class::activate_subroutine(), have subroutine main:: $subroutine_definition_code =' . "\n" . $subroutine_definition_code . "\n"); }
        eval($subroutine_definition_code)
            or croak( $OS_ERROR . "\n" . $EVAL_ERROR );
        if ($EVAL_ERROR) { croak($EVAL_ERROR); }

#        $subroutine_definition_diag_code = "\n" . {RPerl::diag "IN POST-INIT, subroutine direct call MODE } . $package_name . '::' . $subroutine_name . q{\n"; } . "\n";
        $subroutine_definition_code
            = '*{'
            . $package_name . '::'
            . $subroutine_name
            . '} = sub {'
            . $subroutine_definition_diag_code
            . $subroutine_arguments_check_code
            . 'return &${'
            . $package_name . '::'
            . $subroutine_name
            . '}(@_); };';
#        if ($subroutine_arguments_check_code ne q{}) { RPerl::diag('in Class::activate_subroutine(), have subroutine package:: $subroutine_definition_code =' . "\n" . $subroutine_definition_code . "\n"); }
        eval($subroutine_definition_code)
            or croak( $OS_ERROR . "\n" . $EVAL_ERROR );
        if ($EVAL_ERROR) { croak($EVAL_ERROR); }
    }
}

# RPerl object constructor, shorthand
sub new {
    no strict;
    return bless { %{ $_[0] . '::properties' } }, $_[0];
}

# suppress deprecated feature warning
local $SIG{__WARN__} = sub {
    return if $_[0] =~ /^Use of inherited AUTOLOAD for non-method /xms;
    carp @_;
};

sub DESTROY { }

1;

__END__

# RPerl function/method autoloader, longhand; allows syntax for typed functions/methods and automates get/set accessors/mutators for object properties;
# creates real subroutines to avoid AUTOLOADing any function/method more than once, performs operation inside AUTOLOAD that one time
# now fully deprecated in favor of INIT block above
our $AUTOLOAD;
sub AUTOLOAD
{
	RPerl::diag "IN AUTOLOAD, top of subroutine, received \$AUTOLOAD = '$AUTOLOAD', and \@_ =\n" . Dumper(\@_) . "\n";
	no strict;
	my $retval;

	# DISABLE RUNTIME ACCESSOR/MUTATOR BEHAVIOR
#	if ($AUTOLOAD =~ /^([\w+::]*)(get|set)_(\w+)$/)
	if (0)
	{
		RPerl::diag "IN AUTOLOAD, accessor/mutator MODE, have \$1 = '$1', \$2 = '$2', \$3 = '$3'\n";
		if ($2 eq 'get')	
		{
			RPerl::diag "IN AUTOLOAD, accessor MODE\n";
#			eval "\*\{$AUTOLOAD\} \= sub \{ return \$\_\[0\]\-\>\{$3\}\; \}\;";
			eval "\*\{$AUTOLOAD\} \= sub \{ RPerl::diag \"IN POST\-AUTOLOAD\, accessor MODE $AUTOLOAD\\n\"\; return \$\_\[0\]\-\>\{$3\}\; \}\;";
			$retval = $_[0]->{$3};
		}
		else  # ($2 eq 'set')
		{
			RPerl::diag "IN AUTOLOAD, mutator MODE\n";
#			eval "\*\{$AUTOLOAD\} \= sub \{ \$\_\[0\]\-\>\{$3\} \= \$\_\[1\]\; return \$\_\[0\]\-\>\{$3\}\; \}\;";
			eval "\*\{$AUTOLOAD\} \= sub \{ RPerl::diag \"IN POST\-AUTOLOAD\, mutator MODE $AUTOLOAD\\n\"\; \$\_\[0\]\-\>\{$3\} \= \$\_\[1\]\; return \$\_\[0\]\-\>\{$3\}\; \}\;";
			$_[0]->{$3} = $_[1];
			$retval = $_[0]->{$3};
		}
	}
	else
	{
		RPerl::diag "IN AUTOLOAD, direct call MODE\n";
		# disable creating symtab entries here to avoid redefining subroutines in INIT block above;
		# still need direct call mode here in case we want to call an RPerl function/method before the INIT block executes,
		# such as when an RPerl class calls one of it's own functions/methods during compile time
#		eval "\*\{$AUTOLOAD\} \= sub \{ return \&\$\{$AUTOLOAD\}\(\@\_\)\; \}\;";  # NEED UPGRADE: how can I do this w/out a subroutine?
#		eval "\*\{$AUTOLOAD\} \= sub \{ RPerl::diag \"IN POST\-AUTOLOAD\, direct call MODE $AUTOLOAD\\n\"\; return \&\$\{$AUTOLOAD\}\(\@\_\)\; \}\;";  # NEED UPGRADE: how can I do this w/out a subroutine?
		if (defined(${$AUTOLOAD})) { $retval = &${$AUTOLOAD}(@_); }
		else { die "Attempt to AUTOLOAD undefined subroutine '$AUTOLOAD', dying"; }
	}
=SNIP
	# is there any reason to encapsulate calls in an eval() to trap their errors???
	else
	{
		my $eval_string = '&$' . $AUTOLOAD . '(@_);';
		RPerl::diag "IN AUTOLOAD, eval call MODE, have \$eval_string = '$eval_string'\n";
		$retval = eval $eval_string;
	}
=cut

	croak $EVAL_ERROR if ($EVAL_ERROR);  # suppress '...propagated at RPerl/Class.pm' appended exception	
#	croak if ($EVAL_ERROR);  # allow '...propagated at RPerl/Class.pm' appended exception	

#	RPerl::diag "IN AUTOLOAD, bottom of subroutine, about to return \$retval = '$retval'\n";
	return $retval;
}

# RPerl object constructor, longhand
#sub new($class_name_const_str)
sub new_longhand
{
	(my $class_name_const_str) = @_;
RPerl::diag "in Class.pm, have \$class_name_const_str = '$class_name_const_str'\n";
	my $properties_name_const_str = $class_name_const_str . '::properties';
RPerl::diag "in Class.pm, have \$properties_name_const_str = '$properties_name_const_str'\n";
	my %properties = %{$properties_name_const_str};
RPerl::diag "in Class.pm, have \%properties =\n" . Dumper(\%properties) . "\n";
#	my $new_obj = bless({%{$class_name_const_str . '::properties'}}, $class_name_const_str);
	my $new_obj = bless({%properties}, $class_name_const_str);
RPerl::diag "in Class.pm, have \$new_obj =\n" . Dumper($new_obj) . "\n";
	return $new_obj;
}
