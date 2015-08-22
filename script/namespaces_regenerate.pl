#!/usr/bin/perl
use strict;
use warnings;
use rperlnamespaces;
our $VERSION = 0.001_020;

## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN>

print 'ARE YOU AN RPERL SYSTEM DEVELOPER? ';
my $stdin_confirm = <STDIN>;
if ( $stdin_confirm =~ /^[Yy]/ ) {
    print 'Regenerating RPerl Namespaces...' . "\n";
}
else {
    exit;
}

my $namespaces_filename = 'lib/rperlnamespaces_generated.pm';

use English qw(-no_match_vars);
use Data::Dumper;
$Data::Dumper::Sortkeys = 1;

package main;
my $namespaces_core = rperlnamespaces::hash();

#print 'have $namespaces_core_string = ' . "\n" . $namespaces_core_string . "\n\n";

# NEED FIX: remove hard-coded list of packages
# DEV NOTE, CORRELATION #rp03: some RPerl packages are missed due to BEGIN{} or INIT{} blocks, etc.
my $namespaces_rperl_missed = { 
    # DEV NOTE, CORRELATION #rp21: remove hard-coded fake 'rperl::' namespace?
    'rperl::' => 1,
    'rperlnames::' => 1,
    'rperlnamespaces::' => 1,
    'rperlnamespaces_generated::' => 1,
    'rperltypes::' => 1,
    'rperloperations::' => 1,
    'rperlrules::' => 1,
    'rperlsse::' => 1,
};

# NEED FIX: remove hard-coded list of packages
# NEED UPDATE: some of these should be in core
my $namespaces_rperl_deps = {
    'AutoSplit::'    => 1,
    'AutoLoader::'    => 1,
    'Class::'        => 1,
    'Clone::'        => 1,
    'Config::'       => 1,
    'Config_git::'   => 1,
    'Config_heavy::' => 1,
    'CPAN::'         => 1,
    'Cwd::'          => 1,
    'Devel::'       => 1,
    'Digest::'       => 1,
    'DirHandle::'    => 1,
    'Dos::'          => 1,
    'EPOC::'         => 1,
    'Email::'       => 1,
    'Encode::'       => 1,
    'Env::'       => 1,
    'Exception::'     => 1,
    'ExtUtils::'     => 1,
    'Fcntl::'        => 1,
    'File::'         => 1,
    'FileHandle::'   => 1,
    'Filter::'       => 1,
    'FindBin::'      => 1,
    'Getopt::'      => 1,
    'HTML::' => 1,
    'I18N::'         => 1,
    'Inline::'       => 1,
    'IPC::'          => 1,
    'List::'         => 1,
    'Lingua::'         => 1,
    'Locale::'       => 1,
    'Log::'          => 1,
    'MIME::'         => 1,
    'Module::'       => 1,
    'POSIX::'        => 1,
    'PadWalker::'    => 1,
    'Params::'       => 1,
    'Parse::'        => 1,
    'Path::'        => 1,
    'Perl::'        => 1,
    'Pod::'        => 1,
    'PPI::'        => 1,
    'PPIx::'        => 1,
    'Readonly::'  => 1,
    'Role::'   => 1,
    'SelectSaver::'  => 1,
    'SelfLoader::'   => 1,
    'Socket::'       => 1,
    'Storable::'     => 1,
    'String::'  => 1,
    'Symbol::'       => 1,
    'Sub::'       => 1,
    'Term::'         => 1,
    'Test::'         => 1,
    'Text::'         => 1,
    'Time::'         => 1,
    'VMS::'          => 1,
    'Win32::'        => 1,
    'auto::'         => 1,
    'base::'         => 1,
    'charnames::'         => 1,
    '_charnames::'         => 1,
    'bytes_heavy::'  => 1,
    'deprecate::'  => 1,
    'feature::'      => 1,
    'fields::'       => 1,
    'if::'           => 1,
    'integer::'      => 1,    # NEED FIX: this is also an RPerl data type
    'locale::'       => 1,
    'parent::'       => 1,
    'psSnake::'      => 1,
    're::'           => 1,
    'unicore::'      => 1,
    'utf8_heavy::'   => 1,
};

