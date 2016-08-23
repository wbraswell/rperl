# [[[ HEADER ]]]
package RPerl::Operation::Expression::Operator::Named;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.001_400;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::Operator);
use RPerl::Operation::Expression::Operator;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO PROPERTIES, CLASS PROPERTY AKA PACKAGE VARIABLE ]]]
# DEV NOTE, CORRELATION #rp020: upon adding new named op file lib/RPerl/Operation/Expression/Operator/Named*/* also add in Named*.pm and rperloperations.*
our string_hashref $NAMES = {
    'abs'     => 'RPerl::Operation::Expression::Operator::Named::AbsoluteValue',
    'atan2'   => 'RPerl::Operation::Expression::Operator::Named::Atan2',
    'chomp'   => 'RPerl::Operation::Expression::Operator::Named::Chomp',
    'exp'     => 'RPerl::Operation::Expression::Operator::Named::Exp',
    'join'    => 'RPerl::Operation::Expression::Operator::Named::Join',
    'keys'    => 'RPerl::Operation::Expression::Operator::Named::Keys',
    'pop'     => 'RPerl::Operation::Expression::Operator::Named::Pop',
    'push'    => 'RPerl::Operation::Expression::Operator::Named::Push',
    'reverse' => 'RPerl::Operation::Expression::Operator::Named::Reverse',
    'sort'    => 'RPerl::Operation::Expression::Operator::Named::Sort',
    'split'   => 'RPerl::Operation::Expression::Operator::Named::Split',
    'values'  => 'RPerl::Operation::Expression::Operator::Named::Values',
    'wait'  => 'RPerl::Operation::Expression::Operator::Named::Wait'
};

# [[[ SUBROUTINES & OO METHODS ]]]

our string_hashref::method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };
    my string_hashref $rperl_source_subgroup;

    #    RPerl::diag( 'in Operator::Named->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;
    my string $operator_name;
    if ( $self_class eq 'Operation_80' ) {    # Statement -> OP01_NAMED_SCOLON
        $operator_name = substr $self->{children}->[0], 0, -1;
    }
    elsif (( $self_class eq 'Operator_84' )    # Operator -> OP01_NAMED SubExpression
        or ( $self_class eq 'OperatorVoid_123' )
        )                                   # OperatorVoid -> OP01_NAMED ListElement OP21_LIST_COMMA ListElements ';'
    {
        $operator_name = $self->{children}->[0];
    }
    elsif ( $self_class eq 'Operator_85' ) {    # Operator -> LPAREN OP01_NAMED ListElement OP21_LIST_COMMA ListElements ')'
        $operator_name = $self->{children}->[1];
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . $self_class
                . ' found where Operation_80, Operator_84, Operator_85, or OperatorVoid_123 expected, dying' )
            . "\n";
    }
 
    # strip trailing whitespace, caused by the need to have the grammar match some tokens with a trailing whitespace, as with 'scalar ', etc.
    $operator_name =~ s/^(\w+)\s*$/$1/gxms;

 # DEV NOTE: compile-time operator name checking short-circuited first by Parse Phase 0 ERROR ECOPAPL02 'Bareword "FOO" not allowed while "strict subs" in use';
 # can't figure out how to create test which gets past ECOPAPL02 to trigger ECOGEASRP13
    if ( not exists $NAMES->{$operator_name} ) {
        die q{ERROR ECOGEASRP13, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: unsupported or unrecognized named operator '}
            . $operator_name
            . q{' found where }
            . ( join ', ', ( sort keys %{$NAMES} ) )
            . ' expected, operator may not be properly listed in $RPerl::Operation::Expression::Operator::Named::NAMES, dying' . "\n";
    }
    my string $operator_class  = $NAMES->{$operator_name};
    my object $operator_object = $operator_class->new();

    $rperl_source_subgroup = $operator_object->ast_to_rperl__generate( $self, $modes );
    RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );

    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::O::E::O::N __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{} };
    my string_hashref $cpp_source_subgroup;

    #    RPerl::diag( 'in Operator::Named->ast_to_cpp__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;
    my string $operator_name;
    if ( $self_class eq 'Operation_80' ) {    # Statement -> OP01_NAMED_SCOLON
        $operator_name = substr $self->{children}->[0], 0, -1;
    }
    elsif (( $self_class eq 'Operator_84' )    # Operator -> OP01_NAMED SubExpression
        or ( $self_class eq 'OperatorVoid_123' )
        )                                   # OperatorVoid -> OP01_NAMED ListElement OP21_LIST_COMMA ListElements ';'
    {
        $operator_name = $self->{children}->[0];
    }
    elsif ( $self_class eq 'Operator_85' ) {    # Operator -> LPAREN OP01_NAMED ListElement OP21_LIST_COMMA ListElements ')'
        $operator_name = $self->{children}->[1];
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . $self_class
                . ' found where Operation_80, Operator_84, Operator_85, or OperatorVoid_123 expected, dying' )
            . "\n";
    }
 
    # strip trailing whitespace, caused by the need to have the grammar match some tokens with a trailing whitespace, as with 'scalar ', etc.
    $operator_name =~ s/^(\w+)\s*$/$1/gxms;

 # DEV NOTE: compile-time operator name checking short-circuited first by Parse Phase 0 ERROR ECOPAPL02 'Bareword "FOO" not allowed while "strict subs" in use';
 # can't figure out how to create test which gets past ECOPAPL02 to trigger ECOGEASCP13
    if ( not exists $NAMES->{$operator_name} ) {
        die q{ERROR ECOGEASCP13, CODE GENERATOR, ABSTRACT SYNTAX TO C++: unsupported or unrecognized named operator '}
            . $operator_name
            . q{' found where }
            . ( join ', ', ( sort keys %{$NAMES} ) )
            . ' expected, operator may not be properly listed in $RPerl::Operation::Expression::Operator::Named::NAMES, dying' . "\n";
    }
    my string $operator_class  = $NAMES->{$operator_name};
    my object $operator_object = $operator_class->new();

    $cpp_source_subgroup = $operator_object->ast_to_cpp__generate__CPPOPS_CPPTYPES( $self, $modes );
    RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );

    return $cpp_source_group;
};

1;    # end of class
