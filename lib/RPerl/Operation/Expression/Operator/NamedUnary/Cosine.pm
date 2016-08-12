# [[[ DOCUMENTATION ]]]
# http://perldoc.perl.org/functions/cos.html
#     SUPPORTED:  cos EXPR
# NOT SUPPORTED:  cos

# [[[ HEADER ]]]
package RPerl::Operation::Expression::Operator::NamedUnary::Cosine;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.003_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::Operator::NamedUnary);
use RPerl::Operation::Expression::Operator::NamedUnary;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ CONSTANTS ]]]
use constant NAME          => my string $TYPED_NAME           = 'cos';
use constant ARGUMENTS_MIN => my integer $TYPED_ARGUMENTS_MIN = 1;
use constant ARGUMENTS_MAX => my integer $TYPED_ARGUMENTS_MAX = 1;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

our string_hashref::method $ast_to_rperl__generate = sub {
    ( my object $self, my object $operator_named, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Operator::NamedUnary::Cosine->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag( 'in Operator::NamedUnary::Cosine->ast_to_rperl__generate(), received $operator_named = ' . "\n" . RPerl::Parser::rperl_ast__dump($operator_named) . "\n" );

    my string $operator_named_class = ref $operator_named;
    if ( $operator_named_class eq 'Operation_81' ) {    # Operation -> OP10_NAMED_UNARY_SCOLON
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP16, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Named operator '
                . $operator_named->{children}->[0]
                . ' requires exactly one argument, dying' )
            . "\n";
    }
    elsif ( $operator_named_class eq 'Operator_100' ) {    # Operator -> OP10_NAMED_UNARY SubExpression
        $rperl_source_group->{PMC} .= $operator_named->{children}->[0] . q{ };
        my string_hashref $rperl_source_subgroup = $operator_named->{children}->[1]->ast_to_rperl__generate( $modes, $self );
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }
    elsif ( $operator_named_class eq 'Operator_101' ) {    # Operator -> OP10_NAMED_UNARY
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP16, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Named operator '
                . $operator_named->{children}->[0]
                . ' requires exactly one argument, dying' )
            . "\n";
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . ($operator_named_class)
                . ' found where Operation_81, Operator_100, or Operator_101 expected, dying' )
            . "\n";
    }

    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::O::E::O::NU::C __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my object $operator_named, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{} };

    #RPerl::diag( 'in NamedUnary::Scalar->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
    #RPerl::diag( 'in NamedUnary::Scalar->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $operator_named = ' . "\n" . RPerl::Parser::rperl_ast__dump($operator_named) . "\n");

    my string $operator_named_class = ref $operator_named;

    if ( $operator_named_class eq 'Operation_81' ) {    # Operation -> OP10_NAMED_UNARY_SCOLON
	die RPerl::Parser::rperl_rule__replace( 'ERROR EC0GEASCP16, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Named operator '
	    	. q{'} . $operator_named->{children}->[0] . q{'}
		. ' requires exactly one argument, dying' )
	    . "\n";
    }
    elsif ( $operator_named_class eq 'Operator_100' ) {    # Operator -> OP10_NAMED_UNARY SubExpression
	my object $subexpression       = $operator_named->{children}->[1];
	my string $subexpression_class = ref $subexpression;

	$cpp_source_group->{CPP} .= $operator_named->{children}->[0];
	$cpp_source_group->{CPP} .= '(';
	#RPerl::diag( 'XXX - subexpression_class = ' . RPerl::Parser::rperl_ast__dump($subexpression_class) . "\n");
	if ( $subexpression_class eq 'SubExpression_138' ) { # Dealing with a Literal
	    #RPerl::diag( 'XXX - X -- ' . $subexpression_class . "\n" );
	    my object $subsubexpression = $subexpression->{children}->[0];
	    my string $subsubexpression_class = ref $subsubexpression;
	    #RPerl::diag( 'XXX - X - X -- ' . $subsubexpression_class . "\n" );
	    #RPerl::diag( 'XXX - X - X -- subsubexpression_class = ' . RPerl::Parser::rperl_ast__dump($subsubexpression_class) . "\n");
	    if ( $subsubexpression_class eq 'Literal_235' ) { # Dealing with type Number
		#RPerl::diag( 'XXX - X - X -- subsubexpression = ' . "\n" . RPerl::Parser::rperl_ast__dump($subsubexpression) . "\n");
		$cpp_source_group->{CPP} .= $subsubexpression->{children}->[0];
	    }
	}
	$cpp_source_group->{CPP} .= ')';
    }
    elsif ( $operator_named_class eq 'Operator_101' ) {    # Operator -> OP10_NAMED_UNARY
	die RPerl::Parser::rperl_rule__replace( 'ERROR EC0GEASCP16, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Named operator '
	    	. $operator_named->{children}->[0]
		. ' requires exactly one argument, dying' )
	    . "\n";
    }
    else {
	die RPerl::Parser::rperl_rule__replace( 'ERROR EC0GEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
	    	. ($operator_named_class)
		. ' found where Operation_81, Operator_100, or Operator_101 expected, dying' )
	    . "\n";
    }

    return $cpp_source_group;
};

1;    # end of class
