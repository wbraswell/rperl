# [[[ HEADER ]]]
package RPerl::CompileUnit::Module::Header;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.003_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::GrammarRule);
use RPerl::GrammarRule;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = {};
    
#    RPerl::diag('in Header->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n");
#    RPerl::diag('in Header->ast_to_rperl__generate(), received $modes = ' . "\n" . Dumper($modes) . "\n");

#    my $class = ref $self;
#    RPerl::diag('in Header->ast_to_rperl__generate(), have symtab entries for ' . $class . "\n" . RPerl::analyze_class_symtab_entries($class) . "\n");

    my object $critic_optional = $self->{children}->[0];
    my string $package_keyword = $self->{children}->[1];  # PERLOPS only
    my object $package_name = $self->{children}->[2]->{children}->[0];
    my string $package_semicolon = $self->{children}->[3];  # PERLOPS only
    my string $use_strict = $self->{children}->[4]->{children}->[0];  # PERLOPS only
    my string $use_warnings = $self->{children}->[4]->{children}->[1];  # PERLOPS only
    my string $use_rperl = $self->{children}->[4]->{children}->[2];  # PERLOPS only
    my string $our_keyword = $self->{children}->[4]->{children}->[3];  # PERLOPS only
    my string $version_number = $self->{children}->[4]->{children}->[4];
    
    $rperl_source_group->{PMC} = q{};
    if ((exists $critic_optional->{children}->[0]) and (defined $critic_optional->{children}->[0])) {
        my string_hashref $rperl_source_subgroup = $critic_optional->{children}->[0]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append($rperl_source_group, $rperl_source_subgroup);
    }
    if ($modes->{label} eq 'ON') {
        $rperl_source_group->{PMC} .= '# [[[ HEADER ]]]' . "\n";
    }
    $rperl_source_group->{PMC} .= $package_keyword . ' ' . $package_name . $package_semicolon . "\n";
    $rperl_source_group->{PMC} .= $use_strict . "\n";
    $rperl_source_group->{PMC} .= $use_warnings . "\n";
    $rperl_source_group->{PMC} .= $use_rperl . "\n";
    # DEV NOTE: as of v1.0b2, the hard-coded ' $VERSION = ' & ';' below are the only discarded tokens in the RPerl grammar,
    # due to the need to differentiate between v-numbers and otherwise-identical normal numbers
    $rperl_source_group->{PMC} .= $our_keyword . ' $VERSION = ' . $version_number . q{;} . "\n";

    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::CU::M::H __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP =>  q{// <<< RP::CU::M::H __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
};

1;    # end of class
