# [[[ DOCUMENTATION ]]]
# http://perldoc.perl.org/functions/scalar.html
#     SUPPORTED:  scalar EXPR

# [[[ HEADER ]]]
package RPerl::Operation::Expression::Operator::NamedUnary::Scalar;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.003_100;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::Operator::NamedUnary);
use RPerl::Operation::Expression::Operator::NamedUnary;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ CONSTANTS ]]]
use constant NAME                  => my string  $TYPED_NAME                  = 'scalar';
use constant NAME_CPPOPS_PERLTYPES => my string  $TYPED_NAME_CPPOPS_PERLTYPES = 'DUMMY_OP_SCALAR';
use constant NAME_CPPOPS_CPPTYPES  => my string  $TYPED_NAME_CPPOPS_CPPTYPES  = 'size';
use constant ARGUMENTS_MIN         => my integer $TYPED_ARGUMENTS_MIN         = 1;
use constant ARGUMENTS_MAX         => my integer $TYPED_ARGUMENTS_MAX         = 1;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub ast_to_rperl__generate {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my object $operator_named, my string_hashref $modes) = @ARG;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Operator::NamedUnary::Scalar->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag( 'in Operator::NamedUnary::Scalar->ast_to_rperl__generate(), received $operator_named = ' . "\n" . RPerl::Parser::rperl_ast__dump($operator_named) . "\n" );

    my string $operator_named_class = ref $operator_named;
    if ( $operator_named_class eq 'Operation_97' ) {    # Operation -> OP10_NAMED_UNARY_SCOLON
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP016, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Named operator '
                . q{'} . $operator_named->{children}->[0] . q{'}
                . ' requires exactly one argument, dying' )
            . "\n";
    }
    elsif ( $operator_named_class eq 'Operator_116' ) {    # Operator -> OP10_NAMED_UNARY SubExpression
        $rperl_source_group->{PMC} .= $operator_named->{children}->[0] . q{ };
        my string_hashref $rperl_source_subgroup = $operator_named->{children}->[1]->ast_to_rperl__generate( $modes, $self );
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }
    elsif ( $operator_named_class eq 'Operator_117' ) {    # Operator -> OP10_NAMED_UNARY
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP016, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Named operator '
                . q{'} . $operator_named->{children}->[0] . q{'}
                . ' requires exactly one argument, dying' )
            . "\n";
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP000, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . ($operator_named_class)
                . ' found where Operation_97, Operator_116, or Operator_117 expected, dying' )
            . "\n";
    }
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::O::E::O::NU::Sca __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my object $operator_named, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{} };

#    RPerl::diag( 'in NamedUnary::Scalar->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag( 'in NamedUnary::Scalar->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $operator_named = ' . "\n" . RPerl::Parser::rperl_ast__dump($operator_named) . "\n" );

    my string $operator_named_class = ref $operator_named;
    if ( $operator_named_class eq 'Operation_97' ) {    # Operation -> OP10_NAMED_UNARY_SCOLON
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP016, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Named operator '
                . q{'} . $operator_named->{children}->[0] . q{'}
                . ' requires exactly one argument, dying' )
            . "\n";
    }
    elsif ( $operator_named_class eq 'Operator_116' ) {    # Operator -> OP10_NAMED_UNARY SubExpression




        # DEV NOTE, CORRELATION #rp031: NEED UPGRADE: implement proper @array vs $arrayref, %hash vs $hashref, dereferencing, etc.

# UPGRADE START HERE: do not require named operator or ArrayDereference below, once we allow RPerl variables/subroutines to store/return non-reference @arrays; sync w/ PERLOPS_PERLTYPES above; create tests
# UPGRADE START HERE: do not require named operator or ArrayDereference below, once we allow RPerl variables/subroutines to store/return non-reference @arrays; sync w/ PERLOPS_PERLTYPES above; create tests
# UPGRADE START HERE: do not require named operator or ArrayDereference below, once we allow RPerl variables/subroutines to store/return non-reference @arrays; sync w/ PERLOPS_PERLTYPES above; create tests
        
        # must have Perl named operator (AKA named function) or ArrayDereference as only argument, because this operator requires non-reference array input
        my object $subexpression       = $operator_named->{children}->[1];
        my string $subexpression_class = ref $subexpression;
        if (    (not exists $rperloperations::BUILTINS_PERL_NAMED->{$subexpression_class})
            and ( $subexpression_class ne 'SubExpression_160' )
            and ( $subexpression_class ne 'ArrayDereference_221' )
            and ( $subexpression_class ne 'ArrayDereference_222' ) )
        {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP870, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Named operator ' . q{'} . $operator_named->{children}->[0] . q{'}
                . ' requires Perl named operator (AKA named function) or ArrayDereference argument, received ' . $subexpression_class . ' instead, dying' ) . "\n";
        }





        # unwrap ArrayDereference_221 and ArrayDereference_222 from SubExpression_160
        if ( $subexpression_class eq 'SubExpression_160' ) {    # SubExpression -> ArrayDereference
            $subexpression = $subexpression->{children}->[0];
        }

        $subexpression_class = ref $subexpression;
        my string_hashref $cpp_source_subgroup;



        # NEED REMOVE OR MODIFY DURING UPGRADE
        if ( exists $rperloperations::BUILTINS_PERL_NAMED->{$subexpression_class} ) {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP8xx, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Named operator ' . q{'} . $operator_named->{children}->[0] . q{'}
                . ' received Perl named operator (AKA named function) argument ' . $subexpression_class . '; this feature is not yet supported, dying' ) . "\n";
        }



        # DEV NOTE, CORRELATION #rp031: NEED UPGRADE: implement proper @array vs $arrayref, %hash vs $hashref, dereferencing, etc.

