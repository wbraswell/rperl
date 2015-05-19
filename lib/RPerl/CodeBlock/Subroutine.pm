package RPerl::CodeBlock::Subroutine;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_020;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names
BEGIN {

    package object_method;
    1;

    package hashref_method;
    1;

    package string_method;
    1;

# DEV NOTE, CORRELATION #03: method types reside in Method.pm, which is a sub-type of Subroutine.pm, causing the need to have this special BEGIN block
# to enable the *_method types, and Class.pm's INIT block symbol table entry generator needs us to switch back into the primary package so we have
# that happen in the following line, which furthermore triggers the need to avoid re-defining class accessor/mutator methods; how to fix?
    package RPerl::CodeBlock::Subroutine;
    1;
}

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CodeBlock);

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    type       => my string $TYPED_type                   = undef,
    name       => my string $TYPED_name                   = undef,
    arguments  => my hashref_arrayref $TYPED_arguments = undef,
    operations => my object_arrayref $TYPED_operations  = undef
};

# [[[ OO METHOD(S) ]]]


# Random note for later from mst:  spring/summer 2012
#   This would warn BUT "no warnings 'illegalproto'" disables that
#   Now you can extract the prototype at runtime using 'perldoc -f prototype'
#   Key thing: whitespace in the prototype is lost so you'll be parsing 'integer_arrayref->integer_arrayref'
#   however it's otherwise preserved verbatim by the perl compiler and you can do what you like with it
#   Web::Simple uses this to provide 'sub (GET + /user/:id) { ... }' for web routing.
#   sub bubblesort(integer_arrayref -> integer_arrayref) {}
# end random note

1;
