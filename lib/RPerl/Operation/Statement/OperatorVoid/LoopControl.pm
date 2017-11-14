# [[[ HEADER ]]]
package RPerl::Operation::Statement::OperatorVoid::LoopControl;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Statement::OperatorVoid);
use RPerl::Operation::Statement::OperatorVoid;

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

#    RPerl::diag( 'in OperatorVoid::LoopControl->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;
    if ( $self_class eq 'OperatorVoid_141' ) { # OperatorVoid -> OP19_LOOP_CONTROL_SCOLON
        if (($self->{children}->[0] ne 'next;') and ($self->{children}->[0] ne 'last;')) {
            die RPerl::Parser::rperl_rule__replace(
                'ERROR ECOGEASRP26, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: loop control operator '
                    . $self->{children}->[0]
                    . ' found where next; or last; expected, dying'
            ) . "\n";
        }
        $rperl_source_group->{PMC} .= $self->{children}->[0] . "\n";
    }
    elsif ( $self_class eq 'OperatorVoid_142' ) { # OperatorVoid -> OP19_LOOP_CONTROL LoopLabel ';'
        my string $loop_control = $self->{children}->[0];
        my string $loop_label   = $self->{children}->[1]->{children}->[0];
        my string $semicolon    = $self->{children}->[2];
        $rperl_source_group->{PMC} .= $loop_control . q{ } . $loop_label . $semicolon . "\n";
 
 
 
        if (($loop_control !~ /^next/xms) and ($loop_control !~ /^last/xms) and ($loop_control !~ /^redo/xms)) {
            die RPerl::Parser::rperl_rule__replace(
                'ERROR ECOGEASCP27, CODE GENERATOR, ABSTRACT SYNTAX TO C++: loop control operator '
                    . $loop_control
                    . ' found where next, last, or redo expected, dying'
            ) . "\n";
        }
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . $self_class
                . ' found where OperatorVoid_141 or OperatorVoid_142 expected, dying'
        ) . "\n";
    }
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group
        = { CPP =>
            q{// <<< RP::O::S::OV::LC __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n" };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{} };
    my string_hashref $cpp_source_subgroup;

#    RPerl::diag( 'in OperatorVoid::LoopControl->$ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;
    if ( $self_class eq 'OperatorVoid_141' ) { # OperatorVoid -> OP19_LOOP_CONTROL_SCOLON
        if ($self->{children}->[0] eq 'next;') {
            $cpp_source_group->{CPP} .= 'continue;' . "\n";
        }
        elsif ($self->{children}->[0] eq 'last;') {
            $cpp_source_group->{CPP} .= 'break;' . "\n";
        }
        else {
            die RPerl::Parser::rperl_rule__replace(
                'ERROR ECOGEASCP26, CODE GENERATOR, ABSTRACT SYNTAX TO C++: loop control operator '
                    . $self->{children}->[0]
                    . ' found where next; or last; expected, dying'
            ) . "\n";
        }
    }
    elsif ( $self_class eq 'OperatorVoid_142' ) { # OperatorVoid -> OP19_LOOP_CONTROL LoopLabel ';'
        my string $loop_control = $self->{children}->[0];
        my string $loop_label   = $self->{children}->[1]->{children}->[0];
        my string $semicolon    = $self->{children}->[2];
        if ($loop_control =~ /^next/xms) {
            $cpp_source_group->{CPP} .= 'goto ' . $loop_label . '_NEXT' . $semicolon . "\n";
        }
        elsif ($loop_control =~ /^last/xms) {
            $cpp_source_group->{CPP} .= 'goto ' . $loop_label . '_LAST' . $semicolon . "\n";
        }
        elsif ($loop_control =~ /^redo/xms) {
            $cpp_source_group->{CPP} .= 'goto ' . $loop_label . '_REDO' . $semicolon . "\n";
        }
        else {
            die RPerl::Parser::rperl_rule__replace(
                'ERROR ECOGEASCP27, CODE GENERATOR, ABSTRACT SYNTAX TO C++: loop control operator '
                    . $loop_control
                    . ' found where next, last, or redo expected, dying'
            ) . "\n";
        }
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                . $self_class
                . ' found where OperatorVoid_141 or OperatorVoid_142 expected, dying'
        ) . "\n";
    }
    return $cpp_source_group;
}

1;    # end of class
