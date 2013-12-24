#!/usr/bin/perl
use strict;
use warnings;
use version; our $VERSION = -0.001_000;

use Test::More; # tests => 14;
use Test::Exception;

BEGIN { diag("\n[[[ Beginning Dependency Tests ]]]\n "); }

BEGIN {
    lives_and( sub { use_ok('Data::Dumper'); },
        q{use_ok('Data::Dumper') lives} );
}
lives_and(
    sub { require_ok('Data::Dumper'); },
    q{require_ok('Data::Dumper') lives}
);

# DEPENDENCIES LIKELY FULFILLED BY SYSTEM-WIDE MODULES ABOVE THIS LINE
# DEPENDENCIES POSSIBLY FULFILLED BY USER-SPECIFIC MODULES BELOW THIS LINE

BEGIN {
    lives_ok(
        sub {    ## PERLTIDY BUG blank newline

            package main;
            our $RPERL_INCLUDE_PATH = 'lib';
        },
        q{package main;  our $RPERL_INCLUDE_PATH = 'lib';} ## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow single-quoted sigils
    );
}    # NEED REMOVE hard-coded path




BEGIN {
    lives_and(
        sub { use_ok('Parse::RecDescent'); },
        q{use_ok('Parse::RecDescent') lives}
    );
}

lives_and(
    sub { require_ok('Parse::RecDescent'); },
    q{require_ok('Parse::RecDescent') lives}
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