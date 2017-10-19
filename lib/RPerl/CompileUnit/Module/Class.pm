# [[[ HEADER ]]]
package RPerl::CompileUnit::Module::Class;
use strict;
use warnings;
use RPerl::Config;    # get @ARG, Dumper, Carp, English without 'use RPerl;'
our $VERSION = 0.043_000;

# [[[ OO INHERITANCE ]]]
# BASE CLASS HAS NO INHERITANCE
# "The Buck Stops Here"

# [[[ CRITICS ]]]
## no critic qw(ProhibitStringyEval)  # SYSTEM DEFAULT 1: allow eval()
## no critic qw(ProhibitAutoloading RequireArgUnpacking)  # SYSTEM SPECIAL 2: allow Autoload & read-only @ARG
## no critic qw(ProhibitExcessComplexity)  # SYSTEM SPECIAL 5: allow complex code inside subroutines, must be after line 1
## no critic qw(ProhibitDeepNests)  # SYSTEM SPECIAL 7: allow deeply-nested code
## no critic qw(ProhibitNoStrict)  # SYSTEM SPECIAL 8: allow no strict
## no critic qw(RequireBriefOpen)  # SYSTEM SPECIAL 10: allow complex processing with open filehandle

# [[[ INCLUDES ]]]
use File::Basename;
use File::Spec;  # for splitpath() to test if @INC file entries are absolute or relative
use Scalar::Util 'reftype';  # to test for HASH ref when given initialization values for new() method
use rperltypes;  # required for all automatically-generated type-checking subroutine calls

# [[[ OO PROPERTIES ]]]
# BASE CLASS HAS NO PROPERTIES

# [[[ SUBROUTINES & OO METHODS ]]]

# RPerl object constructor, SHORT FORM
sub new {
    no strict;
    if ( not defined ${ $_[0] . '::properties' } ) {
        croak 'ERROR ECOOOCO00, SOURCE CODE, OO OBJECT CONSTRUCTOR: Undefined hashref $properties for class ' . $_[0] . ', croaking' . "\n";
    }
#    return bless { %{ ${ $_[0] . '::properties' } } }, $_[0];  # DOES NOT INHERIT PROPERTIES FROM PARENT CLASSES
#    return bless { %{ ${ $_[0] . '::properties' } }, %{ properties_inherited($_[0]) } }, $_[0];  # WHAT DOES THIS DO???
#    return bless { %{ properties_inherited($_[0]) } }, $_[0];  # WORKS PROPERLY, BUT DOES NOT INITIALIZE PROPERTIES
    return bless { %{ properties_inherited_initialized($_[0], $_[1]) } }, $_[0];
}


# allow properties to be initialized by passing them as hashref arg to new() method
sub properties_inherited_initialized {
#    print {*STDERR} 'in Class::properties_inherited_initialized(), top of subroutine, received $ARG[0] = ', $ARG[0], "\n";
#    print {*STDERR} 'in Class::properties_inherited_initialized(), top of subroutine, received $ARG[1] = ', $ARG[1], "\n";

    my $properties_inherited = properties_inherited($_[0]);

    if (defined $_[1]) {
        if ((not defined reftype($_[1])) or (reftype($_[1]) ne 'HASH')) {
            croak 'ERROR ECOOOCO01, SOURCE CODE, OO OBJECT CONSTRUCTOR: Initialization values for new() method must be key-value pairs inside a hash reference, croaking';
        }
        foreach my $property_name (sort keys %{$_[1]}) {
            if (not exists $properties_inherited->{$property_name}) {
                croak 'ERROR ECOOOCO02, SOURCE CODE, OO OBJECT CONSTRUCTOR: Attempted initialization of invalid property ' . q{'} . $property_name . q{'} . ', croaking';
            }
            $properties_inherited->{$property_name} = $_[1]->{$property_name};
        }
    }

    return $properties_inherited;
}


# inherit properties from parent and grandparnt classes
sub properties_inherited {
#    print {*STDERR} 'in Class::properties_inherited(), top of subroutine, received $ARG[0] = ', $ARG[0], "\n";
    no strict;

    # always keep self class' $properties
    my $properties = { %{ ${ $ARG[0] . '::properties' } } };

    # inherit parent & (great*)grandparent class' $properties
    foreach my $parent_package_name (@{ $ARG[0] . '::ISA' }) {
#        print {*STDERR} 'in Class::properties_inherited(), top of foreach() loop, have $parent_package_name = ', $parent_package_name, "\n";
        # RPerl base class & Eyapp classes have no $properties, skip
        if (($parent_package_name eq 'RPerl::CompileUnit::Module::Class') or
            ($parent_package_name eq 'Parse::Eyapp::Node')) {
                next;
        }

        # recurse to get inherited $properties
        my $parent_and_grandparent_properties = properties_inherited($parent_package_name);

        # self class' $properties override inherited $properties, same as C++
        foreach my $parent_property_key (keys %{ $parent_and_grandparent_properties }) {
            if (not exists $properties->{$parent_property_key}) {
                $properties->{$parent_property_key} = $parent_and_grandparent_properties->{$parent_property_key};
            }
        }
    }
    return $properties;
}


