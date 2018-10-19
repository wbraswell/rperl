#!/usr/bin/env perl
use strict;
use warnings;
use rperlnamespaces;
our $VERSION = 0.017_000;

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

#print 'in namespaces_regenerate.pl main::, about to call rperlnamespaces::hash()...', "\n";
my $namespaces_core = rperlnamespaces::hash();
#print 'in namespaces_regenerate.pl main::, ret from rperlnamespaces::hash(), have $namespaces_core = ', Dumper($namespaces_core), "\n";

# do not call Module::ScanDeps in RPerl.pm on files in the following namespaces
# DEV NOTE, CORRELATION #rp050: hard-coded list of RPerl files/packages/namespaces
my $namespaces_noncompiled = {
    'Acme::' => 1,
    'Algorithm::' => 1,
    'Archive::' => 1,
    'Array::' => 1,
    'Attribute::' => 1,
    'Authen::' => 1,
    'Benchmark::' => 1,
    'CGI::' => 1,
    'Compress::' => 1,
    'Cookie::' => 1,
    'Cpanel::' => 1,
    'Crypt::' => 1,
    'DBD::' => 1,
    'DBI::' => 1,
    'Date::' => 1,
    'Excel::' => 1,
    'FFI::' => 1,
    'Geo::' => 1,
    'HTTP::' => 1,
    'Hash::' => 1,
    'Hook::' => 1,
    'Import::' => 1,
    'IS::' => 1,
    'LWP::' => 1,
    'Mail::' => 1,
    'MooX::' => 1,
    'MooseX::' => 1,
    'Net::' => 1,
    'Number::' => 1,
    'Opcode::' => 1,
    'Plack::' => 1,
    'RPC::' => 1,
    'Sereal::' => 1,
    'StackTrace::' => 1,
    'Statistics::' => 1,
    'Stream::' => 1,
    'TAP::' => 1,
    'Throwable::' => 1,
    'Tree::' => 1,
    'URI::' => 1,
    'Unicode::' => 1,
    'WWW::' => 1,
    'XML::' => 1,
    'ZMQ::' => 1,
    'autouse::' => 1,
    'metaclass::' => 1,
    'subs::' => 1,
};

# DEV NOTE, CORRELATION #rp050: hard-coded list of RPerl files/packages/namespaces
# DEV NOTE, CORRELATION #rp003: some RPerl packages are missed due to BEGIN{} or INIT{} blocks, etc.
my $namespaces_rperl_missed = { 
    # DEV NOTE, CORRELATION #rp021: remove hard-coded fake 'rperl::' namespace?
    'rperl::' => 1,
    'rperlnames::' => 1,
    'rperlnamespaces::' => 1,
    'rperlnamespaces_generated::' => 1,
    'rperltypes::' => 1,
    'rperltypesconv::' => 1,
    'rperltypessizes::' => 1,
    'rperloperations::' => 1,
    'rperloptions::' => 1,
    'rperlrules::' => 1,
    'rperlsse::' => 1,
    'rperlgmp::' => 1,
    'rperlgsl::' => 1,
    'RPerl::Support::' => 1,
    'RPerl::Support::MongoDB::' => 1,
    'perlapinames_generated::' => 1,
};

# DEV NOTE, CORRELATION #rp050: hard-coded list of RPerl files/packages/namespaces
my $filenames_rperl = {
    # forward slash
    'RPerl/CompileUnit/Module/Class.pm' => 1,
    'RPerl/AfterSubclass.pm' => 1,
    'RPerl/Config.pm' => 1,
    'RPerl/HelperFunctions_cpp.pm' => 1,
    'RPerl/Inline.pm' => 1,
    'RPerl/Exporter.pm' => 1,
    'RPerl/Support.pm' => 1,
    'RPerl/Support/MongoDB.pm' => 1,

    # backslash
    'RPerl\CompileUnit\Module\Class.pm' => 1,
    'RPerl\AfterSubclass.pm' => 1,
    'RPerl\Config.pm' => 1,
    'RPerl\HelperFunctions_cpp.pm' => 1,
    'RPerl\Inline.pm' => 1,
    'RPerl\Exporter.pm' => 1,
    'RPerl\Support.pm' => 1,
    'RPerl\Support\MongoDB.pm' => 1,

    # no slash
    'RPerl.pm' => 1,
    'rperlnames.pm' => 1,
    'rperlnamespaces.pm' => 1,
    'rperlnamespaces_generated.pm' => 1,
    'rperltypes.pm' => 1,
    'rperltypesconv.pm' => 1,
    'rperltypessizes.pm' => 1,
    'rperloperations.pm' => 1,
    'rperloptions.pm' => 1,
    'rperlrules.pm' => 1,
    'rperlsse.pm' => 1,
    'rperlgmp.pm' => 1,
    'rperlgsl.pm' => 1,
    'perlapinames_generated.pm' => 1,
};

