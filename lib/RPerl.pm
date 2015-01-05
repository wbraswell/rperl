# [[[ HEADER SPECIAL ]]]
package RPerl;
use strict;
use warnings;

our $VERSION = 1.000_002;    # ONE POINT OH BETA TWO!!!

#our $VERSION = 20141225;    # NON-RELEASE VERSION

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 5: allow <STDIN> prompt
## no critic qw(ProhibitStringyEval)  # SYSTEM DEFAULT 1: allow eval()
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES SPECIAL ]]]
require RPerl::Config;

#no magic;  # require data types, full declarations, other non-magic
#use rperltypes;  # circular dependency causes "subroutine DUMPER redefined" error, solved by replacing use with require below
require rperltypes;

# [[[ OO CLASS PROPERTIES SPECIAL ]]]

# see perl_modes.txt for more info
our $OPS_TYPES_IDS_DECODED = {
    0 => { ops => 'PERL', types => 'PERL_STATIC' },
    1 => { ops => 'CPP',  types => 'PERL_STATIC' },
    2 => { ops => 'CPP',  types => 'CPP' }
};

# data type checking mode, disabled in RPerl system code which calls 'use RPerl;',
# changed on a per-file basis by preprocessor directive, see RPerl::CompileUnit::Module::Class::INIT
# NEED UPGRADE: enable in RPerl system code when boostrapping compiler
our $CHECK = 'OFF';
our $DEBUG = 0; # Perl variable $RPerl::DEBUG and environmental variable RPERL_DEBUG are equivalent, see diag*() below
our $VERBOSE = 0; # Perl variable $RPerl::VERBOSE and environmental variable RPERL_VERBOSE are equivalent, see verbose*() below

# [[[ SUBROUTINES SPECIAL ]]]

# NEED UPGRADE: replace Data::Dumper with pure-RPerl equivalent?
sub DUMPER {
    ( my $dumpee ) = @_;

#	die ('in RPerl::DUMPER(), received undef argument, dying') if (not(defined($_[0])));
    return '**UNDEF**' if ( not( defined $dumpee ) );
    return $dumpee->DUMPER()
        if ( defined( eval( q{$} . ref($dumpee) . q{::DUMPER} ) ) );
    return Dumper($dumpee);
}

# NEED UPGRADE: enable variable number of arguments as seen below
sub diag {

    #    ( my $message ) = @_;
    my @messages = @_;

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

1;    # end of class
