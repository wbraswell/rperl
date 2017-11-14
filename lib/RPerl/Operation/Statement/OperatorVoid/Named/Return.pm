# [[[ DOCUMENTATION ]]]
# http://perldoc.perl.org/functions/return.html
#     SUPPORTED:  return EXPR
#     SUPPORTED:  return

# [[[ HEADER ]]]
package RPerl::Operation::Statement::OperatorVoid::Named::Return;
use strict;
use warnings;
use RPerl::AfterSubclass;
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
use constant NAME_PERLOPS_PERLTYPES => my string $TYPED_NAME_PERLOPS_PERLTYPES = 'return';
use constant NAME_CPPOPS_PERLTYPES  => my string $TYPED_NAME_CPPOPS_PERLTYPES  = 'return';
use constant NAME_CPPOPS_CPPTYPES   => my string $TYPED_NAME_CPPOPS_CPPTYPES   = 'return';
# DEV NOTE: ARGUMENTS_MIN of 0 can be ignored, no such thing as negative number of args!
use constant ARGUMENTS_MIN => my integer $TYPED_ARGUMENTS_MIN = 0; # call 'return;' for all subroutines which return void
use constant ARGUMENTS_MAX => my integer $TYPED_ARGUMENTS_MAX = 1; # call 'return @{[ELEM0, ELEM1, ...]};' for all subroutines which return an array; disallow return(ELEM0, ELEM1, ...) multiple return values

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub ast_to_rperl__generate {
    { my string_hashref::method $RETURN_TYPE };
    (   my object $self,
        my string_hashref $modes,
        my object $operator_void_named)
        = @ARG;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in OperatorVoid::Named::Return->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag( 'in OperatorVoid::Named::Return->ast_to_rperl__generate(), received $operator_void_named = ' . "\n" . RPerl::Parser::rperl_ast__dump($operator_void_named) . "\n" );

    if ( ref $operator_void_named eq 'OperatorVoid_137' ) { # OperatorVoid -> OP01_NAMED_VOID_SCOLON
        $rperl_source_group->{PMC} .= $operator_void_named->{children}->[0]; # name semicolon
    }
    elsif ( ref $operator_void_named eq 'OperatorVoid_138' ) {  # OperatorVoid -> OP01_NAMED_VOID_LPAREN OPTIONAL-32 ')' ';'

# DEV NOTE: if $arguments_optional is empty, will generate 'return();' which perltidy will change to 'return ();', both return undef, not empty array, so it's okay
        $rperl_source_group->{PMC}
            .= $operator_void_named->{children}->[0];    # name lparen
        my object $arguments_optional = $operator_void_named->{children}->[1];
        if ( exists $arguments_optional->{children}->[0] ) {
            my object $arguments       = $arguments_optional->{children}->[0];
            my integer $argument_count = $arguments->length();
            if ( $argument_count > ARGUMENTS_MAX() ) {
                die
                    'ERROR ECOGEASRP03, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL:'
                    . "\n"
                    . 'Argument count '
                    . $argument_count
                    . ' exceeds maximum argument limit '
                    . ARGUMENTS_MAX()
                    . ' for operator ' . q{'}
                    . NAME_PERLOPS_PERLTYPES() . q{'}
                    . ', dying' . "\n";
            }
#            RPerl::diag( 'in OperatorVoid::Named::Return->ast_to_rperl__generate(), have $arguments = ' . "\n" . RPerl::Parser::rperl_ast__dump($arguments) . "\n" );
            if ((( ref $arguments->{children}->[0] ) eq 'ListElement_211' ) and ( exists $arguments->{children}->[0]->{children}->[0] ))
            {
                my object $arguments_subexpression = $arguments->{children}->[0]->{children}->[0];
                # look inside nested parenthesis-as-subexpressions, always length 1 so no need to check length
                while ((ref $arguments_subexpression) eq 'SubExpression_163') {  # RPerl::Operation::Expression::SubExpression::Parenthesis
                    $arguments_subexpression = $arguments_subexpression->{children}->[1];
                }
                if (( ref $arguments_subexpression ) eq 'SubExpression_160' ) {
                    die 'ERROR ECOGEASRP04, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL:' . "\n" . 'Attempt to return dereferenced array, please return arrayref instead, dying' . "\n";
                }
                elsif (( ref $arguments_subexpression ) eq 'SubExpression_162' ) {
                    die 'ERROR ECOGEASRP05, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL:' . "\n" . 'Attempt to return dereferenced hash, please return hashref instead, dying' . "\n";
                }
            }
            my string_hashref $rperl_source_subgroup
                = $arguments->ast_to_rperl__generate( $modes, $self );
            RPerl::Generator::source_group_append( $rperl_source_group,
                $rperl_source_subgroup );
        }
        $rperl_source_group->{PMC} .= $operator_void_named->{children}->[2]
            . $operator_void_named->{children}->[3];    # rparen semicolon
    }
    elsif ( ref $operator_void_named eq 'OperatorVoid_139' ) { # OperatorVoid -> OP01_NAMED_VOID ListElements ';'
        $rperl_source_group->{PMC}
            .= $operator_void_named->{children}->[0] . q{ };    # name
        my object $arguments       = $operator_void_named->{children}->[1];
        my integer $argument_count = $arguments->length();
        if ( $argument_count > ARGUMENTS_MAX() ) {
            die
                'ERROR ECOGEASRP03, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL:'
                . "\n"
                . 'Argument count '
                . $argument_count
                . ' exceeds maximum argument limit '
                . ARGUMENTS_MAX()
                . ' for operator ' . q{'}
                . NAME_PERLOPS_PERLTYPES() . q{'}
                . ', dying' . "\n";
        }
#        RPerl::diag( 'in OperatorVoid::Named::Return->ast_to_rperl__generate(), have $arguments = ' . "\n" . RPerl::Parser::rperl_ast__dump($arguments) . "\n" );
        if ((( ref $arguments->{children}->[0] ) eq 'ListElement_211' ) and ( exists $arguments->{children}->[0]->{children}->[0] ))
        {
            my object $arguments_subexpression = $arguments->{children}->[0]->{children}->[0];
            # look inside nested parenthesis-as-subexpressions, always length 1 so no need to check length
            while ((ref $arguments_subexpression) eq 'SubExpression_163') {  # RPerl::Operation::Expression::SubExpression::Parenthesis
                $arguments_subexpression = $arguments_subexpression->{children}->[1];
            }
            if (( ref $arguments_subexpression ) eq 'SubExpression_160' ) {
                die 'ERROR ECOGEASRP04, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL:' . "\n" . 'Attempt to return dereferenced array, please return arrayref instead, dying' . "\n";
            }
            elsif (( ref $arguments_subexpression ) eq 'SubExpression_162' ) {
                die 'ERROR ECOGEASRP05, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL:' . "\n" . 'Attempt to return dereferenced hash, please return hashref instead, dying' . "\n";
            }
        }
        my string_hashref $rperl_source_subgroup
            = $arguments->ast_to_rperl__generate( $modes, $self );
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= $operator_void_named->{children}->[2]; # semicolon
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . ( ref $operator_void_named )
                . ' found where OperatorVoid_137, OperatorVoid_138, or OperatorVoid_139 expected, dying'
        ) . "\n";
    }

    $rperl_source_group->{PMC} .= "\n";
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group
        = { CPP =>
            q{// <<< RP::O::S::OV::N::R __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
}

# DEV NOTE: PERLOPS_PERLTYPES & CPPOPS_CPPTYPES code generation are exactly equivalent
sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    (   my object $self,
        my string_hashref $modes,
        my object $operator_void_named)
        = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{} };

#    RPerl::diag( 'in OperatorVoid::Named::Return->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag( 'in OperatorVoid::Named::Return->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $operator_void_named = ' . "\n" . RPerl::Parser::rperl_ast__dump($operator_void_named) . "\n" );

    if ( ref $operator_void_named eq 'OperatorVoid_137' ) { # OperatorVoid -> OP01_NAMED_VOID_SCOLON
        $cpp_source_group->{CPP} .= $operator_void_named->{children}->[0]; # name semicolon
    }
    elsif ( ref $operator_void_named eq 'OperatorVoid_138' ) {  # OperatorVoid -> OP01_NAMED_VOID_LPAREN OPTIONAL-32 ')' ';'

# DEV NOTE: if $arguments_optional is empty, will generate 'return();' which perltidy will change to 'return ();', both return undef, not empty array, so it's okay
        $cpp_source_group->{CPP}
            .= $operator_void_named->{children}->[0];    # name lparen
        my object $arguments_optional = $operator_void_named->{children}->[1];
        if ( exists $arguments_optional->{children}->[0] ) {
            my object $arguments       = $arguments_optional->{children}->[0];
            my integer $argument_count = $arguments->length();
            if ( $argument_count > ARGUMENTS_MAX() ) {
                die
                    'ERROR ECOGEASCP03, CODE GENERATOR, ABSTRACT SYNTAX TO C++:'
                    . "\n"
                    . 'Argument count '
                    . $argument_count
                    . ' exceeds maximum argument limit '
                    . ARGUMENTS_MAX()
                    . ' for operator ' . q{'}
                    . NAME_PERLOPS_PERLTYPES() . q{'}
                    . ', dying' . "\n";
            }
#            RPerl::diag( 'in OperatorVoid::Named::Return->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $arguments = ' . "\n" . RPerl::Parser::rperl_ast__dump($arguments) . "\n" );
            if ((( ref $arguments->{children}->[0] ) eq 'ListElement_211' ) and ( exists $arguments->{children}->[0]->{children}->[0] ))
            {
                my object $arguments_subexpression = $arguments->{children}->[0]->{children}->[0];
                # look inside nested parenthesis-as-subexpressions, always length 1 so no need to check length
                while ((ref $arguments_subexpression) eq 'SubExpression_163') {  # RPerl::Operation::Expression::SubExpression::Parenthesis
                    $arguments_subexpression = $arguments_subexpression->{children}->[1];
                }
                if (( ref $arguments_subexpression ) eq 'SubExpression_160' ) {
                    die 'ERROR ECOGEASCP04, CODE GENERATOR, ABSTRACT SYNTAX TO C++:' . "\n" . 'Attempt to return dereferenced array, please return arrayref instead, dying' . "\n";
                }
                elsif (( ref $arguments_subexpression ) eq 'SubExpression_162' ) {
                    die 'ERROR ECOGEASCP05, CODE GENERATOR, ABSTRACT SYNTAX TO C++:' . "\n" . 'Attempt to return dereferenced hash, please return hashref instead, dying' . "\n";
                }
            }
            my string_hashref $cpp_source_subgroup
                = $arguments->ast_to_cpp__generate__CPPOPS_CPPTYPES( $modes, $self );
#            RPerl::diag( 'in OperatorVoid::Named::Return->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $cpp_source_subgroup = ' . "\n" . RPerl::Parser::rperl_ast__dump($cpp_source_subgroup) . "\n" );
            RPerl::Generator::source_group_append( $cpp_source_group,
                $cpp_source_subgroup );
        }
        $cpp_source_group->{CPP} .= $operator_void_named->{children}->[2]
            . $operator_void_named->{children}->[3];    # rparen semicolon
    }
    elsif ( ref $operator_void_named eq 'OperatorVoid_139' ) { # OperatorVoid -> OP01_NAMED_VOID ListElements ';'
        $cpp_source_group->{CPP}
            .= $operator_void_named->{children}->[0] . q{ };    # name
        my object $arguments       = $operator_void_named->{children}->[1];
        my integer $argument_count = $arguments->length();
        if ( $argument_count > ARGUMENTS_MAX() ) {
            die
                'ERROR ECOGEASCP03, CODE GENERATOR, ABSTRACT SYNTAX TO C++:'
                . "\n"
                . 'Argument count '
                . $argument_count
                . ' exceeds maximum argument limit '
                . ARGUMENTS_MAX()
                . ' for operator ' . q{'}
                . NAME_PERLOPS_PERLTYPES() . q{'}
                . ', dying' . "\n";
        }
#        RPerl::diag( 'in OperatorVoid::Named::Return->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $arguments = ' . "\n" . RPerl::Parser::rperl_ast__dump($arguments) . "\n" );
        if ((( ref $arguments->{children}->[0] ) eq 'ListElement_211' ) and ( exists $arguments->{children}->[0]->{children}->[0] ))
        {
            my object $arguments_subexpression = $arguments->{children}->[0]->{children}->[0];
            # look inside nested parenthesis-as-subexpressions, always length 1 so no need to check length
            while ((ref $arguments_subexpression) eq 'SubExpression_163') {  # RPerl::Operation::Expression::SubExpression::Parenthesis
                $arguments_subexpression = $arguments_subexpression->{children}->[1];
            }
            if (( ref $arguments_subexpression ) eq 'SubExpression_160' ) {
                die 'ERROR ECOGEASCP04, CODE GENERATOR, ABSTRACT SYNTAX TO C++:' . "\n" . 'Attempt to return dereferenced array, please return arrayref instead, dying' . "\n";
            }
            elsif (( ref $arguments_subexpression ) eq 'SubExpression_162' ) {
                die 'ERROR ECOGEASCP05, CODE GENERATOR, ABSTRACT SYNTAX TO C++:' . "\n" . 'Attempt to return dereferenced hash, please return hashref instead, dying' . "\n";
            }
        }
        my string_hashref $cpp_source_subgroup
            = $arguments->ast_to_cpp__generate__CPPOPS_CPPTYPES( $modes, $self );
#        RPerl::diag( 'in OperatorVoid::Named::Return->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $cpp_source_subgroup = ' . "\n" . RPerl::Parser::rperl_ast__dump($cpp_source_subgroup) . "\n" );
        RPerl::Generator::source_group_append( $cpp_source_group,
            $cpp_source_subgroup );
        $cpp_source_group->{CPP} .= $operator_void_named->{children}->[2]; # semicolon
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                . ( ref $operator_void_named )
                . ' found where OperatorVoid_137, OperatorVoid_138, or OperatorVoid_139 expected, dying'
        ) . "\n";
    }

    $cpp_source_group->{CPP} .= "\n";
    return $cpp_source_group;
}

1;    # end of class