# DEV NOTE, CORRELATION #rp050: hard-coded list of RPerl files/packages/namespaces
# NEED UPDATE: some of these should be in core
my $namespaces_rperl_deps = {
    # BEGIN DEPENDENCY BLOCK, all subdependencies of MongoDB?
    'Authen::'                                => 1,
    'Cross::'                                 => 1,
    'Does::'                                  => 1,
    'Error::'                                 => 1,
    'FFI::'                                   => 1,
    'FakeLocale::'                            => 1,
    'MM::'                                    => 1,
    'MY::'                                    => 1,
    'Mango::'                                 => 1,
    'Mouse::'                                 => 1,
    'Mozilla::'                               => 1,
    'Net::'                                   => 1,
    'Object::'                                => 1,
    'Ref::'                                   => 1,
    'Unicode::'                               => 1,
    'Validation::'                            => 1,
    'f845a9c1ac41be33::'                      => 1,
    'flock::'                                 => 1,
    'isn::'                                   => 1,
    'maybe::'                                 => 1,
    'next::'                                  => 1,
    'strictures::'                            => 1,
    'swig_runtime_data::'                     => 1,
    # END DEPENDENCY BLOCK

    'Alien::'    => 1,
    'AutoSplit::'    => 1,
    'AutoLoader::'    => 1,
    'BSON::'         => 1,  # subdependency of MongoDB?
    'Capture::'      => 1,
    'Class::'        => 1,
    'Clone::'        => 1,
    'Config::'       => 1,
    'Config_git::'   => 1,
    'Config_heavy::' => 1,
    'CPAN::'         => 1,
    'Cwd::'          => 1,
    'DateTime::'       => 1,
    'Devel::'       => 1,
    'Digest::'       => 1,
    'DirHandle::'    => 1,
    'Dos::'          => 1,
    'EPOC::'         => 1,
    'Email::'       => 1,
    'Encode::'       => 1,
    'Env::'       => 1,
    'Eval::'       => 1,
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
    'JSON::'         => 1,
    'List::'         => 1,
    'Lingua::'         => 1,
    'Locale::'       => 1,
    'Log::'          => 1,
    'MIME::'         => 1,
    'Math::'         => 1,
    'Method::'         => 1,  # subdependency of Moo(se)
    'Module::'       => 1,
    'MongoDB::'       => 1,
    'Moo::'       => 1,
    'Moose::'       => 1,
    'MRO::'         => 1,
    'POSIX::'        => 1,
    'PadWalker::'    => 1,
    'Package::'    => 1,
    'Params::'       => 1,
    'Parse::'        => 1,
    'Path::'        => 1,
    'Perl::'        => 1,
    'Pod::'        => 1,
    'PPI::'        => 1,
    'PPIx::'        => 1,
    'Readonly::'  => 1,
    'Role::'   => 1,
    'Safe::'     => 1,
    'SDL_perl::'     => 1,
    'SDL::'          => 1,
    'SDLx::'         => 1,
    'SelectSaver::'  => 1,
    'SelfLoader::'   => 1,
    'Socket::'       => 1,
    'Specio::'       => 1,  # subdependency of MongoDB
    'Storable::'     => 1,
    'String::'  => 1,
    'Symbol::'       => 1,
    'Syntax::'       => 1,
    'Sys::'       => 1,
    'Sub::'       => 1,
    'Term::'         => 1,
    'Test::'         => 1,
    'Test2::'         => 1,
    'Text::'         => 1,
    'Tie::'          => 1,
    'Time::'         => 1,
    'Try::'         => 1,
    'Type::'       => 1,  # subdependency of MongoDB
    'Types::'       => 1,  # subdependency of MongoDB
    'Variable::'          => 1,
    'VMS::'          => 1,
    'Win32::'        => 1,
    'auto::'         => 1,
    'base::'         => 1,
    'charnames::'         => 1,
    '_charnames::'         => 1,
    'attributes::'  => 1,
    'boolean::'  => 1,
    'bytes_heavy::'  => 1,
    'deprecate::'  => 1,
    'feature::'      => 1,
    'fields::'       => 1,
    'if::'           => 1,
    'integer::'      => 1,    # NEED FIX: this is also an RPerl data type, duplicate entry below
    'locale::'       => 1,
    'namespace::'       => 1,
    'parent::'       => 1,
    'psSnake::'      => 1,
    're::'           => 1,
    'ref::'          => 1,
    'strict::'       => 1,
    'unicore::'      => 1,
    'utf8_heavy::'   => 1,
    'vars::'         => 1,
    'warnings::'     => 1,
};

