#!/usr/bin/perl
use strict;
use warnings;
our $VERSION = 0.001_002;

use Test::More tests => 14;
use Test::Exception;

BEGIN {
    if ( $ENV{TEST_VERBOSE} ) {
        diag("[[[ Beginning Dependency Tests ]]]");
    }
}

BEGIN {
    lives_and(
        sub { use_ok('Test::Exception'); },
        q{use_ok('Test::Exception') lives}
    );
}
lives_and(
    sub { require_ok('Test::Exception'); },
    q{require_ok('Test::Exception') lives}
);

BEGIN {
    lives_and( sub { use_ok('Perl::Critic'); },
        q{use_ok('Perl::Critic') lives} );
}
lives_and(
    sub { require_ok('Perl::Critic'); },
    q{require_ok('Perl::Critic') lives}
);

BEGIN {
    lives_and( sub { use_ok('Perl::Tidy'); }, q{use_ok('Perl::Tidy') lives} );
}
lives_and( sub { require_ok('Perl::Tidy'); },
    q{require_ok('Perl::Tidy') lives} );

BEGIN {
    lives_and( sub { use_ok('Parse::Eyapp'); },
        q{use_ok('Parse::Eyapp') lives} );
}
lives_and(
    sub { require_ok('Parse::Eyapp'); },
    q{require_ok('Parse::Eyapp') lives}
);

BEGIN {
    lives_and( sub { use_ok('Inline'); }, q{use_ok('Inline') lives} );
}

lives_and( sub { require_ok('Inline'); }, q{require_ok('Inline') lives} );

# It is invalid to use 'Inline::C' directly. Please consult the Inline documentation for more information.
lives_and( sub { require_ok('Inline::C'); },
    q{require_ok('Inline::C') lives} );

# It is invalid to use 'Inline::CPP' directly. Please consult the Inline documentation for more information.
lives_and(
    sub { require_ok('Inline::CPP'); },
    q{require_ok('Inline::CPP') lives}
);

BEGIN {
    lives_and(
        sub { use_ok('Inline::Filters'); },
        q{use_ok('Inline::Filters') lives}
    );
}

lives_and(
    sub { require_ok('Inline::Filters'); },
    q{require_ok('Inline::Filters') lives}
);

done_testing();
