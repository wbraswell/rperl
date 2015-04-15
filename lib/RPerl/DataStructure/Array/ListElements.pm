## no critic qw(ProhibitExcessMainComplexity)  # SYSTEM SPECIAL 5: allow complex code outside subroutines, must be on line 1
package RPerl::DataStructure::Array::ListElements;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_005;

# [[[ SETUP ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitBooleanGrep)  # SYSTEM SPECIAL 1: allow grep
use Data::Dumper;
use Scalar::Util 'blessed';

# [[[ OO INHERITANCE ]]]
use RPerl::GrammarRule;
use parent qw(RPerl::GrammarRule);

# [[[ OO PROPERTIES ]]]
# DEV NOTE: no active properties, this is a stub object for now, see children objects for active properties
our hash_ref $properties = {
    elements => my object__array_ref $TYPED_elements = undef,
};

# [[[ OO METHODS ]]]

# TRANSLATE
our object__array_ref__method $ppi_to_rperl__translate = sub {
    ( my string $class, my object $node) = @_;    # class method

    # variable declarations
    my string $rule_name = 'LIST_ELEMENTS';
    my string $production_name;
    my string $component_name;
    my integer $node_index_max;
    my string $node_class;
    my string $node_classes_expected = [qw(PPI::Statement)]; # NEED FIX: accept what other classes?
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

    RPerl::diag
        "in ListElements::ppi_to_rperl__translate(), received \$node =\n"
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
        "in ListElements::ppi_to_rperl__translate(), have \$node_class = '$node_class'\n";

    # LIST_ELEMENTS rule begin
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

    # this rule never returns empty, create AST object now
    $node_translated = RPerl::DataStructure::Array::ListElements->new();

 # LIST_ELEMENTS rule, LIST_ELEMENT_VALUE0 component @ KEY 'children', INDEX 0
    $production_name = '<default>';
    $component_name  = 'LIST_ELEMENT_VALUE0';
    $child_key       = 'children';
    $child_index     = 0;
    $child           = $node->{$child_key}->[$child_index];
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
    push @{ $node_translated->{elements} },
        RPerl::DataStructure::Array::ListElements
        ->ppi_to_rperl__value_translate($child);

    # (comma LIST_ELEMENT_VALUE1)* components begin
    $production_name = '<default>';
    $child_key       = 'children';
    my integer $child_index_loop = 1;
    while ( $child_index_loop <= $child_index_max ) {

        # LIST_ELEMENTS rule, COMMA component @ KEY 'children', INDEX odd
        $component_name         = 'COMMA';
        $child_class_expected   = 'PPI::Token::Operator';
        $child_content_expected = q{,};
        $child                  = $node->{$child_key}->[$child_index_loop];
        RPerl::diag
            'in ListElements::ppi_to_rperl__translate(), top of for() loop '
            . $child_index_loop . q{/}
            . $child_index_max
            . ", have first \$child =\n"
            . Dumper($child) . "\n";
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
        $child_content = $child->{content};    # assume FOO
        if ( $child_content ne $child_content_expected ) {
            croak(
                "\nERROR ECVTRSY01, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, in $child_class child sub-object at index $child_index, '$child_content_expected' expected but '$child_content' found,\ncroaking"
            );
        }

        # increment loop index to check 2 items per iteration
        $child_index_loop++;

 # LIST_ELEMENTS rule, LIST_ELEMENT_VALUE1 component @ KEY 'children', INDEX 0
        $production_name = '<default>';
        $component_name  = 'LIST_ELEMENT_VALUE1';
        $child_key       = 'children';
        $child_index     = 0;
        $child           = $node->{$child_key}->[$child_index_loop];
        RPerl::diag
            'in ListElements::ppi_to_rperl__translate(), middle of for() loop '
            . $child_index_loop . q{/}
            . $child_index_max
            . ", have second \$child =\n"
            . Dumper($child) . "\n";
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
        push @{ $node_translated->{elements} },
            RPerl::DataStructure::Array::ListElements
            ->ppi_to_rperl__value_translate($child);

        # increment loop index to check 2 items per iteration
        $child_index_loop++;
    }

#    RPerl::diag "in ListElements::ppi_to_rperl__translate(), bottom of subroutine, about to return \$node_translated=\n" . Dumper($node_translated) . "\n";

    # this rule never matches empty
    return ($node_translated);
};

