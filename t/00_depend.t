#!/usr/bin/perl

# [[[ HEADER ]]]
use strict;
use warnings;
our $VERSION = 0.003_000;

# [[[ INCLUDES ]]]
use Test::More tests => 20;
use Test::Exception;

# [[[ OPERATIONS ]]]

BEGIN {
    if ( $ENV{RPERL_VERBOSE} ) {
        Test::more::diag("[[[ Beginning Dependency Tests ]]]");
    }
}

BEGIN {
    lives_and( sub { use_ok('ExtUtils::MakeMaker'); }, q{use_ok('ExtUtils::MakeMaker') lives} );
}
lives_and( sub { require_ok('ExtUtils::MakeMaker'); }, q{require_ok('ExtUtils::MakeMaker') lives} );

BEGIN {
    lives_and( sub { use_ok('Test::Exception'); }, q{use_ok('Test::Exception') lives} );
}
lives_and( sub { require_ok('Test::Exception'); }, q{require_ok('Test::Exception') lives} );

BEGIN {
    lives_and( sub { use_ok('Perl::Critic'); }, q{use_ok('Perl::Critic') lives} );
}
lives_and( sub { require_ok('Perl::Critic'); }, q{require_ok('Perl::Critic') lives} );

BEGIN {
    lives_and( sub { use_ok('Perl::Tidy'); }, q{use_ok('Perl::Tidy') lives} );
}
lives_and( sub { require_ok('Perl::Tidy'); }, q{require_ok('Perl::Tidy') lives} );

# 3RD-PARTY ISSUE #0: Perl v5.22, Unescaped left brace in regex
#BEGIN {
#    lives_and( sub { use_ok('Parse::Eyapp'); }, q{use_ok('Parse::Eyapp') lives} );
#}
#lives_and( sub { require_ok('Parse::Eyapp'); }, q{require_ok('Parse::Eyapp') lives} );

BEGIN {
    lives_and( sub { use_ok('Inline'); }, q{use_ok('Inline') lives} );
}

lives_and( sub { require_ok('Inline'); }, q{require_ok('Inline') lives} );

# It is invalid to use 'Inline::C' directly. Please consult the Inline documentation for more information.
lives_and( sub { require_ok('Inline::C'); }, q{require_ok('Inline::C') lives} );

# It is invalid to use 'Inline::CPP' directly. Please consult the Inline documentation for more information.
lives_and( sub { require_ok('Inline::CPP'); }, q{require_ok('Inline::CPP') lives} );

BEGIN {
    lives_and( sub { use_ok('Inline::Filters'); }, q{use_ok('Inline::Filters') lives} );
}
lives_and( sub { require_ok('Inline::Filters'); }, q{require_ok('Inline::Filters') lives} );

BEGIN {
    lives_and( sub { use_ok('PadWalker'); }, q{use_ok('PadWalker') lives} );
}
lives_and( sub { require_ok('PadWalker'); }, q{require_ok('PadWalker') lives} );

BEGIN {
    lives_and( sub { use_ok('Module::Refresh'); }, q{use_ok('Module::Refresh') lives} );
}
lives_and( sub { require_ok('Module::Refresh'); }, q{require_ok('Module::Refresh') lives} );

BEGIN {
    lives_and( sub { use_ok('Test::CPAN::Changes'); }, q{use_ok('Test::CPAN::Changes') lives} );
}
lives_and( sub { require_ok('Test::CPAN::Changes'); }, q{require_ok('Test::CPAN::Changes') lives} );

done_testing();