sub parent_and_grandparent_package_names {
#    print {*STDERR} 'in Class::parent_and_grandparent_package_names(), top of subroutine, received $ARG[0] = ', $ARG[0], "\n";
    no strict;

    RPerl::eval_use($ARG[0]);

    my $arg0_isa_string = $ARG[0] . '::ISA';
#    print {*STDERR} 'in Class::parent_and_grandparent_package_names(), have $arg0_isa_string = ', $arg0_isa_string, "\n";

    my @arg0_isa = @{$arg0_isa_string};
#    print {*STDERR} 'in Class::parent_and_grandparent_package_names(), have @arg0_isa = ', Dumper(\@arg0_isa), "\n";

    my $package_names = [];

    foreach my $parent_package_name (@{ $ARG[0] . '::ISA' }) {
#        print {*STDERR} 'in Class::parent_and_grandparent_package_names(), top of foreach() loop, have $parent_package_name = ', $parent_package_name, "\n";
        # RPerl base class & Eyapp classes have no $properties, skip
        if (($parent_package_name eq 'RPerl::CompileUnit::Module::Class') or
            ($parent_package_name eq 'Parse::Eyapp::Node')) {
                next;
        }

        # get parent's package name
        push @{$package_names}, $parent_package_name;

        # recurse to get (great*)grandparents' package names
        my $grandparent_package_names = parent_and_grandparent_package_names($parent_package_name);
        $package_names = [@{$package_names}, @{$grandparent_package_names}];
#        print {*STDERR} 'in Class::parent_and_grandparent_package_names(), inside foreach() loop, have $grandparent_package_names = ', Dumper($grandparent_package_names), "\n";
    }
#    print {*STDERR} 'in Class::parent_and_grandparent_package_names(), bottom of subroutine, returning $package_names = ', Dumper($package_names), "\n";
    return $package_names;
}


# RPerl object destructor
# NEED ADDRESS: do we ever need to actually deconstruct anything to free resources?
sub DESTROY { }


# [[[ SUBROUTINES ]]]

# suppress deprecated feature warning
local $SIG{__WARN__} = sub {
    return if $_[0] =~ /^Use of inherited AUTOLOAD for non-method /xms;
    carp @ARG;
};


BEGIN {
    #RPerl::diag('in Class.pm BEGIN block, about to use data types...' . "\n");

    # DEV NOTE, CORRELATION #rp012: type system includes, hard-copies in rperltypes.pm & rperltypesconv.pm & Class.pm

    # [[[ DATA TYPES ]]]
    use RPerl::DataType::Void;
    use RPerl::DataType::Boolean;
    use RPerl::DataType::UnsignedInteger;
    use RPerl::DataType::Integer;
    use RPerl::DataType::Number;
    use RPerl::DataType::Character;
    use RPerl::DataType::String;
    use RPerl::DataType::Scalar;
    use RPerl::DataType::Unknown;
    use RPerl::DataType::FileHandle;

    #RPerl::diag('in Class.pm BEGIN block, about to use data structures...' . "\n");

    # [[[ DATA STRUCTURES ]]]
    use RPerl::DataStructure::Array;
    use RPerl::DataStructure::Array::SubTypes;
    use RPerl::DataStructure::Array::Reference;
    use RPerl::DataStructure::Hash;
    use RPerl::DataStructure::Hash::SubTypes;
    use RPerl::DataStructure::Hash::Reference;

    #RPerl::diag('in Class.pm BEGIN block, done' . "\n");
}


# after compiling but before runtime: create symtab entries for all RPerl functions/methods, and accessors/mutators for all RPerl class properties
INIT {
    create_symtab_entries_and_accessors_mutators(\%INC);
};


