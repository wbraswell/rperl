package RPerl::DataStructure::Hash::Properties;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_012;

# [[[ SETUP ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

use Scalar::Util 'blessed';

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::GrammarRule RPerl::DataStructure::Hash);

# [[[ OO PROPERTIES ]]]
our hashref $properties = {  # whoah, so meta
    property_entries => my object_hashref $TYPED_property_entries = undef
};

# [[[ OO METHODS ]]]

# TRANSLATE
our object_method $ppi_to_rperl__translate = sub {
    ( my string $class, my object $node) = @_;    # class method
    my object $node_translated;
    $node_translated = { STUB_AST_OBJECT =>
            'CREATED BY RPerl::DataStructure::Hash::Properties' };
    return ($node_translated);
};

# GENERATE CPPOPS_PERLTYPES
our string_method $rperl_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self ) = @_;                     # object method
    my string $self_generated = q{};
    $self_generated
        .= 'STUB PERL CODE STRING, CREATED BY RPerl::DataStructure::Hash::Properties';
    return ($self_generated);
};

# GENERATE CPPOPS_CPPTYPES
our string_method $rperl_to_cpp__generate__CPPOPS_CPPTYPES = sub {
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
