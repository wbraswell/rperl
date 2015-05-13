#!/usr/bin/perl
use strict;
use warnings;
use rperlnamespaces;
our $VERSION = 0.001_000;

## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN>

print 'ARE YOU AN RPERL SYSTEM DEVELOPER? ';
my $stdin_confirm = <STDIN>;
if ($stdin_confirm =~ /^[Yy]/) {
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

# NEED FIX: remove hard-coded list of missed packages
# DEV NOTE, CORRELATION #03: some RPerl packages are missed due to BEGIN{} or INIT{} blocks, etc.
my $namespaces_rperl_missed = {
    'Digest::'         => 1,
    'FindBin::'        => 1,
    'Inline::'         => 1,
    'MIME::'           => 1,
    'PadWalker::'      => 1,
    'Socket::'         => 1,
    'hashref_method::' => 1
};

eval 'use RPerl';
my $namespaces_rperl = rperlnamespaces::hash();
$namespaces_rperl = {%{$namespaces_rperl}, %{$namespaces_rperl_missed}};
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

my $namespaces_core_string = Dumper($namespaces_core);
$namespaces_core_string =~ s/\$VAR1/\$rperlnamespaces_generated::core/gxms;
my $namespaces_rperl_string = Dumper($namespaces_rperl);
$namespaces_rperl_string =~ s/\$VAR1/\$rperlnamespaces_generated::rperl/gxms;

#print 'have $namespaces_rperl_string = ' . "\n" . $namespaces_rperl_string . "\n\n";

my $namespaces_generated = <<'EOF';
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names
package rperlnamespaces_generated;
use strict;
use warnings;
our $VERSION = 0.001_000;

## no critic qw(ProhibitParensWithBuiltins ProhibitNoisyQuotes)  # SYSTEM SPECIAL 3: allow auto-generated code
## no critic qw(ProhibitPackageVars)  # SYSTEM SPECIAL 4d: allow $rperlnamespaces::*

$rperlnamespaces_generated::core = undef;
EOF

$namespaces_generated .= $namespaces_core_string . "\n";
$namespaces_generated .= q{$rperlnamespaces_generated::rperl = undef;} . "\n";
$namespaces_generated .= $namespaces_rperl_string . "\n";
$namespaces_generated .= q{1;} . "\n";

#print 'have $namespaces_generated = ' . "\n" . $namespaces_generated . "\n\n";

my $open_close_retval = open my $NAMESPACES_FILEHANDLE_OUT, '>',
    $namespaces_filename;
if ( not $open_close_retval ) {
    croak(
        'ERROR XYZZY: Problem opening output file ' . q{'}
            . $namespaces_filename . q{': }
            . $OS_ERROR,
        'croaking'
    );
}

print {$NAMESPACES_FILEHANDLE_OUT} $namespaces_generated;

$open_close_retval = close $NAMESPACES_FILEHANDLE_OUT;
if ( not $open_close_retval ) {
    croak(
        'ERROR XYZZY: Problem closing output file ' . q{'}
            . $namespaces_filename . q{': }
            . $OS_ERROR,
        'croaking'
    );
}

system 'perltidy', '-pbp', '--ignore-side-comment-lengths', '--converge',
    '-b', '-nst', q{-bext='/'}, '-q', $namespaces_filename;

print 'Regenerating RPerl Namespaces... DONE!' . "\n"; 
