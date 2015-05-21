# [[[ HEADER ]]]
package RPerl::Operation::Statement::OperatorVoid::Named::Return;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
# NEED FIX: is not a Grammar Rule so should not inherit from OperatorVoid, need create Grammar Production class
use parent qw(RPerl::Operation::Statement::OperatorVoid::Named);
use RPerl::Operation::Statement::OperatorVoid::Named;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants
## no critic qw(RequireCarping)  # SYSTEM SPECIAL 12: allow die instead of croak

# [[[ CONSTANTS ]]]
# DEV NOTE: (ARGUMENTS_MIN = 0) already handled by inclusion (or not) in grammar token OP01_NAMED_VOID_SCOLON
use constant ARGUMENTS_MIN => my integer $TYPED_ARGUMENTS_MIN = 0; # call 'return;' for all subroutines which return void
use constant ARGUMENTS_MAX => my integer $TYPED_ARGUMENTS_MAX = 1; # call 'return @{[ELEM0, ELEM1, ...]};' for all subroutines which return an array; disallow return(ELEM0, ELEM1, ...) multiple return values

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    (   my object $self,
        my string_hashref $modes,
        my object $operator_void_named)
        = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

    RPerl::diag(
        'in OperatorVoid::Named::Return->ast_to_rperl__generate(), received $self = '
            . "\n"
            . RPerl::Parser::rperl_ast__dump($self)
            . "\n" );

    my string $name_possible_semicolon
        = $operator_void_named->{children}->[0];
    $rperl_source_group->{PMC} .= $name_possible_semicolon;

    if ( exists $operator_void_named->{children}->[2] ) {
        $rperl_source_group->{PMC} .= q{ };
        my object $arguments       = $operator_void_named->{children}->[1];
        my integer $argument_count = $arguments->length();
        if ( $argument_count > ARGUMENTS_MAX() ) {

# START HERE: decide if we should replace all generator croaks with dies?
# START HERE: decide if we should replace all generator croaks with dies?
# START HERE: decide if we should replace all generator croaks with dies?
            
            # DEV NOTE: carp's output is not helpful here
            die
                'ERROR ECVGEAS02, Code Generator, Abstract Syntax to RPerl, argument count '
                . $argument_count
                . ' exceeds maximum argument limit '
                . ARGUMENTS_MAX()
                . ' for operation ' . q{'}
                . $name_possible_semicolon . q{'}
                . ', dying' . "\n";
        }
        my string_hashref $rperl_source_subgroup
            = $arguments->ast_to_rperl__generate( $modes, $self );
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
        my string $semicolon = $operator_void_named->{children}->[2];
        $rperl_source_group->{PMC} .= $semicolon;
    }

    $rperl_source_group->{PMC} .= "\n";
    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP =>
            q{// <<< RP::O::S::OV::N::R DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP =>
            q{// <<< RP::O::S::OV::N::R DUMMY CPPOPS_PERLTYPES SOURCE CODE >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

1;    # end of class
