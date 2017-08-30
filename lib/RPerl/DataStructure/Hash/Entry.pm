# [[[ HEADER ]]]
package RPerl::DataStructure::Hash::Entry;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_600;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::GrammarRule);
use RPerl::GrammarRule;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

our string_hashref::method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };
    my string_hashref $rperl_source_subgroup;

    #    RPerl::diag( 'in Hash::Entry->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;
    if ( $self_class eq 'HashEntry_206' ) {    # HashEntry -> VarOrLitOrOpStrOrWord OP20_HASH_FATARROW OPTIONAL-48 SubExpression
        my string $key                 = $self->{children}->[0];
        my string $key_class           = ref $key;
        my string $fat_arrow           = $self->{children}->[1];
        my object $type_inner_optional = $self->{children}->[2];
        my string $key_name            = undef;

        if (   ( $key_class eq 'VarOrLitOrOpStrOrWord_231' )
            or ( $key_class eq 'VarOrLitOrOpStrOrWord_232' ) )
        {                                      # Variable or Literal
            $rperl_source_subgroup = $key->ast_to_rperl__generate($modes);
            RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        }
        elsif ( $key_class eq 'VarOrLitOrOpStrOrWord_233' ) {    # OpStringOrWord
            $key_name = $key->{children}->[0]->{children}->[0];
            $key_name =~ s/^(\w+)\s*$/$1/gxms;  # strip trailing whitespace, caused by grammar matching operator names with trailing spaces
            if ($key_name !~ /^[a-z]/) {
                die 'ERROR ECOGEASRP23, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: invalid hash key ' . q{'}
                    . $key_name . q{'}
                    . ' does not start with a lowercase letter a-z, dying' . "\n";
            }
            $rperl_source_group->{PMC} .= $key_name . q{ };
        }
        else {
            die RPerl::Parser::rperl_rule__replace( q{ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '}
                    . ($key_class)
                    . q{' found where VarOrLitOrOpStrOrWord_231, VarOrLitOrOpStrOrWord_232, or VarOrLitOrOpStrOrWord_233 expected, dying} )
                . "\n";
        }

        if ( ( exists $type_inner_optional->{children}->[0] ) and ( defined $key_name ) ) {
            my string $type_inner_name = $type_inner_optional->{children}->[0]->{children}->[3]->{children}->[0];
            $type_inner_name =~ s/^(\w+)\s*$/$1/gxms;  # strip trailing whitespace, caused by grammar matching operator names with trailing spaces
            if ( $type_inner_name !~ /$key_name$/xms ) {
                die 'ERROR ECOGEASRP22, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: redundant name mismatch, inner type name ' . q{'}
                    . $type_inner_name . q{'}
                    . ' does not end with OO properties or hash key ' . q{'}
                    . $key_name . q{'}
                    . ', dying' . "\n";
            }
        }

        $rperl_source_group->{PMC} .= $fat_arrow . q{ };

        if ( exists $type_inner_optional->{children}->[0] ) {
            $rperl_source_subgroup = $type_inner_optional->{children}->[0]->ast_to_rperl__generate($modes);
            RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        }

        my object $subexpression = $self->{children}->[3];

        $rperl_source_subgroup = $subexpression->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }
    elsif ( $self_class eq 'HashEntry_208' ) {    # HashEntry -> ENV
        my string $env = $self->{children}->[0];
        $rperl_source_group->{PMC} .= $env . "\n";
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . $self_class
                . ' found where HashEntry_206 or HashEntry_208 expected, dying' )
            . "\n";
    }

    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::DS::H::E __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{} };
    my string_hashref $cpp_source_subgroup;

    #    RPerl::diag( 'in Hash::Entry->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;
    if ( $self_class eq 'HashEntry_206' ) {    # HashEntry -> VarOrLitOrOpStrOrWord OP20_HASH_FATARROW OPTIONAL-48 SubExpression

        my string $key                 = $self->{children}->[0];
        my string $key_class           = ref $key;
        my object $type_inner_optional = $self->{children}->[2];
        my string $key_name            = undef;

        $cpp_source_group->{CPP} .= '{';

        if (   ( $key_class eq 'VarOrLitOrOpStrOrWord_231' )
            or ( $key_class eq 'VarOrLitOrOpStrOrWord_232' ) )
        {                                      # Variable or Literal
            $cpp_source_subgroup = $key->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
        }
        elsif ( $key_class eq 'VarOrLitOrOpStrOrWord_233' ) {    # OpStringOrWord
            $key_name = $key->{children}->[0]->{children}->[0];
            $key_name =~ s/^(\w+)\s*$/$1/gxms;  # strip trailing whitespace, caused by grammar matching operator names with trailing spaces
            if ($key_name !~ /^[a-z]/) {
                die 'ERROR ECOGEASCP23, CODE GENERATOR, ABSTRACT SYNTAX TO C++: invalid hash key ' . q{'}
                    . $key_name . q{'}
                    . ' does not start with a lowercase letter a-z, dying' . "\n";
            }
            $cpp_source_group->{CPP} .= q{"} . $key_name . q{" };
        }
        else {
            die RPerl::Parser::rperl_rule__replace( q{ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '}
                    . ($key_class)
                    . q{' found where VarOrLitOrOpStrOrWord_231, VarOrLitOrOpStrOrWord_232, or VarOrLitOrOpStrOrWord_233 expected, dying} )
                . "\n";
        }

        if ( ( exists $type_inner_optional->{children}->[0] ) and ( defined $key_name ) ) {
            my string $type_inner_name = $type_inner_optional->{children}->[0]->{children}->[3]->{children}->[0];
            $type_inner_name =~ s/^(\w+)\s*$/$1/gxms;  # strip trailing whitespace, caused by grammar matching operator names with trailing spaces
            if ( $type_inner_name !~ /$key_name$/xms ) {
                die 'ERROR ECOGEASCP22, CODE GENERATOR, ABSTRACT SYNTAX TO C++: redundant name mismatch, inner type name ' . q{'}
                    . $type_inner_name . q{'}
                    . ' does not end with OO properties or hash key ' . q{'}
                    . $key_name . q{'}
                    . ', dying' . "\n";
            }
        }

        $cpp_source_group->{CPP} .= q{, };

        my object $subexpression = $self->{children}->[3];

        $cpp_source_subgroup = $subexpression->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );

        $cpp_source_group->{CPP} .= '}';
    }
    elsif ( $self_class eq 'HashEntry_208' ) {    # HashEntry -> ENV
        my string $env = $self->{children}->[0];
        $cpp_source_group->{CPP} .= q{// <<< RP::DS::H::E __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>} . "\n";
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                . $self_class
                . ' found where HashEntry_206 or HashEntry_208 expected, dying' )
            . "\n";
    }

    return $cpp_source_group;
};

1;    # end of class
