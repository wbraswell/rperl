#!/usr/bin/env perl

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt

# [[[ OPERATIONS ]]]

print 'Please input your favorite band or musician: ';
my string $favorite_band = <STDIN>;
chomp $favorite_band;

print 'Please input your favorite movie: ';
my string $favorite_movie = <STDIN>;
chomp $favorite_movie;

print 'Please input your favorite TV show: ';
my string $favorite_show = <STDIN>;
chomp $favorite_show;

print 'You are a fan of ', $favorite_band, ', ', $favorite_movie, ', and ', $favorite_show, q{.}, "\n";
print '(I like Rush, Blade Runner, and Star Trek!)', "\n";
