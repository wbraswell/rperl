## no critic qw(ProhibitUselessNoCritic PodSpelling ProhibitExcessMainComplexity) # DEVELOPER DEFAULT 1a: allow unreachable & POD-commented code, must be on line 1; SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1
package RPerl::Config;
use strict;
use warnings;
our $VERSION = 0.003_010;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitUnreachableCode RequirePodSections RequirePodAtEnd) # DEVELOPER DEFAULT 1b: allow POD & unreachable or POD-commented code, must be after line 1
## no critic qw(ProhibitStringyEval)  # SYSTEM DEFAULT 1: allow eval()
## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names
## no critic qw(ProhibitAutomaticExportation)  # SYSTEM SPECIAL 13: allow global exports from Config.pm

# DEV NOTE: this package exists to serve as the header file for RPerl.pm itself,
# as well as for RPerl.pm dependencies such as Class.pm, HelperFunctions_cpp.pm, and rperltypes.pm

# $OS_ERROR == $ERRNO == $!, $EVAL_ERROR == $@, $CHILD_ERROR == $?, $EXECUTABLE_NAME == $^X, $PROGRAM_NAME == $0

# export various subroutines and variables to all who call 'use RPerl::Config;'
use Data::Dumper;
$Data::Dumper::Sortkeys = 1; # Dumper() output must be sorted for lib/RPerl/Tests/Type_Types/* etc.
use Carp;
use English qw(-no_match_vars);
use Exporter 'import';

# DEV NOTE, CORRELATION #08: can't include to_string(), type(), types(), name(), or scope_type_name_value() in @EXPORT here or in RPerl:: namespace below
our @EXPORT
    = qw(Dumper carp croak confess $OS_ERROR $EVAL_ERROR $CHILD_ERROR $EXECUTABLE_NAME $PROGRAM_NAME);

1;                           # end of package

package RPerl;
use File::Find qw(find);
use File::Spec;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitUnreachableCode RequirePodSections RequirePodAtEnd) # DEVELOPER DEFAULT 1b: allow POD & unreachable or POD-commented code, must be after line 1
## no critic qw(ProhibitStringyEval)  # SYSTEM DEFAULT 1: allow eval()
## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names
## no critic qw(ProhibitAutomaticExportation)  # SYSTEM SPECIAL 13: allow global exports from Config.pm

# export $RPerl::MODES, as well as various subroutines and variables to all who call 'use RPerl;'
our $MODES = {    # see perl_modes.txt for more info
    0 => { ops => 'PERL', types => 'PERL' }, # NEED FIX: should be types => 'PERL_STATIC'
    1 => { ops => 'CPP', types => 'PERL' }, # NEED FIX: should be types => 'PERL_STATIC'
    2 => { ops => 'CPP', types => 'CPP' }
};
use Data::Dumper;
$Data::Dumper::Sortkeys = 1; # Dumper() output must be sorted for lib/RPerl/Tests/Type_Types/* etc.
use Carp;
use English qw(-no_match_vars);
use Exporter 'import';
our @EXPORT
    = qw(Dumper carp croak confess $OS_ERROR $EVAL_ERROR $CHILD_ERROR $EXECUTABLE_NAME $PROGRAM_NAME);

# [[[ OO CLASS PROPERTIES SPECIAL ]]]

# data type checking mode, disabled in RPerl system code which calls 'use RPerl;',
# changed on a per-file basis by preprocessor directive, see RPerl::CompileUnit::Module::Class::INIT
# NEED UPGRADE: enable in RPerl system code when bootstrapping compiler
our $CHECK = 'OFF';
our $DEBUG = 0; # $RPerl::DEBUG & env var RPERL_DEBUG are equivalent, default to off, see diag*() below
our $VERBOSE = 0; # $RPerl::VERBOSE & env var RPERL_VERBOSE are equivalent, default to off, see verbose*() below
our $WARNINGS = 1; # $RPerl::WARNINGS & env var RPERL_WARNINGS are equivalent, default to on, see warn*() below

