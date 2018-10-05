## no critic qw(ProhibitUselessNoCritic PodSpelling ProhibitExcessMainComplexity)  # DEVELOPER DEFAULT 1a: allow unreachable & POD-commented code, must be on line 1; SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1

# NEED FIX: triplicate export code
package RPerl::Config;
use strict;
use warnings;
our $VERSION = 0.012_000;
our $IS_RPERL_CONFIG = 1;  # DEV NOTE, CORRELATION #rp027: RPerl::Config, MathPerl::Config, PhysicsPerl::Config, etc

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitUnreachableCode RequirePodSections RequirePodAtEnd)  # DEVELOPER DEFAULT 1b: allow POD & unreachable or POD-commented code, must be after line 1
## no critic qw(ProhibitStringyEval)  # SYSTEM DEFAULT 1: allow eval()
## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names
## no critic qw(ProhibitAutomaticExportation)  # SYSTEM SPECIAL 14: allow global exports from Config.pm

# DEV NOTE: this package exists to serve as the header file for RPerl.pm itself,
# as well as for RPerl.pm dependencies such as Class.pm, HelperFunctions_cpp.pm, and rperltypes.pm

# @ARG == @_, $OS_ERROR == $ERRNO == $!, $EVAL_ERROR == $@, $CHILD_ERROR == $?, $EXECUTABLE_NAME == $^X, $PROGRAM_NAME == $0, $OSNAME == $^O

# export various subroutines and variables to all who call 'use RPerl::Config;'
use Data::Dumper;
$Data::Dumper::Sortkeys = 1;    # Dumper() output must be sorted for lib/RPerl/Tests/Type_Types/* etc.
use Carp;
use English qw(-no_match_vars);
use POSIX qw(ceil floor modf);
use Exporter 'import';

# DEV NOTE, CORRELATION #rp008: can't include to_string(), type(), types(), name(), or scope_type_name_value() in @EXPORT here or in RPerl:: namespace below
# DEV NOTE, CORRELATION #rp034: enable @ARG in all packages (class & non-class)
our @EXPORT = qw(Dumper carp croak confess *ARG $OS_ERROR $EVAL_ERROR $CHILD_ERROR $EXECUTABLE_NAME $PROGRAM_NAME $OSNAME);

1;                              # end of package

# NEED FIX: triplicate export code
package RPerl::AfterSubclass;

## no critic qw(ProhibitAutomaticExportation)  # SYSTEM SPECIAL 14: allow global exports from Config.pm

# export various subroutines and variables to all who call 'use RPerl::AfterSubclass;'
use Data::Dumper;
$Data::Dumper::Sortkeys = 1;    # Dumper() output must be sorted for lib/RPerl/Tests/Type_Types/* etc.
use Carp;
use English qw(-no_match_vars);
use POSIX qw(ceil floor modf);
use Exporter 'import';

# DEV NOTE, CORRELATION #rp008: can't include to_string(), type(), types(), name(), or scope_type_name_value() in @EXPORT here or in RPerl:: namespace below
# DEV NOTE, CORRELATION #rp034: enable @ARG in all packages (class & non-class)
our @EXPORT = qw(Dumper carp croak confess *ARG $OS_ERROR $EVAL_ERROR $CHILD_ERROR $EXECUTABLE_NAME $PROGRAM_NAME $OSNAME);

1;                              # end of package

# NEED FIX: triplicate export code
package RPerl;
use File::Find qw(find);
use File::Spec;
use IPC::Cmd qw(can_run);       # to check for `reset`

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitUnreachableCode RequirePodSections RequirePodAtEnd)  # DEVELOPER DEFAULT 1b: allow POD & unreachable or POD-commented code, must be after line 1
## no critic qw(ProhibitStringyEval)  # SYSTEM DEFAULT 1: allow eval()
## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names
## no critic qw(ProhibitAutomaticExportation)  # SYSTEM SPECIAL 14: allow global exports from Config.pm

