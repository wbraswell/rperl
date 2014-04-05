use strict;
use warnings;
our $VERSION = 0.001_010;
use ExtUtils::MakeMaker;
WriteMakefile(
  NAME         => 'RPerl',
  VERSION_FROM => 'lib/RPerl.pm',
  PREREQ_PM    => {
        'Perl::Critic'    => 0,
        'Perl::Tidy'      => 0,

        # NEED FIX: point to experimental RURBAN/Inline-0.54_01.tar.gz or newer
        'Inline'          => 0,

        'Inline::CPP'     => 0,
        'Inline::Filters' => 0.13,
        'Test::Exception' => 0,
        'Module::Compile' => 0,
  },
  clean => {FILES => '_Inline'}
);