# NEED ADDRESS: should we not be doing 'use RPerl;' below now that it does filter()???  replace w/ 'use RPerl::AFilter;' ???
eval 'use RPerl';
my $namespaces_rperl = rperlnamespaces::hash();
$namespaces_rperl = { %{$namespaces_rperl}, %{$namespaces_rperl_missed} };

# separate RPerl namespaces and Perl core namespaces
foreach my $namespace ( keys %{$namespaces_rperl} ) {
    if ( exists $namespaces_core->{$namespace} ) {
        if ( $namespace =~ /rperl/ ) {
            delete $namespaces_core->{$namespace};
        }
        else {
            delete $namespaces_rperl->{$namespace};
        }
    }
}

# remove RPerl dependency namespaces from RPerl namespaces
foreach my $namespace_rperl_dep ( keys %{$namespaces_rperl_deps} ) {
    if ( exists $namespaces_rperl->{$namespace_rperl_dep} ) {
        delete $namespaces_rperl->{$namespace_rperl_dep};
    }
}

my $namespaces_core_string = Dumper($namespaces_core);
$namespaces_core_string =~ s/\$VAR1/\$rperlnamespaces_generated::CORE/gxms;
my $namespaces_rperl_deps_string = Dumper($namespaces_rperl_deps);
$namespaces_rperl_deps_string =~ s/\$VAR1/\$rperlnamespaces_generated::RPERL_DEPS/gxms;
my $namespaces_rperl_string = Dumper($namespaces_rperl);
$namespaces_rperl_string =~ s/\$VAR1/\$rperlnamespaces_generated::RPERL/gxms;

#print 'have $namespaces_rperl_string = ' . "\n" . $namespaces_rperl_string . "\n\n";

my $namespaces_generated = <<'EOF';
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names
package  # hide from PAUSE indexing
    rperlnamespaces_generated;
use strict;
use warnings;
our $VERSION = 0.001_000;

## no critic qw(ProhibitParensWithBuiltins ProhibitNoisyQuotes)  # SYSTEM SPECIAL 3: allow auto-generated code

$rperlnamespaces_generated::CORE = undef;
EOF

$namespaces_generated .= $namespaces_core_string . "\n";
$namespaces_generated .= q{$rperlnamespaces_generated::RPERL_DEPS = undef;} . "\n";
$namespaces_generated .= $namespaces_rperl_deps_string . "\n";
$namespaces_generated .= q{$rperlnamespaces_generated::RPERL = undef;} . "\n";
$namespaces_generated .= $namespaces_rperl_string . "\n";
$namespaces_generated .= q{1;} . "\n";

#print 'have $namespaces_generated = ' . "\n" . $namespaces_generated . "\n\n";

my $open_close_retval = open my $NAMESPACES_FILEHANDLE_OUT, '>', $namespaces_filename;
if ( not $open_close_retval ) {
    croak( 'ERROR ERPNS00: Problem opening output file ' . q{'} . $namespaces_filename . q{': } . $OS_ERROR, 'croaking' );
}

print {$NAMESPACES_FILEHANDLE_OUT} $namespaces_generated;

$open_close_retval = close $NAMESPACES_FILEHANDLE_OUT;
if ( not $open_close_retval ) {
    croak( 'ERROR ERPNS01: Problem closing output file ' . q{'} . $namespaces_filename . q{': } . $OS_ERROR, 'croaking' );
}

system 'perltidy', '-pbp', '--ignore-side-comment-lengths', '--converge', '-b', '-nst', q{-bext='/'}, '-q', $namespaces_filename;

print 'Regenerating RPerl Namespaces... DONE!' . "\n";