# [[[ SUBROUTINES SPECIAL ]]]

=DISABLE
# NEED UPGRADE: replace Data::Dumper with pure-RPerl equivalent?
sub DUMPER {
    ( my $dumpee ) = @_;

#	die ('in RPerl::DUMPER(), received undef argument, dying') if (not(defined($_[0])));
    return '**UNDEF**' if ( not( defined $dumpee ) );
    return $dumpee->DUMPER()
        if ( defined( eval( q{$} . ref($dumpee) . q{::DUMPER} ) ) );
    return Dumper($dumpee);
}
=cut

# NEED UPGRADE: enable variable number of arguments as seen below
sub diag {

    #    ( my $message ) = @_;
    my @messages = @_;

  # default to off; if either variable is set to true, then do emit messages
  #    if ( $ENV{RPERL_DEBUG} or $RPerl::DEBUG ) { print {*STDERR} $message; }
    if ( $ENV{RPERL_DEBUG} or $RPerl::DEBUG ) {
        foreach my $message (@messages) { print {*STDERR} $message; }
    }

#    if ( $ENV{RPERL_DEBUG} or $RPerl::DEBUG ) { print {*STDERR} "\e[1;31m $message \e[0m"; }  # print in red
    return 1; # DEV NOTE: this must be here to avoid 'at -e line 0. INIT failed--call queue aborted.'... BUT WHY???
}

sub diag_pause {
    my @messages = @_;
    if ( $ENV{RPERL_DEBUG} or $RPerl::DEBUG ) {
        foreach my $message (@messages) { print {*STDERR} $message; }
        my $stdin_ignore = <STDIN>;
    }
    return 1;
}

sub verbose {
    my @messages = @_;

    # default to off; if either variable is set to true, then do emit messages
    if ( $ENV{RPERL_VERBOSE} or $RPerl::VERBOSE ) {
        foreach my $message (@messages) { print {*STDOUT} $message; }
    }
    return 1;
}

sub verbose_pause {
    my @messages = @_;
    if ( $ENV{RPERL_VERBOSE} or $RPerl::VERBOSE ) {
        foreach my $message (@messages) { print {*STDOUT} $message; }
        my $stdin_ignore = <STDIN>;
    }
    return 1;
}

sub verbose_reset {
    if ( $ENV{RPERL_VERBOSE} or $RPerl::VERBOSE ) { system 'reset'; }
    return 1;
}

sub warning {
    my @messages = @_;

# default to on; if either variable is set to false, then do not emit messages
    if ( ( ( not defined $ENV{RPERL_WARNINGS} ) or $ENV{RPERL_WARNINGS} )
        and $RPerl::WARNINGS )
    {
        # NEED FIX: the two following lines should be equivalent, but warn causes false ECVPAPL03
        foreach my $message (@messages) { print {*STDERR} $message; }
#        foreach my $message (@messages) { warn $message . "\n"; }
    }
    return 1;
}

