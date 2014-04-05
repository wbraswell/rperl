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
#        'Inline'          => 0.55,  # NEED FIX: Reini must make 0.54_02 official as 0.55
        'Inline'          => 0,
        'Inline::CPP'     => 0,
        'Inline::Filters' => 0.13,
        'Test::Exception' => 0,
        'Module::Compile' => 0,
  },
  clean => {FILES => '_Inline'}
);
