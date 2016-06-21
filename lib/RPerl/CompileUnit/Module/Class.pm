# [[[ HEADER ]]]
package RPerl::CompileUnit::Module::Class;
use strict;
use warnings;
use RPerl::Config;    # get Dumper, Carp, English without 'use RPerl;'
our $VERSION = 0.036_000;

# [[[ OO INHERITANCE ]]]
# BASE CLASS HAS NO INHERITANCE

# [[[ CRITICS ]]]
## no critic qw(ProhibitStringyEval)  # SYSTEM DEFAULT 1: allow eval()
## no critic qw(ProhibitAutoloading RequireArgUnpacking)  # SYSTEM SPECIAL 2: allow Autoload & read-only @_
## no critic qw(ProhibitExcessComplexity)  # SYSTEM SPECIAL 5: allow complex code inside subroutines, must be after line 1
## no critic qw(ProhibitDeepNests)  # SYSTEM SPECIAL 7: allow deeply-nested code
## no critic qw(ProhibitNoStrict)  # SYSTEM SPECIAL 8: allow no strict
## no critic qw(RequireBriefOpen)  # SYSTEM SPECIAL 10: allow complex processing with open filehandle

# [[[ INCLUDES ]]]
use File::Basename;

# [[[ OO PROPERTIES ]]]
# BASE CLASS HAS NO PROPERTIES

# [[[ SUBROUTINES & OO METHODS ]]]

