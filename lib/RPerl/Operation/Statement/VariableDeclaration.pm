# [[[ HEADER ]]]
package RPerl::Operation::Statement::VariableDeclaration;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Statement);

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
    my string $self_class = ref $self;

#    RPerl::diag( 'in VariableDeclaration->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

# unwrap VariableDeclaration_170, VariableDeclaration_171, and VariableDeclaration_172 from Statement_146
    if ( $self_class eq 'Statement_146' ) {   # Statement -> VariableDeclaration
        $self = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( $self_class eq 'VariableDeclaration_170' ) { # VariableDeclaration -> MY Type VARIABLE_SYMBOL ';'
        my string $my        = $self->{children}->[0];
        my string $type      = $self->{children}->[1]->{children}->[0];
        my string $symbol    = $self->{children}->[2];
        my string $semicolon = $self->{children}->[3];
        $rperl_source_group->{PMC}
            .= $my . q{ } . $type . q{ } . $symbol . $semicolon . "\n";
    }
    elsif ( $self_class eq 'VariableDeclaration_171' ) { # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpressionOrStdin ';'
        my string $my     = $self->{children}->[0];
        my string $type   = $self->{children}->[1]->{children}->[0];
        my string $symbol = $self->{children}->[2];
        my string $equal  = $self->{children}->[3];
        my object $subexpression_or_stdin = $self->{children}->[4];
        my string $semicolon              = $self->{children}->[5];

        $rperl_source_group->{PMC}
            .= $my . q{ } . $type . q{ } . $symbol . q{ } . $equal;
        $rperl_source_subgroup
            = $subexpression_or_stdin->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= $semicolon . "\n";
    }
    elsif ( $self_class eq 'VariableDeclaration_172' ) { # VariableDeclaration -> MY TYPE_FHREF FHREF_SYMBOL ';'
        my string $my           = $self->{children}->[0];
        my string $type_fhref   = $self->{children}->[1];
        my string $fhref_symbol = $self->{children}->[2];
        my string $semicolon    = $self->{children}->[3];
        $rperl_source_group->{PMC}
            .= $my . q{ }
            . $type_fhref . q{ }
            . $fhref_symbol
            . $semicolon . "\n";
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . $self_class
                . ' found where VariableDeclaration_170, VariableDeclaration_171, or VariableDeclaration_172 expected, dying'
        ) . "\n";
    }

    return $rperl_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group
        = {
        CPP => q{// <<< RP::O::S::VD __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n"
        };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{} };
    my string_hashref $cpp_source_subgroup;
    my string $self_class = ref $self;

#    RPerl::diag( 'in VariableDeclaration->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

# unwrap VariableDeclaration_170, VariableDeclaration_171, and VariableDeclaration_172 from Statement_146
    if ( $self_class eq 'Statement_146' ) {   # Statement -> VariableDeclaration
        $self = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( $self_class eq 'VariableDeclaration_170' ) { # VariableDeclaration -> MY Type VARIABLE_SYMBOL ';'
        my string $type      = $self->{children}->[1]->{children}->[0];
        my string $symbol    = $self->{children}->[2];
        $cpp_source_group->{CPP}
            .= $type . q{ } . (substr $symbol, 1) . ';' . "\n";
    }
    elsif ( $self_class eq 'VariableDeclaration_171' ) { # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpressionOrStdin ';'
        my string $type   = $self->{children}->[1]->{children}->[0];
        my string $symbol = $self->{children}->[2];
        my object $subexpression_or_stdin = $self->{children}->[4];

        $cpp_source_group->{CPP}
            .= $type . q{ } . (substr $symbol, 1) . q{ = };
        $cpp_source_subgroup
            = $subexpression_or_stdin->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group,
            $cpp_source_subgroup );
        $cpp_source_group->{CPP} .= ';' . "\n";
    }
    elsif ( $self_class eq 'VariableDeclaration_172' ) { # VariableDeclaration -> MY TYPE_FHREF FHREF_SYMBOL ';'
        my string $type_fhref   = $self->{children}->[1];
        my string $fhref_symbol = $self->{children}->[2];
        $cpp_source_group->{CPP} .= $type_fhref . q{ } . (substr $fhref_symbol, 1) . ';' . "\n";
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: grammar rule '
                . $self_class
                . ' found where VariableDeclaration_170, VariableDeclaration_171, or VariableDeclaration_172 expected, dying'
        ) . "\n";
    }

    return $cpp_source_group;
};

1;    # end of class
