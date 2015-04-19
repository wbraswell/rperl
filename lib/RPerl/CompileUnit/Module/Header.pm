# [[[ HEADER ]]]
package RPerl::CompileUnit::Module::Header;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::GrammarRule);
use RPerl::GrammarRule;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hash_ref $properties = {};

# [[[ OO METHODS ]]]

our string__hash_ref__method $ast_to_rperl__generate = sub {
    ( my object $self, my string__hash_ref $modes) = @_;
    my string__hash_ref $rperl_source_group = { PMC => q{<<< RP::CU::M::H DUMMY PERLOPS_PERLTYPES SOURCE CODE >>>} . "\n" };
    
    RPerl::diag('in Header->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n");
#    RPerl::diag('in Header->ast_to_rperl__generate(), received $modes = ' . "\n" . Dumper($modes) . "\n");

#    my $class = ref $self;
#    RPerl::diag('in Header->ast_to_rperl__generate(), have symtab entries for ' . $class . "\n" . RPerl::analyze_class_symtab_entries($class) . "\n");

#    my object__array_ref $modules_and_headers = $self->{children}->[0]->{children};
    
#    foreach my object $module_or_header (@{$modules_and_headers}) {
#        RPerl::diag('in Header->ast_to_rperl__generate(), have $module_or_header = ' . "\n" . RPerl::Parser::rperl_ast__dump($module_or_header) . "\n\n");
#        $rperl_source .= $module_or_header->ast_to_rperl__generate($modes);
#    }

    return $rperl_source_group;
};

our string__hash_ref__method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string__hash_ref $modes) = @_;
    my string__hash_ref $cpp_source_group = { CPP => q{<<< RP::CU::M::H DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>} . "\n" };

    #...
    return $cpp_source_group;
};

our string__hash_ref__method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string__hash_ref $modes) = @_;
    my string__hash_ref $cpp_source_group = { CPP =>  q{<<< RP::CU::M::H DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>} . "\n" };

    #...
    return $cpp_source_group;
};

1;    # end of class
