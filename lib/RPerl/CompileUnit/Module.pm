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

# [[[ INCLUDES ]]]
use RPerl::Parser;
use RPerl::Generator;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = {};
 
#    RPerl::diag('in Module->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n");
#    RPerl::diag('in Module->ast_to_rperl__generate(), received $modes = ' . "\n" . Dumper($modes) . "\n");

    my object_arrayref $modules_and_headers = $self->{children}->[0]->{children};
    
    # disable unused symbol table testing
#    RPerl::diag('in Module->ast_to_rperl__generate(), have %RPerl::Generator:: symbol table = ' . "\n" . Dumper(\%RPerl::Generator::) . "\n");
#    RPerl::diag('in Module->ast_to_rperl__generate(), have %RPerl::CompileUnit::Module::Header:: symbol table dumped = ' . "\n" . Dumper(\%RPerl::CompileUnit::Module::Header::) . "\n");
#    RPerl::diag('in Module->ast_to_rperl__generate(), have %ModuleHeader_21:: symbol table dumped = ' . "\n" . Dumper(\%ModuleHeader_21::) . "\n");
#    my $class = 'RPerl::CompileUnit::Module::Header';
#    RPerl::diag('in Module->ast_to_rperl__generate(), have symtab entries for ' . $class . "\n" . RPerl::analyze_class_symtab_entries($class) . "\n\n");
#    $class = 'ModuleHeader_21';
#    RPerl::diag('in Module->ast_to_rperl__generate(), have symtab entries for ' . $class . "\n" . RPerl::analyze_class_symtab_entries($class) . "\n\n");
    
    foreach my object $header_or_module (@{$modules_and_headers}) {
#        RPerl::diag('in Module->ast_to_rperl__generate(), have $header_or_module = ' . "\n" . RPerl::Parser::rperl_ast__dump($header_or_module) . "\n\n");
        my string_hashref $rperl_source_subgroup = $header_or_module->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append($rperl_source_group, $rperl_source_subgroup);
    }

    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{<<< RP::CU::M DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>} . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP =>  q{<<< RP::CU::M DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>} . "\n" };

    #...
    return $cpp_source_group;
};

1;    # end of class
