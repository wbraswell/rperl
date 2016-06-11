# [[[ HEADER ]]]
package RPerl::CompileUnit::Module::Header;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.004_200;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::GrammarRule);
use RPerl::GrammarRule;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref::method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = {};

    #    RPerl::diag('in Header->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n");
    #    RPerl::diag('in Header->ast_to_rperl__generate(), received $modes = ' . "\n" . Dumper($modes) . "\n");
    #    die 'tmp debug';

    #    my $class = ref $self;
    #    RPerl::diag('in Header->ast_to_rperl__generate(), have symtab entries for ' . $class . "\n" . RPerl::analyze_class_symtab_entries($class) . "\n");

    # ModuleHeader -> Critic? USE_RPERL? 'package' WordScoped ';' Header
    my object $critic_optional    = $self->{children}->[0];
    my string $use_rperl_optional = $self->{children}->[1];                    # PERLOPS only
    my string $package_keyword    = $self->{children}->[2];                    # PERLOPS only
    my object $package_name       = $self->{children}->[3]->{children}->[0];
    my string $package_semicolon  = $self->{children}->[4];                    # PERLOPS only

    # Header -> 'use strict;' 'use warnings;' USE_RPERL_AFTER? 'our' VERSION_NUMBER_ASSIGN;
    my string $use_strict               = $self->{children}->[5]->{children}->[0];    # PERLOPS only
    my string $use_warnings             = $self->{children}->[5]->{children}->[1];    # PERLOPS only
    my string $use_rperl_after_optional = $self->{children}->[5]->{children}->[2];    # PERLOPS only
    my string $our_keyword              = $self->{children}->[5]->{children}->[3];    # PERLOPS only
    my string $version_number           = $self->{children}->[5]->{children}->[4];

    if ((substr $package_name, 0, 1) eq '_') {
        die 'ERROR ECOGEASRP07, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: package name ' . ($package_name)
                . ' must not start with underscore, dying' . "\n";
    }

    $rperl_source_group->{PMC} = q{};
    if ( ( exists $critic_optional->{children}->[0] ) and ( defined $critic_optional->{children}->[0] ) ) {
        my string_hashref $rperl_source_subgroup = $critic_optional->{children}->[0]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }
    if ( $modes->{label} eq 'ON' ) {
        $rperl_source_group->{PMC} .= '# [[[ HEADER ]]]' . "\n";
    }
    if ( ( exists $use_rperl_optional->{children}->[0] ) and ( defined $use_rperl_optional->{children}->[0] ) ) {
        $rperl_source_group->{PMC} .= $use_rperl_optional->{children}->[0]->{attr} . "\n";
    }
    $rperl_source_group->{PMC} .= $package_keyword . ' ' . $package_name . $package_semicolon . "\n";
    $rperl_source_group->{PMC} .= $use_strict . "\n";
    $rperl_source_group->{PMC} .= $use_warnings . "\n";
    if ( ( exists $use_rperl_after_optional->{children}->[0] ) and ( defined $use_rperl_after_optional->{children}->[0] ) ) {
        chomp $use_rperl_after_optional->{children}->[0]->{attr};
        $rperl_source_group->{PMC} .= $use_rperl_after_optional->{children}->[0]->{attr} . "\n";
    }

    # DEV NOTE, CORRELATION #rp14: the hard-coded ' $VERSION = ' & ';' below are the only discarded tokens in the RPerl grammar,
    # due to the need to differentiate between v-numbers and otherwise-identical normal numbers
    $rperl_source_group->{PMC} .= $our_keyword . ' $VERSION = ' . $version_number . q{;} . "\n";

    my string $package_name_underscores = $package_name;
    $package_name_underscores =~ s/::/__/gxms;
    $rperl_source_group->{_package_name} = $package_name;
    $rperl_source_group->{_package_name_underscores} = $package_name_underscores;

    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::CU::M::H __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate_begin__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = {};

    #RPerl::diag( 'in Header->ast_to_cpp__generate_begin__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
    #RPerl::diag('in Header->ast_to_cpp__generate_begin__CPPOPS_CPPTYPES(), received $modes = ' . "\n" . Dumper($modes) . "\n");
#    RPerl::diag( 'in Header->ast_to_cpp__generate_begin__CPPOPS_CPPTYPES(), received $modes->{_symbol_table} = ' . "\n" . Dumper($modes->{_symbol_table}) . "\n" );

#my $class = ref $self;
#RPerl::diag('in Header->ast_to_cpp__generate_begin__CPPOPS_CPPTYPES(), have symtab entries for ' . $class . "\n" . RPerl::analyze_class_symtab_entries($class) . "\n");

