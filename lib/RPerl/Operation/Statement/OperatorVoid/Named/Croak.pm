# [[[ HEADER ]]]
package RPerl::Operation::Statement::OperatorVoid::Named::Croak;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.002_010;

# [[[ OO INHERITANCE ]]]
# NEED FIX: is not a Grammar Rule so should not inherit from OperatorVoid, need create Grammar Production class
use parent qw(RPerl::Operation::Statement::OperatorVoid::Named);
use RPerl::Operation::Statement::OperatorVoid::Named;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants

# [[[ CONSTANTS ]]]
use constant NAME => my string $TYPED_NAME = 'croak';

# DEV NOTE: ARGUMENTS_MIN of 0 can be ignored, no such thing as negative number of args!
use constant ARGUMENTS_MIN => my integer $TYPED_ARGUMENTS_MIN = 0;
use constant ARGUMENTS_MAX => my integer $TYPED_ARGUMENTS_MAX = 999;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes, my object $operator_void_named) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in OperatorVoid::Named::Croak->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag( 'in OperatorVoid::Named::Croak->ast_to_rperl__generate(), received $operator_void_named = ' . "\n" . RPerl::Parser::rperl_ast__dump($operator_void_named) . "\n" );

    if ( ref $operator_void_named eq 'OperatorVoid_114' ) {    # OperatorVoid -> OP01_NAMED_VOID_SCOLON
        $rperl_source_group->{PMC} .= $operator_void_named->{children}->[0];    # name semicolon
    }
    elsif ( ref $operator_void_named eq 'OperatorVoid_115' ) {                  # OperatorVoid -> OP01_NAMED_VOID_LPAREN OPTIONAL-32 ')' ';'
        $rperl_source_group->{PMC}
            .= $operator_void_named->{children}->[0];                           # name lparen
        my object $arguments_optional = $operator_void_named->{children}->[1];
        if ( exists $arguments_optional->{children}->[0] ) {
            my object $arguments       = $arguments_optional->{children}->[0];
            my integer $argument_count = $arguments->length();
            if ( $argument_count > ARGUMENTS_MAX() ) {
                die 'ERROR ECVGEASRP03, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL:' . "\n"
                    . 'Argument count '
                    . $argument_count
                    . ' exceeds maximum argument limit '
                    . ARGUMENTS_MAX()
                    . ' for operation ' . q{'}
                    . NAME() . q{'}
                    . ', dying' . "\n";
            }

#            RPerl::diag( 'in OperatorVoid::Named::Croak->ast_to_rperl__generate(), have $arguments = ' . "\n" . RPerl::Parser::rperl_ast__dump($arguments) . "\n" );
=DISABLE; allow dereferenced hashes and arrays
            if ( ( ( ref $arguments->{children}->[0] ) eq 'ListElement_181' ) and ( exists $arguments->{children}->[0]->{children}->[0] ) ) {
                my object $arguments_subexpression = $arguments->{children}->[0]->{children}->[0];

                # look inside nested parenthesis-as-subexpressions, always length 1 so no need to check length
                while ( ( ref $arguments_subexpression ) eq 'SubExpression_137' ) {    # RPerl::Operation::Expression::SubExpression::Parenthesis
                    $arguments_subexpression = $arguments_subexpression->{children}->[1];
                }
                if ( ( ref $arguments_subexpression ) eq 'SubExpression_134' ) {
                    die 'ERROR ECVGEASRP10, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL:' . "\n"
                        . 'Attempt to croak with dereferenced array, please croak with string instead, dying' . "\n";
                }
                elsif ( ( ref $arguments_subexpression ) eq 'SubExpression_136' ) {
                    die 'ERROR ECVGEASRP11, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL:' . "\n"
                        . 'Attempt to croak with dereferenced hash, please croak with string instead, dying' . "\n";
                }
            }

=cut
            my string_hashref $rperl_source_subgroup = $arguments->ast_to_rperl__generate( $modes, $self );
            RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        }
        $rperl_source_group->{PMC} .= $operator_void_named->{children}->[2] . $operator_void_named->{children}->[3];    # rparen semicolon
    }
    elsif ( ref $operator_void_named eq 'OperatorVoid_116' ) {    # OperatorVoid -> OP01_NAMED_VOID ListElements ';'
        $rperl_source_group->{PMC}
            .= $operator_void_named->{children}->[0] . q{ };      # name
        my object $arguments       = $operator_void_named->{children}->[1];
        my integer $argument_count = $arguments->length();
        if ( $argument_count > ARGUMENTS_MAX() ) {
            die 'ERROR ECVGEASRP03, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL:' . "\n"
                . 'Argument count '
                . $argument_count
                . ' exceeds maximum argument limit '
                . ARGUMENTS_MAX()
                . ' for operation ' . q{'}
                . NAME() . q{'}
                . ', dying' . "\n";
        }

#        RPerl::diag( 'in OperatorVoid::Named::Croak->ast_to_rperl__generate(), have $arguments = ' . "\n" . RPerl::Parser::rperl_ast__dump($arguments) . "\n" );
=DISABLE; allow dereferenced hashes and arrays
        if ( ( ( ref $arguments->{children}->[0] ) eq 'ListElement_181' ) and ( exists $arguments->{children}->[0]->{children}->[0] ) ) {
            my object $arguments_subexpression = $arguments->{children}->[0]->{children}->[0];

            # look inside nested parenthesis-as-subexpressions, always length 1 so no need to check length
            while ( ( ref $arguments_subexpression ) eq 'SubExpression_137' ) {    # RPerl::Operation::Expression::SubExpression::Parenthesis
                $arguments_subexpression = $arguments_subexpression->{children}->[1];
            }
            if ( ( ref $arguments_subexpression ) eq 'SubExpression_134' ) {
                die 'ERROR ECVGEASRP10, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL:' . "\n"
                    . 'Attempt to croak with dereferenced array, please croak with string instead, dying' . "\n";
            }
            elsif ( ( ref $arguments_subexpression ) eq 'SubExpression_136' ) {
                die 'ERROR ECVGEASRP11, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL:' . "\n"
                    . 'Attempt to croak with dereferenced hash, please croak with string instead, dying' . "\n";
            }
        }
=cut
        my string_hashref $rperl_source_subgroup = $arguments->ast_to_rperl__generate( $modes, $self );
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= $operator_void_named->{children}->[2];    # semicolon
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . ( ref $operator_void_named )
                . ' found where OperatorVoid_114, OperatorVoid_115, or OperatorVoid_116 expected, dying' )
            . "\n";
    }

    $rperl_source_group->{PMC} .= "\n";
    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::O::S::OV::N::C __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::O::S::OV::N::C __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
};

1;    # end of class
