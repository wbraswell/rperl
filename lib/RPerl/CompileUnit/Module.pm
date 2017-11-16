# [[[ HEADER ]]]
package RPerl::CompileUnit::Module;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.004_000;

# [[[ OO INHERITANCE ]]]
# <<< CHANGE_ME: leave as base class for no inheritance, or replace with real parent package name >>>
use parent qw(RPerl::CompileUnit);
use RPerl::CompileUnit;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
#use RPerl::Parser;
#eval 'require RPerl::Parser;';
eval {require RPerl::Parser;};
if ($EVAL_ERROR and ($EVAL_ERROR =~ /attempt to reload/i)){
    delete $INC{'RPerl::Parser'};
    require RPerl::Parser;
}
elsif ($EVAL_ERROR ne q{}) { die $EVAL_ERROR; }

use RPerl::Generator;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub ast_to_rperl__generate {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $rperl_source_group = {};

#    RPerl::diag('in Module->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n");
#    RPerl::diag('in Module->ast_to_rperl__generate(), received $modes = ' . "\n" . Dumper($modes) . "\n");

    my object_arrayref $modules_and_headers = $self->{children}->[0]->{children};
    my string_hashref $rperl_source_subgroup;
    my string $package_name_underscores;  # get from Header to Class or Package
    my boolean $header_started = 0;
    my boolean $current_package_count = 0;

    # disable unused symbol table testing
#    RPerl::diag('in Module->ast_to_rperl__generate(), have %RPerl::Generator:: symbol table = ' . "\n" . Dumper(\%RPerl::Generator::) . "\n");
#    RPerl::diag('in Module->ast_to_rperl__generate(), have %RPerl::CompileUnit::Module::Header:: symbol table dumped = ' . "\n" . Dumper(\%RPerl::CompileUnit::Module::Header::) . "\n");
#    RPerl::diag('in Module->ast_to_rperl__generate(), have %ModuleHeader_23:: symbol table dumped = ' . "\n" . Dumper(\%ModuleHeader_23::) . "\n");
#    my $class = 'RPerl::CompileUnit::Module::Header';
#    RPerl::diag('in Module->ast_to_rperl__generate(), have symtab entries for ' . $class . "\n" . RPerl::analyze_class_symtab_entries($class) . "\n\n");
#    $class = 'ModuleHeader_23';
#    RPerl::diag('in Module->ast_to_rperl__generate(), have symtab entries for ' . $class . "\n" . RPerl::analyze_class_symtab_entries($class) . "\n\n");

    foreach my object $header_or_module (@{$modules_and_headers}) {
#        RPerl::diag('in Module->ast_to_rperl__generate(), have $header_or_module = ' . "\n" . RPerl::Parser::rperl_ast__dump($header_or_module) . "\n\n");
#        RPerl::diag('in Module->ast_to_rperl__generate(), have $header_or_module = ' . "\n" . $header_or_module . "\n\n");
        if ((ref $header_or_module) eq 'ModuleHeader_23') {
            if ($header_started) {
                die 'ERROR ECOGEASRP34, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: ModuleHeader found without first finding Module for previous ModuleHeader, dying' . "\n";
            }
            else {
#                if ($current_package_count >= 1) { $rperl_source_group->{PMC} .= "\n\n"; }  # DEV NOTE: extra spaces removed by perltidy???
                if (($current_package_count == 1) and ( $modes->{label} eq 'ON' )) {
                    $rperl_source_group->{PMC} .= '# [[[ ADDITIONAL CLASSES ]]]' . "\n\n";
                }
                $header_started = 1;
                $rperl_source_subgroup = $header_or_module->ast_to_rperl__generate($modes);
                $package_name_underscores = $rperl_source_subgroup->{_package_name_underscores};
                RPerl::Generator::source_group_append($rperl_source_group, $rperl_source_subgroup);
            }
        }
        elsif (((ref $header_or_module) eq 'Module_24') or ((ref $header_or_module) eq 'Module_25')) {
            if ($header_started) {
#                RPerl::diag('in Module->ast_to_rperl__generate(), have Module_24 or Module_25, about to call ast_to_rperl__generate()...', "\n");
                $rperl_source_subgroup = $header_or_module->ast_to_rperl__generate($package_name_underscores, $modes);
#                RPerl::diag('in Module->ast_to_rperl__generate(), have Module_24 or Module_25, ret from ast_to_rperl__generate()', "\n");
                RPerl::Generator::source_group_append($rperl_source_group, $rperl_source_subgroup);
                $header_started = 0;
                $current_package_count++;
            }
            else {
                die 'ERROR ECOGEASRP35, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Module found without first finding ModuleHeader, dying' . "\n";
            }
        }
        else {
            die RPerl::Parser::rperl_rule__replace(
                'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                    . ( ref $header_or_module )
                    . ' found where ModuleHeader_23, Module_24, or Module_25 expected, dying' )
                . "\n";
        }
    }
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes ) = @ARG;
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
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes ) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{}, H => q{} };

