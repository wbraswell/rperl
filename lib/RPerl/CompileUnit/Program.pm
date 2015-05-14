# [[[ HEADER ]]]
package RPerl::CompileUnit::Program;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit);
use RPerl::CompileUnit;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = {
        PMC => q{<<< RP::CU::P DUMMY PERLOPS_PERLTYPES >>>} . "\n",
        EXE => q{<<< RP::CU::P DUMMY PERLOPS_PERLTYPES >>>} . "\n"
    };

#    RPerl::diag('in Program->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n");
#    RPerl::diag('in Program->ast_to_rperl__generate(), received $modes = ' . "\n" . Dumper($modes) . "\n");

    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = {
        CPP => q{<<< RP::CU::P DUMMY CPPOPS_PERLTYPES >>>} . "\n",
        H   => q{<<< RP::CU::P DUMMY CPPOPS_PERLTYPES >>>} . "\n",
        PMC => q{<<< RP::CU::P DUMMY CPPOPS_PERLTYPES >>>} . "\n",
        EXE => q{<<< RP::CU::P DUMMY CPPOPS_PERLTYPES >>>} . "\n"
    };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = {
        CPP => q{<<< RP::CU::P DUMMY CPPOPS_CPPTYPES >>>} . "\n",
        H   => q{<<< RP::CU::P DUMMY CPPOPS_CPPTYPES >>>} . "\n",
        PMC => q{<<< RP::CU::P DUMMY CPPOPS_CPPTYPES >>>} . "\n",
        EXE => q{<<< RP::CU::P DUMMY CPPOPS_CPPTYPES >>>} . "\n"
    };

    #...
    return $cpp_source_group;
};

1;    # end of class
