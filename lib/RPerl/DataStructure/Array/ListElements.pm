# [[[ HEADER ]]]
package RPerl::DataStructure::Array::ListElements;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.003_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::GrammarRule);
use RPerl::GrammarRule;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub length {
    { my integer::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my integer $length = 0;

    #    RPerl::diag( 'in Array::ListElements->length(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    if ( exists $self->{children}->[0] ) {
        $length++;
    }
    else {
    return $length;
    }
    my object $list_elements_star = $self->{children}->[1];

    foreach my object $list_element ( @{ $list_elements_star->{children} } ) {

#        RPerl::diag( 'in Array::ListElements->length(), top of foreach() loop, have $list_element = ' . "\n" . RPerl::Parser::rperl_ast__dump($list_element) . "\n" );
        if ( ref $list_element ne 'TERMINAL' ) {
            $length++;
        }
    }

    return $length;
}

sub ast_to_rperl__generate {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $rperl_source_group = { PMC => q{} };

    #    RPerl::diag( 'in Array::ListElements->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    if ( ( ref $self ) ne 'ListElements_204' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule ' . ( ref $self ) . ' found where ListElements_204 expected, dying' )
            . "\n";
    }

    my object $list_element0      = $self->{children}->[0];
    my object $list_elements_star = $self->{children}->[1];

#    RPerl::diag( 'in Array::ListElements->ast_to_rperl__generate(), top of foreach() loop, have $list_element0 = ' . "\n" . RPerl::Parser::rperl_ast__dump($list_element0) . "\n" );
#    die 'TMP DEBUG';

    my string_hashref $rperl_source_subgroup = $list_element0->ast_to_rperl__generate($modes);
    RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );

    foreach my object $list_element ( @{ $list_elements_star->{children} } ) {

#        RPerl::diag( 'in Array::ListElements->ast_to_rperl__generate(), top of foreach() loop, have $list_element = ' . "\n" . RPerl::Parser::rperl_ast__dump($list_element) . "\n" );
#        die 'TMP DEBUG';
        if ( ref $list_element eq 'TERMINAL' ) {
            if ( $list_element->{attr} ne q{,} ) {
                die RPerl::Parser::rperl_rule__replace( q{ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '}
                        . $list_element->{attr}
                        . q{' found where OP21_LIST_COMMA ',' expected, dying} )
                    . "\n";
            }
            $rperl_source_group->{PMC} .= $list_element->{attr} . q{ };    # OP21_LIST_COMMA
        }
        else {
            my string_hashref $rperl_source_subgroup = $list_element->ast_to_rperl__generate($modes);
            RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        }
    }
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::DS::A::LEs __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{} };

#    RPerl::diag( 'in Array::ListElements->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag( 'in Array::ListElements->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modes->{_inside_print_operator} = ' . $modes->{_inside_print_operator} . "\n" );

    if ( ( ref $self ) ne 'ListElements_204' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule ' . ( ref $self ) . ' found where ListElements_204 expected, dying' )
            . "\n";
    }

    # save to stack of saved flags, when needed
    if ( ( exists $modes->{_inside_list_elements} ) and ( defined $modes->{_inside_list_elements} ) ) {
        if ( ( not exists $modes->{_inside_list_elements_saved} ) or ( not defined $modes->{_inside_list_elements_saved} ) ) {
            $modes->{_inside_list_elements_saved} = [];
        }
        push @{ $modes->{_inside_list_elements_saved} }, $modes->{_inside_list_elements};
    }
    $modes->{_inside_list_elements} = 1;

    my object $list_element0      = $self->{children}->[0];
    my object $list_elements_star = $self->{children}->[1];

    my string_hashref $cpp_source_subgroup = $list_element0->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
    RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );

    foreach my object $list_element ( @{ $list_elements_star->{children} } ) {

#        RPerl::diag( 'in Array::ListElements->ast_to_cpp__generate__CPPOPS_CPPTYPES(), top of foreach() loop, have $list_element = ' . "\n" . RPerl::Parser::rperl_ast__dump($list_element) . "\n" );
        if ( ref $list_element eq 'TERMINAL' ) {
            if ( $list_element->{attr} ne q{,} ) {
                die RPerl::Parser::rperl_rule__replace( q{ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '}
                        . $list_element->{attr}
                        . q{' found where OP21_LIST_COMMA ',' expected, dying} )
                    . "\n";
            }

            # OP21_LIST_COMMA
            if ( ( exists $modes->{_inside_print_operator} ) and ( defined $modes->{_inside_print_operator} ) and $modes->{_inside_print_operator} ) {    # or

#                ((exists $modes->{_inside_die_operator}) and (defined $modes->{_inside_die_operator}) and $modes->{_inside_die_operator})) { # DEV NOTE, CORRELATION #rp102b
# replace comma with << when inside print operator
                $cpp_source_group->{CPP} .= ' << ';
            }
            else {
                # keep comma when not inside print operator
                $cpp_source_group->{CPP} .= $list_element->{attr} . q{ };
            }
        }
        else {
            my string_hashref $cpp_source_subgroup = $list_element->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
        }
    }

    # restore from stack of saved flags, when needed
    delete $modes->{_inside_list_elements};
    if (    ( exists $modes->{_inside_list_elements_saved} )
        and ( defined $modes->{_inside_list_elements_saved} )
        and ( scalar $modes->{_inside_list_elements_saved} ) )
    {
        $modes->{_inside_list_elements} = pop @{ $modes->{_inside_list_elements_saved} };
        if ( not scalar $modes->{_inside_list_elements_saved} ) { delete $modes->{_inside_list_elements_saved}; }
    }
    return $cpp_source_group;
}

1;    # end of class
