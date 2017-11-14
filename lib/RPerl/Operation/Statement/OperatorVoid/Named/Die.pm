# [[[ HEADER ]]]
package RPerl::Operation::Statement::OperatorVoid::Named::Die;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.003_000;

# [[[ OO INHERITANCE ]]]
# NEED FIX: is not a Grammar Rule so should not inherit from OperatorVoid, need create Grammar Production class
use parent qw(RPerl::Operation::Statement::OperatorVoid::Named);
use RPerl::Operation::Statement::OperatorVoid::Named;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants

# [[[ CONSTANTS ]]]
use constant NAME => my string $TYPED_NAME = 'die';

# DEV NOTE: ARGUMENTS_MIN of 0 can be ignored, no such thing as negative number of args!
use constant ARGUMENTS_MIN => my integer $TYPED_ARGUMENTS_MIN = 0;
use constant ARGUMENTS_MAX => my integer $TYPED_ARGUMENTS_MAX = 999;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub ast_to_rperl__generate {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes, my object $operator_void_named) = @ARG;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in OperatorVoid::Named::Die->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag( 'in OperatorVoid::Named::Die->ast_to_rperl__generate(), received $operator_void_named = ' . "\n" . RPerl::Parser::rperl_ast__dump($operator_void_named) . "\n" );

    if ( ref $operator_void_named eq 'OperatorVoid_137' ) {    # OperatorVoid -> OP01_NAMED_VOID_SCOLON
        $rperl_source_group->{PMC} .= $operator_void_named->{children}->[0];    # name semicolon
    }
    elsif ( ref $operator_void_named eq 'OperatorVoid_139' ) {                  # OperatorVoid -> OP01_NAMED_VOID ListElements ';'
        $rperl_source_group->{PMC}
            .= $operator_void_named->{children}->[0] . q{ };                    # name
        my object $arguments       = $operator_void_named->{children}->[1];
        my integer $argument_count = $arguments->length();
        if ( $argument_count > ARGUMENTS_MAX() ) {
            die 'ERROR ECOGEASRP03, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL:' . "\n"
                . 'Argument count '
                . $argument_count
                . ' exceeds maximum argument limit '
                . ARGUMENTS_MAX()
                . ' for operator ' . q{'}
                . NAME() . q{'}
                . ', dying' . "\n";
        }
        my string_hashref $rperl_source_subgroup = $arguments->ast_to_rperl__generate( $modes, $self );
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= $operator_void_named->{children}->[2];    # semicolon
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . ( ref $operator_void_named )
                . ' found where OperatorVoid_137 or OperatorVoid_139 expected, dying' )
            . "\n";
    }

    $rperl_source_group->{PMC} .= "\n";
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes, my object $operator_void_named) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::O::S::OV::N::D __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes, my object $operator_void_named) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{} };

#    RPerl::diag( 'in OperatorVoid::Named::Die->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag( 'in OperatorVoid::Named::Die->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $operator_void_named = ' . "\n" . RPerl::Parser::rperl_ast__dump($operator_void_named) . "\n" );

    if ( ref $operator_void_named eq 'OperatorVoid_137' ) {    # OperatorVoid -> OP01_NAMED_VOID_SCOLON
        # DEV NOTE, CORRELATION #rp102: renamed from Perl die to C++ Die to avoid error redefining Perl's embed.h die
        $cpp_source_group->{CPP} .= ucfirst $operator_void_named->{children}->[0];    # Name semicolon
    }
    elsif ( ref $operator_void_named eq 'OperatorVoid_139' ) {                  # OperatorVoid -> OP01_NAMED_VOID ListElements ';'
        # DEV NOTE, CORRELATION #rp102: renamed from Perl die to C++ Die to avoid error redefining Perl's embed.h die
        # DEV NOTE, CORRELATION #rp102a: C++ cerr w/ recursive variadic template and exit() is equivalent to Perl die, DISABLED
        # DEV NOTE, CORRELATION #rp102b: C++ cerr w/ inlined exit() is equivalent to Perl die
        $cpp_source_group->{CPP} .= ucfirst $operator_void_named->{children}->[0];                    # Name
        $cpp_source_group->{CPP} .= q{(};                    # left parentheses, CORRELATION #rp102a
        $cpp_source_group->{CPP} .= q{ };
        my object $arguments       = $operator_void_named->{children}->[1];
        my integer $argument_count = $arguments->length();
        if ( $argument_count > ARGUMENTS_MAX() ) {
            die 'ERROR ECOGEASCP03, CODE GENERATOR, ABSTRACT SYNTAX TO C++:' . "\n"
                . 'Argument count ' . $argument_count . ' exceeds maximum argument limit ' . ARGUMENTS_MAX()
                . ' for operator ' . q{'} . NAME() . q{'} . ', dying' . "\n";
        }

        # save to stack of saved flags, when needed
        if ((exists $modes->{_inside_die_operator}) and (defined $modes->{_inside_die_operator})) {
            if ((not exists $modes->{_inside_die_operator_saved}) or (not defined $modes->{_inside_die_operator_saved})) {
                $modes->{_inside_die_operator_saved} = [];
            }
            push @{$modes->{_inside_die_operator_saved}}, $modes->{_inside_die_operator};
        }
        $modes->{_inside_die_operator} = 1;

        my string_hashref $cpp_source_subgroup = $arguments->ast_to_cpp__generate__CPPOPS_CPPTYPES( $modes, $self );
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
        $cpp_source_group->{CPP} .= q{ )};                    # right parentheses, CORRELATION #rp102a
        $cpp_source_group->{CPP} .= $operator_void_named->{children}->[2];    # semicolon
#        $cpp_source_group->{CPP} .= '  exit(1);';  # inlined exit(), CORRELATION #rp102b

        # restore from stack of saved flags, when needed
        delete $modes->{_inside_die_operator};
        if ((exists $modes->{_inside_die_operator_saved}) and (defined $modes->{_inside_die_operator_saved}) and (scalar $modes->{_inside_die_operator_saved})) {
            $modes->{_inside_die_operator} = pop @{$modes->{_inside_die_operator_saved}};
            if (not scalar $modes->{_inside_die_operator_saved}) { delete $modes->{_inside_die_operator_saved}; }
        }
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . ( ref $operator_void_named )
                . ' found where OperatorVoid_137 or OperatorVoid_139 expected, dying' )
            . "\n";
    }

    $cpp_source_group->{CPP} .= "\n";
    return $cpp_source_group;
}

1;    # end of class
