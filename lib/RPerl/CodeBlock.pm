# [[[ HEADER ]]]
package RPerl::CodeBlock;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.004_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::GrammarRule);
use RPerl::GrammarRule;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub ast_to_rperl__generate {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $rperl_source_group = { PMC => q{} };

    #    RPerl::diag( 'in CodeBlock->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    if ( $self_class eq 'CodeBlock_194' ) {    # CodeBlock -> LBRACE PLUS-41 '}'
        my string $left_brace     = $self->{children}->[0];
        my object $operation_plus = $self->{children}->[1];
        my string $right_brace    = $self->{children}->[2];

        $rperl_source_group->{PMC} .= $left_brace . "\n";

        foreach my object $operation ( @{ $operation_plus->{children} } ) {
            my object $rperl_source_subgroup = $operation->ast_to_rperl__generate($modes);
            RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );

            #            $rperl_source_group->{PMC} .= "\n";
        }

        $rperl_source_group->{PMC} .= $right_brace . "\n";
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule ' . $self_class . ' found where CodeBlock_194 expected, dying' )
            . "\n";
    }
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string $loop_label, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::CB __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string $loop_label, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{} };

    #    RPerl::diag( 'in CodeBlock->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
    #    RPerl::diag( 'in CodeBlock->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $loop_label = ' . "\n" . RPerl::Parser::rperl_ast__dump($loop_label) . "\n" );
#    RPerl::diag( 'in CodeBlock->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $modes->{_inside_parallel_loop} = ' . "\n" . $modes->{_inside_parallel_loop} . "\n" );
#    RPerl::diag( 'in CodeBlock->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $modes->{_current_parallel_loop} = ' . "\n" . Dumper($modes->{_current_parallel_loop}) . "\n" );
    
    my string $self_class = ref $self;

    if ( $self_class eq 'CodeBlock_194' ) {    # CodeBlock -> LBRACE PLUS-41 '}'
        my string $left_brace     = $self->{children}->[0];
        my object $operation_plus = $self->{children}->[1];
        my string $right_brace    = $self->{children}->[2];

        $cpp_source_group->{CPP} .= $left_brace . "\n";
        # NEED FIX PARALLEL: temporarily disabled loop control labels while inside parallel loop to avoid pluto polycc error
#        RPerl::diag( 'in CodeBlock->ast_to_cpp__generate__CPPOPS_CPPTYPES(), before _REDO, have $modes->{_inside_parallel_loop} = ' . "\n" . RPerl::Parser::rperl_ast__dump($modes->{_inside_parallel_loop}) . "\n" );
        if (( defined $loop_label ) and 
                not ((exists $modes->{_inside_parallel_loop}) and (defined $modes->{_inside_parallel_loop}) and $modes->{_inside_parallel_loop})) {
            $cpp_source_group->{CPP} .= $loop_label . '_REDO: 1;' . "\n";
        }

        foreach my object $operation ( @{ $operation_plus->{children} } ) {
#            RPerl::diag( 'in CodeBlock->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $operation = ' . "\n" . RPerl::Parser::rperl_ast__dump($operation) . "\n" );
            my object $cpp_source_subgroup = $operation->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
        }
        
        # DEV NOTE, INLINE BUG: must include '1;' null statement after labels to avoid the following error messages during g++ call from 'Running Mkbootstrap' Inline phase
        # error: expected primary-expression before ‘}’ token
        # error: expected ‘;’ before ‘}’ token
        # NEED FIX PARALLEL: temporarily disabled loop control labels while inside parallel loop to avoid pluto polycc error
#        RPerl::diag( 'in CodeBlock->ast_to_cpp__generate__CPPOPS_CPPTYPES(), before _NEXT, have $modes->{_inside_parallel_loop} = ' . "\n" . RPerl::Parser::rperl_ast__dump($modes->{_inside_parallel_loop}) . "\n" );
        if (( defined $loop_label ) and 
                not ((exists $modes->{_inside_parallel_loop}) and (defined $modes->{_inside_parallel_loop}) and $modes->{_inside_parallel_loop})) {
            $cpp_source_group->{CPP} .= $loop_label . '_NEXT: 1;' . "\n";
        }

        $cpp_source_group->{CPP} .= $right_brace . "\n";

#        RPerl::diag( 'in CodeBlock->ast_to_cpp__generate__CPPOPS_CPPTYPES(), before _LAST, have $modes->{_inside_parallel_loop} = ' . "\n" . RPerl::Parser::rperl_ast__dump($modes->{_inside_parallel_loop}) . "\n" );
        if (( defined $loop_label ) and 
                not ((exists $modes->{_inside_parallel_loop}) and (defined $modes->{_inside_parallel_loop}) and $modes->{_inside_parallel_loop})) {
            $cpp_source_group->{CPP} .= $loop_label . '_LAST: 1;' . "\n";
        }
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule ' . $self_class . ' found where CodeBlock_194 expected, dying' )
            . "\n";
    }
    return $cpp_source_group;
}

# [[[ SUB-TYPES ]]]

package RPerl::CodeReference;
use strict;
use warnings;
use parent qw(RPerl::DataType::Modifier::Reference);
use RPerl::DataType::Modifier::Reference;

package  # hide from PAUSE indexing
    coderef;
use strict;
use warnings;
use parent -norequire, qw(RPerl::CodeReference);

1;    # end of class
