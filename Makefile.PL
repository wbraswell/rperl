use strict;
use warnings;
our $VERSION = 0.001_027;
use ExtUtils::MakeMaker;
push(@ExtUtils::MakeMaker::Overridable, qw(pm_to_blib)) if ($^O eq 'MSWin32');

WriteMakefile(
  NAME         => 'RPerl',
  VERSION_FROM => 'lib/RPerl.pm',
  PREREQ_PM    => {
        'Perl::Critic'    => 1.121,
        'Perl::Tidy'      => 20140711,
        'Inline'          => 0.76,
        'Inline::C'       => 0.62,  # really 0.62_03, but travis cannot handle it
        'Inline::CPP'     => 0.63,  # davido & mohawk fixed ntype warnings; davido & wbraswell fixed namespace hack
        'Inline::Filters' => 0.16,  # wbraswell, rurban, & bulk88 added preprocess inc array
        'Test::Exception' => 0.32,
#        'Module::Compile' => 0,
        'Parse::Eyapp'    => 1.182,
  },
  clean => {FILES => '_Inline bin/_Inline bin/development/_Inline'},
);


package MY;

sub pm_to_blib {
    my $self = shift;
    my $blib = $self->SUPER::pm_to_blib(@_);
    # un-read-only blib/lib for tests to pass, files are modified at runtime there
    if ($^O eq 'MSWin32') {
	my ($lastline,$start) =  qq{\t\$(NOECHO) \$(TOUCH) pm_to_blib\n};
	($start = index($blib, $lastline)) == -1
	    && die "Can't find replacement string for pm_to_blib target";
	substr($blib, $start, 0, "\t".'attrib -R /S  blib/lib/*'."\n");
    }
    return $blib;
}

# NEED UPGRADE: disable `make install` for now, enable when appropriate
sub install {
    return '';
}