# DEV NOTE: can not use eval{}, must use stringy eval
eval 'use RPerl::AfterSubclass';
eval 'use rperlsse';
eval 'use rperlgmp';
eval 'use rperlgsl';
eval 'use RPerl::Support';
eval 'use RPerl::Support::MongoDB';
eval 'use perlapinames_generated';

#print 'in namespaces_regenerate.pl main::, after evals, about to call rperlnamespaces::hash()...', "\n";
my $namespaces_rperl = rperlnamespaces::hash();
#print 'in namespaces_regenerate.pl main::, after evals, ret from rperlnamespaces::hash(), have $namespaces_rperl = ', Dumper($namespaces_rperl), "\n";

$namespaces_rperl = { %{$namespaces_rperl}, %{$namespaces_rperl_missed} };

# separate RPerl namespaces and Perl core namespaces; discard Inline build eval_XX_YYYY namespaces
foreach my $namespace ( keys %{$namespaces_rperl} ) {
    if ( exists $namespaces_core->{$namespace} ) {
        if ( $namespace =~ /rperl/ ) {
            delete $namespaces_core->{$namespace};
        }
        else {
            delete $namespaces_rperl->{$namespace};
        }
    }
    elsif ((substr $namespace, 0, 5) eq 'eval_') {
        delete $namespaces_rperl->{$namespace};
    }
}

# remove RPerl dependency namespaces from RPerl namespaces
foreach my $namespace_rperl_dep ( keys %{$namespaces_rperl_deps} ) {
    # NEED FIX: allow 'integer::' duplicate entry
    if (($namespace_rperl_dep ne 'integer::') and ( exists $namespaces_rperl->{$namespace_rperl_dep})) {
        delete $namespaces_rperl->{$namespace_rperl_dep};
    }
}

my $namespaces_noncompiled_string = Dumper($namespaces_noncompiled);
$namespaces_noncompiled_string =~ s/\$VAR1/\$rperlnamespaces_generated::NONCOMPILED/gxms;
my $namespaces_core_string = Dumper($namespaces_core);
$namespaces_core_string =~ s/\$VAR1/\$rperlnamespaces_generated::CORE/gxms;
my $namespaces_rperl_deps_string = Dumper($namespaces_rperl_deps);
$namespaces_rperl_deps_string =~ s/\$VAR1/\$rperlnamespaces_generated::RPERL_DEPS/gxms;
my $namespaces_rperl_string = Dumper($namespaces_rperl);
$namespaces_rperl_string =~ s/\$VAR1/\$rperlnamespaces_generated::RPERL/gxms;
my $filenames_rperl_string = Dumper($filenames_rperl);
$filenames_rperl_string =~ s/\$VAR1/\$rperlnamespaces_generated::RPERL_FILES/gxms;

#print 'have $namespaces_rperl_string = ' . "\n" . $namespaces_rperl_string . "\n\n";

my $namespaces_generated = <<'EOF';
# THIS FILE IS AUTOMATICALLY GENERATED BY   script/development/namespaces_regenerate.pl
# DO NOT EDIT THIS FILE DIRECTLY!!!  please put all changes in namespaces_regenerate.pl
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names
package  # hide from PAUSE indexing
    rperlnamespaces_generated;
use strict;
use warnings;
our $VERSION = 0.001_000;

## no critic qw(ProhibitParensWithBuiltins ProhibitNoisyQuotes)  # SYSTEM SPECIAL 3: allow auto-generated code

EOF

$namespaces_generated .= q{$rperlnamespaces_generated::NONCOMPILED = undef;} . "\n";
$namespaces_generated .= $namespaces_noncompiled_string . "\n";
$namespaces_generated .= q{$rperlnamespaces_generated::CORE = undef;} . "\n";
$namespaces_generated .= $namespaces_core_string . "\n";
$namespaces_generated .= q{$rperlnamespaces_generated::RPERL_DEPS = undef;} . "\n";
$namespaces_generated .= $namespaces_rperl_deps_string . "\n";
$namespaces_generated .= q{# DEV NOTE, CORRELATION #rp051: hard-coded list of RPerl data types and data structures [AUTOMATICALLY GENERATED BY script/development/namespaces_regenerate.pl]} . "\n";
$namespaces_generated .= q{# DEV NOTE, CORRELATION #rp054: auto-generation of OO property accessors/mutators checks the auto-generated RPerl type list for base data types to determine if the entire data structure can be returned by setting ($return_whole = 1)} . "\n";
$namespaces_generated .= q{$rperlnamespaces_generated::RPERL = undef;} . "\n";
$namespaces_generated .= $namespaces_rperl_string . "\n";
$namespaces_generated .= q{$rperlnamespaces_generated::RPERL_FILES = undef;} . "\n";
$namespaces_generated .= $filenames_rperl_string . "\n";
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
