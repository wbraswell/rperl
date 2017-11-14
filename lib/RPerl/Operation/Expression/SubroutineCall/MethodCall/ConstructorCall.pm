# [[[ HEADER ]]]
package RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.003_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::SubroutineCall::MethodCall);
use RPerl::Operation::Expression::SubroutineCall::MethodCall;

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
    my string_hashref $rperl_source_subgroup;

#    RPerl::diag( 'in ConstructorCall->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    if ( ( ref $self ) ne 'Expression_154' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . ( ref $self )
                . ' found where Expression_154 expected, dying' )
            . "\n";
    }

    # Expression -> WordScoped OP02_METHOD_THINARROW_NEW OPTIONAL-36 ')'
    my object $type                      = $self->{children}->[0];
    my string $thin_arrow_new_left_paren = $self->{children}->[1];
    my object $properties_init_optional  = $self->{children}->[2];
    my string $right_paren               = $self->{children}->[3];

    $rperl_source_group->{PMC} .= $type->{children}->[0] . $thin_arrow_new_left_paren;

    if ( exists $properties_init_optional->{children}->[0] ) {
        $rperl_source_subgroup = $properties_init_optional->{children}->[0]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }

    $rperl_source_group->{PMC} .= $right_paren;
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group
        = { CPP =>
            q{// <<< RP::O::E::SC::MC::CC __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
#    RPerl::diag( 'in ConstructorCall->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
    
    my string_hashref $cpp_source_group = { CPP => q{} };
    my string_hashref $cpp_source_subgroup;

    if ( ( ref $self ) ne 'Expression_154' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule ' . ( ref $self ) . ' found where Expression_154 expected, dying' ) . "\n";
    }

    # Expression -> WordScoped OP02_METHOD_THINARROW_NEW OPTIONAL-36 ')'
    my object $type                      = $self->{children}->[0]->{children}->[0];
    $type = RPerl::Generator::type_convert_perl_to_cpp($type, 0);  # $pointerify_classes = 0
    my object $properties_init_optional  = $self->{children}->[2];

    $cpp_source_group->{CPP} .= 'new ' . $type;

    if ( exists $properties_init_optional->{children}->[0] ) {
        $properties_init_optional = $properties_init_optional->{children}->[0];  # unwrap hashref object
#        RPerl::diag( 'in ConstructorCall->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have unwrapped $properties_init_optional = ' . "\n" . RPerl::Parser::rperl_ast__dump($properties_init_optional) . "\n" );

        my object $property_0 = $properties_init_optional->{children}->[1];
#        RPerl::diag( 'in ConstructorCall->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $property_0 = ' . "\n" . RPerl::Parser::rperl_ast__dump($property_0) . "\n" );

        if ( ( ref $property_0 ) ne 'HashEntry_224' ) {
            die RPerl::Parser::rperl_rule__replace(
                'ERROR ECOGEASCP36, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule ' . ( ref $property_0 ) . ' found where HashEntry_224 expected, object property value initialization hashref must contain normal key/value pairs only, dying' ) . "\n";
        }

        $cpp_source_subgroup = $self->ast_to_cpp__generate__CPPOPS_CPPTYPES__property_init($modes, $property_0);
        RPerl::diag( 'in ConstructorCall->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $cpp_source_subgroup from $property_0 = ' . "\n" . RPerl::Parser::rperl_ast__dump($cpp_source_subgroup) . "\n" );
        die 'TMP DEBUG';

        # START HERE: generate C++ for property 0, add foreach loop to handle remaining properties, copy CPPOPS_CPPTYPES property init semantics to PERLOPS_PERLTYPES mode above, create passing & failing tests
        # START HERE: generate C++ for property 0, add foreach loop to handle remaining properties, copy CPPOPS_CPPTYPES property init semantics to PERLOPS_PERLTYPES mode above, create passing & failing tests
        # START HERE: generate C++ for property 0, add foreach loop to handle remaining properties, copy CPPOPS_CPPTYPES property init semantics to PERLOPS_PERLTYPES mode above, create passing & failing tests
    }
    return $cpp_source_group;
}


sub ast_to_cpp__generate__CPPOPS_CPPTYPES__property_init {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes, my object $property ) = @ARG;
#    RPerl::diag( 'in ConstructorCall->ast_to_cpp__generate__CPPOPS_CPPTYPES__property_init(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag( 'in ConstructorCall->ast_to_cpp__generate__CPPOPS_CPPTYPES__property_init(), received $property = ' . "\n" . RPerl::Parser::rperl_ast__dump($property) . "\n" );
    
    my string_hashref $cpp_source_group = { CPP_name => q{}, CPP_value => q{} };
    my string_hashref $cpp_source_subgroup;

    my object $property_name                = $property->{children}->[0];
    my object $property_type_inner_optional = $property->{children}->[2];
    my object $property_value               = $property->{children}->[3];

    if ( ( ref $property_name ) ne 'VarOrLitOrOpStrOrWord_251' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASCP36, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule ' . ( ref $property_name ) . ' found where VarOrLitOrOpStrOrWord_251 expected, object property value initialization hashref must contain normal key/value pairs only, dying' ) . "\n";
    }

    $property_name = $property_name->{children}->[0];  # unwrap OpStringOrWord_278 from VarOrLitOrOpStrOrWord_251
    if ( ( ref $property_name ) ne 'OpStringOrWord_278' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASCP37, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule ' . ( ref $property_name ) . ' found where OpStringOrWord_278 expected, object property value initialization hashref must contain bareword keys only, dying' ) . "\n";
    }

    $property_name = $property_name->{children}->[0];  # unwrap bareword from OpStringOrWord_278

    if ( exists $property_type_inner_optional->{children}->[0] ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASCP38, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Object property initialization, hashref entry for property name ' . q{'} . $property_name . q{'} . ' has inner type when it should have no inner type, dying' ) . "\n";
    }

    $cpp_source_group->{CPP_name} = $property_name;

    $cpp_source_subgroup = $property_value->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
    $cpp_source_group->{CPP_value} = $cpp_source_subgroup->{CPP};
    return $cpp_source_group;
}

1;    # end of class
