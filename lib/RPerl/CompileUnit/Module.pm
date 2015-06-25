# [[[ HEADER ]]]
package RPerl::CompileUnit::Module;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.002_010;

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

# [[[ OO METHODS & SUBROUTINES ]]]

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
    ( my object $self, my string_hashref $modes ) = @_;
    my string_hashref $cpp_source_group = {
        CPP =>
            q{// <<< RP::CU::M __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n",
        H =>
            q{// <<< RP::CU::M __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n",
        PMC =>
            q{# <<< RP::CU::M __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n"
    };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes ) = @_;
    my string_hashref $cpp_source_group = { CPP => q{}, H => q{}, PMC => q{} };

#    RPerl::diag('in Module->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n");
#    RPerl::diag('in Module->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $modes = ' . "\n" . Dumper($modes) . "\n");

    my object_arrayref $modules_and_headers = $self->{children}->[0]->{children};
    my string_hashref $cpp_source_subgroup;
    my string_hashref $cpp_source_subgroup_saved;
    my string $package_name_underscores;  # get from Header to Class or Package
    my bool $header_started = 0;
 
    foreach my object $header_or_module (@{$modules_and_headers}) {
#        RPerl::diag('in Module->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $header_or_module = ' . "\n" . RPerl::Parser::rperl_ast__dump($header_or_module) . "\n\n");
        # C++ Module::Header wraps around Module, must call both *generate_begin*() and *generate_end*()
        if ((ref $header_or_module) eq 'ModuleHeader_21') {
            if ($header_started) {
                die 'ERROR ECVGEASCP01, CODE GENERATOR, ABSTRACT SYNTAX TO C++, CPPOPS_CPPTYPES: ModuleHeader found without first finding Module for previous ModuleHeader, dying' . "\n";
            }
            else {
                $header_started = 1;
                $cpp_source_subgroup = $header_or_module->ast_to_cpp__generate_begin__CPPOPS_CPPTYPES($modes);
                $package_name_underscores = $cpp_source_subgroup->{package_name_underscores};
                delete $cpp_source_subgroup->{package_name_underscores};
                RPerl::Generator::source_group_append($cpp_source_group, $cpp_source_subgroup);
                $cpp_source_subgroup_saved = $header_or_module->ast_to_cpp__generate_end__CPPOPS_CPPTYPES($modes);
            }
        }
        elsif (((ref $header_or_module) eq 'Module_22') or ((ref $header_or_module) eq 'Module_23')) {
            if ($header_started) {
                $cpp_source_subgroup = $header_or_module->ast_to_cpp__generate__CPPOPS_CPPTYPES($package_name_underscores, $modes);
                RPerl::Generator::source_group_append($cpp_source_group, $cpp_source_subgroup);
                RPerl::Generator::source_group_append($cpp_source_group, $cpp_source_subgroup_saved);
                $header_started = 0;
            }
            else {
                die 'ERROR ECVGEASCP02, CODE GENERATOR, ABSTRACT SYNTAX TO C++, CPPOPS_CPPTYPES: Module found without first finding ModuleHeader, dying' . "\n";
            }
        }
        else {
            die RPerl::Parser::rperl_rule__replace(
                'ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++, CPPOPS_CPPTYPES: grammar rule '
                    . ( ref $header_or_module )
                    . ' found where ModuleHeader_21, Module_22, or Module_23 expected, dying' )
                . "\n";
        }
    }

    return $cpp_source_group;

};

1;    # end of class