# RPerl object constructor, SHORT FORM
sub new {
    no strict;
    if ( not defined ${ $_[0] . '::properties' } ) {
        croak 'ERROR ECOOOCO00, SOURCE CODE, OO OBJECT CONSTRUCTOR: Undefined hashref $properties for class ' . $_[0] . ', croaking' . "\n";
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

#    RPerl::diag('in Class.pm INIT block, have %INC =' . "\n" . Dumper(\%INC) . "\n");
    #    RPerl::diag('in Class.pm INIT block, have $rperlnamespaces_generated::CORE =' . "\n" . Dumper($rperlnamespaces_generated::CORE) . "\n");

    my $module_filename_long;           # string
    my $use_rperl;                      # boolean
    my $inside_package;                 # boolean
    my $package_name;                   # string
    my $package_name_underscores;       # string
    my $namespace_root;                 # string
    my $object_properties;              # hashref
    my $object_properties_string;       # string
    my $object_properties_types;        # hashref
    my $inside_object_properties;       # boolean
    my $subroutine_type;                # string
    my $subroutine_name;                # string
    my $CHECK;                          # string
    my $inside_subroutine;              # boolean
    my $inside_subroutine_arguments;    # boolean
    my $subroutine_arguments_line;      # string

    #	RPerl::diag(q{in Class.pm INIT block, have $PROGRAM_NAME = '} . $PROGRAM_NAME . "'\n");

    foreach my $module_filename_short ( sort keys %INC ) {

        #        RPerl::diag("in Class.pm INIT block, have \$module_filename_short = '$module_filename_short'\n");

        # skip special entry created by Filter::Util::Call
        if ( $module_filename_short eq '-e' ) {
            next;
        }
        # skip absolute file names (such as Komodo's perl5db.pl) which came from a runtime `require $scalar` or `require 'foo.pm'`,
        # and we can not determine the correct package from the absolute path name, we don't know how to figure out which part was in @INC from the absolute path
        elsif ((not defined $module_filename_long ) or ( $module_filename_long eq $module_filename_short )) {
            next;
        }

        $module_filename_long = $INC{$module_filename_short};
        
        # skip already-compiled files with PMC counterparts
        if (-e ($module_filename_long . 'c')) {
            next;
        }

        $use_rperl                   = 0;
        $inside_package              = 0;
        $package_name                = q{};
        $CHECK                       = $RPerl::CHECK;    # reset data type checking to RPerl default for every file
        $object_properties_string    = q{};
        $object_properties_types     = {};
        $inside_object_properties    = 0;
        $inside_subroutine           = 0;
        $inside_subroutine_arguments = 0;
        $subroutine_arguments_line   = q{};

        $namespace_root = RPerl::filename_short_to_namespace_root_guess($module_filename_short);

        #	    RPerl::diag(q{in Class.pm INIT block, have $namespace_root = '} . $namespace_root . "'\n");

        # DEV NOTE: avoid error...
        # Name "rperlnamespaces_generated::RPERL_DEPS" used only once: possible typo
        my $tmp = $rperlnamespaces_generated::CORE;
        $tmp = $rperlnamespaces_generated::RPERL_DEPS;

        if (    ( not exists $rperlnamespaces_generated::CORE->{$namespace_root} )
            and ( not exists $rperlnamespaces_generated::RPERL_DEPS->{$namespace_root} ) )
        {
#            RPerl::diag( 'in Class.pm INIT block, not skipping due to CORE & RPERL_DEPS namespaces, $module_filename_long = ' . $module_filename_long . "\n" );

            open my $MODULE_FILE, '<', $module_filename_long or croak $OS_ERROR;
        MODULE_FILE_LINE_LOOP:
            while ( my $module_file_line = <$MODULE_FILE> ) {
                chomp $module_file_line;

                #				RPerl::diag('in Class.pm INIT block, have $module_file_line =' . "\n" . $module_file_line . "\n");

                # set data type checking mode
                if ( $module_file_line =~ /^\s*\#\s*\<\<\<\s*TYPE_CHECKING\s*\:\s*(\w+)\s*\>\>\>/xms ) {

                    #                    RPerl::diag( "in Class.pm INIT block, have \$module_filename_long = '$module_filename_long'\n" );
                    if ($inside_subroutine) {

#                        RPerl::diag( 'in Class.pm INIT block, found <<< TYPE_CHECKING: ' . $1 . ' >>> while inside subroutine ' . $subroutine_name . '(), aborting RPerl activation of entire file' . "\n" );
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
                        croak "End of file '$module_filename_long' reached without finding '=cut' end of multi-line POD comment '=$1', croaking";
                    }
                    while ( $module_file_line !~ /^\=cut/xms ) {
                        if ( not defined $module_file_line ) {
                            croak "End of file '$module_filename_long' reached without finding '=cut' end of multi-line POD comment '=$1', croaking";
                        }
                        $module_file_line = <$MODULE_FILE>;
                    }
                    next;
                }

                # skip multi-line heredocs
                if (   ( $module_file_line =~ /\=\s*\<\<\s*(\w+)\s*\;\s*$/xms )
                    or ( $module_file_line =~ /\=\s*\<\<\s*\'(\w+)\'\s*\;\s*$/xms )
                    or ( $module_file_line =~ /\=\s*\<\<\s*\"(\w+)\"\s*\;\s*$/xms ) )
                {
                    #					RPerl::diag("in Class.pm INIT block, skipping multi-line heredoc, have \$1 = '$1'\n");
                    $module_file_line = <$MODULE_FILE>;
                    if ( not defined $module_file_line ) {
                        croak "End of file '$module_filename_long' reached without finding '$1' end of multi-line heredoc string, croaking";
                    }
                    while ( $module_file_line !~ /^$1/xms ) {
                        $module_file_line = <$MODULE_FILE>;
                        if ( not defined $module_file_line ) {
                            croak "End of file '$module_filename_long' reached without finding '$1' end of multi-line heredoc string, croaking";
                        }
                    }
                    next;
                }

                # skip __DATA__ footer
                if ( $module_file_line eq '__DATA__' ) {
                    if ($inside_subroutine) {

#                        RPerl::diag( 'in Class.pm INIT block, skipping __DATA__ footer while inside subroutine ' . $subroutine_name . '(), aborting RPerl activation of entire file' . "\n" );
                    }

                    #                    else { RPerl::diag('in Class.pm INIT block, skipping __DATA__ footer' . "\n"); }
                    last;
                }

                # skip __END__ footer
                if ( $module_file_line eq '__END__' ) {
                    if ($inside_subroutine) {

#                        RPerl::diag( 'in Class.pm INIT block, skipping __END__ footer while inside subroutine ' . $subroutine_name . '(), aborting RPerl activation of entire file' . "\n" );
                    }

                    #                    else { RPerl::diag('in Class.pm INIT block, skipping __END__ footer' . "\n"); }
                    last;
                }

                #				RPerl::diag("in Class.pm INIT block, have \$module_file_line =\n$module_file_line\n");

                # create ops/types reporting subroutine & accessor/mutator object methods for each RPerl package

                # user-style RPerl header, anything that starts with 'use RPerl;'
                if ( $module_file_line =~ /^\s*(use\s+RPerl\s*;)/xms ) {

                    #    				RPerl::diag(q{in Class.pm INIT block, found '} . $1 . q{' in $module_filename_short = } . $module_filename_short . "\n");
                    $use_rperl = 1;
                    next;
                }

                # package declaration
                if ( $module_file_line =~ /^\s*package\s+/xms ) {

                    # object properties, save types from just-finished package
                    if ($inside_package) {
                        $object_properties_types = save_object_properties_types( $package_name, $object_properties_string, $object_properties_types );
                        $object_properties_string = q{};
                    }
                    $inside_package = 1;

                    # one-line package declaration, indexed by PAUSE unless listed in no_index in Makefile.PL
                    if ( $module_file_line =~ /^\s*package\s+(\w+(::\w+)*)\;.*$/xms ) {
                        $package_name = $1;

                   #                        RPerl::diag( 'in Class.pm INIT block, one-line package declaration, have $package name = ' . $package_name . "\n" );
                    }

                    # two-line package declaration, not indexed by PAUSE
                    elsif ( $module_file_line =~ /^\s*package\s*\#\s*hide.*$/xms ) {    # EX.    package  # hide from PAUSE indexing
                        $module_file_line = <$MODULE_FILE>;
                        chomp $module_file_line;
                        if ( $module_file_line =~ /^\s*(\w+(::\w+)*)\;.*$/xms ) {
                            $package_name = $1;

               #                            RPerl::diag( 'in Class.pm INIT block, two-line package declaration, have $package name = ' . $package_name . "\n" );
                        }
                        else {
                            croak q{Improperly formed two-line package declaration found in file '}
                                . $module_filename_long
                                . q{' near '}
                                . $module_file_line
                                . q{', croaking};
                        }
                    }
                    else {
                        croak q{Improperly formed package declaration found in file '}
                            . $module_filename_long
                            . q{' near '}
                            . $module_file_line
                            . q{', croaking};
                    }

                    if ($inside_subroutine) {

#                            RPerl::diag( 'in Class.pm INIT block, have $package name = ' . $package_name . 'while inside subroutine ' . $subroutine_name . '(), aborting RPerl activation of entire file' . "\n" );
                        last;
                    }

                    #                    else { RPerl::diag( 'in Class.pm INIT block, have $package name = ' . $package_name . "\n" ); }

                    # system-style RPerl header, 'use strict; use warnings; use RPerl::AfterSubclass;' on 3 lines
                    # don't check for $VERSION due to numerous un-versioned subtypes
                    if ( not $use_rperl ) {
                        foreach my $rperl_header_line ( 'use strict;', 'use warnings;', 'use RPerl::AfterSubclass;' ) {
                            $module_file_line = <$MODULE_FILE>;
                            chomp $module_file_line;
                            if ( $module_file_line !~ /\Q$rperl_header_line/xms ) {

#                    			RPerl::diag(q{in Class.pm INIT block, failed to find RPerl header line '} . $rperl_header_line . q{' for $module_filename_short = } . $module_filename_short . ', aborting RPerl activation of entire file' . "\n");
                                next MODULE_FILE_LINE_LOOP;
                            }
                        }

                #                        RPerl::diag('in Class.pm INIT block, found RPerl header in $module_filename_short = ' . $module_filename_short . "\n");
                        $use_rperl = 1;
                    }

    #                    RPerl::diag(q{in Class.pm INIT block, have $use_rperl, enabling package in $module_filename_short = } . $module_filename_short . "\n");

# ops/types reporting subroutine
# DEV NOTE, CORRELATION #rp18: RPerl::DataStructure::Array & Hash can not 'use RPerl;' so they are skipped in the header-checking loop above, their *__MODE_ID() subroutines are not created below
                    $package_name_underscores = $package_name;
                    $package_name_underscores =~ s/::/__/g;
                    if ( not eval( 'defined &main::' . $package_name_underscores . '__MODE_ID' ) ) {
                        eval( '*main::' . $package_name_underscores . '__MODE_ID = sub { return 0; };' )    # PERLOPS_PERLTYPES is 0

                         #                        eval(     'sub main::' . $package_name_underscores . '__MODE_ID { return 0; }' ) # equivalent to previous line
                            or croak($EVAL_ERROR);
                        if ($EVAL_ERROR) { croak($EVAL_ERROR); }
                    }

                    next;
                }

                # object properties, remember types for deferred accessor/mutator generation below
                if ( $module_file_line =~ /^\s*our\s+hashref\s+\$properties/xms ) {

                    # hard-coded example
                    #our hashref $properties = { foo => my Foo::Bar_arrayref $TYPED_foo = undef, quux => my integer_hashref $TYPED_quux = {a => 12, b => 21} };
                    $inside_object_properties = 1;
                    chomp $module_file_line;    # strip trailing newline
                    $object_properties_string .= $module_file_line;
                    next;
                }

                # create symbol table entries for methods and plain-old non-method subroutines
                if ( $module_file_line =~ /^\s*our\s+([\w:]+)\s+\$(\w+)\s+\=\s+sub\s+\{/xms ) {
                    $inside_object_properties = 0;
                    if ( not $use_rperl ) {

#                        RPerl::diag(q{in Class.pm INIT block, do NOT have $use_rperl, skipping subroutine in $module_filename_short = } . $module_filename_short . "\n");
                        next;
                    }

#                    else { RPerl::diag(q{in Class.pm INIT block, have $use_rperl, enabling subroutine in $module_filename_short = } . $module_filename_short . "\n"); }

                    if ($inside_subroutine_arguments) {

#                        RPerl::diag( q{in Class.pm INIT block, have $subroutine_type = } . $1 . q{, and $subroutine_name = } . $2 . '() while inside arguments of subroutine ' . $subroutine_name . '(), aborting RPerl activation of entire file' . "\n" );
                        last;    # last line of file
                    }

                    # activate previous subroutine, no arguments
                    if ($inside_subroutine) {

#                        RPerl::diag( q{in Class.pm INIT block, have $inside_subroutine = } . $inside_subroutine . q{, about to call activate_subroutine() while inside subroutine } . $subroutine_name . '()' . "\n" );
                        activate_subroutine( $package_name, $subroutine_name, $subroutine_type, q{}, $module_filename_long );
                    }

                    $subroutine_type = $1;
                    $subroutine_name = $2;

#                    RPerl::diag( q{in Class.pm INIT block, have $subroutine_type = } . $subroutine_type . q{, and $subroutine_name = } . $subroutine_name . "()\n" );
#                    RPerl::diag( q{in Class.pm INIT block, have $CHECK = '} . $CHECK . "'\n" );

                    if ( $CHECK eq 'OFF' ) {

                        #                        RPerl::diag( q{in Class.pm INIT block, CHECK IS OFF, about to call activate_subroutine()...} . "\n" );
                        activate_subroutine( $package_name, $subroutine_name, $subroutine_type, q{}, $module_filename_long );
                    }
                    elsif ( ( $CHECK ne 'ON' ) and ( $CHECK ne 'TRACE' ) ) {
                        croak(    'Received invalid value '
                                . $CHECK
                                . ' for RPerl preprocessor directive CHECK to control data type checking, valid values are OFF, ON, and TRACE, croaking' );
                    }
                    else {
                        $inside_subroutine = 1;
                    }
                    next;
                }

                # skip class properties AKA package variables
                if ( $module_file_line =~ /^\s*our\s+[\w:]+\s+\$\w+\s+\=/xms ) {
                    $inside_object_properties = 0;
                }

                # skip non-RPerl-enabled subroutine/method, using normal Perl 'sub foo {}' syntax instead of RPerl 'our type $foo = sub {};' syntax
                if ( $module_file_line =~ /^\s*sub\s+[\w:]+\s+\{/xms ) {
                    $inside_object_properties = 0;
                }

                # skip end-of-module line
                if ( $module_file_line =~ /^\s*1\;\s+\#\ end\ of/xms ) {
                    $inside_object_properties = 0;
                }

                # object properties, continue to aggregate types
                if ($inside_object_properties) {
                    chomp $module_file_line;    # strip trailing newline
                    $object_properties_string .= $module_file_line;
                    next;
                }

                # subroutine/method, process arguments and activate
                if ($inside_subroutine) {
                    if ( not $use_rperl ) {

#                        RPerl::diag(q{in Class.pm INIT block, do NOT have $use_rperl, skipping inside subroutine in $module_filename_short = } . $module_filename_short . "\n");
                        next;
                    }

#                    else { RPerl::diag(q{in Class.pm INIT block, have $use_rperl, enabling inside subroutine in $module_filename_short = } . $module_filename_short . "\n"); }

                    #                    RPerl::diag( q{in Class.pm INIT block, have $inside_subroutine = 1} . "\n" );
                    #                    RPerl::diag("in Class.pm INIT block, have \$module_file_line =\n$module_file_line\n");
                    if ( $module_file_line =~ /^\s*\(\s*my/xms ) {
                        $inside_subroutine_arguments = 1;
                    }

                    #                    RPerl::diag( q{in Class.pm INIT block, have $inside_subroutine_arguments = }, $inside_subroutine_arguments, "\n" );
                    if ($inside_subroutine_arguments) {
                        $subroutine_arguments_line .= $module_file_line;
                        if ( $subroutine_arguments_line =~ /\@\_\;/xms ) {    # @_; found
                            if ( not( $subroutine_arguments_line =~ /\@\_\;$/xms ) ) {    # @_; found not at end-of-line

#                                RPerl::diag( q{in Class.pm INIT block, found @_; NOT at end-of-line while inside subroutine } . $subroutine_name . '(), have $subroutine_arguments_line = ' . "\n" . $subroutine_arguments_line . "\n\n" . 'aborting RPerl activation of entire file' . "\n" );
                                last;
                            }

#                            RPerl::diag( q{in Class.pm INIT block, found @_; at end-of-line while inside subroutine } . $subroutine_name . '(), have $subroutine_arguments_line = ' . "\n" . $subroutine_arguments_line . "\n" );

                            my $subroutine_arguments = [];                                # string_arrayref_arrayref

                            # loop once per subroutine argument
                            while ( $subroutine_arguments_line =~ m/my\s+(\w+)\s+\$(\w+)/g ) {
                                push @{$subroutine_arguments}, [ $1, $2 ];

#                                RPerl::diag( q{in Class.pm INIT block, have subroutine argument type = } . $1 . q{ and subroutine argument name = } . $2 . "\n" );
                            }

             #                            RPerl::diag( q{in Class.pm INIT block, have $subroutine_arguments = } . "\n" . Dumper($subroutine_arguments) . "\n" );

                            my $subroutine_arguments_check_code = "\n";                   # string

                            if ( $CHECK eq 'ON' ) {

                                #                                RPerl::diag( 'in Class.pm INIT block, CHECK IS ON' . "\n" );
                                my $i = 0;                                                # integer
                                foreach my $subroutine_argument ( @{$subroutine_arguments} ) {
                                    $subroutine_arguments_check_code .= q{    } . '::' . $subroutine_argument->[0] . '_CHECK( $_[' . $i . '] );' . "\n";
                                    $i++;
                                }

                           #                                RPerl::diag( 'in Class.pm INIT block, CHECK IS ON, about to call activate_subroutine()...' . "\n" );
                                activate_subroutine( $package_name, $subroutine_name, $subroutine_type, $subroutine_arguments_check_code,
                                    $module_filename_long );
                                $inside_subroutine         = 0;
                                $subroutine_arguments_line = q{};
                            }
                            elsif ( $CHECK eq 'TRACE' ) {

                                #                                RPerl::diag( 'in Class.pm INIT block, CHECK IS TRACE' . "\n" );
                                my $i = 0;    # integer
                                foreach my $subroutine_argument ( @{$subroutine_arguments} ) {
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

                        #                                RPerl::diag( 'in Class.pm INIT block, CHECK IS TRACE, about to call activate_subroutine()...' . "\n" );
                                activate_subroutine( $package_name, $subroutine_name, $subroutine_type, $subroutine_arguments_check_code,
                                    $module_filename_long );
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

            close $MODULE_FILE or croak $OS_ERROR;

            # activate final subroutine in file, no arguments
            if ($inside_subroutine) {
                if ($inside_subroutine_arguments) {
                    croak('Did not find @_ to end subroutine arguments before end of file, croaking');
                }

                #                RPerl::diag( 'in Class.pm INIT block, activating final subroutine in file, no subroutine arguments found' . "\n" );
                activate_subroutine( $package_name, $subroutine_name, $subroutine_type, q{}, $module_filename_long );
                $inside_subroutine = 0;
            }

            # object properties, save final package's types
            $object_properties_types = save_object_properties_types( $package_name, $object_properties_string, $object_properties_types );

#            RPerl::diag( 'in Class.pm INIT block, have $object_properties_types = ' . "\n" . Dumper($object_properties_types) . "\n" ) if ( keys %{$object_properties_types} );

            # accessor/mutator object methods, deferred creation for all packages found in this file
            foreach $package_name ( sort keys %{$object_properties_types} ) {
                $object_properties = eval "\$$package_name\:\:properties";

                foreach my $property_name ( sort keys %{$object_properties} ) {

                    #						RPerl::diag("in Class.pm INIT block, have \$property_name = '$property_name'\n");
                    # DEV NOTE, CORRELATION #rp03: avoid re-defining class accessor/mutator methods; so far only triggered by RPerl::CodeBlock::Subroutine
                    # because it has a special BEGIN{} block with multiple package names including it's own package name

                    my $property_type = $object_properties_types->{$package_name}->{$property_name};
                    my $eval_string;
                    my $return_whole = 0;

                    # array element accessor/mutator
                    if (    ( $property_type =~ /_arrayref$/ )
                        and ( not eval( 'defined &' . $package_name . '::get_' . $property_name . '_element' ) ) )
                    {
          # hard-coded example
          #our int::method $get_foo_size = sub { ( my Foo::Bar $self ) = @_; return (scalar @{$self->{foo}}); };
          #our Foo::Quux::method $get_foo_element = sub { ( my Foo::Bar $self, my integer $i ) = @_; return $self->{foo}->[$i]; };
          #our void::method $set_foo_element = sub { ( my Foo::Bar $self, my integer $i, my Foo::Quux $foo_element ) = @_; $self->{foo}->[$i] = $foo_element; };
                        my $property_element_type = substr $property_type, 0, ( ( length $property_type ) - 9 );    # strip trailing '_arrayref'
                        if ( exists $rperlnamespaces_generated::RPERL->{ $property_element_type . '::' } ) {
                            $return_whole = 1;
                        }
                        else {
                            $eval_string
                                = '*{'
                                . $package_name
                                . '::get_'
                                . $property_name . '_size'
                                . '} = sub { ( my '
                                . $package_name
                                . ' $self ) = @_; return (scalar @{$self->{'
                                . $property_name
                                . '}}); };';
                            $eval_string
                                .= '*{'
                                . $package_name
                                . '::get_'
                                . $property_name
                                . '_element'
                                . '} = sub { ( my '
                                . $package_name
                                . ' $self, my integer $i ) = @_; return $self->{'
                                . $property_name
                                . '}->[$i]; };';
                            $eval_string
                                .= '*{'
                                . $package_name
                                . '::set_'
                                . $property_name
                                . '_element'
                                . '} = sub { ( my '
                                . $package_name
                                . ' $self, my integer $i, my '
                                . $property_element_type . ' $'
                                . $property_name
                                . '_element ) = @_; $self->{'
                                . $property_name
                                . '}->[$i] = $'
                                . $property_name
                                . '_element; };';

#                            RPerl::diag( 'in Class::INIT() block, have user-defined object array element accessor $eval_string = ' . "\n" . $eval_string . "\n" );
                            eval($eval_string) or croak($EVAL_ERROR);
                            if ($EVAL_ERROR) { croak($EVAL_ERROR); }
                        }
                    }

                    # hash value accessor/mutator
                    elsif ( ( $property_type =~ /_hashref$/ )
                        and ( not eval( 'defined &' . $package_name . '::get_' . $property_name . '_element' ) ) )
                    {
          # hard-coded example
          #our string_arrayref::method $get_foo_keys = sub { ( my Foo::Bar $self ) = @_; return [sort keys %{$self->{foo}}]; };
          #our Foo::Quux::method $get_foo_element = sub { ( my Foo::Bar $self, my integer $i ) = @_; return $self->{foo}->{$i}; };
          #our void::method $set_foo_element = sub { ( my Foo::Bar $self, my integer $i, my Foo::Quux $foo_element ) = @_; $self->{foo}->{$i} = $foo_element; };
                        my $property_value_type = substr $property_type, 0, ( ( length $property_type ) - 8 );    # strip trailing '_hashref'
                        if ( exists $rperlnamespaces_generated::RPERL->{ $property_value_type . '::' } ) {
                            $return_whole = 1;
                        }
                        else {
                            $eval_string
                                = '*{'
                                . $package_name
                                . '::get_'
                                . $property_name . '_keys'
                                . '} = sub { ( my '
                                . $package_name
                                . ' $self ) = @_; return [sort keys %{$self->{'
                                . $property_name
                                . '}}]; };';
                            $eval_string
                                .= '*{'
                                . $package_name
                                . '::get_'
                                . $property_name
                                . '_element'
                                . '} = sub { ( my '
                                . $package_name
                                . ' $self, my integer $i ) = @_; return $self->{'
                                . $property_name
                                . '}->{$i}; };';
                            $eval_string
                                .= '*{'
                                . $package_name
                                . '::set_'
                                . $property_name
                                . '_element'
                                . '} = sub { ( my '
                                . $package_name
                                . ' $self, my integer $i, my '
                                . $property_value_type . ' $'
                                . $property_name
                                . '_element ) = @_; $self->{'
                                . $property_name
                                . '}->{$i} = $'
                                . $property_name
                                . '_element; };';

#                            RPerl::diag( 'in Class::INIT() block, have user-defined object hash value accessor $eval_string = ' . "\n" . $eval_string . "\n" );
                            eval($eval_string) or croak($EVAL_ERROR);
                            if ($EVAL_ERROR) { croak($EVAL_ERROR); }
                        }
                    }

                    # scalar accessor/mutator
                    else {
                        $return_whole = 1;
                    }

                    # return whole values for scalars, scalar arrayrefs, and scalar hashrefs
                    if ($return_whole) {
                        if ( not eval( 'defined &' . $package_name . '::get_' . $property_name ) ) {
                            $eval_string = '*{' . $package_name . '::get_' . $property_name . '} = sub { return $_[0]->{' . $property_name . '}; };';
                            eval($eval_string) or croak($EVAL_ERROR);
                            if ($EVAL_ERROR) { croak($EVAL_ERROR); }
                        }

                        if ( not eval( 'defined &' . $package_name . '::set_' . $property_name ) ) {
                            $eval_string
                                = '*{'
                                . $package_name
                                . '::set_'
                                . $property_name
                                . '} = sub { $_[0]->{'
                                . $property_name
                                . '} = $_[1]; return $_[0]->{'
                                . $property_name . '}; };';
                            eval($eval_string)
                                or croak($EVAL_ERROR);
                            if ($EVAL_ERROR) { croak($EVAL_ERROR); }
                        }
                    }
                }
            }
        }

#        else { RPerl::diag('in Class.pm INIT block, found existing $rperlnamespaces_generated::CORE->{' . $namespace_root . '}, aborting RPerl activation of entire file' . "\n"); }
    }
}

# fake getting and setting values of *_raw subclass of user-defined type (AKA class),
# achieved by treating normal Perl object reference (C++ std::unique_ptr<Foo> AKA Foo_ptr) as Perl object raw reference (C++ Foo* AKA Foo_rawptr)
sub get_raw {
    ( my $self ) = @_;
    return $self;
}

sub set_raw {
    ( my $self, my $self_new ) = @_;
    %{$self} = %{$self_new};
}

sub save_object_properties_types {
    ( my $package_name, my $object_properties_string, my $object_properties_types ) = @_;
    if ( $object_properties_string eq q{} ) {

        #        RPerl::diag( 'in Class::save_object_properties_types(), have NO PROPERTIES $object_properties_string ' . "\n" );
    }
    elsif ( $object_properties_string =~ /^\s*our\s+hashref\s+\$properties\s*=\s*\{\s*\}\;/xms ) {

#        RPerl::diag( 'in Class::save_object_properties_types(), have EMPTY PROPERTIES $object_properties_string = ' . "\n" . $object_properties_string . "\n" );
    }
    else {
        my $object_property_key             = undef;
        my $object_property_type            = undef;
        my $object_property_inner_type_name = undef;

        $object_properties_string =~ s/^\s*our\s+hashref\s+\$properties\s*=\s*\{(.*)\}\;\s*$/$1/xms;    # strip everything but hash entries

#        RPerl::diag( 'in Class::save_object_properties_types(), have NON-EMPTY PROPERTIES $object_properties_string = ' . "\n" . $object_properties_string . "\n\n" );

        if ( $object_properties_string =~ /(\w+)\s*\=\>\s*my\s+([\w:]+)\s+\$TYPED_(\w+)/gxms ) {
            $object_property_key             = $1;
            $object_property_type            = $2;
            $object_property_inner_type_name = $3;
        }

#        RPerl::diag( 'in Class::save_object_properties_types(), before while() loop, have $object_property_key = ' . $object_property_key . "\n" );
#        RPerl::diag( 'in Class::save_object_properties_types(), before while() loop, have $object_property_type = ' . $object_property_type . "\n" );
#        RPerl::diag( 'in Class::save_object_properties_types(), before while() loop, have $object_property_inner_type_name = ' . $object_property_inner_type_name . "\n" );

        while ( ( defined $object_property_key ) and ( defined $object_property_type ) and ( defined $object_property_inner_type_name ) ) {
            if ( $object_property_key ne $object_property_inner_type_name ) {
                # DEV NOTE, CORRELATION #rp30: matches numbering of ECOGEASCP20 in RPerl/CompileUnit/Module/Class/Generator.pm
                die 'ERROR ECOGEPPRP20, CODE GENERATOR, PURE PERL TO RPERL: redundant name mismatch, inner type name ' . q{'}
                    . $object_property_inner_type_name . q{'}
                    . ' does not equal OO properties key ' . q{'}
                    . $object_property_key . q{'}
                    . ', dying' . "\n";
            }
            $object_properties_types->{$package_name}->{$object_property_key} = $object_property_type;

            if ( $object_properties_string =~ /(\w+)\s*\=\>\s*my\s+([\w:]+)\s+\$TYPED_(\w+)/gxms ) {
                $object_property_key             = $1;
                $object_property_type            = $2;
                $object_property_inner_type_name = $3;
            }
            else {
                $object_property_key             = undef;
                $object_property_type            = undef;
                $object_property_inner_type_name = undef;
            }
            
#            RPerl::diag( 'in Class::save_object_properties_types(), bottom of while() loop, have $object_property_key = ' . $object_property_key . "\n" );
#            RPerl::diag( 'in Class::save_object_properties_types(), bottom of while() loop, have $object_property_type = ' . $object_property_type . "\n" );
#            RPerl::diag( 'in Class::save_object_properties_types(), bottom of while() loop, have $object_property_inner_type_name = ' . $object_property_inner_type_name . "\n" );
        }
    }
    return $object_properties_types;
}

# create Perl symbol table entries for RPerl subroutines and methods
sub activate_subroutine {
    ( my $package_name, my $subroutine_name, my $subroutine_type, my $subroutine_arguments_check_code, my $module_filename_long ) = @_;

#    RPerl::diag('in Class::activate_subroutine(), received $package_name = ' . $package_name . "\n");
#    RPerl::diag('in Class::activate_subroutine(), received $subroutine_name = ' . $subroutine_name . "\n");
#    RPerl::diag('in Class::activate_subroutine(), received $subroutine_type = ' . $subroutine_type . "\n");
#    RPerl::diag('in Class::activate_subroutine(), received $subroutine_arguments_check_code = ' . $subroutine_arguments_check_code . "\n");
#    RPerl::diag('in Class::activate_subroutine(), received $module_filename_long = ' . $module_filename_long . "\n");
 
    my $package_name_tmp;              # string
    my $subroutine_definition_code;    # string
    my $subroutine_definition_diag_code = q{};    # string
    if ( $subroutine_type =~ /\::method$/xms ) {
        if ( $package_name eq '' ) {
            croak( 'Received no package name for method ', $subroutine_name, ' in file ' . $module_filename_long . ' ... croaking' );
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
                "ERROR ECOPR00, Pre-Processor: Attempt by package '$package_name' to re-define shared global subroutine '$subroutine_name', please re-name your subroutine or make it a method, croaking";
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

# RPerl function/method autoloader, LONG FORM; allows syntax for typed functions/methods and automates get/set accessors/mutators for object properties;
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

# RPerl object constructor, LONG FORM
# DEPRECATED still uses %properties hash instead of $properties hashref
#sub new($class_name_const_str)
sub new_LONG FORM
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
