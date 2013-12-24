use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
  NAME => 'RPerl',
  VERSION => 0,
  PREREQ_PM => {
    'Perl::Critic' => 0,
    'Inline' => 0,
    'Perl::Tidy' => 0
  }
);
