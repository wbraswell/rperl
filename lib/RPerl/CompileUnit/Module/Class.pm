# [[[ HEADER ]]]
package RPerl::CompileUnit::Module::Class;
use strict;
use warnings;
use RPerl::Config;    # get Dumper, Carp, English without 'use RPerl;'
our $VERSION = 0.020_030;

# [[[ OO INHERITANCE ]]]
# BASE CLASS HAS NO INHERITANCE

# [[[ CRITICS ]]]
## no critic qw(ProhibitStringyEval) # SYSTEM DEFAULT 1: allow eval()
## no critic qw(ProhibitAutoloading RequireArgUnpacking)  # SYSTEM SPECIAL 2: allow Autoload & read-only @_
## no critic qw(ProhibitExcessComplexity)  # SYSTEM SPECIAL 5: allow complex code inside subroutines, must be after line 1
## no critic qw(ProhibitDeepNests)  # SYSTEM SPECIAL 7: allow deeply-nested code
## no critic qw(ProhibitNoStrict)  # SYSTEM SPECIAL 8: allow no strict
## no critic qw(RequireBriefOpen)  # SYSTEM SPECIAL 9: allow complex processing with open filehandle

# [[[ INCLUDES ]]]
use File::Basename;

# [[[ OO PROPERTIES ]]]
# BASE CLASS HAS NO PROPERTIES

# [[[ OO METHODS & SUBROUTINES ]]]

# RPerl object constructor, shorthand
sub new {
    no strict;
    if (not defined ${ $_[0] . '::properties' }) {
        croak 'ERROR ECVOOCO00, SOURCE CODE, OO OBJECT CONSTRUCTOR: Undefined hashref $properties for class ' . $_[0] . ', croaking' . "\n";
    }
    return bless { %{ ${ $_[0] . '::properties' } } }, $_[0];
}

# RPerl object destructor
# NEED ADDRESS: do we ever need to actually deconstruct anything to free resources?
sub DESTROY { }

# [[[ SUBROUTINES ]]]

# suppress deprecated feature warning
local $SIG{__WARN__} = sub {
    return if $_[0] =~ /^Use of inherited AUTOLOAD for non-method /xms;
    carp @_;
};

