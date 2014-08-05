use strict;
use warnings;
our $VERSION = 0.001_023;
use ExtUtils::MakeMaker;
push(@ExtUtils::MakeMaker::Overridable, qw(pm_to_blib)) if ($^O eq 'MSWin32');

WriteMakefile(
  NAME         => 'RPerl',
  VERSION_FROM => 'lib/RPerl.pm',
  PREREQ_PM    => {
        'Perl::Critic'    => 0,
        'Perl::Tidy'      => 0,
        'Inline'          => 0.64,
        'Inline::C'       => 0.62,
        'Inline::CPP'     => 0.52,  # fix namespace hack & ntype warnings
        'Inline::Filters' => 0.13,
        'Test::Exception' => 0,
        'Module::Compile' => 0,
        'Parse::Eyapp'    => 1.182,
  },
  clean => {FILES => '_Inline'},
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
