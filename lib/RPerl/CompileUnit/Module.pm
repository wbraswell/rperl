# [[[ HEADER ]]]
package RPerl::CompileUnit::Module;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
# <<< CHANGE_ME: leave as base class for no inheritance, or replace with real parent package name >>>
use parent qw(RPerl::CompileUnit);
use RPerl::CompileUnit;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hash_ref $properties = {
    plugh => my integer $TYPED_plugh           = 23,
    xyzzy => my string $TYPED_xyzzy            = 'twenty-three',
    thud  => my integer__array_ref $TYPED_thud = [ 2, 4, 6, 8 ],
    yyz => my number__hash_ref $TYPED_yyz = { a => 3.1, b => 6.2, c => 9.3 }
};

# [[[ OO METHODS ]]]

our string__method $ast_to_rperl__generate = sub {
    ( my object $self, my string__hash_ref $mode) = @_;
    my string $rperl_source = q{<<< DUMMY PERLOPS_PERLTYPES SOURCE CODE >>>};

    #...
    return $rperl_source;
};

our string__method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string__hash_ref $mode) = @_;
    my string $cpp_source = q{<<< DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>};

    #...
    return $cpp_source;
};

our string__method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string__hash_ref $mode) = @_;
    my string $cpp_source = q{<<< DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>};

    #...
    return $cpp_source;
};

1;    # end of class
