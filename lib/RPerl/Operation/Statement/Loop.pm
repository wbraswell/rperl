# [[[ HEADER ]]]
package RPerl::Operation::Statement::Loop;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_010;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Statement);
use RPerl::Operation::Statement;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub ast_to_rperl__generate {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in Loop->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    # unwrap Loop_184, Loop_185, and Loop_186 from Statement_173
    if ( $self_class eq 'Statement_173' ) {
        $self = $self->{children}->[0];
        $self_class = ref $self;
    }

    if (   ( $self_class eq 'Loop_184' )  # Loop -> LoopFor
        or ( $self_class eq 'Loop_185' )  # Loop -> LoopForEach
        or ( $self_class eq 'Loop_186' ) )  # Loop -> LoopWhile
    {
        my object $rperl_source_subgroup = $self->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP000, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . $self_class
                . ' found where Loop_184, Loop_185, or Loop_186 expected, dying'
        ) . "\n";
    }
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string $loop_label, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group
        = {
        CPP => q{// <<< RP::O::S::L __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n"
        };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string $loop_label, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{} };

#    RPerl::diag( 'in Loop->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag( 'in Loop->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $loop_label = ' . $loop_label . "\n" );

    my string $self_class = ref $self;

    # unwrap Loop_184, Loop_185, and Loop_186 from Statement_173
    if ( $self_class eq 'Statement_173' ) {
        $self = $self->{children}->[0];
        $self_class = ref $self;
    }

    if (   ( $self_class eq 'Loop_184' )  # Loop -> LoopFor
        or ( $self_class eq 'Loop_185' )  # Loop -> LoopForEach
        or ( $self_class eq 'Loop_186' ) )  # Loop -> LoopWhile
    {
        my object $cpp_source_subgroup = $self->ast_to_cpp__generate__CPPOPS_CPPTYPES($loop_label, $modes);
        RPerl::Generator::source_group_append( $cpp_source_group,
            $cpp_source_subgroup );
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASCP000, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                . $self_class
                . ' found where Loop_184, Loop_185, or Loop_186 expected, dying'
        ) . "\n";
    }
#    RPerl::diag( 'in Loop->ast_to_cpp__generate__CPPOPS_CPPTYPES(), bottom of subroutine, have $modes->{_loop_iterators} = ' . "\n" . Dumper($modes->{_loop_iterators}) . "\n" );
    return $cpp_source_group;
}

1;    # end of class
