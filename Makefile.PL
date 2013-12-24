use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
  NAME => 'RPerl',
  VERSION => 0,
  PREREQ_PM => {
    'Perl::Critic' => 0,
    'Perl::Tidy' => 0,
    'Inline' => 0,
    'Inline::CPP' => 0,
    'Inline::Filters' => 0,
    'Test::Exception' => 0,
  }
);