# export $RPerl::MODES, as well as various subroutines and variables to all who call 'use RPerl;'
our $MODES = {                  # see perl_modes.txt for more info
    0 => { ops => 'PERL', types => 'PERL' },    # NEED FIX: should be types => 'PERL_STATIC'
    1 => { ops => 'CPP',  types => 'PERL' },    # NEED FIX: should be types => 'PERL_STATIC'
    2 => { ops => 'CPP',  types => 'CPP' }
};

use Data::Dumper;
$Data::Dumper::Sortkeys = 1;                    # Dumper() output must be sorted for lib/RPerl/Tests/Type_Types/* etc.
use Carp;
use English qw(-no_match_vars);
use POSIX qw(ceil floor modf);
use Exporter 'import';
# DEV NOTE, CORRELATION #rp034: enable @ARG in all packages (class & non-class)
our @EXPORT = qw(Dumper carp croak confess *ARG $OS_ERROR $EVAL_ERROR $CHILD_ERROR $EXECUTABLE_NAME $PROGRAM_NAME $OSNAME);

# [[[ OO CLASS PROPERTIES SPECIAL ]]]

# data type checking mode, disabled in RPerl system code which calls 'use RPerl;',
# changed on a per-file basis by preprocessor directive, see RPerl::CompileUnit::Module::Class::INIT
# NEED UPGRADE: enable in RPerl system code when bootstrapping compiler
our $CHECK    = 'OFF';
our $DEBUG    = 0;       # $RPerl::DEBUG & env var RPERL_DEBUG are equivalent, default to off, see debug*() & diag*() below
our $VERBOSE  = 0;       # $RPerl::VERBOSE & env var RPERL_VERBOSE are equivalent, default to off, see verbose*() below
our $WARNINGS = 1;       # $RPerl::WARNINGS & env var RPERL_WARNINGS are equivalent, default to on, see warn*() below
our $TYPES_CCFLAG = ' -D__CPP__TYPES'; # rperltypes_mode.h & here default to CPPTYPES if PERLTYPES not explicitly set in this variable via rperltypes::types_enable()
our $BASE_PATH    = undef;                             # all target software lives below here
our $INCLUDE_PATH = undef;                             # all target system modules live here
our $SCRIPT_PATH  = undef;                             # interpreted target system programs live here
our $CORE_PATH    = undef;                             # all Perl core components (perl.h, etc) live here

# DEV NOTE, CORRELATION #rp032: NEED UPGRADE: properly determine whether to use DBL_EPSILON or FLT_EPSILON below
use constant EPSILON => POSIX::DBL_EPSILON();
#use constant EPSILON => POSIX::FLT_EPSILON();

# [[[ SUBROUTINES SPECIAL ]]]

