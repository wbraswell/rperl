## no critic qw(ProhibitExcessMainComplexity)  # SYSTEM SPECIAL 5: allow complex code outside subroutines, must be on line 1
package RPerl::CodeBlock::Subroutine;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_011;

# [[[ SETUP ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values and print operator
## no critic qw(RequireInterpolationOfMetachars)  # SYSTEM DEFAULT 2: allow single-quoted control characters, sigils, and regexes
## no critic qw(Capitalization ProhibitMultiplePackages)  # SYSTEM DEFAULT 4: allow multiple lower case package names
## no critic qw(ProhibitBooleanGrep)  # SYSTEM SPECIAL 1: allow grep
## no critic qw(ProhibitPackageVars)  # SYSTEM SPECIAL 4a: allow $rperltypes::supported
BEGIN {

    package object__method;
    1;

    package hash_ref__method;
    1;

    package string__method;
    1;

# DEV NOTE, CORRELATION #03: method types reside in Method.pm, which is a sub-type of Subroutine.pm, causing the need to have this special BEGIN block
# to enable the *__method types, and Class.pm's INIT block symbol table entry generator needs us to switch back into the primary package so we have
# that happen in the following line, which furthermore triggers the need to avoid re-defining class accessor/mutator methods; how to fix?
    package RPerl::CodeBlock::Subroutine;
    1;
}
use Data::Dumper;
use Scalar::Util 'blessed';

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CodeBlock);

# [[[ OO PROPERTIES ]]]
our %properties = ( ## no critic qw(ProhibitPackageVars)  # USER DEFAULT 2: allow OO properties
    type       => my string $TYPED_type                   = undef,
    name       => my string $TYPED_name                   = undef,
    arguments  => my hash_ref__array_ref $TYPED_arguments = undef,
    operations => my object__array_ref $TYPED_operations  = undef,
);

# [[[ OO METHOD(S) ]]]

# GENERATE CPPOPS_CPPTYPES
our string__method $rperl_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self ) = @_;    # object method
    my string $self_generated = q{};

#RPerl::diag "in Subroutine::rperl_to_cpp__generate__CPPOPS_CPPTYPES(), received \$self = \n" . Dumper($self) . "\n";
#$self_generated .= "// <<< SUBROUTINE RULE, BEGIN CPPOPS_CPPTYPES >>>\n"; # DEBUG TEMP

    $self_generated
        .= $self->rperl_to_cpp__header_generate__CPPOPS_CPPTYPES();
    $self_generated .= q[{] . "\n";

    foreach my object $operation ( @{ $self->{operations} } ) {
        $self_generated
            .= $operation->rperl_to_cpp__generate__CPPOPS_CPPTYPES();
    }

    $self_generated .= q[}] . "\n";

#$self_generated .= "// <<< SUBROUTINE RULE, END CPPOPS_CPPTYPES >>>\n"; # DEBUG TEMP
#RPerl::diag "in Subroutine::rperl_to_cpp__generate__CPPOPS_CPPTYPES(), about to return \$self_generated = \n\n\n" . $self_generated . "\n\n";

    return ($self_generated);
};

# GENERATE HEADER CPPOPS_CPPTYPES
our string__method $rperl_to_cpp__header_generate__CPPOPS_CPPTYPES = sub {
    ( my object $self ) = @_;    # object method
    my string $self_header_generated = q{};

#RPerl::diag "in Subroutine::rperl_to_cpp__header_generate__CPPOPS_CPPTYPES(), received \$self = \n" . Dumper($self) . "\n";
#$self_header_generated .= "// <<< SUBROUTINE RULE, HEADER COMPONENTS, BEGIN CPPOPS_CPPTYPES >>>\n"; # DEBUG TEMP

    # trim leading sigil dollar sign
    if ( ( substr $self->{name}, 0, 1 ) eq q{$} ) {
        substr $self->{name}, 0, 1, q{};
    }
    $self_header_generated .= $self->{type} . q{ } . $self->{name} . q{(};
    my integer $argument_is_not_first = 0;
    foreach my string__hash_ref $argument ( @{ $self->{arguments} } ) {
        if ($argument_is_not_first) {
            $self_header_generated .= q{, };
            $argument_is_not_first++;
        }
        if ( ( substr $argument->{name}, 0, 1 ) eq q{$} ) {
            substr $argument->{name}, 0, 1, q{};
        }
        $self_header_generated
            .= $argument->{type} . q{ } . $argument->{name};
    }
    $self_header_generated .= q[)];

#$self_header_generated .= "\n// <<< SUBROUTINE RULE, HEADER COMPONENTS, END CPPOPS_CPPTYPES >>>\n"; # DEBUG TEMP
#RPerl::diag "in Subroutine::rperl_to_cpp__header_generate__CPPOPS_CPPTYPES(), about to return \$self_header_generated = \n\n\n" . $self_header_generated . "\n\n";

    return ($self_header_generated);
};

