use strict;
use warnings;
our $VERSION = 0.001_010;
use ExtUtils::MakeMaker;
WriteMakefile(
    NAME      => 'RPerl',
    VERSION   => 0,
    PREREQ_PM => {
        'Perl::Critic'    => 0,
        'Perl::Tidy'      => 0,
        'Inline'          => 0,
        'Inline::CPP'     => 0,
        'Inline::Filters' => 0.13,
        'Test::Exception' => 0,
        'Module::Compile' => 0,
    }
);