sub create_symtab_entries_and_accessors_mutators {
    (my $INC_ref) = @ARG;
#    $RPerl::DEBUG                   = 1;
#    $RPerl::VERBOSE                 = 1;

    # add calling .pl driver to INC for subroutine activation;
    # DEV NOTE: should be safe to use basename() here instead of fileparse(), because $PROGRAM_NAME should never end in a directory
    $INC{ basename($PROGRAM_NAME) } = $PROGRAM_NAME;

#    RPerl::diag('in Class.pm INIT block, have $INC_ref =' . "\n" . Dumper($INC_ref) . "\n");
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
    my $inside_subroutine_header;       # boolean
    my $inside_subroutine_arguments;    # boolean
    my $subroutine_arguments_line;      # string

#	RPerl::diag(q{in Class.pm INIT block, have $PROGRAM_NAME = '} . $PROGRAM_NAME . "'\n");

    foreach my $module_filename_short ( sort keys %{$INC_ref} ) {

#        RPerl::diag("in Class.pm INIT block, have \$module_filename_short = '$module_filename_short'\n");

        # skip special entry created by Filter::Util::Call
        if ( $module_filename_short eq '-e' ) {
            next;
        }

        $module_filename_long = $INC{$module_filename_short};
#        RPerl::diag( 'in Class.pm INIT block, have $module_filename_long = ' . $module_filename_long . "\n" );

        # determine if both short & long module filenames are absolute;
        # file names w/out any volume or directories are not absolute, allows 'use Foo;' where "Foo.pm" exists in current directory w/out any volume or directory
        my $module_is_absolute = 0;
        if (defined $module_filename_long) {
            (my $module_volume, my $module_directories, my $module_file) = File::Spec->splitpath( $module_filename_long );
#            RPerl::diag( 'in Class.pm INIT block, have $module_volume = ' . q{'} . $module_volume . q{'} . "\n" );
#            RPerl::diag( 'in Class.pm INIT block, have $module_directories = ' . q{'} . $module_directories . q{'} . "\n" );
#            RPerl::diag( 'in Class.pm INIT block, have $module_file = ' . q{'} . $module_file . q{'} . "\n" );
#            if (($module_volume ne q{}) or ($module_directories ne q{})) {  # DEV NOTE: this isn't right, if the volume is empty then it can't be absolute regardless of directories
            if ($module_volume ne q{}) {
                if ( $module_filename_long eq $module_filename_short ) {
                    # absolute module names include volume, and must match both short & long filenames
                    $module_is_absolute = 1;
                }
            }
        }

#        RPerl::diag( 'in Class.pm INIT block, have $module_is_absolute = ' . $module_is_absolute . "\n" );
        
        # skip absolute file names (such as Komodo's perl5db.pl) which came from a runtime `require $scalar` or `require 'foo.pm'`,
        # because we can not determine the correct package from the absolute path name, and we don't know how to figure out which part was in @INC from the absolute path;
        if ((not defined $module_filename_long) or $module_is_absolute) {
#            RPerl::diag( 'in Class.pm INIT block, skipping due to undefined or absolute momdule filename' . "\n" );
            next;
        }
        
        # skip already-compiled files with PMC counterparts
        if (-e ($module_filename_long . 'c')) {
#            RPerl::diag( 'in Class.pm INIT block, skipping due to already-compiled PMC file' . "\n" );
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
        $inside_subroutine_header    = 0;
        $inside_subroutine_arguments = 0;
        $subroutine_arguments_line   = q{};

        $namespace_root = RPerl::filename_short_to_namespace_root_guess($module_filename_short);

#	    RPerl::diag(q{in Class.pm INIT block, have $namespace_root = '} . $namespace_root . "'\n");

        # DEV NOTE: avoid error...
        # Name "rperlnamespaces_generated::RPERL_DEPS" used only once: possible typo
        my $tmp = $rperlnamespaces_generated::CORE;
        $tmp = $rperlnamespaces_generated::RPERL_DEPS;

        if (    ( not exists $rperlnamespaces_generated::CORE->{$namespace_root} ) and
                ( not exists $rperlnamespaces_generated::RPERL_DEPS->{$namespace_root} ) and
                ( not exists $rperlnamespaces_generated::RPERL_FILES->{$module_filename_short}) )
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
#                    if ($inside_subroutine) { RPerl::diag( 'in Class.pm INIT block, skipping __DATA__ footer while inside subroutine ' . $subroutine_name . '(), aborting RPerl activation of entire file' . "\n" ); }
#                    else { RPerl::diag('in Class.pm INIT block, skipping __DATA__ footer' . "\n"); }
                    last;
                }

                # skip __END__ footer
                if ( $module_file_line eq '__END__' ) {
#                    if ($inside_subroutine) { RPerl::diag( 'in Class.pm INIT block, skipping __END__ footer while inside subroutine ' . $subroutine_name . '(), aborting RPerl activation of entire file' . "\n" ); }
#                    else { RPerl::diag('in Class.pm INIT block, skipping __END__ footer' . "\n"); }
                    last;
                }

#                if ($module_file_line =~ m/sub\s*/xms) {
#    				RPerl::diag("in Class.pm INIT block, have \$module_file_line =\n$module_file_line\n");
#                }

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
# DEV NOTE, CORRELATION #rp018: RPerl::DataStructure::Array & Hash can not 'use RPerl;' so they are skipped in the header-checking loop above, their *__MODE_ID() subroutines are not created below
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
                # DEPRECATED, CORRELATION #rp120: old subroutine header
#                if ( $module_file_line =~ /^\s*our\s+([\w:]+)\s+\$(\w+)\s+\=\s+sub\s+\{/xms ) {
#                if ( $module_file_line =~ /^\s*sub\s+(\w+)\s*\{[\s\n\r]*\{\s*my\s+([\w:]+)\s+\$RETURN_TYPE\s*\};/xms ) {  # can't match multi-line content against single-line input

                # first half of subroutine header (name)
                if ( $module_file_line =~ /^\s*sub\s+(\w+)\s*\{/xms ) {
#                    RPerl::diag(q{in Class.pm INIT block, found first half of subroutine header for } . $1 . q{() in $module_filename_short = } . $module_filename_short . "\n");
                    if ($inside_subroutine_header) {
#                        RPerl::diag(q{in Class.pm INIT block, found first half of subroutine header for } . $1 . q{() when already marked as $inside_subroutine_header for } . $subroutine_name . q{(), skipping activation of non-RPerl subroutine } . $subroutine_name . q{() in $module_filename_short = } . $module_filename_short . "\n");
                        $inside_subroutine_header = 0;
                    }
                    else {
                        $inside_subroutine_header = 1;
                    }
                    $inside_object_properties = 0;
                    $inside_subroutine = 0;
                    if ( not $use_rperl ) {
#                        RPerl::diag(q{in Class.pm INIT block, do NOT have $use_rperl, skipping subroutine } . $1 . q{() in $module_filename_short = } . $module_filename_short . "\n");
                        $subroutine_name = q{};
                        next;
                    }
#                    else { RPerl::diag(q{in Class.pm INIT block, have $use_rperl, looking for second half of header for subroutine } . $1 . q{() in $module_filename_short = } . $module_filename_short . "\n"); }

                    # NEED ANSWER: should this be a croak() or die() statement instead of just an abort?
                    if ($inside_subroutine_arguments) {
#                        RPerl::diag( q{in Class.pm INIT block, have $subroutine_name = } . $1 . '() while inside arguments of subroutine ' . $subroutine_name . '(), aborting RPerl activation of entire file' . "\n" );
                        $subroutine_name = q{};
                        last;    # last line of file
                    }

                    # DEV NOTE, CORRELATION #rp053: since the upgrade to normal Perl subroutine headers, do NOT activate args type checking when no args found or explicitly disabled with CHECK OFF
                    # DO NOT activate previous subroutine, no arguments
#                    if ($inside_subroutine) {
#                        RPerl::diag( q{in Class.pm INIT block, have $inside_subroutine = } . $inside_subroutine . q{, about to call activate_subroutine_args_checking() while inside subroutine } . $subroutine_name . '(), no arguments assumed' . "\n" );
#                        activate_subroutine_args_checking( $package_name, $subroutine_name, $subroutine_type, q{}, $module_filename_long );
#                    }

                    $subroutine_name = $1;
                    next;
                }

                # second half of subroutine header (return type)
                if ( $module_file_line =~ /^\s*\{\s*my\s+([\w:]+)\s+\$RETURN_TYPE\s*\}\s*;/xms ) {
#                    RPerl::diag(q{in Class.pm INIT block, found second half of subroutine header for } . $subroutine_name . q{() in $module_filename_short = } . $module_filename_short . "\n");
                    if ($inside_subroutine_header) {
                        $inside_subroutine_header = 0;
                    }
                    else {
#                        RPerl::diag(q{in Class.pm INIT block, found second half of subroutine header with $RETURN_TYPE } . $1 . q{ when not already marked as $inside_subroutine_header for } . $subroutine_name . q{(), skipping activation of unknown subroutine in $module_filename_short = } . $module_filename_short . "\n");
                        next;
                    }
                    $subroutine_type = $1;

#                    RPerl::diag( q{in Class.pm INIT block, have $subroutine_type = } . $subroutine_type . q{, and $subroutine_name = } . $subroutine_name . "()\n" );
#                    RPerl::diag( q{in Class.pm INIT block, have $CHECK = '} . $CHECK . "'\n" );

                    # DEV NOTE: with new subroutine headers, do NOT activate args type checking when no args found
                    # DEV NOTE, CORRELATION #rp053: since the upgrade to normal Perl subroutine headers, do NOT activate args type checking when no args found or explicitly disabled with CHECK OFF
                    if ( $CHECK eq 'OFF' ) {
#                        RPerl::diag( q{in Class.pm INIT block, CHECK IS OFF, about to call activate_subroutine_args_checking()...} . "\n" );
#                        activate_subroutine_args_checking( $package_name, $subroutine_name, $subroutine_type, q{}, $module_filename_long );
                        1;  # NO OPERATION
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

                # skip non-RPerl-enabled subroutine/method, using normal Perl 'sub foo {}' syntax instead of RPerl syntax
                # DEPRECATED, CORRELATION #rp120: old subroutine header
#                if ( $module_file_line =~ /^\s*sub\s+[\w:]+\s+\{/xms ) {
#                    $inside_object_properties = 0;
#                }

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

                # subroutine/method, process arguments and activate type checking
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
                        if ( $subroutine_arguments_line =~ /\@ARG\;/xms ) {    # @ARG; found
                            if ( not( $subroutine_arguments_line =~ /\@ARG\;$/xms ) ) {    # @ARG; found not at end-of-line
#                                RPerl::diag( q{in Class.pm INIT block, found @ARG; NOT at end-of-line while inside subroutine } . $subroutine_name . '(), have $subroutine_arguments_line = ' . "\n" . $subroutine_arguments_line . "\n\n" . 'aborting RPerl activation of entire file' . "\n" );
                                last;
                            }

#                            RPerl::diag( q{in Class.pm INIT block, found @ARG; at end-of-line while inside subroutine } . $subroutine_name . '(), have $subroutine_arguments_line = ' . "\n" . $subroutine_arguments_line . "\n" );

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
#                                    $subroutine_arguments_check_code .= q{    } . $subroutine_argument->[0] . '_CHECK( $_[' . $i . '] );' . "\n";  # DOES NOT WORK, fails to find RPerl::Exporter::integer_CHECKTRACE() etc.
#                                    $subroutine_arguments_check_code .= q{    ::} . $subroutine_argument->[0] . '_CHECK( $_[' . $i . '] );' . "\n";  # DOES NOT WORK, we no longer export all the type-checking subroutines to the main '::' namespace
                                    $subroutine_arguments_check_code .= q{    rperltypes::} . $subroutine_argument->[0] . '_CHECK( $_[' . $i . '] );' . "\n";  # does work, hard-code all automatically-generated type-checking code to 'rperltypes::' namespace
                                    $i++;
                                }

#                                RPerl::diag( 'in Class.pm INIT block, CHECK IS ON, about to call activate_subroutine_args_checking()...' . "\n" );
                                activate_subroutine_args_checking( $package_name, $subroutine_name, $subroutine_type, $subroutine_arguments_check_code, $module_filename_long );
                                $inside_subroutine         = 0;
                                $subroutine_arguments_line = q{};
                            }
                            elsif ( $CHECK eq 'TRACE' ) {
#                                RPerl::diag( 'in Class.pm INIT block, CHECK IS TRACE' . "\n" );
                                my $i = 0;    # integer
                                foreach my $subroutine_argument ( @{$subroutine_arguments} ) {
#                                    $subroutine_arguments_check_code .= q{    } . $subroutine_argument->[0] . '_CHECKTRACE( $_[' . $i . q{], '$} . $subroutine_argument->[1] . q{', '} . $subroutine_name . q{()' );} . "\n";  # DOES NOT WORK
#                                    $subroutine_arguments_check_code .= q{    ::} . $subroutine_argument->[0] . '_CHECKTRACE( $_[' . $i . q{], '$} . $subroutine_argument->[1] . q{', '} . $subroutine_name . q{()' );} . "\n";  # DOES NOT WORK
                                    $subroutine_arguments_check_code .= q{    rperltypes::} . $subroutine_argument->[0] . '_CHECKTRACE( $_[' . $i . q{], '$} . $subroutine_argument->[1] . q{', '} . $subroutine_name . q{()' );} . "\n";
                                    $i++;
                                }
#                                RPerl::diag( 'in Class.pm INIT block, CHECK IS TRACE, about to call activate_subroutine_args_checking()...' . "\n" );
                                activate_subroutine_args_checking( $package_name, $subroutine_name, $subroutine_type, $subroutine_arguments_check_code, $module_filename_long );
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
#                            RPerl::diag( 'in Class.pm INIT block, have $subroutine_arguments_check_code =' . "\n" . $subroutine_arguments_check_code . "\n" );
                        }

                        next;    # next file line
                    }
                }
            }

            close $MODULE_FILE or croak $OS_ERROR;

            # activate final subroutine in file, no arguments
            if ($inside_subroutine) {
                if ($inside_subroutine_arguments) {
                    croak('Did not find @ARG to end subroutine arguments before end of file, croaking');
                }

                # DEV NOTE, CORRELATION #rp053: since the upgrade to normal Perl subroutine headers, do NOT activate args type checking when no args found or explicitly disabled with CHECK OFF
#                RPerl::diag( 'in Class.pm INIT block, activating final subroutine in file, no subroutine arguments found' . "\n" );
#                activate_subroutine_args_checking( $package_name, $subroutine_name, $subroutine_type, q{}, $module_filename_long );
                $inside_subroutine = 0;
            }

            # object properties, save final package's types
            $object_properties_types = save_object_properties_types( $package_name, $object_properties_string, $object_properties_types );