# TRANSLATE LIST_ELEMENT_VALUE RULE
our object__method $ppi_to_rperl__value_translate = sub {
    ( my string $class, my object $node) = @_;    # class method

# IF CHILD @ INDEX 0 IS AT_SIGN, THEN NODE IS ARRAY_ELEMENTS PRODUCTION
# ELSIF CHILD @ INDEX 0 IS KEYS_OR_VALUES, THEN NODE IS HASH_KEYS_OR_VALUES PRODUCTION
# ELSE NODE IS EXPRESSION PRODUCTION

    # variable declarations
    my string $rule_name = 'LIST_ELEMENT_VALUE';
    my string $production_name;
    my string $component_name;
    my string $node_class;
    my string $node_class_expected;
    my integer $node_disqualified;
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

    RPerl::diag
        "in ListElements::ppi_to_rperl__value_translate(), received \$node =\n"
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
        "in ListElements::ppi_to_rperl__value_translate(), have \$node_class = '$node_class'\n";

    # LIST_ELEMENT_VALUE rule, POSSIBLE ARRAY_ELEMENTS production
    $production_name = 'POSSIBLE ARRAY_ELEMENTS';
    $component_name  = 'POSSIBLE AT_SIGN';
    $node_class_expected = 'PPI::FOO'; # NEED FIX: what class is @{FOO} ARRAY_ELEMENTS production in this context?  maybe multiple objects?
    $node_disqualified   = 0;
    if ( $node_class ne $node_class_expected ) {
        $node_disqualified = 1;
    }

# LIST_ELEMENT_VALUE rule, POSSIBLE ARRAY_ELEMENTS production, POSSIBLE AT_SIGN component @ KEY 'children', INDEX 0
    if ( not $node_disqualified ) {
        $child_key   = 'children';
        $child_index = 0;
        $child_class_expected = 'PPI::Token::FOO'; # NEED FIX: what class is @ at_sign in this context???
        $child_content_expected = q{@};
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
        $child_content = $child->{content};    # assume PPI::Token::FOO
        if ( $child_content ne $child_content_expected ) {
            $child_disqualified = 1;
        }

# LIST_ELEMENT_VALUE rule, ARRAY_ELEMENTS production, AT_SIGN component @ KEY 'children', INDEX 0
        if ( not($child_disqualified) ) {      # FIRST CHILD IS AT_SIGN
            $node_translated
                = { DUMMY_AST_KEY =>
                    'DUMMY AST DATA CREATED BY ARRAY_ELEMENTS PRODUCTION IN LIST_ELEMENT_VALUE RULE'
                };
            RPerl::diag
                "in ListElements::ppi_to_rperl__value_translate(), ARRAY_ELEMENTS production, about to return \$node_translated=\n"
                . Dumper($node_translated) . "\n";
            return ($node_translated);
        }
    }

    # LIST_ELEMENT_VALUE rule, POSSIBLE HASH_KEYS_OR_VALUES production
    $production_name = 'POSSIBLE HASH_KEYS_OR_VALUES';
    $component_name  = 'POSSIBLE KEYS_OR_VALUES';
    $node_class_expected = 'PPI::FOO'; # NEED FIX: what class is keys_or_values %{FOO} HASH_KEYS_OR_VALUES production in this context?  maybe multiple objects?
    $node_disqualified   = 0;
    if ( $node_class ne $node_class_expected ) {
        $node_disqualified = 1;
    }

# LIST_ELEMENT_VALUE rule, POSSIBLE HASH_KEYS_OR_VALUES production, POSSIBLE KEYS_OR_VALUES component @ KEY 'children', INDEX 0
    if ( not $node_disqualified ) {
        $production_name = 'POSSIBLE HASH_KEYS_OR_VALUES';
        $component_name  = 'POSSIBLE KEYS_OR_VALUES';
        $child_key       = 'children';
        $child_index     = 0;
        $child_class_expected = 'PPI::Token::Word'; # NEED FIX: what class is keys or values in this context???
        $child_content_expected = {
            'keys'   => 'RPerl::Operation::Expression::Operator::FOO::Keys',
            'values' => 'RPerl::Operation::Expression::Operator::FOO::Values'
        };
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
        $child_content = $child->{content};    # assume PPI::Token::FOO
        if ( not( defined $child_content_expected->{$child_content} ) ) {
            $child_disqualified = 1;
        }

# LIST_ELEMENT_VALUE rule, HASH_KEYS_OR_VALUES production, KEYS_OR_VALUES component @ KEY 'children', INDEX 0
        if ( not($child_disqualified) ) {      # FIRST CHILD IS KEYS_OR_VALUES
            $node_translated
                = { DUMMY_AST_KEY =>
                    'DUMMY AST DATA CREATED BY HASH_KEYS_OR_VALUES PRODUCTION IN LIST_ELEMENT_VALUE RULE'
                };
            RPerl::diag
                "in ListElements::ppi_to_rperl__value_translate(), HASH_KEYS_OR_VALUES production, about to return \$node_translated=\n"
                . Dumper($node_translated) . "\n";
            return ($node_translated);
        }
    }

# LIST_ELEMENT_VALUE rule, EXPRESSION production @ KEY 'children', INDEX 0 - max
    $node_translated
        = RPerl::Operation::Expression->ppi_to_rperl__translate($node); # class method call
    RPerl::diag
        "in ListElements::ppi_to_rperl__value_translate(), EXPRESSION production, about to return \$node_translated=\n"
        . Dumper($node_translated) . "\n";

# this rule never matches empty, assume EXPRESSION errors caught by ppi_to_rperl__translate()
    return ($node_translated);
};

# GENERATE CPPOPS_PERLTYPES
our string__method $rperl_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self ) = @_;    # object method
    my string $self_generated = q{};
    $self_generated
        .= 'STUB PERL CODE STRING, CREATED BY RPerl::DataStructure::Array::ListElements';
    return ($self_generated);
};

# GENERATE CPPOPS_CPPTYPES
our string__method $rperl_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self ) = @_;    # object method
    my string $self_generated = q{};
    $self_generated
        .= 'STUB CPP CODE STRING, CREATED BY RPerl::DataStructure::Array::ListElements';
    return ($self_generated);
};

1;
