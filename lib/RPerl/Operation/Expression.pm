package RPerl::Operation::Expression;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_011;

# [[[ SETUP ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitBooleanGrep)  # SYSTEM SPECIAL 1: allow grep
use Scalar::Util 'blessed';

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation);

# [[[ OO PROPERTIES ]]]
# DEV NOTE: no active properties, this is a stub object for now, see children objects for active properties
our hash_ref $properties = {};

# [[[ OO METHODS ]]]
# TRANSLATE
our object__method $ppi_to_rperl__translate = sub {
    ( my string $class, my object $node) = @_;    # class method

    # variable declarations
    my string $rule_name = 'EXPRESSION';
    my string $production_name;
    my string $component_name;
    my string $node_class;
    my string__array_ref $node_classes_expected;
    my integer $node_disqualified;
    my object $node_translated;
    my object $child;
    my string $child_key;
    my integer $child_index;
    my integer $child_index_max;
    my string $child_class;
    my string__array_ref $child_classes_expected;
    my string $child_content;
    my string $child_content_expected;
    my integer $child_disqualified;

    RPerl::diag
        "in Expression::ppi_to_rperl__translate(), received \$node =\n"
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
        "in Expression::ppi_to_rperl__translate(), have \$node_class = '$node_class'\n";

    # EXPRESSION rule, POSSIBLE _LITERAL PRODUCTION
    $production_name = 'POSSIBLE _LITERAL';
    $component_name  = '<default>';
    $node_classes_expected
        = [
        qw(PPI::Token::Number PPI::Token::Quote::Single PPI::Token::Quote::Double)
        ];
    $node_disqualified = 0;
    if ( not( grep { $_ eq $node_class } @{$node_classes_expected} ) ) {
        $node_disqualified = 1;
    }

    # EXPRESSION rule, _LITERAL PRODUCTION
    if ( not $node_disqualified ) {
        $production_name = '_LITERAL';
        $component_name  = '<default>';
        $node_translated = RPerl::Operation::Expression::SubExpression::Literal->new();
        $node_translated->{value} = $node->{content};
        if ( $node_class eq $node_classes_expected->[0] ) {    # NUMBER
            $node_translated->{type} = 'number';
        }
        else {
            $node_translated->{type}             = 'string';
            $node_translated->{string_separator} = $node->{separator};
        }
        RPerl::diag
            "in Expression::ppi_to_rperl__translate(), _LITERAL production, about to return \$node_translated=\n"
            . Dumper($node_translated) . "\n";
        return ($node_translated);
    }

# NEED FIX: handle multi-object VARIABLE production (VARIABLE_RETRIEVAL, not just _variable_symbol)
# EXPRESSION rule, POSSIBLE VARIABLE PRODUCTION
    $production_name       = 'POSSIBLE VARIABLE';
    $component_name        = '<default>';
    $node_classes_expected = [qw(PPI::Token::Symbol)];
    $node_disqualified     = 0;
    if ( not( grep { $_ eq $node_class } @{$node_classes_expected} ) ) {
        $node_disqualified = 1;
    }

    # EXPRESSION rule, VARIABLE PRODUCTION
    if ( not $node_disqualified ) {
        $production_name = 'VARIABLE';
        $component_name  = '<default>';

# NEED FIX: wrapping _variable_symbol in PPI::Statement, short-circuiting check for multi-object VARIABLE production
        my object $variable_node = PPI::Statement->new();
        $variable_node->{children} = [$node];
        $node_translated = RPerl::Operation::Expression::SubExpression::Variable
            ->ppi_to_rperl__translate($variable_node);
        RPerl::diag
            "in Expression::ppi_to_rperl__translate(), _LITERAL production, about to return \$node_translated=\n"
            . Dumper($node_translated) . "\n";
        return ($node_translated);
    }

    croak('SORRY, MANY FEATURES ARE CURRENTLY DISABLED, croaking ');
};

# GENERATE CPPOPS_PERLTYPES
our string__method $rperl_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self ) = @_;    # object method
    my string $self_generated = q{};
    $self_generated
        .= ' STUB PERL CODE STRING, CREATED BY RPerl::Operation::Expression ';
    return ($self_generated);
};

# GENERATE CPPOPS_CPPTYPES
our string__method $rperl_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self ) = @_;    # object method
    my string $self_generated = q{};
    $self_generated
        .= ' STUB CPP CODE STRING, CREATED BY RPerl::Operation::Expression ';
    return ($self_generated);
};

1;
