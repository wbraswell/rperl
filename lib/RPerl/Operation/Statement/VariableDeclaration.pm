## no critic qw(ProhibitExcessMainComplexity)  # SYSTEM SPECIAL 5: allow complex code outside subroutines, must be on line 1
package RPerl::Operation::Statement::VariableDeclaration;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_011;

# [[[ SETUP ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitPackageVars)  # SYSTEM SPECIAL 4a: allow $rperltypes::supported
## no critic qw(ProhibitBooleanGrep)  # SYSTEM SPECIAL 1: allow grep
use Scalar::Util 'blessed';

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Statement);

# [[[ OO PROPERTIES ]]]
our %properties = ( ## no critic qw(ProhibitPackageVars)  # USER DEFAULT 3: allow OO properties
    type  => my string $TYPED_type  = undef,
    name  => my string $TYPED_name  = undef,
    value => my object $TYPED_value = undef,
);

# [[[ OO METHODS ]]]
# VARIABLE_DECLARATION RULE
our object__method $ppi_to_rperl__translate = sub {
    ( my string $class, my object $node) = @_;    # class method

    # variable declarations
    my string $rule_name = 'VARIABLE_DECLARATION';
    my string $production_name;
    my string $component_name;
    my string $node_class;
    my string $node_class_expected = 'PPI::Statement::Variable';
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
        "in VariableDeclaration::ppi_to_rperl__translate(), received \$node =\n"
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
        "in VariableDeclaration::ppi_to_rperl__translate(), have \$node_class = '$node_class'\n";

    # VARIABLE_DECLARATION rule begin
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

    # VARIABLE_DECLARATION rule, MY component @ KEY 'children', INDEX 0
    $production_name        = '<any>';
    $component_name         = 'MY';
    $child_key              = 'children';
    $child_index            = 0;
    $child_class_expected   = 'PPI::Token::Word';
    $child_content_expected = 'my';
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
            "\nERROR ECVTRSY00, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, $child_class_expected child sub-object expected at key '$child_key' and index $child_index,\nbut $child_class child sub-object found,\ncroaking"
        );
    }
    $child_content = $child->{content}; # assume PPI::Token::Word contains _word or _keyword
    if ( $child_content ne $child_content_expected ) {
        croak(
            "\nERROR ECVTRSY01, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, in $child_class child sub-sub-object at key '$child_key' and index $child_index,\n'$child_content_expected' expected but '$child_content' found,\ncroaking"
        );
    }

    # VARIABLE_DECLARATION rule, TYPE component @ KEY 'children', INDEX 1
    $production_name        = '<any>';
    $component_name         = 'TYPE';
    $child_key              = 'children';
    $child_index            = 1;
    $child_class_expected   = 'PPI::Token::Word';
    $child_content_expected = $rperltypes::supported;
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
            "\nERROR ECVTRSY00, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, $child_class_expected child sub-object expected at key '$child_key' and index $child_index,\nbut $child_class child sub-object found,\ncroaking"
        );
    }
    $child_content = $child->{content}; # assume PPI::Token::Word contains _type
    if ( not( grep { $_ eq $child_content } @{$child_content_expected} ) ) {
        croak(
            "\nERROR ECVTRSY01, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, in $child_class child sub-sub-object at index $child_index,\nmember of ("
                . join( ', ', @{$child_content_expected} )
                . ")\nexpected but '$child_content' found,\ncroaking" );
    }

    $node_translated
        = RPerl::Operation::Statement::VariableDeclaration->new();
    $node_translated->{type} = $child_content;

    # VARIABLE_DECLARATION rule, VARIABLE component @ KEY 'children', INDEX 2
    $production_name      = '<any>';
    $component_name       = 'VARIABLE';
    $child_key            = 'children';
    $child_index          = 2;
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
    $node_translated->{name} = $child->{content}; # assume PPI::Token::Symbol contains _variable

# don't bother checking for EQUAL EXPRESSION if we're at the end of the children
    if ( $child_index_max > 3 ) {

# VARIABLE_DECLARATION rule, POSSIBLE EXPRESSION rule/production, POSSIBLE EQUAL component @ KEY 'children', INDEX 3
        $production_name        = 'POSSIBLE EXPRESSION';
        $component_name         = 'POSSIBLE EQUAL';
        $child_key              = 'children';
        $child_index            = 3;
        $child_class_expected   = 'PPI::Token::Operator';
        $child_content_expected = q{=};
        $child_qualified        = 0;
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
        $child_content = $child->{content};
        if (    ( $child_class eq $child_class_expected )
            and ( $child_content eq $child_content_expected ) )
        {
            $child_qualified = 1;
        }

# VARIABLE_DECLARATION rule, EXPRESSION rule/production/component @ KEY 'children', INDEX 4
        if ($child_qualified) {
            $production_name = 'EXPRESSION';
            $component_name  = 'EXPRESSION';
            $child_key       = 'children';
            $child_index     = 4;
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
                = RPerl::Operation::Expression->ppi_to_rperl__translate(
                $child);
        }
    }

# VARIABLE_DECLARATION rule end, SEMICOLON component @ KEY 'children', INDEX max
    $production_name        = '<any>';
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
        "in VariableDeclaration::ppi_to_rperl__translate(), bottom of subroutine, about to return \$node_translated=\n"
        . Dumper($node_translated) . "\n";

    # this rule never matches empty
    return ($node_translated);
};

1;
