# [[[ HEADER ]]]
package RPerl::Operation::Statement;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_010;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation);
use RPerl::Operation;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref::method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };
    my object $child0 = $self->{children}->[0];
    my string $child0_class = ref $child0;
    my string_hashref $rperl_source_subgroup;

#    RPerl::diag( 'in Statement->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    # Conditional, OperatorVoid, VariableDeclaration, or VariableModification
    if (   ( $child0_class eq 'Statement_152' )
        or ( $child0_class eq 'Statement_154' )
        or ( $child0_class eq 'Statement_155' )
        or ( $child0_class eq 'Statement_156' ) )
    {
        $rperl_source_subgroup
            = $child0->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
    }

    # Loop
    elsif ( $child0_class eq 'Statement_153' ) {
        my $optional_loop_label = $child0->{children}->[0];
        my $loop = $child0->{children}->[1];
#        RPerl::diag( 'in Statement->ast_to_rperl__generate(), have $optional_loop_label = ' . "\n" . RPerl::Parser::rperl_ast__dump($optional_loop_label) . "\n" );
        if ( exists $optional_loop_label->{children}->[0] ) {  # LoopLabel COLON
            $rperl_source_group->{PMC} .= "\n" . $optional_loop_label->{children}->[0]->{children}->[0] . $optional_loop_label->{children}->[1]->{attr} . "\n";
        }
        $rperl_source_subgroup = $loop->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . $child0_class
                . ' found where Statement_152, Statement_153, Statement_154, Statement_155, or Statement_156 expected, dying'
        ) . "\n";
    }

    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = { CPP => q{// <<< RP::O::S __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
#    RPerl::diag( 'in Statement->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $modes->{_symbol_table} = ' . "\n" . Dumper($modes->{_symbol_table}) . "\n");

    my string_hashref $cpp_source_group = { CPP => q{} };
    my object $child0 = $self->{children}->[0];
    my string $child0_class = ref $child0;
    my string_hashref $cpp_source_subgroup;

#    RPerl::diag( 'in Statement->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    # Conditional, OperatorVoid, VariableDeclaration, or VariableModification
    if (   ( $child0_class eq 'Statement_152' )
        or ( $child0_class eq 'Statement_154' )
        or ( $child0_class eq 'Statement_155' )
        or ( $child0_class eq 'Statement_156' ) )
    {
        $cpp_source_subgroup = $child0->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
#        RPerl::diag( 'in Statement->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $cpp_source_subgroup = ' . "\n" . RPerl::Parser::rperl_ast__dump($cpp_source_subgroup) . "\n" );
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
    }

    # Loop
    elsif ( $child0_class eq 'Statement_153' ) {
        my object $optional_loop_label = $child0->{children}->[0];
        my object $loop = $child0->{children}->[1];
        my string $loop_label = undef;
#        RPerl::diag( 'in Statement->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $loop = ' . "\n" . RPerl::Parser::rperl_ast__dump($loop) . "\n" );
#        RPerl::diag( 'in Statement->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $optional_loop_label = ' . "\n" . RPerl::Parser::rperl_ast__dump($optional_loop_label) . "\n" );

        if ( exists $optional_loop_label->{children}->[0] ) {  # LoopLabel COLON
            $loop_label = $optional_loop_label->{children}->[0]->{children}->[0];
        }
#        RPerl::diag( 'in Statement->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $loop_label = ' . "\n" . RPerl::Parser::rperl_ast__dump($loop_label) . "\n" );
        $cpp_source_subgroup = $loop->ast_to_cpp__generate__CPPOPS_CPPTYPES($loop_label, $modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                . $child0_class
                . ' found where Statement_152, Statement_153, Statement_154, Statement_155, or Statement_156 expected, dying'
        ) . "\n";
    }

    return $cpp_source_group;
};

1;    # end of class
