#!/usr/bin/perl

use strict;
use warnings;
our $VERSION = 0.005_000;
use ExtUtils::MakeMaker;

BEGIN { use English; }

push( @ExtUtils::MakeMaker::Overridable, qw(pm_to_blib) )
    if ( $OSNAME eq 'MSWin32' );

WriteMakefile(
    NAME             => 'RPerl',
    ABSTRACT         => 'Restricted Perl, The Optimizing Perl 5 Compiler',
    AUTHOR           => 'Will Braswell <wbraswell@cpan.org>',
    VERSION_FROM     => 'lib/RPerl.pm',
    LICENSE          => 'perl_5',
    EXE_FILES        => ['script/rperl'],
    MIN_PERL_VERSION => '5.10.0',  # NEED ANSWER, CORRELATION #rp000: is RPerl truly incompatible with Perl v5.8 and earlier?
#    MAKE             => 'gmake',   # CORRELATION #rp200, Windows + EU::MM + GNU makef
    PREREQ_PM        => {
        # RPERL USER DEPENDENCIES
        'ExtUtils::MakeMaker' => 7.04,     # for compatibility with Inline::C >= v0.75
        'Test::Exception'     => 0.43,     # 0.43 needed because Appveyor testing required it
        'Test::CPAN::Changes' => 0.400002,
        'Test::Number::Delta' => 1.06,     # for compatibility with Perls compiled using -Duselongdouble
        'Perl::Critic'        => 1.121,
        'Perl::Tidy'          => 20140711,
        'Inline'              => 0.80,
        'Inline::C'           => 0.76,     # wbraswell added CPPFLAGS
        'Inline::CPP'         => 0.74,     # davido & mohawk fixed ntype warnings; davido & wbraswell fixed namespace hack; nanis fixed Win32 filename space bug
        'Inline::Filters'     => 0.18,     # wbraswell, rurban, & bulk88 added preprocess inc array; wbraswell added CPPFLAGS; bulk88 fix space in path
        'PadWalker'           => 2.1,
        'Module::Refresh'     => 0.17,
        'Filter::Simple'      => 0.91,
        'Module::ScanDeps'    => 1.19,
        'Time::HiRes'         => 1.9726,
        'List::MoreUtils'     => 0.33,
        'Math::BigInt::GMP'   => 1.46,

        # RPERL SYSTEM (NON-USER) DEPENDENCIES
        'Parse::Eyapp'        => 1.182,    # RPerl Grammar; used by grammar_recompile.sh
        'File::Which'         => 1.21,     # RPerl Grammar; used by grammar_increment.pl
        'CPAN::Meta'          => 2.150005, # CPAN Distribution Build; used for generating CPAN metadata from this file
        'App::Pod2CpanHtml'   => 0.04,     # Learning RPerl; used by pod2rperlhtml.pl, provides pod2cpanhtml
        'Date::Format'        => 2.24,     # Learning RPerl; used by pod2rperlhtml.pl
        'Pod::PseudoPod'      => 0.18,     # Learning RPerl; provides ppodchecker, ppod2txt, ppod2html, ppod2docbook
        'Text::ASCIITable'    => 0.20,     # Learning RPerl; used by pod2text & ppod2txt
	'IPC::Run3'           => 0.048     # RPerl Compiler; used for internals (subcompile, testing)
    },
    META_MERGE => {
        'meta-spec' => {
            version => 2,
            url     => 'https://metacpan.org/pod/CPAN::Meta::Spec'
        },

        # NEED FIX: no_index is a temporary solution to the CPAN indexing and data type package naming issue
        # mst says we need to set data type package names without using 'package FOO;' like how Lexical::Types works
        no_index => {

            # DEV NOTE: the following package namespaces are already controlled by some other PAUSE owner on CPAN,
            # their indexing is double-disabled in that they are both listed here and also given newlines-in-package-declarations
            package => [ 'array', 'boolean', 'hash', 'integer', 'method', 'number', 'object', 'ref', 'string', 'unknown' ],

            # DEV NOTE: disable indexing of all test package namespaces
            namespace => ['RPerl::Test'],
        },
        release_status => 'stable',
        keywords       => [qw(rperl perl5 optimizing compiler optimize compile)],
        description    => 'RPerl is the optimizing compiler for the Perl 5 programming language.  '
            . 'RPerl compiles slow low-magic Perl 5 code into fast binary code, which can optionally be mixed back into high-magic Perl apps.',
        resources => {
            license    => ['http://dev.perl.org/licenses/'],
            homepage   => 'http://www.rperl.org',
            bugtracker => { web => 'http://rt.cpan.org/Public/Dist/Display.html?Name=RPerl' },
            repository => {
                type => 'git',
                url  => 'git://github.com/wbraswell/rperl.git',
                web  => 'https://github.com/wbraswell/rperl',
            },
            x_IRC         => "irc://irc.perl.org/#perl11",
#            x_mailinglist => "http://lists.rperl.org/listinfo/dev",
#            x_wiki        => "http://wiki.rperl.org/",
        },
    },

    # NEED UPDATE, CORRELATION #rp005: list of _Inline directories to delete/exclude in Makefile.PL, .gitignore, and MANIFEST.SKIP
    # NEED UPDATE, CORRELATION #rp006: list of CPAN files & directories to delete/exclude in Makefile.PL, .gitignore, and MANIFEST.SKIP
    # NEED UPDATE, CORRELATION #rp013: list of RPerl build files & directories to delete/exclude in Makefile.PL, .gitignore, and MANIFEST.SKIP
    clean => {
        FILES =>
            'pod2htmd.tmp Makefile.old MANIFEST.bak lib/RPerl/Algorithm.pmc lib/RPerl/Algorithm.h lib/RPerl/Algorithm.cpp lib/RPerl/Algorithm/Inefficient.pmc lib/RPerl/Algorithm/Inefficient.h lib/RPerl/Algorithm/Inefficient.cpp lib/RPerl/Algorithm/Sort.pmc lib/RPerl/Algorithm/Sort.h lib/RPerl/Algorithm/Sort.cpp lib/RPerl/Algorithm/Sort/Bubble.pmc lib/RPerl/Algorithm/Sort/Bubble.h lib/RPerl/Algorithm/Sort/Bubble.cpp lib/RPerl/Test.pmc lib/RPerl/Test.h lib/RPerl/Test.cpp lib/RPerl/Test/Fu.pmc lib/RPerl/Test/Foo.pmc lib/RPerl/Test/Foo.h lib/RPerl/Test/Foo.cpp lib/RPerl/Test/Subclass/MySubclasserA_Good.pmc lib/RPerl/Test/Subclass/MySubclasserA_Good.h lib/RPerl/Test/Subclass/MySubclasserA_Good.cpp lib/RPerl/Test/Subclass/MySubclasserB_Good.pmc lib/RPerl/Test/Subclass/MySubclasserB_Good.h lib/RPerl/Test/Subclass/MySubclasserB_Good.cpp lib/RPerl/Test/Subclass/MySubclasserCDE_Good.pmc lib/RPerl/Test/Subclass/MySubclasserCDE_Good.h lib/RPerl/Test/Subclass/MySubclasserCDE_Good.cpp lib/rperltypes_mode.h.orig lib/rperltypes_mode.h.swap _Inline lib/_Inline lib/RPerl/Algorithm/Sort/_Inline script/_Inline script/development/_Inline script/development/unused/_Inline t/_Inline lib/RPerl/Test/OperationsTypesReporting/_Inline lib/RPerl/Test/Module/_Inline lib/RPerl/Test/Properties/_Inline lib/RPerl/Test/Type_Types/_Inline lib/RPerl/Operation/Statement/_Inline lib/RPerl/DataStructure/Array/_Inline lib/RPerl/_Inline lib/RPerl/CompileUnit/_Inline lib/RPerl/DataType/_Inline lib/RPerl/Operation/Expression/Operator/_Inline'

    },
);

package MY;
BEGIN { use English; }

sub pm_to_blib {
    my $self = shift;
    my $blib = $self->SUPER::pm_to_blib(@_);

    # un-read-only blib/lib for tests to pass, files are modified at runtime there
    if ( $OSNAME eq 'MSWin32' ) {
        my ( $lastline, $start ) = qq{\t\$(NOECHO) \$(TOUCH) pm_to_blib\n};
        ( $start = index( $blib, $lastline ) ) == -1
            && die "Can't find replacement string for pm_to_blib target";
        substr( $blib, $start, 0, "\t" . 'attrib -R /S  blib/lib/*' . "\n" );
    }
    return $blib;
}

# disable PERL_DL_NONLAZY=1 to avoid C++ compile errors for GMP library (and possibly others)
sub test_via_harness {
    my $self = shift;
    my $command = $self->MM::test_via_harness(@_);
    $command =~ s/\bPERL_DL_NONLAZY=1\s+//gxms;
    return $command;
}

sub test_via_script {
    my $self = shift;
    my $command = $self->MM::test_via_script(@_);
    $command =~ s/\bPERL_DL_NONLAZY=1\s+//gxms;
    return $command;
}
