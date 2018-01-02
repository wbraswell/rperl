# [[[ HEADER ]]]
package RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.005_000;

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
    my string $type                      = $self->{children}->[0]->{children}->[0];
    my string $thin_arrow_new_left_paren = $self->{children}->[1];
    my object $properties_init_optional  = $self->{children}->[2];
    my string $right_paren               = $self->{children}->[3];

    $rperl_source_group->{PMC} .= $type . $thin_arrow_new_left_paren;

    if ( defined $properties_init_optional->{children}->[0] ) {
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
    my string $type                      = $self->{children}->[0]->{children}->[0];
    my string $type_cpp = RPerl::Generator::type_convert_perl_to_cpp($type, 0);  # $pointerify_classes = 0
    my object $properties_init_optional  = $self->{children}->[2];

    # FROM: MongoDB::MongoClient->new();                                       # YES SUPPORT, default value
    # FROM: MongoDB::MongoClient->new({host => 'mongodb://localhost:27017'});  # YES SUPPORT, host parameter
    # FROM: MongoDB::MongoClient->new({host => q{mongodb://localhost:27017}}); # YES SUPPORT, host parameter
    # FROM: MongoDB::MongoClient->new({host => 'localhost', port => 27_017});  # NO  SUPPORT, parsing of non-host parameters not yet implemented below
    #   TO:                   {mongodb_host   {"mongodb://localhost:27017"}};

    # DEV NOTE, CORRELATION #rp131: constructor call for MongoDB
    if ( (substr $type, 0, 7) eq 'MongoDB' ) {
        if ((not exists $modes->{_enable_mongodb}) or (not defined $modes->{_enable_mongodb}) or (not $modes->{_enable_mongodb})) {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP91b, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Found constructor call for package '
                . q{'} . $type . q{'}
                . ' but MongoDB support is not enabled, perhaps you forgot to load MongoDB support via `use RPerl::Support::MongoDB;`, dying' )
                . "\n";
        }
        # only MongoClient objects may be directly constructed, see MongoDB::Database & MongoDB::Collection documentation
        if ($type ne 'MongoDB::MongoClient') {
            die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP92b, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Found constructor call for package '
                . q{'} . $type . q{'}
                . ' but only ' . q{'} . 'MongoDB::MongoClient' . q{'} . ' may be directly constructed, please see the MongoDB documentation on CPAN for more information, dying' )
                . "\n";
        }
        
        my string $mongodb_host;
        if ( defined $properties_init_optional->{children}->[0] ) {
            # NEED UPGRADE: parse MongoDB parameters other than only 'host' below 
#            RPerl::diag( 'in ConstructorCall->ast_to_cpp__generate__CPPOPS_CPPTYPES(), MongoDB constructor, have $properties_init_optional->{children}->[0] = ' . "\n" . RPerl::Parser::rperl_ast__dump($properties_init_optional->{children}->[0]) . "\n" );
            my $properties_init = $properties_init_optional->{children}->[0];

            if ((ref $properties_init) ne 'HashReference_231') {
                die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP97a, CODE GENERATOR, ABSTRACT SYNTAX TO C++: In constructor call for package '
                    . q{'} . $type . q{()'} . ', invalid arguments found, must be exactly 1 non-empty hashref, only ' . q{'host'} . ' key with ' . q{'mongodb://HOST:PORT'} . ' value currently supported, dying' ) . "\n";
            }
            elsif ((not exists $properties_init->{children}) or 
                (not defined $properties_init->{children}) or
                (scalar @{$properties_init->{children}}) != 4) {  # the empty _STAR_LIST plus curly braces makes 4 elements instead of 1
                die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP98a, CODE GENERATOR, ABSTRACT SYNTAX TO C++: In constructor call for package '
                    . q{'} . $type . q{()'} . ', wrong number of arguments found, must be exactly 1 non-empty hashref, only ' . q{'host'} . ' key with ' . q{'mongodb://HOST:PORT'} . ' value currently supported, dying' ) . "\n";
            }

            elsif ((not defined $properties_init->{children}->[2]) or
                ((ref $properties_init->{children}->[2]) ne '_STAR_LIST')) {
                die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP97b, CODE GENERATOR, ABSTRACT SYNTAX TO C++: In constructor call for package '
                    . q{'} . $type . q{()'} . ', invalid or no arguments found, must be exactly 1 non-empty hashref, only ' . q{'host'} . ' key with ' . q{'mongodb://HOST:PORT'} . ' value currently supported, dying' ) . "\n";
            }
            elsif ((not exists $properties_init->{children}->[2]->{children}) or
                (not defined $properties_init->{children}->[2]->{children}) or
                ((scalar @{$properties_init->{children}->[2]->{children}}) != 0)) {  # the empty _STAR_LST has 0 children elements
                die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP98b, CODE GENERATOR, ABSTRACT SYNTAX TO C++: In constructor call for package '
                    . q{'} . $type . q{()'} . ', wrong number of arguments found, must be exactly 1 non-empty hashref, only ' . q{'host'} . ' key with ' . q{'mongodb://HOST:PORT'} . ' value currently supported, dying' ) . "\n";
            }

            elsif ((not defined $properties_init->{children}->[1]) or
                ((ref $properties_init->{children}->[1]) ne 'HashEntry_224')) {
                die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP97c, CODE GENERATOR, ABSTRACT SYNTAX TO C++: In constructor call for package '
                    . q{'} . $type . q{()'} . ', invalid or no arguments found, must be exactly 1 non-empty hashref, only ' . q{'host'} . ' key with ' . q{'mongodb://HOST:PORT'} . ' value currently supported, dying' ) . "\n";
            }
            elsif ((not exists $properties_init->{children}->[1]->{children}) or
                (not defined $properties_init->{children}->[1]->{children}) or
                ((scalar @{$properties_init->{children}->[1]->{children}}) != 4)) {  # the key name, fat comma/arrow =>, optional inner type, and value make 4 
#                RPerl::diag( 'in ConstructorCall->ast_to_cpp__generate__CPPOPS_CPPTYPES(), MongoDB constructor, have $properties_init->{children}->[1]->{children} = ' . "\n" . RPerl::Parser::rperl_ast__dump($properties_init->{children}->[1]->{children}) . "\n" );
                die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP98c, CODE GENERATOR, ABSTRACT SYNTAX TO C++: In constructor call for package '
                    . q{'} . $type . q{()'} . ', wrong number of arguments found, must be exactly 1 non-empty hashref, only ' . q{'host'} . ' key with ' . q{'mongodb://HOST:PORT'} . ' value currently supported, dying' ) . "\n";
            }

            elsif ((not defined $properties_init->{children}->[1]->{children}->[0]) or
                ((ref $properties_init->{children}->[1]->{children}->[0]) ne 'VarOrLitOrOpStrOrWord_251')) {
                die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP97d, CODE GENERATOR, ABSTRACT SYNTAX TO C++: In constructor call for package '
                    . q{'} . $type . q{()'} . ', invalid or no arguments found, must be exactly 1 non-empty hashref, only ' . q{'host'} . ' key with ' . q{'mongodb://HOST:PORT'} . ' value currently supported, dying' ) . "\n";
            }
            elsif ((not exists $properties_init->{children}->[1]->{children}->[0]->{children}) or
                (not defined $properties_init->{children}->[1]->{children}->[0]->{children}) or
                ((scalar @{$properties_init->{children}->[1]->{children}->[0]->{children}}) != 1)) {
                die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP98d, CODE GENERATOR, ABSTRACT SYNTAX TO C++: In constructor call for package '
                    . q{'} . $type . q{()'} . ', wrong number of arguments found, must be exactly 1 non-empty hashref, only ' . q{'host'} . ' key with ' . q{'mongodb://HOST:PORT'} . ' value currently supported, dying' ) . "\n";
            }

            elsif ((not defined $properties_init->{children}->[1]->{children}->[0]->{children}->[0]) or
                ((ref $properties_init->{children}->[1]->{children}->[0]->{children}->[0]) ne 'OpStringOrWord_278')) {
                die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP97e, CODE GENERATOR, ABSTRACT SYNTAX TO C++: In constructor call for package '
                    . q{'} . $type . q{()'} . ', invalid or no arguments found, must be exactly 1 non-empty hashref, only ' . q{'host'} . ' key with ' . q{'mongodb://HOST:PORT'} . ' value currently supported, dying' ) . "\n";
            }
            elsif ((not exists $properties_init->{children}->[1]->{children}->[0]->{children}->[0]->{children}) or
                (not defined $properties_init->{children}->[1]->{children}->[0]->{children}->[0]->{children}) or
                ((scalar @{$properties_init->{children}->[1]->{children}->[0]->{children}->[0]->{children}}) != 1)) {
                die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP98e, CODE GENERATOR, ABSTRACT SYNTAX TO C++: In constructor call for package '
                    . q{'} . $type . q{()'} . ', wrong number of arguments found, must be exactly 1 non-empty hashref, only ' . q{'host'} . ' key with ' . q{'mongodb://HOST:PORT'} . ' value currently supported, dying' ) . "\n";
            }

            elsif ((not defined $properties_init->{children}->[1]->{children}->[0]->{children}->[0]->{children}->[0]) or
                ($properties_init->{children}->[1]->{children}->[0]->{children}->[0]->{children}->[0] ne 'host')) {
                die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP97f, CODE GENERATOR, ABSTRACT SYNTAX TO C++: In constructor call for package '
                    . q{'} . $type . q{()'} . ', invalid or no arguments found, must be exactly 1 non-empty hashref, only ' . q{'host'} . ' key with ' . q{'mongodb://HOST:PORT'} . ' value currently supported, dying' ) . "\n";
            }

            elsif ((not defined $properties_init->{children}->[1]->{children}->[3]) or
                ((ref $properties_init->{children}->[1]->{children}->[3]) ne 'SubExpression_157')) {
#                RPerl::diag( 'in ConstructorCall->ast_to_cpp__generate__CPPOPS_CPPTYPES(), MongoDB constructor, have $properties_init->{children}->[1]->{children}->[3] = ' . "\n" . RPerl::Parser::rperl_ast__dump($properties_init->{children}->[1]->{children}->[3]) . "\n" );
                die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP97g, CODE GENERATOR, ABSTRACT SYNTAX TO C++: In constructor call for package '
                    . q{'} . $type . q{()'} . ', invalid or no arguments found, must be exactly 1 non-empty hashref, only ' . q{'host'} . ' key with ' . q{'mongodb://HOST:PORT'} . ' value currently supported, dying' ) . "\n";
            }
            elsif ((not exists $properties_init->{children}->[1]->{children}->[3]->{children}) or
                (not defined $properties_init->{children}->[1]->{children}->[3]->{children}) or
                ((scalar @{$properties_init->{children}->[1]->{children}->[3]->{children}}) != 1)) {
                die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP98g, CODE GENERATOR, ABSTRACT SYNTAX TO C++: In constructor call for package '
                    . q{'} . $type . q{()'} . ', wrong number of arguments found, must be exactly 1 non-empty hashref, only ' . q{'host'} . ' key with ' . q{'mongodb://HOST:PORT'} . ' value currently supported, dying' ) . "\n";
            }

            elsif ((not defined $properties_init->{children}->[1]->{children}->[3]->{children}->[0]) or
                ((ref $properties_init->{children}->[1]->{children}->[3]->{children}->[0]) ne 'Literal_255')) {
                die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP97h, CODE GENERATOR, ABSTRACT SYNTAX TO C++: In constructor call for package '
                    . q{'} . $type . q{()'} . ', invalid or no arguments found, must be exactly 1 non-empty hashref, only ' . q{'host'} . ' key with ' . q{'mongodb://HOST:PORT'} . ' value currently supported, dying' ) . "\n";
            }
            elsif ((not exists $properties_init->{children}->[1]->{children}->[3]->{children}->[0]->{children}) or
                (not defined $properties_init->{children}->[1]->{children}->[3]->{children}->[0]->{children}) or
                ((scalar @{$properties_init->{children}->[1]->{children}->[3]->{children}->[0]->{children}}) != 1)) {
                die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP98h, CODE GENERATOR, ABSTRACT SYNTAX TO C++: In constructor call for package '
                    . q{'} . $type . q{()'} . ', wrong number of arguments found, must be exactly 1 non-empty hashref, only ' . q{'host'} . ' key with ' . q{'mongodb://HOST:PORT'} . ' value currently supported, dying' ) . "\n";
            }

            elsif ((not defined $properties_init->{children}->[1]->{children}->[3]->{children}->[0]->{children}->[0]) or
                (
                    ((substr $properties_init->{children}->[1]->{children}->[3]->{children}->[0]->{children}->[0], 1, 10) ne q{mongodb://}) and
                    ((substr $properties_init->{children}->[1]->{children}->[3]->{children}->[0]->{children}->[0], 2, 10) ne q{mongodb://}) 
                ) ) {
#                RPerl::diag( 'in ConstructorCall->ast_to_cpp__generate__CPPOPS_CPPTYPES(), MongoDB constructor, have $properties_init->{children}->[1]->{children}->[3]->{children}->[0]->{children}->[0] = ' . "\n" . RPerl::Parser::rperl_ast__dump($properties_init->{children}->[1]->{children}->[3]->{children}->[0]->{children}->[0]) . "\n" );
                die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP97i, CODE GENERATOR, ABSTRACT SYNTAX TO C++: In constructor call for package '
                    . q{'} . $type . q{()'} . ', invalid or no arguments found, must be exactly 1 non-empty hashref, only ' . q{'host'} . ' key with ' . q{'mongodb://HOST:PORT'} . ' value currently supported, dying' ) . "\n";
            }

            $mongodb_host = $properties_init->{children}->[1]->{children}->[3]->{children}->[0]->{children}->[0];

            # trim leading & trailing quotation marks
            if ((substr $mongodb_host, 0, 1) eq q{'} ) {
                substr $mongodb_host, 0, 1, q{};
                substr $mongodb_host, -1, 1, q{};
            }
            elsif ((substr $mongodb_host, 0, 1) eq 'q' ) {
                substr $mongodb_host, 0, 2, q{};
                substr $mongodb_host, -1, 1, q{};
            }
            else {
                die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP97j, CODE GENERATOR, ABSTRACT SYNTAX TO C++: In constructor call for package '
                    . q{'} . $type . q{()'} . ', invalid or no arguments found, must be exactly 1 non-empty hashref, only ' . q{'host'} . ' key with ' . q{'mongodb://HOST:PORT'} . ' value currently supported, dying' ) . "\n";
            }
        }
        # default host & port
        else {
            $mongodb_host = 'mongodb://localhost:27017';
        }
        
        $cpp_source_group->{CPP} .= '{mongodb_host{"' . $mongodb_host . '"}}';
    }
    # constructor call with properties to initialize
    elsif ( defined $properties_init_optional->{children}->[0] ) {
        $properties_init_optional = $properties_init_optional->{children}->[0];  # unwrap hashref object
#        RPerl::diag( 'in ConstructorCall->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have unwrapped $properties_init_optional = ' . "\n" . RPerl::Parser::rperl_ast__dump($properties_init_optional) . "\n" );

        my object $property_0 = $properties_init_optional->{children}->[1];
#        RPerl::diag( 'in ConstructorCall->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $property_0 = ' . "\n" . RPerl::Parser::rperl_ast__dump($property_0) . "\n" );

        if ( ( ref $property_0 ) ne 'HashEntry_224' ) {
            die RPerl::Parser::rperl_rule__replace(
                'ERROR ECOGEASCP36, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule ' . ( ref $property_0 ) . ' found where HashEntry_224 expected, object property value initialization hashref must contain normal key/value pairs only, dying' ) . "\n";
        }

        $cpp_source_subgroup = $self->ast_to_cpp__generate__CPPOPS_CPPTYPES__property_init($modes, $property_0);
#        RPerl::diag( 'in ConstructorCall->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $cpp_source_subgroup from $property_0 = ' . "\n" . RPerl::Parser::rperl_ast__dump($cpp_source_subgroup) . "\n" );
#        $cpp_source_group->{CPP} .= 'NEW_' . $type_cpp . '{}.' . $cpp_source_subgroup->{CPP_name} . '(' . $cpp_source_subgroup->{CPP_value} . ')';  # this should work except for AStyle bug
        $cpp_source_group->{CPP} .= '(NEW_' . $type_cpp . '{}).' . $cpp_source_subgroup->{CPP_name} . '(' . $cpp_source_subgroup->{CPP_value} . ')';  # NEED FIX: extraneous parentheses required due to AStyle bug    https://sourceforge.net/p/astyle/bugs/468/

        my object $properties = $properties_init_optional->{children}->[2];
#        RPerl::diag( 'in ConstructorCall->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $properties = ' . "\n" . RPerl::Parser::rperl_ast__dump($properties) . "\n" );
        if (defined $properties->{children}->[0]) {
            foreach my object $property (@{$properties->{children}}) {
#                RPerl::diag( 'in ConstructorCall->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $property = ' . "\n" . RPerl::Parser::rperl_ast__dump($property) . "\n" );
                if ((exists $property->{attr}) and (defined $property->{attr}) and ($property->{attr} eq ',')) {
                    next;  # skip commas, they are not properties!
                }
                $cpp_source_subgroup = $self->ast_to_cpp__generate__CPPOPS_CPPTYPES__property_init($modes, $property);
#                RPerl::diag( 'in ConstructorCall->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $cpp_source_subgroup from $property = ' . "\n" . RPerl::Parser::rperl_ast__dump($cpp_source_subgroup) . "\n" );
                $cpp_source_group->{CPP} .= '.' . $cpp_source_subgroup->{CPP_name} . '(' . $cpp_source_subgroup->{CPP_value} . ')';
            }
        }

        $cpp_source_group->{CPP} .= '.NEW()';
    }
    # constructor call without properties to initialize
    else {
        $cpp_source_group->{CPP} .= 'new ' . $type_cpp;
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
