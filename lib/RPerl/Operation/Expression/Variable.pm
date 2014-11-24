package RPerl::Operation::Expression::Variable;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_011;

# [[[ SETUP ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values and print operator
use Scalar::Util 'blessed';

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression);

# [[[ OO PROPERTIES ]]]
our %properties = ( ## no critic qw(ProhibitPackageVars)  # USER DEFAULT 2: allow OO properties
    type       => my string $TYPED_type                  = undef,
    symbol     => my string $TYPED_string_separator      = undef,
    retrievals => my object__array_ref $TYPED_retrievals = undef,
);

# [[[ OO METHODS ]]]

# TRANSLATE
our object__method $ppi_to_rperl__translate = sub {
    ( my string $class, my object $node) = @_;    # class method

    # variable declarations
    my string $rule_name = 'VARIABLE';
    my string $production_name;
    my string $component_name;
    my string $node_class;
    my string $node_class_expected = 'PPI::Statement'; # NEED FIX: what other classes to support for VARIABLE productions including VARIABLE_RETRIEVAL(s)?
    my object $node_translated;
    my object $child;
    my string $child_key;
    my integer $child_index;
    my integer $child_index_max;
    my string $child_class;
    my string $child_class_expected;
    my string $child_content;

    RPerl::diag
        "in Print::ppi_to_rperl__translate(), received \$node =\n"
        . Dumper($node) . "\n";

    if ( not( defined $node ) ) {
        croak(
            "\nERROR ECVTRPI00, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, PPI OBJECT FAILURE:\nobject expected but undefined/null value found,\ncroaking"
        );
    }
    $node_class = blessed($node);
    if ( not( defined $node_class ) ) {
        croak(
            "\nERROR ECVTRPI01, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, PPI OBJECT FAILURE:\nobject expected but non-object value found,\ncroaking"
        );
    }

    RPerl::diag
        "in Print::ppi_to_rperl__translate(), have \$node_class = '$node_class'\n";

    # VARIABLE rule begin
    if ( $node_class ne $node_class_expected ) {
        croak(
            "\nERROR ECVTRPI02, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, PPI OBJECT FAILURE:\n$node_class_expected object expected but $node_class object found,\ncroaking"
        );
    }

    # VARIABLE rule, _VARIABLE_SYMBOL component @ KEY 'children', INDEX 0
    $production_name      = '<any>';
    $component_name       = '_VARIABLE_SYMBOL';
    $child_key            = 'children';
    $child_index          = 0;
    $child_class_expected = 'PPI::Token::Symbol';
    $child                = $node->{$child_key}->[$child_index];
    if ( not( defined $child ) ) {
        croak(
            "\nERROR ECVTRPI05, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, PPI OBJECT FAILURE:\nin $node_class object, $child_class_expected child sub-object expected at key '$child_key' and index $child_index but undefined/null value found,\ncroaking"
        );
    }
    $child_class = blessed($child);
    if ( not( defined $child_class ) ) {
        croak(
            "\nERROR ECVTRPI06, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, PPI OBJECT FAILURE:\nin $node_class object, $child_class_expected child sub-object expected at key '$child_key' and index $child_index but non-object value found,\ncroaking"
        );
    }
    if ( $child_class ne $child_class_expected ) {
        croak(
            "\nERROR ECVTRSY00, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, $child_class_expected child sub-object expected at key '$child_key' and index $child_index,\nbut $child_class great-grandchild sub-sub-sub-object found,\ncroaking"
        );
    }
    $child_content = $child->{content}; # assume PPI::Token::Symbol contains _variable_symbol
    $node_translated = RPerl::Operation::Expression::Variable->new();
    $node_translated->{symbol} = $child_content;

    # NEED FIX: add VARIABLE_RETRIEVAL* semantics

    RPerl::diag
        "in Print::ppi_to_rperl__translate(), bottom of subroutine, about to return \$node_translated=\n"
        . Dumper($node_translated) . "\n";

    # this rule never matches empty
    return ($node_translated);
};

# GENERATE CPPOPS_PERLTYPES
our string__method $rperl_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self ) = @_;    # object method
    my string $self_generated = q{};
    $self_generated
        .= 'STUB PERL CODE STRING, CREATED BY RPerl::Operation::Expression::Variable';
    return ($self_generated);
};

# GENERATE CPPOPS_CPPTYPES
our string__method $rperl_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self ) = @_;    # object method
    my string $self_generated = q{};

    # trim leading sigil dollar sign
    if ( ( substr $self->{symbol}, 0, 1 ) eq q{$} ) {
        substr $self->{symbol}, 0, 1, q{};
    }
    $self_generated .= $self->{symbol};
    return ($self_generated);
};

1;
