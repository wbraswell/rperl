package RPerl::CompileUnit::Module::Package; ## no critic qw(ProhibitExcessMainComplexity)  ## RPERL SYSTEM allow complex code
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_014;

# [[[ SETUP ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values and print operator
## no critic qw(RequireInterpolationOfMetachars)  # SYSTEM DEFAULT 2: allow single-quoted control characters, sigils, and regexes
use Data::Dumper;
use Scalar::Util 'blessed';

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module);

# [[[ OO PROPERTIES ]]]
our %properties = ( ## no critic qw(ProhibitPackageVars)  ## RPERL SYSTEM, allow OO properties
    name => my string $KEY_name = undef,
    version => my string $KEY_version = undef, # NEED UPGRADE: convert vstring from string type to number type?
    includes    => my string__array_ref $KEY_includes    = undef,
    subroutines => my object__array_ref $KEY_subroutines = undef,
);

# [[[ OO METHODS ]]]

# GENERATE CPPOPS_CPPTYPES
our string__method $rperl_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self ) = @_;    # object method
    my string $self_generated = q{};

#print {*STDERR} "in Package::rperl_to_cpp__generate__CPPOPS_CPPTYPES(), received \$self = \n" . Dumper($self) . "\n";
#$self_generated .= "// <<< PACKAGE RULE, BEGIN CPPOPS_CPPTYPES >>>\n"; # DEBUG TEMP

    $self_generated
        .= q{// namespace }
        . $self->{name}
        . q{;  // NEED UPGRADE: Perl vs C++ namespace compatibility} . "\n";
    $self_generated .= q{using std::cout;} . "\n";
    $self_generated .= q{using std::cerr;} . "\n";
    $self_generated .= q{// VERSION } . $self->{version} . "\n";
    $self_generated
        .= q{#include <rperltypes.h>  // for data types and structures}
        . "\n";
    $self_generated
        .= q{#include <RPerl/HelperFunctions.cpp>  // -> HelperFunctions.h}
        . "\n\n";

    $self_generated
        .= q{// [[[ PROCEDURAL SUBROUTINE DECLARATION(S) ]]]} . "\n";
    foreach my object $subroutine ( @{ $self->{subroutines} } ) {
        $self_generated
            .= $subroutine->rperl_to_cpp__header_generate__CPPOPS_CPPTYPES();
        $self_generated .= q{;} . "\n";
    }
    $self_generated .= "\n";

    $self_generated
        .= q{// [[[ PROCEDURAL SUBROUTINE DEFINITION(S) ]]]} . "\n";
    foreach my object $subroutine ( @{ $self->{subroutines} } ) {
        $self_generated
            .= $subroutine->rperl_to_cpp__generate__CPPOPS_CPPTYPES();
    }
    $self_generated .= "\n";

    my $self_name_underscores = $self->{name};
    $self_name_underscores =~ s/::/_/gxms;

    $self_generated .= q{// [[[ OPERATIONS & DATA TYPES REPORTING ]]]} . "\n";
    $self_generated
        .= q{string } . $self_name_underscores . q[__ops() {] . "\n";
    $self_generated .= q{    string retval = "CPP";} . "\n";
    $self_generated .= q{    return (retval);} . "\n";
    $self_generated .= q[}] . "\n";
    $self_generated
        .= q{string } . $self_name_underscores . q[__types() {] . "\n";
    $self_generated .= q{    string retval = "CPP";} . "\n";
    $self_generated .= q{    return (retval);} . "\n";
    $self_generated .= q[}] . "\n";

#$self_generated .= "// <<< PACKAGE RULE, END CPPOPS_CPPTYPES >>>\n"; # DEBUG TEMP
    print {*STDERR}
        "in Package::rperl_to_cpp__generate__CPPOPS_CPPTYPES(), about to return \$self_generated = \n\n\n"
        . $self_generated . "\n\n";

    return ($self_generated);
};

# TRANSLATE
# NEED UPGRADE: use arg0 to determine if (class/object) method, remove confusing __method type suffix or some other solution???
our object__method $ppi_to_rperl__translate = sub { # DEV NOTE: object is the return type, __method is the OO namespace keyword for Class.pm INIT magic
    ( my string $class, my object $node) = @_; # DEV NOTE: arg0 of $class means this is a class method, arg0 of $self would mean object method

    # variable declarations
    my string $rule_name = 'PACKAGE';
    my string $production_name;
    my string $component_name;
    my string $node_class;
    my string $node_class_expected = 'PPI::Document';
    my object $node_translated;
    my object $child;
    my string $child_class;
    my string $child_class_expected;
    my string $child_content;
    my string $child_content_expected;
    my string $child_key;
    my integer $child_index;
    my integer $child_index_max;
    my object $child_translated;
    my object $grandchild;
    my string $grandchild_key;
    my integer $grandchild_index;
    my string $grandchild_class_expected;
    my string $grandchild_class;
    my string $grandchild_content_expected;
    my string $grandchild_content;

#    print {*STDERR} "in Package::ppi_to_rperl__translate(), received \$node =\n" . Dumper($node) . "\n";

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

    print {*STDERR}
        "in Package::ppi_to_rperl__translate(), have \$node_class = '$node_class'\n";

    # PACKAGE rule begin
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

# DEV NOTE: do we need to add more fine-grained syntax checking for child objects' sub-components accessed below,
# or can we make AST configuration assumptions safely based on input from Perl Critic & PPI?

    # PACKAGE rule, PACKAGE_NAME component @ KEY 'children', INDEX 0
    $production_name           = '<default>';
    $component_name            = 'PACKAGE_NAME';
    $child_key                 = 'children';
    $child_index               = 0;
    $child_class_expected      = 'PPI::Statement::Package';
    $grandchild_key            = 'children';
    $grandchild_index          = 1;
    $grandchild_class_expected = 'PPI::Token::Word';
    $child                     = $node->{$child_key}->[$child_index];
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

    $grandchild = $node->{$child_key}->[$child_index]->{$grandchild_key}
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

    $grandchild_content = $grandchild->{content}; # assume PPI::Token::Word contains _package
    $node_translated = RPerl::CompileUnit::Module::Package->new();
    $node_translated->{name} = $grandchild_content;

#print {*STDERR} "in Package::ppi_to_rperl__translate(), PACKAGE_NAME component, have \$grandchild = \n" . Dumper($grandchild) . "\n";
#print {*STDERR} "in Package::ppi_to_rperl__translate(), PACKAGE_NAME component, have \$node_translated = \n" . Dumper($node_translated) . "\n";

# PACKAGE rule, RPERL_HEADER rule/component begin, USE_STRICT component @ KEY 'children', INDEX 1
    $production_name        = '<default>';
    $component_name         = 'RPERL_HEADER / USE_STRICT';
    $child_key              = 'children';
    $child_index            = 1;
    $child_class_expected   = 'PPI::Statement::Include';
    $child_content_expected = 'strict';
    $grandchild_key         = 'children';
    $grandchild_index       = '1';
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
    $child_content
        = $child->{$grandchild_key}->[$grandchild_index]->{content}; # assume grandchild at index 1 of PPI::Statement::Include is PPI::Token::Word containing _package or _pragma
    if ( $child_content ne $child_content_expected ) {
        croak(
            "\nERROR ECVTRSY01, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, in $child_class child sub-object at index $child_index, '$child_content_expected' expected but '$child_content' found,\ncroaking"
        );
    }

# PACKAGE rule, RPERL_HEADER rule/component begin, USE_WARNINGS component @ KEY 'children', INDEX 2
    $production_name        = '<default>';
    $component_name         = 'RPERL_HEADER / USE_WARNINGS';
    $child_key              = 'children';
    $child_index            = 2;
    $child_class_expected   = 'PPI::Statement::Include';
    $child_content_expected = 'warnings';
    $grandchild_key         = 'children';
    $grandchild_index       = '1';
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
    $child_content
        = $child->{$grandchild_key}->[$grandchild_index]->{content}; # assume child at index 1 of PPI::Statement::Include is PPI::Token::Word containing _package or _pragma
    if ( $child_content ne $child_content_expected ) {
        croak(
            "\nERROR ECVTRSY01, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, in $child_class child sub-object at index $child_index, '$child_content_expected' expected but '$child_content' found,\ncroaking"
        );
    }

# PACKAGE rule, RPERL_HEADER rule/component begin, OUR_VERSION component @ KEY 'children', INDEX 3
    $production_name        = '<default>';
    $component_name         = 'RPERL_HEADER / OUR_VERSION';
    $child_key              = 'children';
    $child_index            = 3;
    $child_class_expected   = 'PPI::Statement::Variable';
    $child_content_expected = '$VERSION';
    $grandchild_key         = 'children';
    $grandchild_index       = '1';
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
    $child_content
        = $child->{$grandchild_key}->[$grandchild_index]->{content}; # assume grandchild at index 1 of PPI::Statement::Variable is PPI::Token::Symbol containing variable name
    if ( $child_content ne $child_content_expected ) {
        croak(
            "\nERROR ECVTRSY01, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, in $child_class child sub-object at index $child_index, '$child_content_expected' expected but '$child_content' found,\ncroaking"
        );
    }

# assume grandchild at index 3 of PPI::Statement::Variable is PPI::Token::Number::Float containing package version number
    $grandchild_index = 3;
    $node_translated->{version}
        = $child->{$grandchild_key}->[$grandchild_index]->{content};

# PACKAGE rule, RPERL_HEADER rule/component begin, USE_CARP component @ KEY 'children', INDEX 4
    $production_name        = '<default>';
    $component_name         = 'RPERL_HEADER / USE_CARP';
    $child_key              = 'children';
    $child_index            = 4;
    $child_class_expected   = 'PPI::Statement::Include';
    $child_content_expected = 'Carp';
    $grandchild_key         = 'children';
    $grandchild_index       = '1';
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
    $child_content
        = $child->{$grandchild_key}->[$grandchild_index]->{content}; # assume grandchild at index 1 of PPI::Statement::Include is PPI::Token::Word containing _package or _pragma
    if ( $child_content ne $child_content_expected ) {
        croak(
            "\nERROR ECVTRSY01, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, in $child_class child sub-object at index $child_index, '$child_content_expected' expected but '$child_content' found,\ncroaking"
        );
    }

# PACKAGE rule, RPERL_HEADER rule/component begin, USE_RPERL component @ KEY 'children', INDEX 5
    $production_name        = '<default>';
    $component_name         = 'RPERL_HEADER / USE_RPERL';
    $child_key              = 'children';
    $child_index            = 5;
    $child_class_expected   = 'PPI::Statement::Include';
    $child_content_expected = 'RPerl';
    $grandchild_key         = 'children';
    $grandchild_index       = '1';
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
    $child_content
        = $child->{$grandchild_key}->[$grandchild_index]->{content}; # assume grandchild at index 1 of PPI::Statement::Include is PPI::Token::Word containing _package or _pragma
    if ( $child_content ne $child_content_expected ) {
        croak(
            "\nERROR ECVTRSY01, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, in $child_class child sub-object at index $child_index, '$child_content_expected' expected but '$child_content' found,\ncroaking"
        );
    }

    # PACKAGE rule, SUBROUTINE+ component @ 6 <= INDEX < max
    $child_key = 'children';
    $child_index++;
    $node_translated->{subroutines} = []; # DEV NOTE: cannot include object__array_ref type due to 'my' syntax masking error
    for my integer $child_index_loop (
        $child_index .. ( $child_index_max - 1 ) )
    {
        print {*STDERR}
            'in Package::ppi_to_rperl__translate(), top of SUBROUTINE+ for() loop '
            . ( $child_index_loop - 6 ) . q{/}
            . ( $child_index_max - 7 ) . "...\n";

# DEV NOTE: due to unique 'sub' placement, able to pre-qualify SUBROUTINE here;
# due to unique PPI::Statement::Variable class in PACKAGE rule, also able to pre-disqualify SUBROUTINE here, thus croak() instead of carp() here
# PACKAGE rule, PACKAGE rule/production, SUBROUTINE component pre-qualify @ 6 <= INDEX < max
        $production_name             = '<default>';
        $component_name              = 'SUBROUTINE';
        $child_key                   = 'children';
        $child_class_expected        = 'PPI::Statement::Variable';
        $grandchild_key              = 'children';
        $grandchild_index            = 4;
        $grandchild_class_expected   = 'PPI::Token::Word';
        $grandchild_content_expected = 'sub';
        $child = $node->{$child_key}->[$child_index_loop];

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
        $grandchild_content = $grandchild->{content}; # assume PPI::Token::Word contains sub
        if ( $grandchild_content ne $grandchild_content_expected ) {
            croak(
                "\nERROR ECVTRSY01, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, in $grandchild_class grandchild sub-sub-object at key '$grandchild_key' and index $grandchild_index,\n'$grandchild_content_expected' expected but '$grandchild_content' found,\ncroaking"
            );
        }

#print {*STDERR} 'in Package::ppi_to_rperl__translate(), SUBROUTINE+ for() loop ' . ($child_index_loop - 6) . q{/} . ($child_index_max - 7) . ", about to call RPerl::CodeBlock::Subroutine::ppi_to_rperl__translate( \$child )...\n";

        $child_translated
            = RPerl::CodeBlock::Subroutine->ppi_to_rperl__translate($child); # class method call

#print {*STDERR} 'in Package::ppi_to_rperl__translate(), SUBROUTINE+ for() loop ' . ($child_index_loop - 6) . q{/} . ($child_index_max - 7) . ", returned from RPerl::CodeBlock::Subroutine::ppi_to_rperl__translate( \$child ), received \$child_translated = \n" . Dumper($child_translated) . "\n";

        push @{ $node_translated->{subroutines} }, $child_translated;
    }

    # PACKAGE rule, _NUMBER_ONE component @ KEY 'children', INDEX max
    $production_name        = '<default>';
    $component_name         = '_NUMBER_ONE';
    $child_key              = 'children';
    $child_index            = $child_index_max;
    $child_class_expected   = 'PPI::Statement';
    $child_content_expected = '1';
    $grandchild_key         = 'children';
    $grandchild_index       = '0';
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
    $child_content
        = $child->{$grandchild_key}->[$grandchild_index]->{content}; # assume grandchild at index 0 of PPI::Statement is PPI::Token::Number containing stringified numeric value
    if ( $child_content ne $child_content_expected ) {
        croak(
            "\nERROR ECVTRSY01, PPI DOCTREE TO RPERL AST TRANSLATOR, $rule_name RULE, $production_name PRODUCTION, $component_name COMPONENT, RPERL SYNTAX:\nin $node_class object, in $child_class child sub-object at index $child_index, '$child_content_expected' expected but '$child_content' found,\ncroaking"
        );
    }

#    print {*STDERR} "in Package::ppi_to_rperl__translate(), bottom of subroutine, about to return \$node_translated=\n" . Dumper($node_translated) . "\n";

    # this rule never matches empty
    return ($node_translated);
};

1;