# use a possibly-compiled RPerl package during runtime
sub eval_use {
    (my $package_name, my $display_errors) = @ARG;
#    RPerl::debug('in RPerl::eval_use(), received $package_name = ', $package_name, "\n");
#    RPerl::debug('in RPerl::eval_use(), CHECKPOINT c000', "\n");

    my $INC_ref_pre = {};
    foreach my $INC_key_pre (keys %INC) { $INC_ref_pre->{$INC_key_pre} = 1; }
#    RPerl::debug('in RPerl::eval_use(), have $INC_ref_pre = ', Dumper($INC_ref_pre), "\n");
#    RPerl::debug('in RPerl::eval_use(), CHECKPOINT c001', "\n");

    my $eval_string =<<"EOL";
#   no warnings 'all';               # DOES NOT SUPPRESS
    local \$SIG{__WARN__} = sub {};  # DOES     SUPPRESS
#    BEGIN { RPerl::debug('in RPerl::eval_use() eval, about to call use $package_name...', "\\n"); }

#   use $package_name;      # DOES NOT SUPPRESS, THIS IS THE HIDDEN PERPETRATOR OF UNSUPPRESSABLE WARNINGS!  'Too late to call INIT block' inside multi-class module files
    require $package_name;  # DOES     SUPPRESS

#    BEGIN { RPerl::debug('in RPerl::eval_use() eval, ret from use $package_name...', "\\n"); }

    # detect compiled C++ code and call cpp_load() accordingly
    if (defined \&$package_name\:\:cpp_load) {
#        RPerl::debug('in RPerl::eval_use() eval, $package_name\:\:cpp_load() is defined, calling...', "\\n");
        $package_name\:\:cpp_load();
#        RPerl::debug('in RPerl::eval_use() eval, $package_name\:\:cpp_load() is defined, returned from call', "\\n");
    }
#    else { RPerl::debug('in RPerl::eval_use() eval, $package_name\:\:cpp_load() is NOT defined, skipping...', "\\n"); }
EOL

#    RPerl::debug('in RPerl::eval_use(), have $eval_string = ', "\n\n", $eval_string, "\n\n");
#    RPerl::debug('in RPerl::eval_use(), CHECKPOINT c002', "\n");

    $eval_string .=<<'EOL';
    my $INC_ref_post = {};
    foreach my $INC_key_post (keys %INC) {
        if (not exists $INC_ref_pre->{$INC_key_post}) {
            $INC_ref_post->{$INC_key_post} = $INC{$INC_key_post};
        }
    }
#    RPerl::debug('in RPerl::eval_use() eval, have $INC_ref_post = ', Dumper($INC_ref_post), "\n");
    RPerl::CompileUnit::Module::Class::create_symtab_entries_and_accessors_mutators($INC_ref_post);
EOL
#    RPerl::debug('in RPerl::eval_use(), CHECKPOINT c003', "\n");

    my $eval_retval = eval $eval_string;
#    RPerl::debug('in RPerl::eval_use(), CHECKPOINT c004', "\n");

    # FOR DEBUG PURPOSES
#    if (defined $eval_retval) { print 'have $eval_retval = ', $eval_retval, "\n"; }
#    else { print 'have $eval_retval = undef, have $EVAL_ERROR = ', $EVAL_ERROR, "\n"; }

    if ($display_errors and (defined $EVAL_ERROR) and ($EVAL_ERROR ne q{})) {
        RPerl::warning( 'WARNING WCOEU00, EVAL USE: Failed to eval-use package ' . q{'}
            . $package_name . q{'} . ', fatal error trapped and delayed' . "\n" );
        RPerl::diag( '                                                Trapped the following error message...' . "\n\n" . $EVAL_ERROR . "\n" );
        RPerl::warning("\n");
    }
#    RPerl::debug('in RPerl::eval_use(), CHECKPOINT c005', "\n");

    return $eval_retval;
}

# NEED UPGRADE: replace Data::Dumper with pure-RPerl equivalent?
#sub DUMPER {
#    ( my $dumpee ) = @ARG;
#	die ('in RPerl::DUMPER(), received undef argument, dying') if (not(defined($_[0])));
#    return '**UNDEF**' if ( not( defined $dumpee ) );
#    return $dumpee->DUMPER()
#        if ( defined( eval( q{$} . ref($dumpee) . q{::DUMPER} ) ) );
#    return Dumper($dumpee);
#}

# DEV NOTE: to make diag*() & debug*() & verbose*() & warning() truly variadic, do not accept args as first line in subroutine

# DEV NOTE: diag() is simply a wrapper around debug(), they are 100% equivalent; likewise diag_pause() and debug_pause()
sub diag { return debug(@ARG); }
sub diag_pause { return debug_pause(@ARG); }

# print debugging AKA diagnostic message to STDERR, if either RPERL_DEBUG environmental variable or $RPerl::DEBUG global variable are true
sub debug {
#    print {*STDERR} 'in debug(), have $ENV{RPERL_DEBUG} = ' . $ENV{RPERL_DEBUG} . "\n";

    # DEV NOTE, CORRELATION #rp017: default to off; if either variable is set to true, then do emit messages
    if ( $ENV{RPERL_DEBUG} or $RPerl::DEBUG ) { print {*STDERR} @ARG; }

#    if ( $ENV{RPERL_DEBUG} or $RPerl::DEBUG ) { print {*STDERR} "\e[1;31m $message \e[0m"; }  # print in red
    return 1;    # DEV NOTE: this must be here to avoid 'at -e line 0. INIT failed--call queue aborted.'... BUT WHY???
}

# same as debug(), except require <ENTER> to continue
sub debug_pause {
    if ( $ENV{RPERL_DEBUG} or $RPerl::DEBUG ) {
        print {*STDERR} @ARG;
        my $stdin_ignore = <STDIN>;
    }
    return 1;
}

# print verbose user-friendly message to STDOUT, if either RPERL_VERBOSE environmental variable or $RPerl::VERBOSE global variable are true
sub verbose {
    # DEV NOTE, CORRELATION #rp017: default to off; if either variable is set to true, then do emit messages
    if ( $ENV{RPERL_VERBOSE} or $RPerl::VERBOSE ) {
        print {*STDOUT} @ARG;
    }
    return 1;
}

# same as verbose(), except require <ENTER> to continue
sub verbose_pause {
    if ( $ENV{RPERL_VERBOSE} or $RPerl::VERBOSE ) {
        print {*STDOUT} @ARG;
        my $stdin_ignore = <STDIN>;
    }
    return 1;
}

# clear STDOUT, if either RPERL_VERBOSE environmental variable or $RPerl::VERBOSE global variable are true
sub verbose_clear_screen {
    if ( $ENV{RPERL_VERBOSE} or $RPerl::VERBOSE ) {
        if ( $OSNAME eq 'linux' ) {
            my $reset_path = can_run('reset');
            if ( defined $reset_path ) {
                system $reset_path;
            }
        }
        elsif ( $OSNAME eq 'MSWin32' ) {

            # cls is a shell builtin, not a command which can be found by can_run()
            system 'cls';
        }
        else {
            RPerl::warning(
                q{WARNING WOSCLSC00: Unknown operating system '} . $OSNAME . q{' where 'linux' or 'Win32' expected, skipping screen clearing} . "\n" );
            return 0;
        }
    }
    return 1;
}

# print non-fatal warning message to STDERR, unless either RPERL_WARNINGS environmental variable or $RPerl::WARNINGS global variable are false
sub warning {
    # default to on; if either variable is set to false, then do not emit messages
    if ( ( ( not defined $ENV{RPERL_WARNINGS} ) or $ENV{RPERL_WARNINGS} )
        and $RPerl::WARNINGS )
    {
        # NEED ADDRESS? the two following lines should be equivalent, but warn causes false ECOPAPL03
        print {*STDERR} @ARG;

        #        warn $message . "\n";
    }
    return 1;
}

sub analyze_class_symtab_entries {
    ( my $class ) = @ARG;
    my $retval    = q{};
    my @isa_array = eval q{@} . $class . q{::ISA};

    #print Dumper(\@isa_array);
    my $isa_string = join ', ', @isa_array;
    $retval .= '<<<<< BEGIN SYMTAB ENTRIES >>>>>' . "\n";
    $retval .= $class . ' ISA (' . $isa_string . ')' . "\n\n";

    #foreach my $entry ( sort keys %RPerl::CompileUnit::Module::Header:: ) {
    my @keys = eval q{sort keys %} . $class . q{::};
    foreach my $entry (@keys) {

        #    my $glob = $RPerl::CompileUnit::Module::Header::{$entry};
        my $glob = eval q{$} . $class . q{::{$entry}};

        $retval .= q{-} x 50;
        $retval .= "\n";
        $retval .= $entry . "\n";

        #    $retval .= ref \$glob, "\n";  # always says GLOB

        if ( defined ${$glob} ) {
            $retval .= "\t" . 'scalar';
            my $ref_type = ref ${$glob};
            if ( $ref_type ne q{} ) {
                $retval .= "\t" . $ref_type . 'ref';
            }
        }
        if ( @{$glob} ) {
            $retval .= "\t" . 'array';
        }
        if ( %{$glob} ) {
            $retval .= "\t" . 'hash';
        }
        if ( defined &{$glob} ) {
            $retval .= "\t" . 'code';
        }

        $retval .= "\n";
    }
    $retval .= '<<<<< END SYMTAB ENTRIES >>>>>' . "\n";
    return $retval;
}

# [ AUTOMATICALLY SET SYSTEM-DEPENDENT PATH VARIABLES ]
sub set_system_paths {
    ( my $target_file_name_config, my $target_package_name_config, my $target_file_name_pm, my $target_file_name_script ) = @ARG;
    if (( not exists $INC{$target_file_name_config} )
        or ( not defined $INC{$target_file_name_config} )
        )
    {
        Carp::croak 'BIZARRE ERROR EINPL00: Non-existent or undefined Perl %INC path entry for '
            . $target_file_name_config
            . ', reported from within '
            . $target_package_name_config
            . ', croaking';
    }
    my $target_config_pm_loaded = $INC{$target_file_name_config};
    if ( not -e $target_config_pm_loaded ) {
        Carp::croak 'BIZARRE ERROR EINPL01: Non-existent file ',
            $target_config_pm_loaded,
            ' supposedly loaded in %INC, reported from within ' . $target_package_name_config . ', croaking';
    }
    ( my $volume_loaded, my $directories_loaded, my $file_loaded ) = File::Spec->splitpath( $target_config_pm_loaded, my $no_file = 0 );
    my @directories_loaded_split = File::Spec->splitdir($directories_loaded);

    #print {*STDERR} 'in ' . $target_package_name_config . ', have pre-pop @directories_loaded_split = ', "\n", Dumper(@directories_loaded_split), "\n";

    # pop twice if empty entry on top
    if ( pop @directories_loaded_split eq q{} ) { pop @directories_loaded_split; }
    my $target_pm_wanted = File::Spec->catpath( $volume_loaded, ( File::Spec->catdir(@directories_loaded_split) ), $target_file_name_pm );

    #print {*STDERR} 'in ' . $target_package_name_config . ', have post-pop @directories_loaded_split = ', "\n", Dumper(@directories_loaded_split), "\n";
    #print {*STDERR} 'in ' . $target_package_name_config . ', have $target_config_pm_loaded = ', $target_config_pm_loaded, "\n";
    #print {*STDERR} 'in ' . $target_package_name_config . ', have $target_pm_wanted = ', $target_pm_wanted, "\n";

    my $target_pm_loaded = undef;
    if ( ( exists $INC{$target_file_name_pm} ) and ( defined $INC{$target_file_name_pm} ) ) {
        $target_pm_loaded = $INC{$target_file_name_pm};

        # BULK88 20150608 2015.159: Win32 Bug Fix
        #    if ( not -e $target_pm_loaded ) {
        if ( not -f $target_pm_loaded ) {
            Carp::croak 'BIZARRE ERROR EINPL02: Non-existent file ', $target_pm_loaded,
                ' supposedly loaded in %INC, reported from within ' . $target_package_name_config . ', croaking';
        }
    }

    # strip trailing '/'
    if ( ( substr $directories_loaded, -1, 1 ) eq q{/} ) {
        $directories_loaded = substr $directories_loaded, 0, -1;
    }

    #print {*STDERR} 'in ' . $target_package_name_config . ', have $directories_loaded = ', $directories_loaded, "\n";
    #print {*STDERR} 'in ' . $target_package_name_config . ', have $target_pm_loaded = ', ( $target_pm_loaded or '<undef>' ), "\n";

    my $target_scripts_found = [];
    my $target_pms_found     = [];

    # BULK88 20150608 2015.159: Win32 Bug Fix
    #foreach my $inc_path ( $directories_loaded, @INC ) {  # this doesn't work with Win32
    # DEV NOTE: search order precedence for script command is OS paths, path of loaded TARGET/Config.pm (this file), Perl INC paths
    foreach my $inc_path ( ( split ':', $ENV{PATH} ), File::Spec->catpath( $volume_loaded, $directories_loaded, '' ), @INC ) {

        #    print {*STDERR} 'in ' . $target_package_name_config . ', top of main foreach() loop, have $inc_path = ', $inc_path, "\n";
        my $sub_inc_paths = [];

        #    push @{$sub_inc_paths}, $inc_path;
        ( my $inc_volume, my $inc_directories, my $inc_file ) = File::Spec->splitpath( $inc_path, my $no_file = 1 );

        push @{$sub_inc_paths}, $inc_directories;

        my @directories_split = File::Spec->splitdir($inc_directories);
        pop @directories_split;
        push @{$sub_inc_paths}, File::Spec->catdir(@directories_split);
        pop @directories_split;
        push @{$sub_inc_paths}, File::Spec->catdir(@directories_split);

        #    print {*STDERR} 'in ' . $target_package_name_config . ', in main foreach() loop, have $sub_inc_paths = ', "\n", Dumper($sub_inc_paths), "\n";
        #    print {*STDERR} 'in ' . $target_package_name_config . ', in main foreach() loop, have $inc_volume = ', "\n", Dumper($inc_volume), "\n";
        #    print {*STDERR} 'in ' . $target_package_name_config . ', in main foreach() loop, have $inc_directories = ', "\n", Dumper($inc_directories), "\n";
        #    print {*STDERR} 'in ' . $target_package_name_config . ', in main foreach() loop, have $inc_file = ', "\n", Dumper($inc_file), "\n";

        my $possible_target_scripts = [];
        foreach my $sub_inc_path ( @{$sub_inc_paths} ) {
            push @{$possible_target_scripts}, File::Spec->catpath( $inc_volume, $sub_inc_path, $target_file_name_script );
            if ( $sub_inc_path ne q{} ) {
                push @{$possible_target_scripts}, File::Spec->catpath( $inc_volume, File::Spec->catdir( $sub_inc_path, 'script' ), $target_file_name_script );
                push @{$possible_target_scripts}, File::Spec->catpath( $inc_volume, File::Spec->catdir( $sub_inc_path, 'bin' ),    $target_file_name_script );
            }
            else {
                push @{$possible_target_scripts}, File::Spec->catpath( $inc_volume, 'script', $target_file_name_script );
                push @{$possible_target_scripts}, File::Spec->catpath( $inc_volume, 'bin',    $target_file_name_script );
            }
        }

        foreach my $possible_target_script ( @{$possible_target_scripts} ) {

            #        print {*STDERR} 'in ' . $target_package_name_config . ', have $possible_target_script = ', $possible_target_script, "\n";
            # BULK88 20150608 2015.159: Win32 Bug Fix
            #        if ( ( -e $possible_target_script ) and ( -x $possible_target_script ) ) {
            if ( ( -f $possible_target_script ) and ( $OSNAME eq 'MSWin32' ? 1 : -x $possible_target_script ) ) {
                my $is_unique = 1;
                foreach my $target_script_found ( @{$target_scripts_found} ) {
                    if ( $target_script_found eq $possible_target_script ) { $is_unique = 0; }
                }
                if ($is_unique) { push @{$target_scripts_found}, $possible_target_script; }
            }
        }

        if ( not defined $target_pm_loaded ) {
            my $possible_target_pm = File::Spec->catfile( $inc_path, $target_file_name_pm );

            # BULK88 20150608 2015.159: Win32 Bug Fix
            #        if ( -e $possible_target_pm ) {
            if ( -f $possible_target_pm ) {
                my $is_unique = 1;
                foreach my $target_pm_found ( @{$target_pms_found} ) {
                    if ( $target_pm_found eq $possible_target_pm ) {
                        $is_unique = 0;
                    }
                }
                if ($is_unique) { push @{$target_pms_found}, $possible_target_pm; }
            }
        }
    }

    #print {*STDERR} 'in ' . $target_package_name_config . ', have $target_scripts_found = ', "\n", Dumper($target_scripts_found), "\n";
    #print {*STDERR} 'in ' . $target_package_name_config . ', have $target_pms_found = ', "\n", Dumper($target_pms_found), "\n";

    if ( scalar @{$target_scripts_found} == 0 ) {
        die 'ERROR EEXRP00: Failed to find `' . $target_file_name_script . '` executable, dying' . "\n";
    }
    my $target_script_found = $target_scripts_found->[0];
    if ( scalar @{$target_scripts_found} > 1 ) {
        RPerl::warning( 'WARNING WEXRP00: Found multiple `' . $target_file_name_script . '` executables, using first located, ' . 
            q{`} . $target_script_found . q{`} . '; other locations include ' . 
            (join ', ', (map {q{`} . $_ . q{`}} @{$target_scripts_found}[1 .. ((scalar @{$target_scripts_found} - 1))])) . "\n" );
    }

    my $target_pm_found = undef;
    if ( defined $target_pm_loaded ) {
        $target_pm_found = $target_pm_loaded;
    }
    else {

        if ( scalar @{$target_pms_found} == 0 ) {
            Carp::croak 'ERROR EINRP00: Failed to find ' . $target_file_name_pm . ' module, croaking';
        }
        foreach my $target_pm_found_single ( @{$target_pms_found} ) {
            # strip leading './' and '.\', for matching purposes only, do not actually save stripped filename
            my $target_pm_found_single_stripped = $target_pm_found_single;
            if (((substr $target_pm_found_single, 0, 2) eq './') or ((substr $target_pm_found_single, 0, 2) eq '.\\')) {
                substr $target_pm_found_single_stripped, 0, 2, q{};
            }
            if ( $target_pm_found_single_stripped eq $target_pm_wanted ) {
                $target_pm_found = $target_pm_found_single;
            }
        }
        if ( not defined $target_pm_found ) {
            Carp::croak 'ERROR EINRP01: Expected to find ', $target_pm_wanted, ' but instead found ', "\n", Dumper($target_pms_found), ', croaking';
        }
    }

    #print {*STDERR} 'in ' . $target_package_name_config . ', have $target_pm_found = ', $target_pm_found, "\n";
    #print {*STDERR} 'in ' . $target_package_name_config . ', have $target_script_found = ', $target_script_found, "\n";

    #( my $volume_target_pm, my $directories_target_pm, my $file_target_pm ) = File::Spec->splitpath( $target_pm_found, $no_file = 0 );
    #( my $volume_target_script, my $directories_target_script, my $file_target_script ) = File::Spec->splitpath( $target_script_found, $no_file = 0 );
    ( undef, my $directories_target_pm,     my $file_target_pm )     = File::Spec->splitpath( $target_pm_found,     $no_file = 0 );
    ( undef, my $directories_target_script, my $file_target_script ) = File::Spec->splitpath( $target_script_found, $no_file = 0 );

    #print {*STDERR} 'in ' . $target_package_name_config . ', have $volume_target_pm = ', $volume_target_pm, "\n";
    #print {*STDERR} 'in ' . $target_package_name_config . ', have $directories_target_pm = ', $directories_target_pm, "\n";
    #print {*STDERR} 'in ' . $target_package_name_config . ', have $file_target_pm = ', $file_target_pm, "\n";
    #print {*STDERR} 'in ' . $target_package_name_config . ', have $volume_target_script = ', $volume_target_script, "\n";
    #print {*STDERR} 'in ' . $target_package_name_config . ', have $directories_target_script = ', $directories_target_script, "\n";
    #print {*STDERR} 'in ' . $target_package_name_config . ', have $file_target_script = ', $file_target_script, "\n";

    my @directories_target_pm_split     = File::Spec->splitdir($directories_target_pm);
    my @directories_target_script_split = File::Spec->splitdir($directories_target_script);
    my @directories_base_split          = ();

    for my $i ( 0 .. ( ( scalar @directories_target_pm_split ) - 1 ) ) {
        if ( $directories_target_pm_split[$i] eq $directories_target_script_split[$i] ) {
            push @directories_base_split, $directories_target_pm_split[$i];
        }
        else {
            for my $j ( 0 .. ( $i - 1 ) ) {
                shift @directories_target_pm_split;
                shift @directories_target_script_split;
            }
            last;
        }
    }

    #print {*STDERR} 'in ' . $target_package_name_config . ', have @directories_base_split = ', "\n", Dumper(\@directories_base_split), "\n";
    #print {*STDERR} 'in ' . $target_package_name_config . ', have @directories_target_pm_split = ', "\n", Dumper(\@directories_target_pm_split), "\n";
    #print {*STDERR} 'in ' . $target_package_name_config . ', have @directories_target_script_split = ', "\n", Dumper(\@directories_target_script_split), "\n";

    my $MY_BASE_PATH;
    my $MY_INCLUDE_PATH;
    my $MY_SCRIPT_PATH;
    my $MY_CORE_PATH;

    # NEED FIX: how do we catpath() with some $volume instead of catdir() below, without breaking relative paths?
    $MY_BASE_PATH = File::Spec->catpath( $volume_loaded, File::Spec->catdir(@directories_base_split), '' );
    if ( $MY_BASE_PATH eq q{} ) {
        $MY_INCLUDE_PATH = File::Spec->catpath( $volume_loaded, File::Spec->catdir(@directories_target_pm_split),     '' );
        $MY_SCRIPT_PATH  = File::Spec->catpath( $volume_loaded, File::Spec->catdir(@directories_target_script_split), '' );
        #print {*STDERR} 'in ' . $target_package_name_config . ', have $MY_BASE_PATH eq q{} = ', $MY_BASE_PATH, "\n";
    }
    else {
        $MY_INCLUDE_PATH = File::Spec->catdir( $MY_BASE_PATH, @directories_target_pm_split );
        $MY_SCRIPT_PATH  = File::Spec->catdir( $MY_BASE_PATH, @directories_target_script_split );
        #print {*STDERR} 'in ' . $target_package_name_config . ', have $MY_BASE_PATH ne q{} ', $MY_BASE_PATH, "\n";
    }

    foreach my $inc_path (@INC) {
        $MY_CORE_PATH = File::Spec->catdir( $inc_path, 'CORE' );
        my $inc_core_perl_h_path = File::Spec->catfile( $MY_CORE_PATH, 'perl.h' );
        if   ( ( -e $inc_core_perl_h_path ) and ( -r $inc_core_perl_h_path ) and ( -f $inc_core_perl_h_path ) ) { last; }
        else                                                                                                    { $MY_CORE_PATH = q{}; }
    }

    #print {*STDERR} 'in ' . $target_package_name_config . ', have $MY_BASE_PATH = ', $MY_BASE_PATH, "\n";
    #print {*STDERR} 'in ' . $target_package_name_config . ', have $MY_INCLUDE_PATH = ', $MY_INCLUDE_PATH, "\n";
    #print {*STDERR} 'in ' . $target_package_name_config . ', have $MY_SCRIPT_PATH = ', $MY_SCRIPT_PATH, "\n";
    #print {*STDERR} 'in ' . $target_package_name_config . ', have $MY_CORE_PATH = ', $MY_CORE_PATH, "\n";
    
    return [$MY_BASE_PATH, $MY_INCLUDE_PATH, $MY_SCRIPT_PATH, $MY_CORE_PATH];
}

# [[[ OPERATIONS SPECIAL ]]]

my $file_name_config    = 'RPerl/Config.pm';    # this file name
my $package_name_config = 'RPerl::Config';      # this file's primary package name
my $file_name_pm        = 'RPerl.pm';
my $file_name_script    = 'rperl';
($BASE_PATH, $INCLUDE_PATH, $SCRIPT_PATH, $CORE_PATH) = @{set_system_paths($file_name_config, $package_name_config, $file_name_pm, $file_name_script)};

1;                                                     # end of package


# export system paths to main:: namespace for use by PMC files
package main;

# [[[ OO CLASS PROPERTIES SPECIAL ]]]
# DEV NOTE: duplicate lines to avoid 'used only once' warnings
our $BASE_PATH = $RPerl::BASE_PATH;
$BASE_PATH = $RPerl::BASE_PATH;
our $INCLUDE_PATH = $RPerl::INCLUDE_PATH;
$INCLUDE_PATH = $RPerl::INCLUDE_PATH;
our $SCRIPT_PATH  = $RPerl::SCRIPT_PATH;
$SCRIPT_PATH  = $RPerl::SCRIPT_PATH;

1;                                                 # end of package