#            RPerl::diag( 'in Class.pm INIT block, have $object_properties_types = ' . "\n" . Dumper($object_properties_types) . "\n" ) if ( keys %{$object_properties_types} );

            # accessor/mutator object methods, deferred creation for all packages found in this file
            foreach $package_name ( sort keys %{$object_properties_types} ) {
#                RPerl::diag("in Class.pm INIT block, about to create accessors/mutators, have \$package_name = '$package_name'\n");
                $object_properties = eval "\$$package_name\:\:properties";

                foreach my $property_name ( sort keys %{$object_properties} ) {

 #                   RPerl::diag("in Class.pm INIT block, about to create accessors/mutators, have \$property_name = '$property_name'\n");
                    # DEV NOTE, CORRELATION #rp003: avoid re-defining class accessor/mutator methods; so far only triggered by RPerl::CodeBlock::Subroutine
                    # because it has a special BEGIN{} block with multiple package names including it's own package name

                    my $property_type = $object_properties_types->{$package_name}->{$property_name};
                    my $eval_string;
                    my $return_whole = 0;

#                    RPerl::diag("in Class.pm INIT block, about to create accessors/mutators, have \$property_type = '$property_type'\n");

                    # array element accessor/mutator
                    if (    ( $property_type =~ /_arrayref$/ )
                        and ( not eval( 'defined &' . $package_name . '::get_' . $property_name . '_element' ) ) )
                    {
#                        RPerl::diag('in Class.pm INIT block, about to create accessors/mutators, have arrayref type' . "\n");
        # hard-coded examples
        # sub get_foo_size { { my integer::method $RETURN_TYPE }; ( my Foo::Bar $self ) = @ARG; return (scalar @{$self->{foo}}); }
        # sub get_foo_element { { my Foo::Quux::method $RETURN_TYPE }; ( my Foo::Bar $self, my integer $i ) = @ARG; return $self->{foo}->[$i]; }
        # sub set_foo_element { { my void::method $RETURN_TYPE }; ( my Foo::Bar $self, my integer $i, my Foo::Quux $foo_element ) = @ARG; $self->{foo}->[$i] = $foo_element; }
                        my $property_element_type = substr $property_type, 0, ( ( length $property_type ) - 9 );    # strip trailing '_arrayref'
                        if ( exists $rperlnamespaces_generated::RPERL->{ $property_element_type . '::' } ) {
#                            RPerl::diag('in Class.pm INIT block, about to create accessors/mutators, have RPerl arrayref type, setting $return_whole flag' . "\n");
                            $return_whole = 1;
                        }
                        else {
                            $eval_string
                                = 'sub'
                                . $package_name
                                . '::get_'
                                . $property_name . '_size'
                                . '} = sub { ( my '
                                . $package_name
                                . ' $self ) = @ARG; return (scalar @{$self->{'
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
                                . ' $self, my integer $i ) = @ARG; return $self->{'
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
                                . '_element ) = @ARG; $self->{'
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
            # sub get_foo_keys { { my string_arrayref::method $RETURN_TYPE }; ( my Foo::Bar $self ) = @ARG; return [sort keys %{$self->{foo}}]; }
            # sub get_foo_element { { my Foo::Quux::method $RETURN_TYPE }; ( my Foo::Bar $self, my integer $i ) = @ARG; return $self->{foo}->{$i}; }
            # sub set_foo_element { { my void::method $RETURN_TYPE }; ( my Foo::Bar $self, my integer $i, my Foo::Quux $foo_element ) = @ARG; $self->{foo}->{$i} = $foo_element; }
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
                                . ' $self ) = @ARG; return [sort keys %{$self->{'
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
                                . ' $self, my integer $i ) = @ARG; return $self->{'
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
                                . '_element ) = @ARG; $self->{'
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
#                            RPerl::diag( 'in Class::INIT() block, have $return_whole accessor $eval_string = ' . "\n" . $eval_string . "\n" );
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
#                            RPerl::diag( 'in Class::INIT() block, have $return_whole mutator $eval_string = ' . "\n" . $eval_string . "\n" );
                            eval($eval_string) or croak($EVAL_ERROR);
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
    ( my $self ) = @ARG;
    return $self;
}


sub set_raw {
    ( my $self, my $self_new ) = @ARG;
    %{$self} = %{$self_new};
}


sub save_object_properties_types {
    ( my $package_name, my $object_properties_string, my $object_properties_types ) = @ARG;
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
                # DEV NOTE, CORRELATION #rp030: matches numbering of ECOGEASCP20 in RPerl/CompileUnit/Module/Class/Generator.pm
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
sub activate_subroutine_args_checking {
    ( my $package_name, my $subroutine_name, my $subroutine_type, my $subroutine_arguments_check_code, my $module_filename_long ) = @ARG;

#    RPerl::diag('in Class::activate_subroutine_args_checking(), received $package_name = ' . $package_name . "\n");
#    RPerl::diag('in Class::activate_subroutine_args_checking(), received $subroutine_name = ' . $subroutine_name . "\n");
#    RPerl::diag('in Class::activate_subroutine_args_checking(), received $subroutine_type = ' . $subroutine_type . "\n");
#    RPerl::diag('in Class::activate_subroutine_args_checking(), received $subroutine_arguments_check_code = ' . $subroutine_arguments_check_code . "\n");
#    RPerl::diag('in Class::activate_subroutine_args_checking(), received $module_filename_long = ' . $module_filename_long . "\n");

    my $package_name_tmp;              # string
    my $subroutine_definition_code = q{};    # string
    my $subroutine_definition_diag_code = q{};    # string
    my $check_code_subroutine_name = q{};  # string

    if ( $subroutine_type =~ /\::method$/xms ) {
#        RPerl::diag("in Class::activate_subroutine_args_checking(), $subroutine_name is a method\n");
        if ( $package_name eq q{} ) {
            croak( 'ERROR ECOPR01, Pre-Processor: Received no package name for method ', $subroutine_name, ' in file ' . $module_filename_long . ' ... croaking' );
        }
    }
    else {
#        RPerl::diag("in Class::activate_subroutine_args_checking(), $subroutine_name is not a method\n");
        # non-method subroutines which are not inside any package are actually in the 'main' package namespace
        if ( $package_name eq q{} ) { $package_name = 'main'; }
    }

#    $subroutine_definition_diag_code = "\n    " . q{RPerl::diag("IN POST-INIT, direct call MODE } . $package_name . '::' . $subroutine_name . q{\n"); };

=DEPRECATED 
    # set symbol table entry for subroutine to new anonymous subroutine containing dereferenced call to real anonymous subroutine, old header style
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
        . '(@ARG); };';
=cut

    # re-define subroutine call to include type checking code; new header style
    do
    {
        no strict;
        # create unchecked symbol table entry for original subroutine
        *{ $package_name . '::__UNCHECKED_' . $subroutine_name } = \&{ $package_name . '::' . $subroutine_name };  # short form, symbol table direct, not strict

        # delete original symtab entry, 
        undef *{ $package_name . '::' . $subroutine_name };

        # re-create new symtab entry pointing to checking code plus unchecked symtab entry
        $subroutine_definition_code .=
            '*' . $package_name . '::' . $subroutine_name . ' = sub { ' .
            $subroutine_definition_diag_code .
            ($subroutine_arguments_check_code or "\n") .
            '    return ' . $package_name . '::__UNCHECKED_' . $subroutine_name . '(@ARG);' . "\n" . '};';

        # create new checked symtab entries, for use by Exporter
        $check_code_subroutine_name = $package_name . '::__CHECK_CODE_' . $subroutine_name;
        $subroutine_definition_code .= "\n" . '*' . $package_name . '::__CHECKED_' . $subroutine_name . ' = \&' . $package_name . '::' . $subroutine_name . "\n" . ';';
#        ${ $check_code_subroutine_name } = $subroutine_arguments_check_code;  # DOES NOT WORK
#        $subroutine_definition_code .= "\n" . '    $' . $check_code_subroutine_name . q{ =<<'EOF';} . "\n" . $subroutine_arguments_check_code . "\n" . 'EOF' . "\n";  # DOES NOT WORK
#        RPerl::diag('in Class::activate_subroutine_args_checking(), have $' . $check_code_subroutine_name . '  = ' . "\n" . '[BEGIN_CHECK_CODE]' . "\n" . ${ $check_code_subroutine_name } . "\n" . ' [END_CHECK_CODE]' . "\n");
 
        $subroutine_definition_code .= "\n" . '*' . $check_code_subroutine_name . ' = sub {' . "\n" . '    my $retval ' . q{ =<<'EOF';} . "\n" . $subroutine_arguments_check_code . "\n" . 'EOF' . "\n" . '};' . "\n";
    };

#    if ($subroutine_arguments_check_code ne q{}) {
#        RPerl::diag('in Class::activate_subroutine_args_checking(), have method $subroutine_definition_code =' . "\n" . $subroutine_definition_code . "\n");
#    }

#    eval($subroutine_definition_code) or (croak 'ERROR ECOPR02, Pre-Processor: Failed to enable type checking for subroutine ' . $package_name . '::' . $subroutine_name . '(),' . "\n" . $EVAL_ERROR . "\n" . 'croaking');  # TRIGGERS FALSE ALARMS ON OUTPUT FROM RPerl::diag()
    eval($subroutine_definition_code) or (RPerl::diag('ERROR ECOPR02, Pre-Processor: Possible failure to enable type checking for subroutine ' . $package_name . '::' . $subroutine_name . '(),' . "\n" . $EVAL_ERROR . "\n" . 'not croaking'));
    if ($EVAL_ERROR) { croak 'ERROR ECOPR03, Pre-Processor: Failed to enable type checking for subroutine ' . $package_name . '::' . $subroutine_name . '(),' . "\n" . $EVAL_ERROR . "\n" . 'croaking'; }

#    do { no strict;
#        RPerl::diag('in Class::activate_subroutine_args_checking(), have ' . $check_code_subroutine_name . '() = ' . "\n" . '[BEGIN_CHECK_CODE]' . "\n" . &{ $check_code_subroutine_name } . "\n" . ' [END_CHECK_CODE]' . "\n");
#    };

# DEPRECATED, CORRELATION #rp120: old subroutine header
# do not automatically export non-method subroutines because that is non-standard behavior, only provide standard Perl behavior
=DEPRECATED
    if ( $subroutine_type =~ /\::method$/xms ) {
        if ( $package_name eq '' ) {
            croak( 'Received no package name for method ', $subroutine_name, ' in file ' . $module_filename_long . ' ... croaking' );
        }

#        $subroutine_definition_diag_code = "\n" . q{RPerl::diag("IN POST-INIT, method direct call MODE } . $package_name . '::' . $subroutine_name . q{\n"); } . "\n";
#        RPerl::diag("in Class::activate_subroutine_args_checking(), $subroutine_name is a method\n");
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
            . '}(@ARG); };';

#        if ($subroutine_arguments_check_code ne q{}) { RPerl::diag('in Class::activate_subroutine_args_checking(), have method $subroutine_definition_code =' . "\n" . $subroutine_definition_code . "\n"); }
        eval($subroutine_definition_code)
            or croak($EVAL_ERROR);
        if ($EVAL_ERROR) { croak($EVAL_ERROR); }
    }
    else {
        #        RPerl::diag( "in Class::activate_subroutine_args_checking(), $subroutine_name is a non-method subroutine\n" );
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
            . '}(@ARG); };';

#        if ($subroutine_arguments_check_code ne q{}) { RPerl::diag('in Class::activate_subroutine_args_checking(), have subroutine main:: $subroutine_definition_code =' . "\n" . $subroutine_definition_code . "\n"); }
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
                . '}(@ARG); };';

#            if ($subroutine_arguments_check_code ne q{}) {
#                RPerl::diag('in Class::activate_subroutine_args_checking(), have subroutine package:: $subroutine_definition_code =' . "\n" . $subroutine_definition_code . "\n");
#            }
            eval($subroutine_definition_code)
                or croak($EVAL_ERROR);
            if ($EVAL_ERROR) { croak($EVAL_ERROR); }
        }
    }
=cut
}

1;    # end of class

__END__


# RPerl function/method autoloader, LONG FORM; allows syntax for typed functions/methods and automates get/set accessors/mutators for object properties;
# creates real subroutines to avoid AUTOLOADing any function/method more than once, performs operation inside AUTOLOAD that one time
# now fully deprecated in favor of INIT block above
our $AUTOLOAD;
sub AUTOLOAD
{
	RPerl::diag("IN AUTOLOAD, top of subroutine, received \$AUTOLOAD = '$AUTOLOAD', and \@ARG =\n" . Dumper(\@ARG) . "\n");
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
		if (defined(${$AUTOLOAD})) { $retval = &${$AUTOLOAD}(@ARG); }
		else { die "Attempt to AUTOLOAD undefined subroutine '$AUTOLOAD', dying"; }
	}
	# is there any reason to encapsulate calls in an eval() to trap their errors???
#	else
#	{
#		my $eval_string = '&$' . $AUTOLOAD . '(@ARG);';
#		RPerl::diag("IN AUTOLOAD, eval call MODE, have \$eval_string = '$eval_string'\n");
#		$retval = eval $eval_string;
#	}

	croak $EVAL_ERROR if ($EVAL_ERROR);  # suppress '...propagated at RPerl/Class.pm' appended exception	
#	croak if ($EVAL_ERROR);  # allow '...propagated at RPerl/Class.pm' appended exception	

#	RPerl::diag("IN AUTOLOAD, bottom of subroutine, about to return \$retval = '$retval'\n");
	return $retval;
}


# RPerl object constructor, LONG FORM
# DEPRECATED still uses %properties hash instead of $properties hashref, does not support property initialization values
#sub new($class_name_const_str)
sub new_LONG FORM
{
	(my $class_name_const_str) = @ARG;
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
