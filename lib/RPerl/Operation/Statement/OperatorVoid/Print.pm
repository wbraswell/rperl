## no critic qw(ProhibitExcessMainComplexity)  # SYSTEM SPECIAL 5: allow complex code outside subroutines, must be on line 1
package RPerl::Operation::Statement::OperatorVoid::Print;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_002;

# [[[ SETUP ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
use Scalar::Util 'blessed';

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Statement::OperatorVoid); # NEED FIX: is not a Grammar Rule so should not inherit from OperatorVoid, need create Grammar Production class

# [[[ OO PROPERTIES ]]]
our hash_ref $properties = {
                    # object properties
    filehandle => my string $TYPED_filehandle           = undef,
    arguments  => my object__array_ref $TYPED_arguments = undef
};
our %class_properties = (
                          # class properties
     # NEED UPGRADE: officialize splitting class and object properties into 2 hashes
    name => my string $TYPED_name = 'print',
    parentheses_require => my integer $TYPED_parentheses_require = 0,
    parentheses_allow => my integer $TYPED_parentheses_allow = 0, # subject to Perl::Critic brutal CodeLayout::ProhibitParensWithBuiltins
    arguments_min     => my integer $TYPED_arguments_min     = 1,
    arguments_max => my integer $TYPED_arguments_max = 999,
);

# [[[ OO METHODS ]]]

# GENERATE CPPOPS_PERLTYPES
our string__method $rperl_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self ) = @_;    # object method
    my string $self_generated = q{};
    $self_generated
        .= "# STUB PERL CODE STRING, CREATED BY RPerl::Operation::Statement::OperatorVoid::Print\n";
    return ($self_generated);
};

# GENERATE CPPOPS_CPPTYPES
our string__method $rperl_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self ) = @_;    # object method
    my string $self_generated = q{};

    # NEED FIX: add non-hardcoded indentation level
    $self_generated .= q{ } x 4;

    if ( defined $self->{filehandle} ) {
        if ( $self->{filehandle} eq q{*STDERR} ) {
            $self_generated .= 'cerr';
        }
        else {
            croak(
                "\nERROR ECVGESY00, C++ GENERATOR, RPERL SYNTAX:\nin OperatorVoid '"
                    . $self->{name}
                    . q{', expected '*STDERR' or no filehandle, but non-matching filehandle '}
                    . $self->{filehandle}
                    . "' found,\ncroaking" );
        }
    }
    else {
        $self_generated .= 'cout';
    }

    foreach my object $argument ( @{ $self->{arguments}->{elements} } ) {
        $self_generated .= ' <<';
        my string $argument_class = blessed($argument);
        if (   ( $argument_class eq 'RPerl::Operation::Expression::SubExpression::Literal' )
            or
            ( $argument_class eq 'RPerl::Operation::Expression::SubExpression::Variable' ) )
        {
            $self_generated .= q{ }
                . $argument->rperl_to_cpp__generate__CPPOPS_CPPTYPES();
        }
        else {
            croak(
                "\nERROR ECVGESY02, C++ GENERATOR, RPERL SYNTAX:\nin OperatorVoid '"
                    . $self->{name}
                    . q{', expected Literal or Variable argument, but non-matching argument class '}
                    . $argument_class
                    . "' found,\ncroaking" );
        }
    }

    $self_generated .= ";\n";

    return ($self_generated);
};

