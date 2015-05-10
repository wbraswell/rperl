use strict;
use warnings;
our $VERSION = 0.001_070;
use ExtUtils::MakeMaker;

BEGIN { use English; }

push( @ExtUtils::MakeMaker::Overridable, qw(pm_to_blib) )
    if ( $OSNAME eq 'MSWin32' );

WriteMakefile(
    NAME         => 'RPerl',
    VERSION_FROM => 'lib/RPerl.pm',
    EXE_FILES    => ['script/rperl'],
    PREREQ_PM    => {
        'Test::Exception' => 0.32,
        'Perl::Critic'    => 1.121,
        'Perl::Tidy'      => 20140711,
        'Parse::Eyapp'    => 1.182,
        'Inline'          => 0.76,
        'Inline::C'       => 0.64,
        'Inline::CPP' => 0.63, # davido & mohawk fixed ntype warnings; davido & wbraswell fixed namespace hack
        'Inline::Filters' => 0.16, # wbraswell, rurban, & bulk88 added preprocess inc array

        #        'Module::Compile' => 0,  # not yet utilized
    },

# NEED UPDATE, CORRELATION #05: list of _Inline directories to delete/exclude in Makefile.PL, .gitignore, and MANIFEST.SKIP
# NEED UPDATE, CORRELATION #06: list of CPAN files & directories to delete/exclude in Makefile.PL, .gitignore, and MANIFEST.SKIP
    clean => {
        FILES =>
            '_Inline lib/RPerl/Algorithm/Sort/_Inline script/_Inline script/development/_Inline script/development/unused/_Inline t/_Inline lib/RPerl/Test/OperationsTypesReporting/_Inline lib/RPerl/Test/Module/_Inline lib/RPerl/Test/Properties/_Inline lib/RPerl/Test/Type_Types/_Inline Makefile.old MANIFEST.bak'
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