sub analyze_class_symtab_entries {
    ( my $class ) = @_;
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

# [[[ OPERATIONS SPECIAL ]]]

# [ AUTOMATICALLY SET SYSTEM-DEPENDENT PATH VARIABLES ]
our $BASE_PATH    = undef;
our $INCLUDE_PATH = undef;    # all RPerl system modules live here
our $SCRIPT_PATH  = undef;    # interpreted RPerl system programs live here

if (   ( not exists $INC{'RPerl/Config.pm'} )
    or ( not defined $INC{'RPerl/Config.pm'} ) )
{
    Carp::croak
        'BIZARRE ERROR EINPL00: Non-existent or undefined Perl %INC path entry for RPerl/Config.pm, reported from within RPerl::Config, croaking';
}
my $rperl_config_pm_loaded = $INC{'RPerl/Config.pm'};
if ( not -e $rperl_config_pm_loaded ) {
    Carp::croak 'BIZARRE ERROR EINPL01: Non-existent file ',
        $rperl_config_pm_loaded,
        ' supposedly loaded in %INC, reported from within RPerl::Config, croaking';
}
( my $volume_loaded, my $directories_loaded, my $file_loaded )
    = File::Spec->splitpath( $rperl_config_pm_loaded, my $no_file = 0 );
my @directories_loaded_split = File::Spec->splitdir($directories_loaded);

#print {*STDERR} 'in RPerl::Config, have pre-pop @directories_loaded_split = ', "\n", Dumper(@directories_loaded_split), "\n";

# pop twice if empty entry on top
if ( pop @directories_loaded_split eq q{} ) { pop @directories_loaded_split; }
my $rperl_pm_wanted = File::Spec->catpath( $volume_loaded,
    ( File::Spec->catdir(@directories_loaded_split) ), 'RPerl.pm' );

#print {*STDERR} 'in RPerl::Config, have post-pop @directories_loaded_split = ', "\n", Dumper(@directories_loaded_split), "\n";
#print {*STDERR} 'in RPerl::Config, have $rperl_config_pm_loaded = ', $rperl_config_pm_loaded, "\n";
#print {*STDERR} 'in RPerl::Config, have $rperl_pm_wanted = ', $rperl_pm_wanted, "\n";

my $rperl_pm_loaded = undef;
if ( ( exists $INC{'RPerl.pm'} ) and ( defined $INC{'RPerl.pm'} ) ) {
    $rperl_pm_loaded = $INC{'RPerl.pm'};
# BULK88 20150608 2015.159: Win32 Bug Fix
#    if ( not -e $rperl_pm_loaded ) {
    if ( not -f $rperl_pm_loaded ) {
        Carp::croak 'BIZARRE ERROR EINPL02: Non-existent file ',
            $rperl_pm_loaded,
            ' supposedly loaded in %INC, reported from within RPerl::Config, croaking';
    }
}

# remove trailing '/'
if ( ( substr $directories_loaded, -1, 1 ) eq q{/} ) {
    $directories_loaded = substr $directories_loaded, 0, -1;
}

#print {*STDERR} 'in RPerl::Config, have $directories_loaded = ', $directories_loaded, "\n";
#print {*STDERR} 'in RPerl::Config, have $rperl_pm_loaded = ', ( $rperl_pm_loaded or '<undef>' ), "\n";

my $rperls_found    = [];
my $rperl_pms_found = [];
# BULK88 20150608 2015.159: Win32 Bug Fix
#foreach my $inc_path ( $directories_loaded, @INC ) {
foreach my $inc_path ( File::Spec->catpath($volume_loaded, $directories_loaded), @INC ) {

#    print {*STDERR} 'in RPerl::Config, top of main foreach() loop, have $inc_path = ', $inc_path, "\n";
    my $sub_inc_paths = [];
#    push @{$sub_inc_paths}, $inc_path;
    ( my $inc_volume, my $inc_directories, my $inc_file )
        = File::Spec->splitpath( $inc_path, my $no_file = 1 );
 
    push @{$sub_inc_paths}, $inc_directories;
 
    my @directories_split = File::Spec->splitdir($inc_directories);
    pop @directories_split;
    push @{$sub_inc_paths}, File::Spec->catdir(@directories_split);
    pop @directories_split;
    push @{$sub_inc_paths}, File::Spec->catdir(@directories_split);

#    print {*STDERR} 'in RPerl::Config, in main foreach() loop, have $sub_inc_paths = ', "\n", Dumper($sub_inc_paths), "\n";
#    print {*STDERR} 'in RPerl::Config, in main foreach() loop, have $inc_volume = ', "\n", Dumper($inc_volume), "\n";
#    print {*STDERR} 'in RPerl::Config, in main foreach() loop, have $inc_directories = ', "\n", Dumper($inc_directories), "\n";
#    print {*STDERR} 'in RPerl::Config, in main foreach() loop, have $inc_file = ', "\n", Dumper($inc_file), "\n";

    my $possible_rperls = [];
    foreach my $sub_inc_path ( @{$sub_inc_paths} ) {
        push @{$possible_rperls},
            File::Spec->catpath( $inc_volume, $sub_inc_path, 'rperl' );
        if ( $sub_inc_path ne q{} ) {
            push @{$possible_rperls},
                File::Spec->catpath( $inc_volume,
                File::Spec->catdir( $sub_inc_path, 'script' ), 'rperl' );
            push @{$possible_rperls},
                File::Spec->catpath( $inc_volume,
                File::Spec->catdir( $sub_inc_path, 'bin' ), 'rperl' );
        }
        else {
            push @{$possible_rperls},
                File::Spec->catpath( $inc_volume, 'script', 'rperl' );
            push @{$possible_rperls},
                File::Spec->catpath( $inc_volume, 'bin', 'rperl' );
        }
    }

    foreach my $possible_rperl ( @{$possible_rperls} ) {

#        print {*STDERR} 'in RPerl::Config, have $possible_rperl = ', $possible_rperl, "\n";
# BULK88 20150608 2015.159: Win32 Bug Fix
#        if ( ( -e $possible_rperl ) and ( -x $possible_rperl ) ) {
        if ( ( -f $possible_rperl ) and (  $^O eq 'MSWin32' ? 1 : -x $possible_rperl ) ) {
            my $is_unique = 1;
            foreach my $rperl_found ( @{$rperls_found} ) {
                if ( $rperl_found eq $possible_rperl ) { $is_unique = 0; }
            }
            if ($is_unique) { push @{$rperls_found}, $possible_rperl; }
        }
    }

    if ( not defined $rperl_pm_loaded ) {
        my $possible_rperl_pm = $inc_path . '/RPerl.pm';
# BULK88 20150608 2015.159: Win32 Bug Fix
#        if ( -e $possible_rperl_pm ) {
        if ( -f $possible_rperl_pm ) {
            my $is_unique = 1;
            foreach my $rperl_pm_found ( @{$rperl_pms_found} ) {
                if ( $rperl_pm_found eq $possible_rperl_pm ) {
                    $is_unique = 0;
                }
            }
            if ($is_unique) { push @{$rperl_pms_found}, $possible_rperl_pm; }
        }
    }
}

#print {*STDERR} 'in RPerl::Config, have $rperls_found = ', "\n", Dumper($rperls_found), "\n";
#print {*STDERR} 'in RPerl::Config, have $rperl_pms_found = ', "\n", Dumper($rperl_pms_found), "\n";

if ( scalar @{$rperls_found} == 0 ) {
    die 'ERROR EEXRP00: Failed to find `rperl` executable, dying' . "\n";
}
my $rperl_found = $rperls_found->[0];
if ( scalar @{$rperls_found} > 1 ) {
    RPerl::warning(
        'WARNING WEXRP00: Found multiple `rperl` executables, using first located, '
            . q{`}
            . $rperl_found . q{`}
            . "\n" );
}

my $rperl_pm_found = undef;
if ( defined $rperl_pm_loaded ) {
    $rperl_pm_found = $rperl_pm_loaded;
}
else {

    if ( scalar @{$rperl_pms_found} == 0 ) {
        Carp::croak 'ERROR EINRP00: Failed to find RPerl.pm module, croaking';
    }
    foreach my $rperl_pm_found_single ( @{$rperl_pms_found} ) {
        if ( $rperl_pm_found_single eq $rperl_pm_wanted ) {
            $rperl_pm_found = $rperl_pm_found_single;
        }
    }
    if ( not defined $rperl_pm_found ) {
        Carp::croak 'ERROR EINRP01: Expected to find ', $rperl_pm_wanted,
            ' but instead found ', "\n", Dumper($rperl_pms_found),
            ', croaking';
    }
}

#print {*STDERR} 'in RPerl::Config, have $rperl_pm_found = ', $rperl_pm_found, "\n";
#print {*STDERR} 'in RPerl::Config, have $rperl_found = ', $rperl_found, "\n";

#( my $volume_rperl_pm, my $directories_rperl_pm, my $file_rperl_pm ) = File::Spec->splitpath( $rperl_pm_found, $no_file = 0 );
#( my $volume_rperl, my $directories_rperl, my $file_rperl ) = File::Spec->splitpath( $rperl_found, $no_file = 0 );
( undef, my $directories_rperl_pm, my $file_rperl_pm )
    = File::Spec->splitpath( $rperl_pm_found, $no_file = 0 );
( undef, my $directories_rperl, my $file_rperl )
    = File::Spec->splitpath( $rperl_found, $no_file = 0 );

#print {*STDERR} 'in RPerl::Config, have $volume_rperl_pm = ', $volume_rperl_pm, "\n";
#print {*STDERR} 'in RPerl::Config, have $directories_rperl_pm = ', $directories_rperl_pm, "\n";
#print {*STDERR} 'in RPerl::Config, have $file_rperl_pm = ', $file_rperl_pm, "\n";
#print {*STDERR} 'in RPerl::Config, have $volume_rperl = ', $volume_rperl, "\n";
#print {*STDERR} 'in RPerl::Config, have $directories_rperl = ', $directories_rperl, "\n";
#print {*STDERR} 'in RPerl::Config, have $file_rperl = ', $file_rperl, "\n";

my @directories_rperl_pm_split = File::Spec->splitdir($directories_rperl_pm);
my @directories_rperl_split    = File::Spec->splitdir($directories_rperl);
my @directories_base_split     = ();

for my $i ( 0 .. ( ( scalar @directories_rperl_pm_split ) - 1 ) ) {
    if ( $directories_rperl_pm_split[$i] eq $directories_rperl_split[$i] ) {
        push @directories_base_split, $directories_rperl_pm_split[$i];
    }
    else {
        for my $j ( 0 .. ( $i - 1 ) ) {
            shift @directories_rperl_pm_split;
            shift @directories_rperl_split;
        }
        last;
    }
}

#print {*STDERR} 'in RPerl::Config, have @directories_base_split = ', "\n", Dumper(\@directories_base_split), "\n";
#print {*STDERR} 'in RPerl::Config, have @directories_rperl_pm_split = ', "\n", Dumper(\@directories_rperl_pm_split), "\n";
#print {*STDERR} 'in RPerl::Config, have @directories_rperl_split = ', "\n", Dumper(\@directories_rperl_split), "\n";

# NEED FIX: how do we catpath() with some $volume instead of catdir() below, without breaking relative paths?
$BASE_PATH = File::Spec->catdir(@directories_base_split);
if ( $BASE_PATH eq q{} ) {
    $INCLUDE_PATH = File::Spec->catdir(@directories_rperl_pm_split);
    $SCRIPT_PATH  = File::Spec->catdir(@directories_rperl_split);
#    print {*STDERR} 'in RPerl::Config, have $BASE_PATH eq q{} = ', $BASE_PATH, "\n";
}
else {
    $INCLUDE_PATH
        = File::Spec->catdir( $BASE_PATH, @directories_rperl_pm_split );
    $SCRIPT_PATH = File::Spec->catdir( $BASE_PATH, @directories_rperl_split );
#    print {*STDERR} 'in RPerl::Config, have $BASE_PATH ne q{} ', $BASE_PATH, "\n";
}

#print {*STDERR} 'in RPerl::Config, have $BASE_PATH = ', $BASE_PATH, "\n";
#print {*STDERR} 'in RPerl::Config, have $INCLUDE_PATH = ', $INCLUDE_PATH, "\n";
#print {*STDERR} 'in RPerl::Config, have $SCRIPT_PATH = ', $SCRIPT_PATH, "\n";

1;    # end of package