# TRANSLATE OPERATOR_VOID RULE, PRINT PRODUCTION
our object__method $ppi_to_rperl__translate = sub {
    ( my string $class, my object $node) = @_;    # class method

    # variable declarations
    my string $rule_name       = 'OPERATOR_VOID';
    my string $production_name = 'PRINT';
    my string $component_name;
    my string $node_class;
    my string $node_class_expected = 'PPI::Statement';
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
    my object $grandchild;
    my string $grandchild_key;
    my integer $grandchild_index;
    my integer $grandchild_index_max;
    my string $grandchild_class;
    my string $grandchild_class_expected;
    my string $grandchild_content;
    my string $grandchild_content_expected;
    my integer $grandchild_disqualified;
    my object $greatgrandchild;
    my string $greatgrandchild_key;
    my integer $greatgrandchild_index;
    my string $greatgrandchild_class;
    my string $greatgrandchild_class_expected;

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

    # OPERATOR_VOID rule, PRINT production begin
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

# OPERATOR_VOID rule, PRINT production, _OPERATOR_VOID_NAME component @ KEY 'children', INDEX 0
    $component_name         = '_OPERATOR_VOID_NAME';
    $child_key              = 'children';
    $child_index            = 0;
    $child_class_expected   = 'PPI::Token::Word';
    $child_content_expected = ( \%class_properties )->{name};
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
    $child_content = $child->{content}; # assume PPI::Token::Operator contains _operator_void_name
    if ( $child_content ne $child_content_expected ) {
        croak(
            "\nERROR ECVTRSY01, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, in $child_class child sub-object at index $child_index, '$child_content_expected' expected but '$child_content' found,\ncroaking"
        );
    }
    $node_translated
        = RPerl::Operation::Statement::OperatorVoid::Print->new();

# OPERATOR_VOID rule, PRINT production, POSSIBLE ARGUMENT__FILEHANDLE component @ KEY 'children', INDEX 1
    $component_name                 = 'POSSIBLE ARGUMENT__FILEHANDLE';
    $child_key                      = 'children';
    $child_index                    = 1;
    $child_class_expected           = 'PPI::Structure::Block';
    $child_disqualified             = 0;
    $grandchild_key                 = 'children';
    $grandchild_index               = 0;
    $grandchild_class_expected      = 'PPI::Statement';
    $greatgrandchild_key            = 'children';
    $greatgrandchild_index          = 0;
    $greatgrandchild_class_expected = 'PPI::Token::Symbol';
    $child                          = $node->{$child_key}->[$child_index];
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
        $child_disqualified = 1;
    }
    if ( not $child_disqualified ) {
        $grandchild
            = $node->{$child_key}->[$child_index]->{$grandchild_key}
            ->[$grandchild_index];
        if ( not( defined $grandchild ) ) {
            croak(
                "\nERROR ECVTRPI05, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, PPI OBJECT FAILURE:\nin $node_class object, $grandchild_class_expected grandchild sub-sub-object expected at key '$grandchild_key' and index $grandchild_index but undefined/null value found,\ncroaking"
            );
        }
        $grandchild_class = blessed($grandchild);
        if ( not( defined $grandchild_class ) ) {
            croak(
                "\nERROR ECVTRPI06, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, PPI OBJECT FAILURE:\nin $node_class object, $grandchild_class_expected grandchild sub-sub-object expected at key '$grandchild_key' and index $grandchild_index but non-object value found,\ncroaking"
            );
        }
        if ( $grandchild_class ne $grandchild_class_expected ) {
            croak(
                "\nERROR ECVTRSY00, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, $grandchild_class_expected grandchild sub-sub-object expected at key '$grandchild_key' and index $grandchild_index,\nbut $grandchild_class grandchild sub-sub-object found,\ncroaking"
            );
        }
        $greatgrandchild
            = $node->{$child_key}->[$child_index]->{$grandchild_key}
            ->[$grandchild_index]->{$greatgrandchild_key}
            ->[$greatgrandchild_index];

        if ( not( defined $greatgrandchild ) ) {
            croak(
                "\nERROR ECVTRPI05, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, PPI OBJECT FAILURE:\nin $node_class object, $greatgrandchild_class_expected great-grandchild sub-sub-sub-object expected at key '$greatgrandchild_key' and index $greatgrandchild_index but undefined/null value found,\ncroaking"
            );
        }
        $greatgrandchild_class = blessed($greatgrandchild);
        if ( not( defined $greatgrandchild_class ) ) {
            croak(
                "\nERROR ECVTRPI06, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, PPI OBJECT FAILURE:\nin $node_class object, $greatgrandchild_class_expected great-grandchild sub-sub-sub-object expected at key '$greatgrandchild_key' and index $greatgrandchild_index but non-object value found,\ncroaking"
            );
        }
        if ( $greatgrandchild_class ne $greatgrandchild_class_expected ) {
            croak(
                "\nERROR ECVTRSY00, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, $greatgrandchild_class_expected great-grandchild sub-sub-sub-object expected at key '$greatgrandchild_key' and index $greatgrandchild_index,\nbut $greatgrandchild_class great-grandchild sub-sub-sub-object found,\ncroaking"
            );
        }
        $node_translated->{filehandle} = $greatgrandchild->{content}; # assume PPI::Token::Symbol contains filehandle name
        $child_index++;                                               # increment for proper use in slice below
    }

# OPERATOR_VOID rule, PRINT production, LIST_ELEMENTS rule/component @ KEY 'children', INDEX (1 or 2) to (max - 1)
    $component_name = 'LIST_ELEMENTS';
    my integer $arguments_count = $child_index_max - $child_index;
    if ( $arguments_count < ( \%class_properties )->{arguments_min} ) {
        croak(
            "\nERROR ECVTRSY02, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, '"
                . ( \%class_properties )->{name}
                . q{' operator, }
                . ( \%class_properties )->{arguments_min}
                . " minimum argument(s) expected, but $arguments_count argument(s) found,\ncroaking"
        );
    }
    if ( $arguments_count > ( \%class_properties )->{arguments_max} ) {
        croak(
            "\nERROR ECVTRSY03, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, '"
                . ( \%class_properties )->{name}
                . q{' operator, }
                . ( \%class_properties )->{arguments_min}
                . " maximum argument(s) expected, but $arguments_count argument(s) found,\ncroaking"
        );
    }
    my @arguments_array = @{ $node->{$child_key} }
        [ $child_index .. ( $child_index_max - 1 ) ];
    my object__array_ref $arguments = \@arguments_array; # two-statement slice

#print "in Print::ppi_to_rperl__translate(), have \$arguments_count = $arguments_count\n";
#print "in Print::ppi_to_rperl__translate(), have \$arguments =\n" . Dumper($arguments) . "\n";

# DEV NOTE: put arguments inside PPI object to pass to ListElements, so that all ppi_to_rperl*translate() methods only accept PPI objects as input
    my object $arguments_node = PPI::Statement->new();
    $arguments_node->{children} = $arguments; # DEV NOTE: breaking encapsulation of PPI::Statement!  there is no set_children() accessor method!

#print "in Print::ppi_to_rperl__translate(), have \$arguments_node =\n" . Dumper($arguments_node) . "\n";

    $node_translated->{arguments}
        = RPerl::DataStructure::Array::ListElements->ppi_to_rperl__translate(
        $arguments_node);

# OPERATOR_VOID rule, PRINT production end, SEMICOLON component @ KEY 'children', INDEX max
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
        "in Print::ppi_to_rperl__translate(), bottom of subroutine, about to return \$node_translated=\n"
        . Dumper($node_translated) . "\n";

    # this rule never matches empty
    return ($node_translated);
};

1;
