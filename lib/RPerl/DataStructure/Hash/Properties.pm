package RPerl::DataStructure::Hash::Properties; ## nfo critic qw(ProhibitExcessMainComplexity)  ## RPERL SYSTEM allow complex code
use strict;
use warnings;
our $VERSION = 0.000_010;
use Carp;
use RPerl;

# [[[ SETUP ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  ## RPERL USER DEFAULT optionally allow numeric values, print operator
## no critic qw(ProhibitMultiplePackages)  ## RPERL SYSTEM types, allow multiple packages
## no critic qw(Capitalization)  ## RPERL SYSTEM types, allow lowercase packages
use Data::Dumper;
use Scalar::Util 'blessed';

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::GrammarRule RPerl::DataStructure::Hash);

# [[[ OO PROPERTIES ]]]
our %properties = ( ## no critic qw(ProhibitPackageVars)  ## RPERL SYSTEM, allow OO properties
    property_entries => my object__hash_ref $KEY_property_entries = undef,
);

# [[[ OO METHODS ]]]

# TRANSLATE
our object__method $ppi_to_rperl__translate = sub {
    ( my string $class, my object $node) = @_;    # class method
    my object $node_translated;
    $node_translated = { STUB_AST_OBJECT =>
            'CREATED BY RPerl::DataStructure::Hash::Properties' };
    return ($node_translated);
};

# GENERATE CPPOPS_PERLTYPES
our string__method $rperl_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self ) = @_;                     # object method
    my string $self_generated = q{};
    $self_generated
        .= 'STUB PERL CODE STRING, CREATED BY RPerl::DataStructure::Hash::Properties';
    return ($self_generated);
};

# GENERATE CPPOPS_CPPTYPES
our string__method $rperl_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self ) = @_;                     # object method
    my string $self_generated = q{};
    $self_generated
        .= 'STUB CPP CODE STRING, CREATED BY RPerl::DataStructure::Hash::Properties';
    return ($self_generated);
};

# [[[ SUB-TYPES ]]]

# a property is a data structure belonging to a class or object, each RPerl object has a properties hash
package properties;
use base qw(RPerl::DataStructure::Hash::Properties);

1;
