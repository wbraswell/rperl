# [[[ HEADER ]]]
package RPerl::DataType::TypeInner;
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

sub ast_to_rperl__generate {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $rperl_source_group = { PMC => q{} };

#    RPerl::diag( 'in TypeInner->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;
    if ( $self_class eq 'TypeInner_243' ) {  # TypeInner -> MY Type '$TYPED_' OpStringOrWord OP19_VARIABLE_ASSIGN
        my string $my = $self->{children}->[0];
        my string $type = $self->{children}->[1]->{children}->[0];
        my string $TYPED = $self->{children}->[2];
        my string $name  = $self->{children}->[3]->{children}->[0];

#        RPerl::diag( 'in TypeInner->ast_to_rperl__generate(), have $name = ' . "\n" . RPerl::Parser::rperl_ast__dump($name) . "\n" );
        
        $name =~ s/^(\w+)\s*$/$1/gxms;  # strip trailing whitespace, caused by grammar matching operator names with trailing spaces
        if ($name !~ /^[a-z]/) {
            die 'ERROR ECOGEASRP025, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: invalid redundant name ' . q{'}
                . $name . q{'}
                . ' does not start with a lowercase letter a-z, dying' . "\n";
        }
        my string $equal = $self->{children}->[4];

        $rperl_source_group->{PMC} .= $my . q{ } . $type . q{ } . $TYPED . $name . q{ } . $equal . q{ };
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP000, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . $self_class
                . ' found where TypeInner_243 expected, dying'
        ) . "\n";
    }
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group
        = { CPP => q{// <<< RP::DT::TI __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = {};

#    RPerl::diag( 'in TypeInner->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;
    if ( $self_class eq 'TypeInner_243' ) {  # TypeInner -> MY Type '$TYPED_' WORD OP19_VARIABLE_ASSIGN
        my string $type = $self->{children}->[1]->{children}->[0];
        my string $name  = $self->{children}->[3]->{children}->[0];
        $name =~ s/^(\w+)\s*$/$1/gxms;  # strip trailing whitespace, caused by grammar matching operator names with trailing spaces
        if ($name !~ /^[a-z]/) {
            die 'ERROR ECOGEASCP025, CODE GENERATOR, ABSTRACT SYNTAX TO C++: invalid redundant name ' . q{'}
                . $name . q{'}
                . ' does not start with a lowercase letter a-z, dying' . "\n";
        }

        $type = RPerl::Generator::type_convert_perl_to_cpp($type, 1);  # $pointerify_classes = 1
        $cpp_source_group->{CPP} = $type;
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASCP000, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                . $self_class
                . ' found where TypeInner_243 expected, dying'
        ) . "\n";
    }
    return $cpp_source_group;
}

1;    # end of class
