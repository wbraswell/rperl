## no critic qw(ProhibitExcessMainComplexity)  # SYSTEM SPECIAL 5: allow complex code outside subroutines, must be on line 1
package RPerl::Operation;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_004;

# [[[ SETUP ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values and print operator
## no critic qw(ProhibitBooleanGrep)  # SYSTEM SPECIAL 1: allow grep
## no critic qw(ProhibitPackageVars)  # SYSTEM SPECIAL 4b: allow $OperatorVoid::_operator_void_names
## no critic qw(ProhibitCascadingIfElse)  ## SYSTEM SPECIAL 12: allow complex conditional logic
use Scalar::Util 'blessed';
use rperloperations;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::GrammarRule);

# [[[ OO PROPERTIES ]]]
our %properties = ( ## no critic qw(ProhibitPackageVars)  # USER DEFAULT 2: allow OO properties
    type      => my string $KEY_type                 = undef,
    name      => my string $KEY_name                 = undef,
    arguments => my object__array_ref $KEY_arguments = undef,
);

# [[[ OO METHODS ]]]

# TRANSLATE OPERATION+
our object__array_ref__method $ppi_to_rperl__translate_plus = sub {
    ( my string $class, my object__array_ref $nodes) = @_;    # class method

    # variable declarations
    my string $rule_name = 'OPERATION+';
    my string $production_name;
    my string $component_name;
    my object__array_ref $nodes_translated = []; # default to empty array of operations, this rule never matches empty
    my object $node;
    my integer $node_index_max;
    my string $node_class;
    my string__array_ref $node_classes_expected = [
        'PPI::Statement',           'PPI::Statement::Compound',
        'PPI::Statement::Variable', 'PPI::Statement::Break',
    ];
    my object $node_translated;
    my object $child;
    my string $child_key;
    my integer $child_index;
    my integer $child_index_max;
    my string $child_class;
    my string $child_class_expected;
    my string $child_content;
    my string $child_content_expected;
    my integer $child_disqualified;

#RPerl::diag "in Operation::ppi_to_rperl__translate_plus(), received \$nodes =\n" . Dumper($nodes) . "\n";

    $node_index_max = ( scalar @{$nodes} ) - 1;

    if ( $node_index_max < 0 ) {
        croak(
            "\nERROR ECVTRPI04, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, PPI OBJECT FAILURE:\nmultiple node sub-objects expected but none found,\ncroaking"
        );
    }

    # OPERATION+ rule begin
NODE_LOOP: for my $node_index_loop ( 0 .. $node_index_max ) {
        $node = $nodes->[$node_index_loop];

        RPerl::diag
            'in Operation::ppi_to_rperl__translate_plus(), top of for() loop '
            . $node_index_loop . q{/}
            . $node_index_max
            . ", have \$node =\n"
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
            'in Operation::ppi_to_rperl__translate_plus(), in for() loop '
            . $node_index_loop . q{/}
            . $node_index_max
            . ", have \$node_class = '$node_class'\n";

        # OPERATION rule begin
        if ( not( grep { $_ eq $node_class } @{$node_classes_expected} ) ) {
            croak(
                "\nERROR ECVTRPI02, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, PPI OBJECT FAILURE:\nmember of ("
                    . join( ', ', @{$node_classes_expected} )
                    . ")\nobject expected but $node_class object found,\ncroaking"
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

        if ( $node_class eq 'PPI::Statement' ) {

# IF LAST CHILD IS SEMICOLON
#     IF CHILD @ INDEX 0 IS _OPERATOR_VOID_NAME, THIS IS AN OPERATOR_VOID RULE
#     ELSIF CHILD @ INDEX 1 IS EQUAL, THIS IS A VARIABLE_MODIFICATION RULE
#     ELSE THIS IS AN EXPRESSION RULE
# ELSE CURRENTLY UNKNOWN

# OPERATION rule, POSSIBLE SEMICOLON component @ INDEX iterated, KEY 'children', INDEX max
            $rule_name              = 'OPERATION';
            $production_name        = '<any>';
            $component_name         = 'POSSIBLE SEMICOLON';
            $child_key              = 'children';
            $child_index            = $child_index_max;
            $child_class_expected   = 'PPI::Token::Structure';
            $child_content_expected = q{;};
            $child_disqualified     = 0;
            $child                  = $node->{$child_key}->[$child_index];
            if ( not( defined $child ) ) {
                croak(
                    "\nERROR ECVTRPI07, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, PPI OBJECT FAILURE:\nin $node_class object, (possibly $child_class_expected) child sub-object expected at index $child_index but undefined/null value found,\ncroaking"
                );
            }
            $child_class = blessed($child);
            if ( not( defined $child_class ) ) {
                croak(
                    "\nERROR ECVTRPI08, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, PPI OBJECT FAILURE:\nin $node_class object, (possibly $child_class_expected) child sub-object expected at index $child_index but non-object value found,\ncroaking"
                );
            }
            if ( ( $child_class ne $child_class_expected ) ) {
                $child_disqualified = 1;
            }
            $child_content = $child->{content}; # assume PPI::Token::Structure contains punctuation
            if ( $child_content ne $child_content_expected ) {
                $child_disqualified = 1;
            }

# OPERATION rule, SEMICOLON component @ INDEX iterated, KEY 'children', INDEX max
            if ( not($child_disqualified) ) {    # LAST CHILD IS SEMICOLON

# OPERATION rule, POSSIBLE STATEMENT rule/production, POSSIBLE OPERATOR_VOID rule/production,
# POSSIBLE _OPERATOR_VOID_NAME component @ INDEX iterated, KEY 'children', INDEX 0
                $rule_name            = 'OPERATION';
                $production_name      = 'POSSIBLE STATEMENT/OPERATOR_VOID';
                $component_name       = 'POSSIBLE _OPERATOR_VOID_NAME';
                $child_key            = 'children';
                $child_index          = 0;
                $child_class_expected = 'PPI::Token::Word';
                $child_content_expected
                    = ${RPerl::Operation::Statement::OperatorVoid::properties}
                    {_operator_void_names}; # DEV NOTE: I'm bad, breaking OO encapsulation!  NEED UPGRADE: create class property accessor (and mutator?) methods
                $child_content_expected
                    = ${RPerl::Operation::Statement::OperatorVoid::properties}
                    {_operator_void_names}; # DEV NOTE: must repeat this line to avoid "used only once, possible typo" warning
                $child_disqualified = 0;
                $child              = $node->{$child_key}->[$child_index];

                if ( not( defined $child ) ) {
                    croak(
                        "\nERROR ECVTRPI07, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, PPI OBJECT FAILURE:\nin $node_class object, (possibly $child_class_expected) child sub-object expected at index $child_index but undefined/null value found,\ncroaking"
                    );
                }
                $child_class = blessed($child);
                if ( not( defined $child_class ) ) {
                    croak(
                        "\nERROR ECVTRPI08, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, PPI OBJECT FAILURE:\nin $node_class object, (possibly $child_class_expected) child sub-object expected at index $child_index but non-object value found,\ncroaking"
                    );
                }
                if ( $child_class ne $child_class_expected ) {
                    $child_disqualified = 1;
                }
                $child_content = $child->{content}; # assume PPI::Token::Word contains _operator_void_name
                if (not( defined $child_content_expected->{$child_content} ) )
                {
                    $child_disqualified = 1;
                }

# OPERATION rule, STATEMENT rule/production, OPERATOR_VOID rule/production, _OPERATOR_VOID_NAME component @ INDEX iterated, KEY 'children', INDEX 0
                if ( not($child_disqualified) ) { # FIRST CHILD IS _OPERATOR_VOID_NAME
                    $node_translated
                        = $child_content_expected->{$child_content}
                        ->ppi_to_rperl__translate($node);  # class method call
                    push @{$nodes_translated}, $node_translated;
                    next NODE_LOOP;
                }

# OPERATION rule, POSSIBLE STATEMENT rule/production, POSSIBLE VARIABLE_MODIFICATION rule/production,
# POSSIBLE EQUAL component @ INDEX iterated, KEY 'children', INDEX 1
                $rule_name       = 'OPERATION';
                $production_name = 'POSSIBLE STATEMENT/VARIABLE_MODIFICATION';
                $component_name  = 'POSSIBLE SEMICOLON';
                $child_key       = 'children';
                $child_index     = 1;
                $child_class_expected   = 'PPI::Token::Operator';
                $child_content_expected = q{=};
                $child_disqualified     = 0;
                $child                  = $node->{$child_key}->[$child_index];
                if ( not( defined $child ) ) {
                    croak(
                        "\nERROR ECVTRPI07, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, PPI OBJECT FAILURE:\nin $node_class object, (possibly $child_class_expected) child sub-object expected at index $child_index but undefined/null value found,\ncroaking"
                    );
                }
                $child_class = blessed($child);
                if ( not( defined $child_class ) ) {
                    croak(
                        "\nERROR ECVTRPI08, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, PPI OBJECT FAILURE:\nin $node_class object, (possibly $child_class_expected) child sub-object expected at index $child_index but non-object value found,\ncroaking"
                    );
                }
                if ( $child_class ne $child_class_expected ) {
                    $child_disqualified = 1;
                }
                $child_content = $child->{content}; # assume PPI::Token::Structure contains punctuation
                if ( $child_content ne $child_content_expected ) {
                    $child_disqualified = 1;
                }

# OPERATION rule, STATEMENT rule/production, VARIABLE_MODIFICATION rule/production @ INDEX iterated
                if ( not($child_disqualified) ) {
                    $node_translated
                        = RPerl::Operation::Statement::VariableModification
                        ->ppi_to_rperl__translate($node);
                    push @{$nodes_translated}, $node_translated;
                    next NODE_LOOP;
                }

                # OPERATION rule, EXPRESSION rule/production @ INDEX iterated
                $node_translated
                    = RPerl::Operation::Expression->ppi_to_rperl__translate(
                    $node);
                push @{$nodes_translated}, $node_translated;
                next NODE_LOOP;

            }
            else {
                croak(
                    "\nERROR ECVTRPI09, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, PPI OBJECT FAILURE:\nin $node_class object, Expression or VariableModification rule/production expected at node index $node_index_loop but unknown node found,\ncroaking"
                );
            }

        }
        elsif ( $node_class eq 'PPI::Statement::Compound' ) {

            # MAY BE PART OF MULTI-NODE STATEMENT RULE
            # ELSE CURRENTLY UNKNOWN
            $node_translated
                = '<DUMMY CODE, MAYBE PART OF MULTI-NODE STATEMENT RULE, PPI::Statement::Compound>';
            push @{$nodes_translated}, $node_translated;
            next NODE_LOOP;
        }
        elsif ( $node_class eq 'PPI::Statement::Variable' ) {

# OPERATION rule, STATEMENT rule/production, VARIABLE_DECLARATION rule/production @ INDEX iterated
            $node_translated
                = RPerl::Operation::Statement::VariableDeclaration
                ->ppi_to_rperl__translate($node);
            push @{$nodes_translated}, $node_translated;
            next NODE_LOOP;
        }
        elsif ( $node_class eq 'PPI::Statement::Break' ) {

# OPERATION rule, STATEMENT rule/production, OPERATOR_VOID rule/production @ INDEX iterated
            $node_translated
                = RPerl::Operation::Statement::OperatorVoid::Return
                ->ppi_to_rperl__translate($node);
            push @{$nodes_translated}, $node_translated;
            next NODE_LOOP;
        }
        else { # DEV NOTE: this should be redundant and delete-able, however it is an extra catch in case previous check of $node_classes_expected is somehow borked
            croak(
                "\nERROR ECVTRPI02a, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, PPI OBJECT FAILURE:\nmember of ("
                    . join( ', ', @{$node_classes_expected} )
                    . ")\nobject expected but $node_class object found,\ncroaking"
            );
        }

# this line and the followirng print statements should never be reached
#RPerl::diag 'in Operation::ppi_to_rperl__translate_plus(), bottom of for() loop ' . $node_index_loop . q{/} . $node_index_max . ", have \$grandchild = \n" . Dumper($grandchild) . "\n";
#RPerl::diag 'in Operation::ppi_to_rperl__translate_plus(), bottom of for() loop ' . $node_index_loop . q{/} . $node_index_max . ", have \$node_translated = \n" . Dumper($node_translated) . "\n";
    }

#    RPerl::diag "in Operation::ppi_to_rperl__translate_plus(), bottom of subroutine, about to return \$node_translated=\n" . Dumper($node_translated) . "\n";

    # this rule never matches empty
    return ($nodes_translated);
};

1;
