# [[[ HEADER ]]]
package RPerl::CompileUnit::Module::Class::Generator;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Parser;
use RPerl::Generator;

# [[[ OO PROPERTIES ]]]
our hash_ref $properties = {};

# [[[ OO METHODS ]]]

our string__hash_ref__method $ast_to_rperl__generate = sub {

    #sub ast_to_rperl__generate {
    ( my object $self, my string__hash_ref $modes) = @_;

    #    ( my $self, my $modes) = @_;
    my string__hash_ref $rperl_source_group
        = { PMC => q{<<< RP::CU::M::H DUMMY PERLOPS_PERLTYPES SOURCE CODE >>>}
            . "\n" };

#    my $rperl_source_group = { PMC => q{<<< RP::CU::M::C DUMMY PERLOPS_PERLTYPES SOURCE CODE >>>} . "\n" };

    RPerl::diag(
              'in Class->ast_to_rperl__generate(), received $self = ' . "\n"
            . RPerl::Parser::rperl_ast__dump($self)
            . "\n" );

#    RPerl::diag('in Class->ast_to_rperl__generate(), received $modes = ' . "\n" . Dumper($modes) . "\n");

    return $rperl_source_group;
};

our string__hash_ref__method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {

    #sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    ( my object $self, my string__hash_ref $modes) = @_;

    #    ( my $self, my $modes) = @_;
    my string__hash_ref $cpp_source_group
        = { CPP => q{<<< RP::CU::M::C DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>}
            . "\n" };

#    my $cpp_source_group = { CPP => q{<<< RP::CU::M::C DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>} . "\n" };

    #...
    return $cpp_source_group;
};

our string__hash_ref__method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {

    #sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    ( my object $self, my string__hash_ref $modes) = @_;

    #    ( my $self, my $modes) = @_;
    my string__hash_ref $cpp_source_group
        = { CPP => q{<<< RP::CU::M::C DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>}
            . "\n" };

#    my $cpp_source_group = { CPP =>  q{<<< RP::CU::M::C DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>} . "\n" };

    #...
    return $cpp_source_group;
};

1;    # end of class