# UPGRADE START HERE: do not unwrap and disregard ArrayDereference @{...} operator below, must actually perform dereference by unwrapping std::vector from std::unique_ptr<std::vector>
# UPGRADE START HERE: do not unwrap and disregard ArrayDereference @{...} operator below, must actually perform dereference by unwrapping std::vector from std::unique_ptr<std::vector>
# UPGRADE START HERE: do not unwrap and disregard ArrayDereference @{...} operator below, must actually perform dereference by unwrapping std::vector from std::unique_ptr<std::vector>

        elsif ( $subexpression_class eq 'ArrayDereference_221' ) {    # ArrayDereference -> '@{' Variable '}'
            $cpp_source_subgroup = $subexpression->{children}->[1]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
        }
        elsif ( $subexpression_class eq 'ArrayDereference_222' ) {    # ArrayDereference -> '@{' TypeInner? ArrayReference '}'
            my object $type_inner_optional = $subexpression->{children}->[1];
            my object $array_reference     = $subexpression->{children}->[2];

            # DEV NOTE: in CPPOPS_CPPTYPES, must cast arrayref data to proper type as provided by TypeInner 
            if ( exists $type_inner_optional->{children}->[0] ) {
                $cpp_source_group->{CPP} .= '((';
                $cpp_source_subgroup = $type_inner_optional->{children}->[0]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);

#                RPerl::diag( 'in NamedUnary::Scalar->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $cpp_source_subgroup = ' . "\n" . RPerl::Parser::rperl_ast__dump($cpp_source_subgroup) . "\n" );
                RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
                $cpp_source_group->{CPP} .= ') ';
                $cpp_source_subgroup = $array_reference->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
                RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
                $cpp_source_group->{CPP} .= ')';
            }
            else {
                die RPerl::Parser::rperl_rule__replace(
                    'ERROR ECOGEASCP871, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Array dereference of array reference must provide data type for array reference in CPPOPS_CPPTYPES mode, but no data type provided, dying'
                ) . "\n";
            }
        }
        else {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP000, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                    . $subexpression_class
                    . ' found where ArrayDereference_221 or ArrayDereference_222 expected, dying' )
                . "\n";
        }

        $cpp_source_group->{CPP} .= '.' . NAME_CPPOPS_CPPTYPES() . '()';
    }
    elsif ( $operator_named_class eq 'Operator_117' ) {    # Operator -> OP10_NAMED_UNARY
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP016, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Named operator '
                . $operator_named->{children}->[0]
                . ' requires exactly one argument, dying' )
            . "\n";
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP000, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                . ($operator_named_class)
                . ' found where Operation_97, Operator_116, or Operator_117 expected, dying' )
            . "\n";
    }
    return $cpp_source_group;
}

1;    # end of class