#RPerl::diag('in Header->ast_to_cpp__generate_begin__CPPOPS_CPPTYPES(), have $self->{children}->[3]->{children}->[0] = ' . "\n" . Dumper($self->{children}->[3]->{children}->[0]) . "\n");


    my object $package_name   = $self->{children}->[3]->{children}->[0];
    my string $version_number = $self->{children}->[5]->{children}->[4];

    if ((substr $package_name, 0, 1) eq '_') {
        die 'ERROR ECOGEASCP07, CODE GENERATOR, ABSTRACT SYNTAX TO C++: package name ' . ($package_name)
                . ' must not start with underscore, dying' . "\n";
    }
    $modes->{_symbol_table}->{_namespace} = $package_name . '::';  # set current namespace
 
#    RPerl::diag( 'in Header->ast_to_cpp__generate_begin__CPPOPS_CPPTYPES(), have $modes->{_symbol_table} = ' . "\n" . Dumper($modes->{_symbol_table}) . "\n" );

    $cpp_source_group->{H}   = q{};
    $cpp_source_group->{CPP} = q{};

    if ( $modes->{label} eq 'ON' ) {
        $cpp_source_group->{H}   .= '// [[[ HEADER ]]]' . "\n";
        $cpp_source_group->{CPP} .= '// [[[ HEADER ]]]' . "\n";
    }

    if ($modes->{subcompile} ne 'DYNAMIC') {
        $cpp_source_group->{CPP} .= '#include <rperlstandalone.h>' . "\n";
    }

    $cpp_source_group->{H}   .= 'using std::cout;  using std::cerr;  using std::endl;' . "\n\n";
    $cpp_source_group->{CPP} .= 'using std::cout;  using std::cerr;  using std::endl;' . "\n\n";

    my string $package_name_underscores = $package_name;
    $package_name_underscores =~ s/::/__/gxms;
    $cpp_source_group->{H}   .= '#ifndef __CPP__INCLUDED__' . $package_name_underscores . '_h' . "\n";
    $cpp_source_group->{H}   .= '#define __CPP__INCLUDED__' . $package_name_underscores . '_h ' . $version_number . "\n\n";
    $cpp_source_group->{CPP} .= '#ifndef __CPP__INCLUDED__' . $package_name_underscores . '_cpp' . "\n";
    $cpp_source_group->{CPP} .= '#define __CPP__INCLUDED__' . $package_name_underscores . '_cpp ' . $version_number . "\n\n";

#    RPerl::diag( 'in Header->ast_to_cpp__generate_begin__CPPOPS_CPPTYPES(), have $package_name = ' . $package_name . "\n" );
#    RPerl::diag( 'in Header->ast_to_cpp__generate_begin__CPPOPS_CPPTYPES(), have $package_name_underscores = ' . $package_name_underscores . "\n" );
#    RPerl::diag( 'in Header->ast_to_cpp__generate_begin__CPPOPS_CPPTYPES(), have $cpp_source_group->{_package_names} = ' . "\n" . Dumper($cpp_source_group->{_package_names}) . "\n" );
#    RPerl::diag( 'in Header->ast_to_cpp__generate_begin__CPPOPS_CPPTYPES(), have $cpp_source_group->{_package_names_underscores} = ' . "\n" . Dumper($cpp_source_group->{_package_names_underscores}) . "\n" );

    $cpp_source_group->{_package_name} = $package_name;
    $cpp_source_group->{_package_name_underscores} = $package_name_underscores;
    if ((not exists $cpp_source_group->{_package_names}) or (not defined $cpp_source_group->{_package_names})) {
        $cpp_source_group->{_package_names} = q{};
    }
    $cpp_source_group->{_package_names} .= $package_name . "\n";
    if ((not exists $cpp_source_group->{_package_names_underscores}) or (not defined $cpp_source_group->{_package_names_underscores})) {
        $cpp_source_group->{_package_names_underscores} = q{};
    }
    $cpp_source_group->{_package_names_underscores} .= $package_name_underscores . "\n";

    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate_end__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = {};

    #RPerl::diag( 'in Header->ast_to_cpp__generate_end__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
    #RPerl::diag('in Header->ast_to_cpp__generate_end__CPPOPS_CPPTYPES(), received $modes = ' . "\n" . Dumper($modes) . "\n");
#    RPerl::diag( 'in Header->ast_to_cpp__generate_end__CPPOPS_CPPTYPES(), received $modes->{_symbol_table} = ' . "\n" . Dumper($modes->{_symbol_table}) . "\n" );

    $cpp_source_group->{H}   = '#endif' . "\n";
    $cpp_source_group->{CPP} = '#endif' . "\n";
    return $cpp_source_group;
};

1;    # end of class
