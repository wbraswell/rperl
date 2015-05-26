# [[[ HEADER ]]]
package RPerl::Operation::Statement;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_012;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation);
use RPerl::Operation;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };
    my string_hashref $rperl_source_subgroup;

    RPerl::diag(
        'in Statement->ast_to_rperl__generate(), received $self = ' . "\n"
            . RPerl::Parser::rperl_ast__dump($self)
            . "\n" );

    # Conditional, OperatorVoid, VariableDeclaration, or VariableModification
    my string $child0_class = ref $self->{children}->[0];
    if (   ( $child0_class eq 'Statement_143' )
        or ( $child0_class eq 'Statement_145' )
        or ( $child0_class eq 'Statement_146' )
        or ( $child0_class eq 'Statement_147' ) )
    {
        $rperl_source_subgroup
            = $self->{children}->[0]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
    }

    # Loop
    elsif ( $child0_class eq 'Statement_144' ) {

        # optional LoopLabel COLON
        if ( exists $self->{children}->[0]->{children}->[0] ) {

            # NEED FIX: implement loop label
            $rperl_source_group->{PMC}
                .= q{# <<< RP::O::S DUMMY SOURCE CODE PERLOPS_PERLTYPES, NEED IMPLEMENT LOOP LABEL!!! >>>}
                . "\n";
        }
        $rperl_source_subgroup
            = $self->{children}->[0]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEAS00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . $child0_class
                . ' found where Statement_143, Statement_144, Statement_145, Statement_146, or Statement_147 expected, dying'
        ) . "\n";
    }

    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP => q{// <<< RP::O::S DUMMY SOURCE CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP => q{// <<< RP::O::S DUMMY SOURCE CODE CPPOPS_CPPTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

1;    # end of class