#    RPerl::diag('in Module->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n");
#    RPerl::diag('in Module->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $modes = ' . "\n" . Dumper($modes) . "\n");

    my object_arrayref $modules_and_headers = $self->{children}->[0]->{children};
    my string_hashref $cpp_source_subgroup;
    my string_hashref $cpp_source_subgroup_saved;
    my string $package_name_underscores;  # get from Header to Class or Package
    my boolean $header_started = 0;
    my boolean $current_package_count = 0;
 
    foreach my object $header_or_module (@{$modules_and_headers}) {
#        RPerl::diag('in Module->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $header_or_module = ' . "\n" . RPerl::Parser::rperl_ast__dump($header_or_module) . "\n\n");
        # C++ Module::Header wraps around Module, must call both *generate_begin*() and *generate_end*()
        if ((ref $header_or_module) eq 'ModuleHeader_23') {
            if ($header_started) {
                die 'ERROR ECOGEASCP34, CODE GENERATOR, ABSTRACT SYNTAX TO C++, CPPOPS_CPPTYPES: ModuleHeader found without first finding Module for previous ModuleHeader, dying' . "\n";
            }
            else {
                if ($current_package_count >= 1) {
                    $cpp_source_group->{CPP} .= "\n\n";
                    $cpp_source_group->{H}   .= "\n\n";
                }
                if (($current_package_count == 1) and ( $modes->{label} eq 'ON' )) {
                    $cpp_source_group->{CPP} .= '// [[[ ADDITIONAL CLASSES ]]]' . "\n\n";
                    $cpp_source_group->{H} .= '// [[[ ADDITIONAL CLASSES ]]]' . "\n\n";
                }
                $header_started = 1;
                $cpp_source_subgroup = $header_or_module->ast_to_cpp__generate_begin__CPPOPS_CPPTYPES($modes);
                $package_name_underscores = $cpp_source_subgroup->{_package_name_underscores};
                RPerl::Generator::source_group_append($cpp_source_group, $cpp_source_subgroup);
                $cpp_source_subgroup_saved = $header_or_module->ast_to_cpp__generate_end__CPPOPS_CPPTYPES($modes);
            }
        }
        elsif (((ref $header_or_module) eq 'Module_24') or ((ref $header_or_module) eq 'Module_25')) {
            if ($header_started) {
                # DEV NOTE, CORRELATION #rp043: no need to include RPerl.cpp multiple times in one file, need current package count for this purpose
                $cpp_source_subgroup = $header_or_module->ast_to_cpp__generate__CPPOPS_CPPTYPES($package_name_underscores, {%{$modes}, current_package_count => $current_package_count});
                RPerl::Generator::source_group_append($cpp_source_group, $cpp_source_subgroup);
                RPerl::Generator::source_group_append($cpp_source_group, $cpp_source_subgroup_saved);
                $header_started = 0;
                $cpp_source_group->{CPP} .= "\n" . '// end of class' . "\n";
                $cpp_source_group->{H}   .= "\n" . '// end of class' . "\n";
                $current_package_count++;
            }
            else {
                die 'ERROR ECOGEASCP35, CODE GENERATOR, ABSTRACT SYNTAX TO C++, CPPOPS_CPPTYPES: Module found without first finding ModuleHeader, dying' . "\n";
            }
        }
        else {
            die RPerl::Parser::rperl_rule__replace(
                'ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++, CPPOPS_CPPTYPES: Grammar rule '
                    . ( ref $header_or_module )
                    . ' found where ModuleHeader_23, Module_24, or Module_25 expected, dying' )
                . "\n";
        }
    }
    return $cpp_source_group;
}

1;    # end of class