# DEV NOTE: due to always being pre-qualified and having only 1 production and having 0 non-pre-qualified components, this rule can croak() on any RPerl syntax error at any component
# SUBROUTINE RULE
our object__method $ppi_to_rperl__translate = sub {
    ( my string $class, my object $node) = @_;    # class method

    # variable declarations MASTER LIST FOR TRANLATION ROUTINES
    my string $rule_name = 'SUBROUTINE';
    my string $production_name;
    my string $component_name;
    my string $node_class;
    my string $node_class_expected = 'PPI::Statement::Variable';
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
    my string $greatgrandchild_content;
    my string $greatgrandchild_content_expected;

    RPerl::diag
        "in Subroutine::ppi_to_rperl__translate(), received \$node =\n"
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
        "in Subroutine::ppi_to_rperl__translate(), have \$node_class = '$node_class'\n";

    # SUBROUTINE rule begin
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

    # SUBROUTINE rule, OUR component @ KEY 'children', INDEX 0
    $production_name        = '<default>';
    $component_name         = 'OUR';
    $child_key              = 'children';
    $child_index            = 0;
    $child_class_expected   = 'PPI::Token::Word';
    $child_content_expected = 'our';
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
    $child_content = $child->{content}; # assume PPI::Token::Word contains _word or _key_word
    if ( $child_content ne $child_content_expected ) {
        croak(
            "\nERROR ECVTRSY01, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, in $child_class child sub-object at index $child_index, '$child_content_expected' expected but '$child_content' found,\ncroaking"
        );
    }

    # SUBROUTINE rule, TYPE component @ KEY 'children', INDEX 1
    $production_name        = '<default>';
    $component_name         = 'TYPE';
    $child_key              = 'children';
    $child_index            = 1;
    $child_class_expected   = 'PPI::Token::Word';
    $child_content_expected = $rperltypes::supported;
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
    $child_content = $child->{content};    # assume PPI::Token::Word contains
    if ( not( grep { $_ eq $child_content } @{$child_content_expected} ) ) {
        croak(
            "\nERROR ECVTRSY01, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, in $child_class child sub-object at index $child_index,\nmember of ("
                . join( ', ', @{$child_content_expected} )
                . ")\nexpected but '$child_content' found,\ncroaking" );
    }

    $node_translated = RPerl::CodeBlock::Subroutine->new();
    $node_translated->{type} = $child_content;

    # SUBROUTINE rule, VARIABLE_SYMBOL component @ KEY 'children', INDEX 2
    $production_name      = '<default>';
    $component_name       = 'VARIABLE_SYMBOL';
    $child_key            = 'children';
    $child_index          = 2;
    $child_class_expected = 'PPI::Token::Symbol';
    $child                = $node->{$child_key}->[$child_index];
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

    $node_translated->{name} = $child->{content}; # assume PPI::Token::Symbol contains variable name

    # SUBROUTINE rule, EQUAL component @ KEY 'children', INDEX 3
    $production_name        = '<default>';
    $component_name         = 'EQUAL';
    $child_key              = 'children';
    $child_index            = 3;
    $child_class_expected   = 'PPI::Token::Operator';
    $child_content_expected = q{=};
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
    $child_content = $child->{content}; # assume PPI::Token::Operator contains operator name _key_word
    if ( $child_content ne $child_content_expected ) {
        croak(
            "\nERROR ECVTRSY01, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, in $child_class child sub-object at index $child_index, '$child_content_expected' expected but '$child_content' found,\ncroaking"
        );
    }

    # SUBROUTINE rule, SUB component @ KEY 'children', INDEX 4
    $production_name        = '<default>';
    $component_name         = 'SUB';
    $child_key              = 'children';
    $child_index            = 4;
    $child_class_expected   = 'PPI::Token::Word';
    $child_content_expected = 'sub';
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
    $child_content = $child->{content}; # assume PPI::Token::Word contains _word or _key_word
    if ( $child_content ne $child_content_expected ) {
        croak(
            "\nERROR ECVTRSY01, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, in $child_class child sub-object at index $child_index, '$child_content_expected' expected but '$child_content' found,\ncroaking"
        );
    }

    # SUBROUTINE rule, LBRACE component begin @ KEY 'children', INDEX 5
    $production_name      = '<default>';
    $component_name       = 'LBRACE';
    $child_key            = 'children';
    $child_index          = 5;
    $child_class_expected = 'PPI::Structure::Block';
    $child                = $node->{$child_key}->[$child_index];
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

# SUBROUTINE rule, LBRACE component end @ KEY 'children', INDEX 5, KEY 'start'
    $production_name             = '<default>';
    $component_name              = 'LBRACE';
    $child_key                   = 'children';
    $child_index                 = 5;
    $grandchild_key              = 'start';
    $grandchild_class_expected   = 'PPI::Token::Structure';
    $grandchild_content_expected = q[{];
    $grandchild
        = $node->{$child_key}->[$child_index]->{$grandchild_key};

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
    $grandchild_content = $grandchild->{content}; # assume PPI::Token::Structure contains punctuation
    if ( $grandchild_content ne $grandchild_content_expected ) {
        croak(
            "\nERROR ECVTRSY01, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, in $grandchild_class grandchild sub-sub-object at key '$grandchild_key' and index $grandchild_index,\n'$grandchild_content_expected' expected but '$grandchild_content' found,\ncroaking"
        );
    }

# DEV NOTE: due to unique '@_' placement, able to pre-qualify SUBROUTINE_ARGUMENTS here instead of implementing a full SUBROUTINE_ARGUMENTS_QUESTIONMARK rule
# SUBROUTINE rule, SUBROUTINE_ARGUMENTS component pre-qualify @ KEY 'children', INDEX 5, KEY 'children', INDEX 0, KEY 'children', INDEX 2
    $production_name           = '<default>';
    $component_name            = 'SUBROUTINE_ARGUMENTS';
    $child_key                 = 'children';
    $child_index               = 5;
    $grandchild_key            = 'children';
    $grandchild_index          = 0;
    $grandchild_class_expected = 'PPI::Statement';
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
    $grandchild_disqualified = 0;
    if ( $grandchild_class ne $grandchild_class_expected ) {
        carp(
            "\nWARNING WCVTRSY00, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, $grandchild_class_expected grandchild sub-sub-object expected at key '$grandchild_key' and index $grandchild_index,\nbut $grandchild_class grandchild sub-sub-object found,\ndisqualifying subroutine from accepting arguments,\ncarping"
        );
        $grandchild_disqualified = 1;
    }
    else {
        # inspect great-grandchild
        $greatgrandchild_key              = 'children';
        $greatgrandchild_index            = 2;
        $greatgrandchild_class_expected   = 'PPI::Token::Magic';
        $greatgrandchild_content_expected = q{@_};
        $greatgrandchild
            = $grandchild->{$greatgrandchild_key}->[$greatgrandchild_index]; # disqualify if great-grandchild is not @_
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
            carp(
                "\nWARNING WCVTRSY00, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, $greatgrandchild_class_expected great-grandchild sub-sub-sub-object expected at key '$greatgrandchild_key' and index $greatgrandchild_index,\nbut $greatgrandchild_class great-grandchild sub-sub-sub-object found,\ndisqualifying subroutine from accepting arguments,\ncarping"
            );
            $grandchild_disqualified = 1;
        }
        $greatgrandchild_content = $greatgrandchild->{content}; # assume PPI::Token::Magic contains @_
        if ( $greatgrandchild_content ne $greatgrandchild_content_expected ) {
            carp(
                "\nWARNING WCVTRSY01, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, in $greatgrandchild_class great-grandchild sub-sub-sub-object at key '$greatgrandchild_key' and index $greatgrandchild_index,\n'$greatgrandchild_content_expected' expected but '$greatgrandchild_content' found,\ndisqualifying subroutine from accepting arguments,\ncarping"
            );
            $grandchild_disqualified = 1;
        }
    }

# SUBROUTINE rule, SUBROUTINE_ARGUMENTS component @ KEY 'children', INDEX 5, KEY 'children', INDEX 0
    if ( not($grandchild_disqualified) ) {
        $child_index      = 5;
        $grandchild_key   = 'children';
        $grandchild_index = 0;
        $grandchild
            = $node->{$child_key}->[$child_index]->{$grandchild_key}
            ->[$grandchild_index];
        $node_translated->{arguments}
            = RPerl::CodeBlock::Subroutine
            ->ppi_to_rperl__arguments_translate($grandchild); # class method call

#RPerl::diag "in Subroutine::ppi_to_rperl__translate(), returned from Subroutine::ppi_to_rperl__arguments_translate(\$grandchild), received \$node_translated->{arguments} =\n" . Dumper( $node_translated->{arguments} ) . "\n";
    }

# SUBROUTINE rule, OPERATION+ component @ KEY 'children', INDEX 5, KEY 'children', 1 <= INDEX <= max
    $child_index      = 5;
    $grandchild_key   = 'children';
    $grandchild_index = 1;
    $grandchild_index_max
        = (
        scalar @{ $node->{$child_key}->[$child_index]->{$grandchild_key} } )
        - 1;
    my @operations_array
        = @{ $node->{$child_key}->[$child_index]->{$grandchild_key} }
        [ $grandchild_index .. $grandchild_index_max ];
    my $operations = \@operations_array;    # two-statement slice

#my $operations = \(@{$node->{$child_key}->[$child_index]->{$grandchild_key}}[$grandchild_index .. $grandchild_index_max]);  # DEV NOTE: why does this not work?
#RPerl::diag "in Subroutine::ppi_to_rperl__translate(), before call to RPerl::Operation->ppi_to_rperl__translate_plus(\$operations), have \$grandchild_index = $grandchild_index\n";
#RPerl::diag "in Subroutine::ppi_to_rperl__translate(), before call to RPerl::Operation->ppi_to_rperl__translate_plus(\$operations), have \$grandchild_index_max = $grandchild_index_max\n";
#RPerl::diag "in Subroutine::ppi_to_rperl__translate(), before call to RPerl::Operation->ppi_to_rperl__translate_plus(\$operations), have \$node->{$child_key}->[$child_index]->{$grandchild_key} =\n" . Dumper( $node->{$child_key}->[$child_index]->{$grandchild_key} ) . "\n";
#RPerl::diag "in Subroutine::ppi_to_rperl__translate(), before call to RPerl::Operation->ppi_to_rperl__translate_plus(\$operations), have \$operations =\n" . Dumper( $operations ) . "\n";
    $node_translated->{operations}
        = RPerl::Operation->ppi_to_rperl__translate_plus($operations); # class method call

   # SUBROUTINE rule, RBRACE component @ KEY 'children', INDEX 5, KEY 'finish'
    $production_name             = '<default>';
    $component_name              = 'RBRACE';
    $child_key                   = 'children';
    $child_index                 = 5;
    $grandchild_key              = 'finish';
    $grandchild_class_expected   = 'PPI::Token::Structure';
    $grandchild_content_expected = q[}];
    $grandchild
        = $node->{$child_key}->[$child_index]->{$grandchild_key};

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
    $grandchild_content = $grandchild->{content}; # assume PPI::Token::Structure contains punctuation
    if ( $grandchild_content ne $grandchild_content_expected ) {
        croak(
            "\nERROR ECVTRSY01, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, in $grandchild_class grandchild sub-sub-object at key '$grandchild_key' and index $grandchild_index,\n'$grandchild_content_expected' expected but '$grandchild_content' found,\ncroaking"
        );
    }

    # SUBROUTINE rule end, SEMICOLON component @ KEY 'children', INDEX max
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
        "in Subroutine::ppi_to_rperl__translate(), bottom of subroutine, about to return \$node_translated=\n"
        . Dumper($node_translated) . "\n";

    # this rule never matches empty
    return ($node_translated);
};

