# [[[ HEADER ]]]
package RPerl::Operation::Expression::Operator::NamedUnary;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.002_010;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::Operator);
use RPerl::Operation::Expression::Operator;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO PROPERTIES, CLASS PROPERTY AKA PACKAGE VARIABLE ]]]
our string_hashref $NAMES = {
    'chdir' => 'RPerl::Operation::Expression::Operator::NamedUnary::ChangeDirectory',
    'rand' => 'RPerl::Operation::Expression::Operator::NamedUnary::Random',
    'scalar' => 'RPerl::Operation::Expression::Operator::NamedUnary::Scalar'
};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };
    my string_hashref $rperl_source_subgroup;

#    RPerl::diag( 'in Operator::NamedUnary->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;
#    RPerl::diag( 'in Operator::NamedUnary->ast_to_rperl__generate(), have $self_class = ' . $self_class . "\n");

    my string $operator_name;
    if (( $self_class eq 'Operator_94' ) or    # Operator -> OP10_NAMED_UNARY SubExpression
        ( $self_class eq 'Operator_95' )) {  # Operator -> OP10_NAMED_UNARY
        # remove trailing whitespace, caused by the need to have the grammar match some tokens with a trailing whitespace, as with 'scalar ', etc.
        $self->{children}->[0] =~ s/^(\w+)\s*$/$1/gxms;
        $operator_name = $self->{children}->[0];
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . $self_class
                . ' found where Operator_94 or Operator_95 expected, dying' )
            . "\n";
    }
#    RPerl::diag( 'in Operator::NamedUnary->ast_to_rperl__generate(), have $operator_name = ' . q{'} . $operator_name . q{'} . "\n" );

    if ( not exists $NAMES->{$operator_name} ) {
        die
            q{ERROR ECVGEASRP15, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: unsupported or unrecognized named operator '}
            . $operator_name
            . q{' found where }
            . ( join ', ', ( sort keys %{$NAMES} ) )
            . ' expected, dying' . "\n";
    }
    my string $operator_class  = $NAMES->{$operator_name};
    my object $operator_object = $operator_class->new();

    $rperl_source_subgroup = $operator_object->ast_to_rperl__generate( $self, $modes );
    RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );

    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = {
        CPP => q{// <<< RP::O::E::O::NU __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n"
        };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{} };
    my string_hashref $cpp_source_subgroup;

#    RPerl::diag( 'in Operator::NamedUnary->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;
    my string $operator_name;
    if (( $self_class eq 'Operator_94' ) or    # Operator -> OP10_NAMED_UNARY SubExpression
        ( $self_class eq 'Operator_95' )) {  # Operator -> OP10_NAMED_UNARY
        # remove trailing whitespace, caused by the need to have the grammar match some tokens with a trailing whitespace, as with 'scalar ', etc.
        $self->{children}->[0] =~ s/^(\w+)\s*$/$1/gxms;
        $operator_name = $self->{children}->[0];
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: grammar rule '
                . $self_class
                . ' found where Operator_94 or Operator_95 expected, dying' )
            . "\n";
    }
#    RPerl::diag( 'in Operator::NamedUnary->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $operator_name = ' . q{'} . $operator_name . q{'} . "\n" );

    if ( not exists $NAMES->{$operator_name} ) {
        die
            q{ERROR ECVGEASRP15, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: unsupported or unrecognized named operator '}
            . $operator_name
            . q{' found where }
            . ( join ', ', ( sort keys %{$NAMES} ) )
            . ' expected, dying' . "\n";
    }
    my string $operator_class  = $NAMES->{$operator_name};
    my object $operator_object = $operator_class->new();

    $cpp_source_subgroup
        = $operator_object->ast_to_cpp__generate__CPPOPS_CPPTYPES( $self, $modes );
    RPerl::Generator::source_group_append( $cpp_source_group,
        $cpp_source_subgroup );

    return $cpp_source_group;
};

1;    # end of class