# after compiling but before runtime: create symtab entries for all RPerl functions/methods, and accessors/mutators for all RPerl class properties
INIT {
#    $RPerl::DEBUG                   = 1;
#    $RPerl::VERBOSE                 = 1;

    # add calling .pl driver to INC for subroutine activation;
    # DEV NOTE: should be safe to use basename() here instead of fileparse(), because $PROGRAM_NAME should never end in a directory
    $INC{ basename($PROGRAM_NAME) } = $PROGRAM_NAME;

#	RPerl::diag("in Class.pm INIT block, have \%INC =\n" . Dumper(\%INC) . "\n");

    my $module_file_long;               # string
    my $package_name;                   # string
    my $package_name_underscores;       # string
    my $object_properties;              # hashref
    my $subroutine_type;                # string
    my $subroutine_name;                # string
    my $CHECK;                          # string
    my $inside_subroutine;              # bool
    my $inside_subroutine_arguments;    # bool
    my $subroutine_arguments_line;      # string

#	RPerl::diag(q{in Class.pm INIT block, have $PROGRAM_NAME = '} . $PROGRAM_NAME . "'\n");

    foreach my $module_file_short ( sort keys %INC ) {
        $package_name = q{};
        $CHECK = $RPerl::CHECK; # reset data type checking to RPerl default for every file
        $inside_subroutine           = 0;
        $inside_subroutine_arguments = 0;
        $subroutine_arguments_line   = q{};

# DEV NOTE: for now, only scan for RPerl subroutines in files or dirs that start with RPerl or rperl
        if (   ( $module_file_short =~ /^RPerl/xms )
            || ( $module_file_short =~ /^rperl/xms )
            || ( $module_file_short =~ /\.pl$/xms ) )
        {
#			RPerl::diag("in Class.pm INIT block, have \$module_file_short = '$module_file_short'\n");
            $module_file_long = $INC{$module_file_short};

#            RPerl::diag("in Class.pm INIT block, have \$module_file_long = '$module_file_long'\n");

            open my $MODULE_FILE, '<', $module_file_long or croak $OS_ERROR;
            while ( my $module_file_line = <$MODULE_FILE> ) {
                chomp $module_file_line;

#				RPerl::diag("in Class.pm INIT block, have \$module_file_line =\n$module_file_line\n");

                # set data type checking mode
                if ( $module_file_line
                    =~ /^\s*\#\s*\<\<\<\s*TYPE_CHECKING\s*\:\s*(\w+)\s*\>\>\>/xms
                    )
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

#					RPerl::diag("in Class.pm INIT block, skipping multi-line POD comment, have \$1 = '$1'\n");
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
#					RPerl::diag("in Class.pm INIT block, skipping multi-line heredoc, have \$1 = '$1'\n");
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

#                    else { RPerl::diag('in Class.pm INIT block, skipping __DATA__ footer' . "\n"); }
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

#                    else { RPerl::diag('in Class.pm INIT block, skipping __END__ footer' . "\n"); }
                    last;
                }

# create ops/types reporting subroutine & accessor/mutator object methods for each package
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

#                    else { RPerl::diag('in Class.pm INIT block, have $package name = ' . $package_name . "\n"); }

                    # ops/types reporting subroutine

                    $package_name_underscores = $package_name;
                    $package_name_underscores =~ s/::/__/g;

                    if (not eval(
                                  'defined &main::'
                                . $package_name_underscores
                                . '__MODE_ID'
                        )
                        )
                    {
                        eval(     '*main::'
                                . $package_name_underscores
                                . '__MODE_ID = sub { return 0; };' ) # PERLOPS_PERLTYPES is 0

#                        eval(     'sub main::' . $package_name_underscores . '__MODE_ID { return 0; }' ) # equivalent to previous line
                            or croak($EVAL_ERROR);
                        if ($EVAL_ERROR) { croak($EVAL_ERROR); }
                    }

                    # accessor/mutator object methods
                    $object_properties = eval "\$$package_name\:\:properties";

                    foreach my $object_property_name (
                        sort keys %{$object_properties} )
                    {
#						RPerl::diag("in Class.pm INIT block, have \$object_property_name = '$object_property_name'\n");
# DEV NOTE, CORRELATION #03: avoid re-defining class accessor/mutator methods; so far only triggered by RPerl::CodeBlock::Subroutine
# because it has a special BEGIN{} block with multiple package names including it's own package name
                        if (not eval(
                                      'defined &'
                                    . $package_name
                                    . '::get_'
                                    . $object_property_name
                            )
                            )
                        {
#                            eval "\*\{$package_name\:\:get_$object_property_name\} \= sub \{ return \$\_\[0\]\-\>\{$object_property_name\}\; \}\;"
                            eval(     '*{'
                                    . $package_name
                                    . '::get_'
                                    . $object_property_name
                                    . '} = sub { return $_[0]->{'
                                    . $object_property_name
                                    . '}; };' )
                                or croak($EVAL_ERROR);
                            if ($EVAL_ERROR) { croak($EVAL_ERROR); }

#eval "\*\{$package_name\:\:get_$object_property_name\} \= sub \{ RPerl::diag(\"IN POST\-INIT\, accessor MODE $package_name\:\:get_$object_property_name\\n\"\; return \$\_\[0\]\-\>\{$object_property_name\}\; \}\;";
                        }

                        if (not eval(
                                      'defined &'
                                    . $package_name
                                    . '::set_'
                                    . $object_property_name
                            )
                            )
                        {
#                            eval "\*\{$package_name\:\:set_$object_property_name\} \= sub \{ \$\_\[0\]\-\>\{$object_property_name\} \= \$\_\[1\]\; return \$\_\[0\]\-\>\{$object_property_name\}\; \}\;"
                            eval(     '*{'
                                    . $package_name
                                    . '::set_'
                                    . $object_property_name
                                    . '} = sub { $_[0]->{'
                                    . $object_property_name
                                    . '} = $_[1]; return $_[0]->{'
                                    . $object_property_name
                                    . '}; };' )
                                or croak($EVAL_ERROR);
                            if ($EVAL_ERROR) { croak($EVAL_ERROR); }

#eval "\*\{$package_name\:\:set_$object_property_name\} \= sub \{ RPerl::diag(\"IN POST\-INIT\, mutator MODE $package_name\:\:set_$object_property_name\\n\"\; \$\_\[0\]\-\>\{$object_property_name\} \= \$\_\[1\]\; return \$\_\[0\]\-\>\{$object_property_name\}\; \}\;";
                        }
                    }
                    next;
                }

# create symbol table entries for methods and plain-old non-method subroutines
                if ( $module_file_line
                    =~ /^\s*our\s+(\w+)\s+\$(\w+)\s+\=\s+sub\s+\{/xms )
                {
                    if ($inside_subroutine_arguments) {
                        RPerl::diag( q{in Class.pm INIT block, have $subroutine_type = } . $1 . q{, and $subroutine_name = } . $2 . '() while inside arguments of subroutine ' . $subroutine_name . '(), aborting RPerl activation of entire file' . "\n" );
                        last;    # last line of file
                    }
 
                    # activate previous subroutine, no arguments
                    if ($inside_subroutine) {
                        activate_subroutine( $package_name, $subroutine_name, $subroutine_type, q{} );
                    }

                    $subroutine_type = $1;
                    $subroutine_name = $2;

#                    RPerl::diag( q{in Class.pm INIT block, have $subroutine_type = } . $subroutine_type . q{, and $subroutine_name = } . $subroutine_name . "()\n" );
#                    RPerl::diag( q{in Class.pm INIT block, have $CHECK = '} . $CHECK . "'\n" );

                    if ( $CHECK eq 'OFF' ) {
                        activate_subroutine( $package_name, $subroutine_name, $subroutine_type, q{} );
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
#                    RPerl::diag("in Class.pm INIT block, have \$module_file_line =\n$module_file_line\n");
                    if ( $module_file_line =~ /^\s*\(\s*my/xms ) {
                        $inside_subroutine_arguments = 1;
                    }
#                    RPerl::diag( q{in Class.pm INIT block, have $inside_subroutine_arguments = }, $inside_subroutine_arguments, "\n" );
                    if ($inside_subroutine_arguments) {
                        $subroutine_arguments_line .= $module_file_line;
                        if ( $subroutine_arguments_line =~ /\@\_\;/xms ) { # @_; found
                            if (not( $subroutine_arguments_line
                                    =~ /\@\_\;$/xms )
                                )
                            {    # @_; found not at end-of-line
                                RPerl::diag( q{in Class.pm INIT block, found @_; NOT at end-of-line while inside subroutine } . $subroutine_name . '(), have $subroutine_arguments_line = ' . "\n" . $subroutine_arguments_line . "\n\n" . 'aborting RPerl activation of entire file' . "\n" );
                                last;
                            }

#                            RPerl::diag( q{in Class.pm INIT block, found @_; at end-of-line while inside subroutine } . $subroutine_name . '(), have $subroutine_arguments_line = ' . "\n" . $subroutine_arguments_line . "\n" );

                            my $subroutine_arguments = []; # string_arrayref_arrayref

                            # loop once per subroutine argument
                            while ( $subroutine_arguments_line
                                =~ m/my\s+(\w+)\s+\$(\w+)/g )
                            {
                                push @{$subroutine_arguments}, [ $1, $2 ];

#                                RPerl::diag( q{in Class.pm INIT block, have subroutine argument type = } . $1 . q{ and subroutine argument name = } . $2 . "\n" );
                            }

#                            RPerl::diag( q{in Class.pm INIT block, have $subroutine_arguments = } . "\n" . Dumper($subroutine_arguments) . "\n" );

                            my $subroutine_arguments_check_code = "\n"; # string

                            if ( $CHECK eq 'ON' ) {

#                            RPerl::diag( 'in Class.pm INIT block, CHECK IS ON' . "\n" );
                                my $i = 0;    # integer
                                foreach my $subroutine_argument (
                                    @{$subroutine_arguments} )
                                {
                                    $subroutine_arguments_check_code
                                        .= q{    } . '::'
                                        . $subroutine_argument->[0]
                                        . '_CHECK( $_['
                                        . $i . '] );' . "\n";
                                    $i++;
                                }
                                activate_subroutine(
                                    $package_name,
                                    $subroutine_name,
                                    $subroutine_type,
                                    $subroutine_arguments_check_code
                                );
                                $inside_subroutine         = 0;
                                $subroutine_arguments_line = q{};
                            }
                            elsif ( $CHECK eq 'TRACE' ) {

#                                RPerl::diag( 'in Class.pm INIT block, CHECK IS TRACE' . "\n" );
                                my $i = 0;    # integer
                                foreach my $subroutine_argument (
                                    @{$subroutine_arguments} )
                                {
                                    $subroutine_arguments_check_code
                                        .= q{    } . '::'
                                        . $subroutine_argument->[0]
                                        . '_CHECKTRACE( $_['
                                        . $i
                                        . q{], '$}
                                        . $subroutine_argument->[1] . q{', '}
                                        . $subroutine_name
                                        . q{()' );} . "\n";
                                    $i++;
                                }
                                activate_subroutine(
                                    $package_name,
                                    $subroutine_name,
                                    $subroutine_type,
                                    $subroutine_arguments_check_code
                                );
                                $inside_subroutine         = 0;
                                $subroutine_arguments_line = q{};
                            }
                            else {
                                croak(    'Received invalid value '
                                        . $CHECK
                                        . ' for RPerl preprocessor directive CHECK to control data type checking, valid values are OFF, ON, and TRACE, croaking'
                                );
                            }
                            $inside_subroutine_arguments = 0;
                        }

#                        RPerl::diag( 'in Class.pm INIT block, have $subroutine_arguments_check_code =' . "\n" . $subroutine_arguments_check_code . "\n" );
                        next;    # next file line
                    }
                }
            }

            # activate final subroutine in file, no arguments
            if ($inside_subroutine) {
                if ($inside_subroutine_arguments) {
                    croak(
                        'Did not find @_ to end subroutine arguments before end of file, croaking'
                    );
                }
#                RPerl::diag( 'in Class.pm INIT block, activating final subroutine in file, no subroutine arguments found' . "\n" );
                activate_subroutine( $package_name, $subroutine_name,
                    $subroutine_type, q{} );
                $inside_subroutine = 0;
            }
            close $MODULE_FILE or croak $OS_ERROR;
        }
    }
}

# create Perl symbol table entries for RPerl subroutines and methods
sub activate_subroutine {
    (   my $package_name,
        my $subroutine_name,
        my $subroutine_type,
        my $subroutine_arguments_check_code
    ) = @_;
#    RPerl::diag("in Class::activate_subroutine(), top of subroutine\n");
    my $package_name_tmp;              # string
    my $subroutine_definition_code;    # string
    my $subroutine_definition_diag_code = q{};    # string
    if ( $subroutine_type =~ /\_method$/xms ) {
        if ( $package_name eq '' ) {
            croak( 'Received no package name for method ',
                $subroutine_name, ', croaking' );
        }

#        $subroutine_definition_diag_code = "\n" . q{RPerl::diag("IN POST-INIT, method direct call MODE } . $package_name . '::' . $subroutine_name . q{\n"); } . "\n";
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
            or croak($EVAL_ERROR);
        if ($EVAL_ERROR) { croak($EVAL_ERROR); }
    }
    else {
#        RPerl::diag( "in Class::activate_subroutine(), $subroutine_name is a non-method subroutine\n" );
        if ( eval( 'defined(&main::' . $subroutine_name . ')' ) ) {
            croak
                "ERROR ECVPR00, Pre-Processor: Attempt by package '$package_name' to re-define shared global subroutine '$subroutine_name', please re-name your subroutine or make it a method, croaking";
        }

# DEV NOTE: must load into both main:: and $package_name:: namespaces,
# in order to call subroutines w/out class prefix from within class file (package) itself, and not to use AUTOLOAD
        if   ( $package_name eq '' ) { $package_name_tmp = 'main'; }
        else                         { $package_name_tmp = $package_name; }

#        $subroutine_definition_diag_code = "\n" . q{RPerl::diag("IN POST-INIT, subroutine direct call MODE main::} . $subroutine_name . q{\n"; } . "\n");
        $subroutine_definition_code
            = '*{main::'
            . $subroutine_name
            . '} = sub { '
            . $subroutine_definition_diag_code
            . $subroutine_arguments_check_code
            . 'return &${'
            . $package_name_tmp . '::'
            . $subroutine_name
            . '}(@_); };';

#        if ($subroutine_arguments_check_code ne q{}) { RPerl::diag('in Class::activate_subroutine(), have subroutine main:: $subroutine_definition_code =' . "\n" . $subroutine_definition_code . "\n"); }
        eval($subroutine_definition_code)
            or croak($EVAL_ERROR);
        if ($EVAL_ERROR) { croak($EVAL_ERROR); }

        # no package name means 'main', handled above
        if ( $package_name ne '' ) {

#            $subroutine_definition_diag_code = "\n" . {RPerl::diag("IN POST-INIT, subroutine direct call MODE } . $package_name . '::' . $subroutine_name . q{\n"; } . "\n");
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

#            if ($subroutine_arguments_check_code ne q{}) { 
#                RPerl::diag('in Class::activate_subroutine(), have subroutine package:: $subroutine_definition_code =' . "\n" . $subroutine_definition_code . "\n"); 
#            }
            eval($subroutine_definition_code)
                or croak($EVAL_ERROR);
            if ($EVAL_ERROR) { croak($EVAL_ERROR); }
        }
    }
}

1;    # end of class

__END__

# RPerl function/method autoloader, longhand; allows syntax for typed functions/methods and automates get/set accessors/mutators for object properties;
# creates real subroutines to avoid AUTOLOADing any function/method more than once, performs operation inside AUTOLOAD that one time
# now fully deprecated in favor of INIT block above
our $AUTOLOAD;
sub AUTOLOAD
{
	RPerl::diag("IN AUTOLOAD, top of subroutine, received \$AUTOLOAD = '$AUTOLOAD', and \@_ =\n" . Dumper(\@_) . "\n");
	no strict;
	my $retval;

	# DISABLE RUNTIME ACCESSOR/MUTATOR BEHAVIOR
#	if ($AUTOLOAD =~ /^([\w+::]*)(get|set)_(\w+)$/)
	if (0)
	{
		RPerl::diag("IN AUTOLOAD, accessor/mutator MODE, have \$1 = '$1', \$2 = '$2', \$3 = '$3'\n");
		if ($2 eq 'get')	
		{
			RPerl::diag("IN AUTOLOAD, accessor MODE\n");
#			eval "\*\{$AUTOLOAD\} \= sub \{ return \$\_\[0\]\-\>\{$3\}\; \}\;";
			eval "\*\{$AUTOLOAD\} \= sub \{ RPerl::diag(\"IN POST\-AUTOLOAD\, accessor MODE $AUTOLOAD\\n\"\; return \$\_\[0\]\-\>\{$3\}\; \}\;";
			$retval = $_[0]->{$3};
		}
		else  # ($2 eq 'set')
		{
			RPerl::diag("IN AUTOLOAD, mutator MODE\n");
#			eval "\*\{$AUTOLOAD\} \= sub \{ \$\_\[0\]\-\>\{$3\} \= \$\_\[1\]\; return \$\_\[0\]\-\>\{$3\}\; \}\;";
			eval "\*\{$AUTOLOAD\} \= sub \{ RPerl::diag(\"IN POST\-AUTOLOAD\, mutator MODE $AUTOLOAD\\n\"\; \$\_\[0\]\-\>\{$3\} \= \$\_\[1\]\; return \$\_\[0\]\-\>\{$3\}\; \}\;";
			$_[0]->{$3} = $_[1];
			$retval = $_[0]->{$3};
		}
	}
	else
	{
		RPerl::diag("IN AUTOLOAD, direct call MODE\n");
		# disable creating symtab entries here to avoid redefining subroutines in INIT block above;
		# still need direct call mode here in case we want to call an RPerl function/method before the INIT block executes,
		# such as when an RPerl class calls one of it's own functions/methods during compile time
#		eval "\*\{$AUTOLOAD\} \= sub \{ return \&\$\{$AUTOLOAD\}\(\@\_\)\; \}\;";  # NEED UPGRADE: how can I do this w/out a subroutine?
#		eval "\*\{$AUTOLOAD\} \= sub \{ RPerl::diag(\"IN POST\-AUTOLOAD\, direct call MODE $AUTOLOAD\\n\"\; return \&\$\{$AUTOLOAD\}\(\@\_\)\; \}\;";  # NEED UPGRADE: how can I do this w/out a subroutine?
		if (defined(${$AUTOLOAD})) { $retval = &${$AUTOLOAD}(@_); }
		else { die "Attempt to AUTOLOAD undefined subroutine '$AUTOLOAD', dying"; }
	}
	# is there any reason to encapsulate calls in an eval() to trap their errors???
#	else
#	{
#		my $eval_string = '&$' . $AUTOLOAD . '(@_);';
#		RPerl::diag("IN AUTOLOAD, eval call MODE, have \$eval_string = '$eval_string'\n");
#		$retval = eval $eval_string;
#	}

	croak $EVAL_ERROR if ($EVAL_ERROR);  # suppress '...propagated at RPerl/Class.pm' appended exception	
#	croak if ($EVAL_ERROR);  # allow '...propagated at RPerl/Class.pm' appended exception	

#	RPerl::diag("IN AUTOLOAD, bottom of subroutine, about to return \$retval = '$retval'\n");
	return $retval;
}

# RPerl object constructor, longhand
# DEPRECATED still uses %properties hash instead of $properties hashref
#sub new($class_name_const_str)
sub new_longhand
{
	(my $class_name_const_str) = @_;
RPerl::diag("in Class.pm, have \$class_name_const_str = '$class_name_const_str'\n");
	my $properties_name_const_str = $class_name_const_str . '::properties';
RPerl::diag("in Class.pm, have \$properties_name_const_str = '$properties_name_const_str'\n");
	my %properties = %{$properties_name_const_str};
RPerl::diag("in Class.pm, have \%properties =\n" . Dumper(\%properties) . "\n");
#	my $new_obj = bless({%{$class_name_const_str . '::properties'}}, $class_name_const_str);
	my $new_obj = bless({%properties}, $class_name_const_str);
RPerl::diag("in Class.pm, have \$new_obj =\n" . Dumper($new_obj) . "\n");
	return $new_obj;
}