# [[[ PROCEDURAL SUBROUTINE(S) ]]]

# DEV NOTE: due to always being pre-qualified and having only 1 production and having 0 rules-as-components,
# this rule never matches empty and can croak() on any RPerl syntax error at any component
# SUBROUTINE_ARGUMENTS RULE
our hash_ref__method $ppi_to_rperl__arguments_translate = sub {
    ( my string $class, my object $node) = @_;    # class method

    # variable declarations
    my string $rule_name = 'SUBROUTINE_ARGUMENTS';
    my string $production_name;
    my string $component_name;
    my string $node_class;
    my string $node_class_expected = 'PPI::Statement';
    my object $node_translated;
    my object $child;
    my string $child_class;
    my string $child_class_expected;
    my string $child_content;
    my string $child_content_expected;
    my string $child_key;
    my integer $child_index;
    my integer $child_index_max;
    my object $grandchild;
    my string $grandchild_class;
    my string $grandchild_class_expected;
    my string $grandchild_content;
    my string $grandchild_content_expected;
    my string $grandchild_key;
    my integer $grandchild_index;
    my integer $grandchild_disqualified;
    my object $greatgrandchild;
    my string $greatgrandchild_class;
    my string $greatgrandchild_class_expected;
    my string $greatgrandchild_content;
    my string $greatgrandchild_content_expected;
    my string $greatgrandchild_key;
    my integer $greatgrandchild_index;
    my integer $greatgrandchild_index_max;

#RPerl::diag "in Subroutine::ppi_to_rperl__arguments_translate(), received \$node =\n" . Dumper($node) . "\n";

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

#RPerl::diag "in Subroutine::ppi_to_rperl__arguments_translate(), have \$node_class = '$node_class'\n";

    # SUBROUTINE_ARGUMENTS rule begin
    if ( $node_class ne $node_class_expected ) {
        croak(
            "\nERROR ECVTRPI02a, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, PPI OBJECT FAILURE:\n$node_class_expected object expected but $node_class object found,\ncroaking"
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

 # SUBROUTINE_ARGUMENTS rule, LPAREN component begin @ KEY 'children', INDEX 0
    $production_name      = '<default>';
    $component_name       = 'LPAREN';
    $child_key            = 'children';
    $child_index          = 0;
    $child_class_expected = 'PPI::Structure::List';
    $child                = $node->{$child_key}->[$child_index];
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

# SUBROUTINE_ARGUMENTS rule, LPAREN component end @ KEY 'children', INDEX 0, KEY 'start'
    $production_name             = '<default>';
    $component_name              = 'LPAREN';
    $child_key                   = 'children';
    $child_index                 = 0;
    $grandchild_key              = 'start';
    $grandchild_class_expected   = 'PPI::Token::Structure';
    $grandchild_content_expected = q{(};
    $grandchild
        = $node->{$child_key}->[$child_index]->{$grandchild_key};

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
    $grandchild_content = $grandchild->{content}; # assume PPI::Token::Structure contains punctuation
    if ( $grandchild_content ne $grandchild_content_expected ) {
        croak(
            "\nERROR ECVTRSY01, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, in $grandchild_class grandchild sub-sub-object at key '$grandchild_key' and index $grandchild_index,\n'$grandchild_content_expected' expected but '$grandchild_content' found,\ncroaking"
        );
    }

# SUBROUTINE_ARGUMENTS rule, MY0 component begin @ KEY 'children', INDEX 0, KEY 'children', INDEX 0
    $production_name           = '<default>';
    $component_name            = 'MY0';
    $child_key                 = 'children';
    $child_index               = 0;
    $grandchild_key            = 'children';
    $grandchild_index          = 0;
    $grandchild_class_expected = 'PPI::Statement::Variable';
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

    $greatgrandchild_key = 'children';
    if (not(defined $node->{$child_key}->[$child_index]->{$grandchild_key}
            ->[$grandchild_index]->{$greatgrandchild_key} )
        )
    {
        croak(
            "\nERROR ECVTRPI03, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, PPI OBJECT FAILURE:\ngreat-grandchildren sub-sub-sub-objects array_ref value expected but undefined/null value found,\ncroaking"
        );
    }
    $greatgrandchild_index_max = (
        scalar @{
            $node->{$child_key}->[$child_index]->{$grandchild_key}
                ->[$grandchild_index]->{$greatgrandchild_key}
        }
    ) - 1;
    if ( $greatgrandchild_index_max < 0 ) {
        croak(
            "\nERROR ECVTRPI04, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, PPI OBJECT FAILURE:\nmultiple great-grandchildren sub-sub-sub-objects expected but none found,\ncroaking"
        );
    }

# SUBROUTINE_ARGUMENTS rule, MY0 component end @ KEY 'children', INDEX 0, KEY 'children', INDEX 0, KEY 'children', INDEX 0
    $production_name                  = '<default>';
    $component_name                   = 'MY0';
    $child_key                        = 'children';
    $child_index                      = 0;
    $grandchild_key                   = 'children';
    $grandchild_index                 = 0;
    $greatgrandchild_key              = 'children';
    $greatgrandchild_index            = 0;
    $greatgrandchild_class_expected   = 'PPI::Token::Word';
    $greatgrandchild_content_expected = 'my';
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
    $greatgrandchild_content = $greatgrandchild->{content}; # assume PPI::Token::Word contains _word or _key_word
    if ( $greatgrandchild_content ne $greatgrandchild_content_expected ) {
        croak(
            "\nERROR ECVTRSY01, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, in $greatgrandchild_class great-grandchild sub-sub-object at key '$greatgrandchild_key' and index $greatgrandchild_index,\n'$greatgrandchild_content_expected' expected but '$greatgrandchild_content' found,\ncroaking"
        );
    }

# SUBROUTINE_ARGUMENTS rule, TYPE0 component @ KEY 'children', INDEX 0, KEY 'children', INDEX 0, KEY 'children', INDEX 1
    $production_name                  = '<default>';
    $component_name                   = 'TYPE0';
    $child_key                        = 'children';
    $child_index                      = 0;
    $grandchild_key                   = 'children';
    $grandchild_index                 = 0;
    $greatgrandchild_key              = 'children';
    $greatgrandchild_index            = 1;
    $greatgrandchild_class_expected   = 'PPI::Token::Word';
    $greatgrandchild_content_expected = $rperltypes::supported;
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
    $greatgrandchild_content = $greatgrandchild->{content}; # assume PPI::Token::Word contains
    if (not( grep { $_ eq $greatgrandchild_content }
            @{$greatgrandchild_content_expected} )
        )
    {
        croak(
            "\nERROR ECVTRSY01, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, in $greatgrandchild_class great-grandchild sub-sub-object at index $greatgrandchild_index,\nmember of ("
                . join( ', ', @{$greatgrandchild_content_expected} )
                . ")\nexpected but '$greatgrandchild_content' found,\ncroaking"
        );
    }

# not an RPerl object, because SUBROUTINE_ARGUMENTS is one of the few Grammar Rules that doesn't get its own Class
    $node_translated              = [];
    $node_translated->[0]         = {};
    $node_translated->[0]->{type} = $greatgrandchild_content;

# SUBROUTINE_ARGUMENTS rule, VARIABLE_SYMBOL0 component @ KEY 'children', INDEX 0, KEY 'children', INDEX 0, KEY 'children', INDEX 2
    $production_name                = '<default>';
    $component_name                 = 'VARIABLE_SYMBOL0';
    $child_key                      = 'children';
    $child_index                    = 0;
    $grandchild_key                 = 'children';
    $grandchild_index               = 0;
    $greatgrandchild_key            = 'children';
    $greatgrandchild_index          = 2;
    $greatgrandchild_class_expected = 'PPI::Token::Symbol';
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
    $greatgrandchild_content = $greatgrandchild->{content}; # assume PPI::Token::Symbol contains variable name

    $node_translated->[0]->{name} = $greatgrandchild_content;

# DEV NOTE: due to PPI pre-parsing TYPE1 & VARIABLE_SYMBOL1, we're able to process (COMMA MY1 TYPE1 VARIABLE_SYMBOL1)* here instead of implementing a full COMMA_MY1_TYPE1_VARIABLE_SYMBOL1_STAR rule
# SUBROUTINE_ARGUMENTS rule, (COMMA MY1 TYPE1 VARIABLE_SYMBOL1)* components @ KEY 'children', INDEX 0, KEY 'children', INDEX 0, KEY 'children', 3 <= INDEX <= max
    $greatgrandchild_index = 3;
    while ( $greatgrandchild_index <= $greatgrandchild_index_max ) {
        $greatgrandchild
            = $node->{$child_key}->[$child_index]->{$grandchild_key}
            ->[$grandchild_index]->{$greatgrandchild_key}
            ->[$greatgrandchild_index];
        RPerl::diag
            "in Subroutine::ppi_to_rperl__arguments_translate(), top of for() loop $greatgrandchild_index/$greatgrandchild_index_max...\n";

# SUBROUTINE_ARGUMENTS rule, COMMA component @ KEY 'children', INDEX 0, KEY 'children', INDEX 0, KEY 'children', INDEX iterated
        $production_name                  = '<default>';
        $component_name                   = 'COMMA';
        $child_key                        = 'children';
        $child_index                      = 0;
        $grandchild_key                   = 'children';
        $grandchild_index                 = 0;
        $greatgrandchild_key              = 'children';
        $greatgrandchild_class_expected   = 'PPI::Token::Operator';
        $greatgrandchild_content_expected = q{,};
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
        $greatgrandchild_content = $greatgrandchild->{content}; # assume PPI::Token::Operator contains operator name _key_word
        if ( $greatgrandchild_content ne $greatgrandchild_content_expected ) {
            croak(
                "\nERROR ECVTRSY01, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, in $greatgrandchild_class great-grandchild sub-sub-object at key '$greatgrandchild_key' and index $greatgrandchild_index,\n'$greatgrandchild_content_expected' expected but '$greatgrandchild_content' found,\ncroaking"
            );
        }
        $greatgrandchild_index++;

# SUBROUTINE_ARGUMENTS rule, MY1 component @ KEY 'children', INDEX 0, KEY 'children', INDEX 0, KEY 'children', INDEX iterated
        $production_name                  = '<default>';
        $component_name                   = 'MY1';
        $child_key                        = 'children';
        $child_index                      = 0;
        $grandchild_key                   = 'children';
        $grandchild_index                 = 0;
        $greatgrandchild_key              = 'children';
        $greatgrandchild_class_expected   = 'PPI::Token::Word';
        $greatgrandchild_content_expected = 'my';
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
        $greatgrandchild_content = $greatgrandchild->{content}; # assume PPI::Token::Word contains _word or _key_word
        if ( $greatgrandchild_content ne $greatgrandchild_content_expected ) {
            croak(
                "\nERROR ECVTRSY01, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, in $greatgrandchild_class great-grandchild sub-sub-object at key '$greatgrandchild_key' and index $greatgrandchild_index,\n'$greatgrandchild_content_expected' expected but '$greatgrandchild_content' found,\ncroaking"
            );
        }
        $greatgrandchild_index++;

# SUBROUTINE_ARGUMENTS rule, TYPE1 component @ KEY 'children', INDEX 0, KEY 'children', INDEX 0, KEY 'children', INDEX iterated
        $production_name                  = '<default>';
        $component_name                   = 'TYPE1';
        $child_key                        = 'children';
        $child_index                      = 0;
        $grandchild_key                   = 'children';
        $grandchild_index                 = 0;
        $greatgrandchild_key              = 'children';
        $greatgrandchild_class_expected   = 'PPI::Token::Word';
        $greatgrandchild_content_expected = $rperltypes::supported;
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
        $greatgrandchild_content = $greatgrandchild->{content}; # assume PPI::Token::Word contains data type _type
        if (not( grep { $_ eq $greatgrandchild_content }
                @{$greatgrandchild_content_expected} )
            )
        {
            croak(
                "\nERROR ECVTRSY01, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, in $greatgrandchild_class great-grandchild sub-sub-object at index $greatgrandchild_index,\nmember of ("
                    . join( ', ', @{$greatgrandchild_content_expected} )
                    . ")\nexpected but '$greatgrandchild_content' found,\ncroaking"
            );
        }

        $node_translated->[ ( ( $greatgrandchild_index - 2 ) / 3 ) ]->{type}
            = $greatgrandchild_content;
        $greatgrandchild_index++;

# SUBROUTINE_ARGUMENTS rule, VARIABLE_SYMBOL1 component @ KEY 'children', INDEX 0, KEY 'children', INDEX 0, KEY 'children', INDEX iterated
        $production_name                = '<default>';
        $component_name                 = 'VARIABLE_SYMBOL1';
        $child_key                      = 'children';
        $child_index                    = 0;
        $grandchild_key                 = 'children';
        $grandchild_index               = 0;
        $greatgrandchild_key            = 'children';
        $greatgrandchild_class_expected = 'PPI::Token::Symbol';
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
        $greatgrandchild_content = $greatgrandchild->{content}; # assume PPI::Token::Symbol contains _variable_symbol

        $node_translated->[ ( ( $greatgrandchild_index - 2 ) / 3 ) ]->{name}
            = $greatgrandchild_content;
        $greatgrandchild_index++;
    }

# SUBROUTINE_ARGUMENTS rule, RPAREN component @ KEY 'children', INDEX 0, KEY 'finish'
    $production_name             = '<default>';
    $component_name              = 'RPAREN';
    $child_key                   = 'children';
    $child_index                 = 0;
    $grandchild_key              = 'finish';
    $grandchild_class_expected   = 'PPI::Token::Structure';
    $grandchild_content_expected = q{)};
    $grandchild
        = $node->{$child_key}->[$child_index]->{$grandchild_key};

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
    $grandchild_content = $grandchild->{content}; # assume PPI::Token::Structure contains punctuation
    if ( $grandchild_content ne $grandchild_content_expected ) {
        croak(
            "\nERROR ECVTRSY01, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, in $grandchild_class grandchild sub-sub-object at key '$grandchild_key' and index $grandchild_index,\n'$grandchild_content_expected' expected but '$grandchild_content' found,\ncroaking"
        );
    }

    # SUBROUTINE_ARGUMENTS rule, EQUAL component @ KEY 'children', INDEX 1
    $production_name        = '<default>';
    $component_name         = 'EQUAL';
    $child_key              = 'children';
    $child_index            = 1;
    $child_class_expected   = 'PPI::Token::Operator';
    $child_content_expected = q{=};
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
    $child_content = $child->{content}; # assume PPI::Token::Operator contains operator name _key_word
    if ( $child_content ne $child_content_expected ) {
        croak(
            "\nERROR ECVTRSY01, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, in $child_class child sub-object at index $child_index, '$child_content_expected' expected but '$child_content' found,\ncroaking"
        );
    }

# SUBROUTINE_ARGUMENTS rule, AT_SIGN_UNDERSCORE component @ KEY 'children', INDEX 2
    $production_name        = '<default>';
    $component_name         = 'AT_SIGN_UNDERSCORE';
    $child_key              = 'children';
    $child_index            = 2;
    $child_class_expected   = 'PPI::Token::Magic';
    $child_content_expected = q{@_};
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
    $child_content = $child->{content}; # assume PPI::Token::Magic contains special variable name
    if ( $child_content ne $child_content_expected ) {
        croak(
            "\nERROR ECVTRSY01, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, in $child_class child sub-object at index $child_index, '$child_content_expected' expected but '$child_content' found,\ncroaking"
        );
    }

# SUBROUTINE_ARGUMENTS rule end, SEMICOLON component @ KEY 'children', INDEX 3
    $production_name        = '<default>';
    $component_name         = 'SEMICOLON';
    $child_key              = 'children';
    $child_index            = 3;
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

#RPerl::diag "in Subroutine::ppi_to_rperl__arguments_translate(), bottom of subroutine, about to return \$node_translated=\n" . Dumper($node_translated) . "\n";

    # this rule never matches empty
    return ($node_translated);
};

# Random note for later from mst:  sprint/summer 2012
#   This would warn BUT "no warnings 'illegalproto'" disables that
#   Now you can extract the prototype at runtime using 'perldoc -f prototype'
#   Key thing: whitespace in the prototype is lost so you'll be parsing 'integer__array_ref->integer__array_ref'
#   however it's otherwise preserved verbatim by the perl compiler and you can do what you like with it
#   Web::Simple uses this to provide 'sub (GET + /user/:id) { ... }' for web routing.
#   sub bubblesort(integer__array_ref -> integer__array_ref) {}
# end random note

1;
