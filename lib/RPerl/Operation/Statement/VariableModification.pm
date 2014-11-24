package RPerl::Operation::Statement::VariableModification;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_011;

# [[[ SETUP ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values and print operator
use Scalar::Util 'blessed';

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Statement);

# [[[ OO PROPERTIES ]]]
our %properties = ( ## no critic qw(ProhibitPackageVars)  # USER DEFAULT 2: allow OO properties
    name  => my string $TYPED_name  = undef,
    value => my object $TYPED_value = undef,
);

# [[[ OO METHODS ]]]
# VARIABLE_MODIFICATION RULE
our object__method $ppi_to_rperl__translate = sub {
    ( my string $class, my object $node) = @_;    # class method

    # variable declarations
    my string $rule_name = 'VARIABLE_MODIFICATION';
    my string $production_name;
    my string $component_name;
    my string $node_class;
    my string $node_class_expected = 'PPI::Statement'; # NEED FIX: also match PPI::Statement::Compound or other classes???
    my object $node_translated;
    my object $child;
    my string $child_class;
    my string $child_class_expected;
    my string $child_content;
    my string $child_content_expected;
    my string $child_key;
    my integer $child_index;
    my integer $child_index_max;
    my integer $child_qualified;

    RPerl::diag
        "in VariableModification::ppi_to_rperl__translate(), received \$node =\n"
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
        "in VariableModification::ppi_to_rperl__translate(), have \$node_class = '$node_class'\n";

    # VARIABLE_MODIFICATION rule begin
    if ( $node_class ne $node_class_expected ) {
        croak(
            "\nERROR ECVTRPI02, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, PPI OBJECT FAILURE:\n$node_class_expected object expected but $node_class object found,\ncroaking"
        );
    }
    $child_key = 'children';
    if ( not( defined $node->{$child_key} ) ) {
        croak(
            "\nERROR ECVTRPI03, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, PPI OBJECT FAILURE:\nchildren sub-objects array_ref value expected but undefined/null value found,\ncroaking"
        );
    }

    $child_index_max = ( scalar @{ $node->{$child_key} } ) - 1;

    if ( $child_index_max < 0 ) {
        croak(
            "\nERROR ECVTRPI04, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, PPI OBJECT FAILURE:\nmultiple children sub-objects expected but none found,\ncroaking"
        );
    }

    # VARIABLE_MODIFICATION rule, VARIABLE component @ KEY 'children', INDEX 0
    $production_name = '<default>';
    $component_name  = 'VARIABLE';
    $child_key       = 'children';
    $child_index     = 0;
    $child_class_expected = 'PPI::FOO'; # NEED FIX: what class(es)?  how to handle multi-object components?  how to handle VARIABLE_RETRIEVAL rule???
    $child = $node->{$child_key}->[$child_index];
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
    $node_translated->{variable}
        = RPerl::Variable->ppi_to_rperl__translate($node);

# NEED FIX: safe to assume hard-coded indices, considering possible multi-object VARIABLE rule above?
# VARIABLE_MODIFICATION rule, EQUAL component @ KEY 'children', INDEX 1
    $production_name        = '<default>';
    $component_name         = 'EQUAL';
    $child_key              = 'children';
    $child_index            = 1;
    $child_class_expected   = 'PPI::Token::Operator';
    $child_content_expected = q{=};
    $child                  = $node->{$child_key}->[$child_index];
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
    $child_content = $child->{content}; # assume PPI::Token::Operator contains operator name _key_word
    if ( $child_content ne $child_content_expected ) {
        croak(
            "\nERROR ECVTRSY01, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, in $child_class child sub-object at index $child_index, '$child_content_expected' expected but '$child_content' found,\ncroaking"
        );
    }

# VARIABLE_MODIFICATION rule, EXPRESSION rule/component @ KEY 'children', INDEX 2
    if ($child_qualified) {
        $production_name = '<default>';
        $component_name  = 'EXPRESSION';
        $child_key       = 'children';
        $child_index     = 2;
        $child           = $node->{$child_key}->[$child_index];
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
        $node_translated->{value}
            = RPerl::Operation::Expression->ppi_to_rperl__translate($child);
    }

# VARIABLE_MODIFICATION rule end, SEMICOLON component @ KEY 'children', INDEX max
    $production_name        = '<default>';
    $component_name         = 'SEMICOLON';
    $child_key              = 'children';
    $child_index            = $child_index_max;
    $child_class_expected   = 'PPI::Token::Structure';
    $child_content_expected = q{;};
    $child                  = $node->{$child_key}->[$child_index];
    if ( not( defined $child ) ) {
        croak(
            "\nERROR ECVTRPI05, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, PPI OBJECT FAILURE:\nin $node_class object, $child_class_expected child sub-object expected at index $child_index but undefined/null value found,\ncroaking"
        );
    }
    $child_class = blessed($child);
    if ( not( defined $child_class ) ) {
        croak(
            "\nERROR ECVTRPI06, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, PPI OBJECT FAILURE:\nin $node_class object, $child_class_expected child sub-object expected at index $child_index but non-object value found,\ncroaking"
        );
    }
    if ( $child_class ne $child_class_expected ) {
        croak(
            "\nERROR ECVTRSY00, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, $child_class_expected child sub-object expected at index $child_index but $child_class child sub-object found,\ncroaking"
        );
    }
    $child_content = $child->{content}; # assume PPI::Token::Structure contains punctuation
    if ( $child_content ne $child_content_expected ) {
        croak(
            "\nERROR ECVTRSY01, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, in $child_class child sub-object at index $child_index, '$child_content_expected' expected but '$child_content' found,\ncroaking"
        );
    }

    RPerl::diag
        "in VariableModification::ppi_to_rperl__translate(), bottom of subroutine, about to return \$node_translated=\n"
        . Dumper($node_translated) . "\n";

    # this rule never matches empty
    return ($node_translated);
};

1;
