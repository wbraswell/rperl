# [[[ HEADER ]]]
package RPerl::Operation::Statement::OperatorVoid::Print;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.004_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Statement::OperatorVoid);
use RPerl::Operation::Statement::OperatorVoid;

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

    #    RPerl::diag( 'in OperatorVoid::Print->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;
    if ( $self_class eq 'OperatorVoid_118' ) {    # OperatorVoid -> OP01_PRINT OPTIONAL-31 ListElements ';'
        my string $print                  = $self->{children}->[0];
        my object $stdout_stderr_optional = $self->{children}->[1];
        my object $list_elements          = $self->{children}->[2];
        my string $semicolon              = $self->{children}->[3];

#        RPerl::diag( 'in OperatorVoid::Print->ast_to_rperl__generate(), have $stdout_stderr_optional = ' . "\n" . RPerl::Parser::rperl_ast__dump($stdout_stderr_optional) . "\n" );

        $rperl_source_group->{PMC} .= $print . q{ };

        if ( exists $stdout_stderr_optional->{children}->[0] ) {
            if ( ( $stdout_stderr_optional->{children}->[0]->{attr} ne '{*STDOUT}' ) and ( $stdout_stderr_optional->{children}->[0]->{attr} ne '{*STDERR}' ) ) {
                die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP28, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: output stream '
                        . $stdout_stderr_optional->{children}->[0]->{attr}
                        . ' found where {*STDOUT} or {*STDERR} expected, dying' )
                    . "\n";
            }

# DEV NOTE: STDOUT & STDERR are generated below, they are only grammar tokens, not grammar rules, so they do not get their own classes, the following do not exist:
# RPerl::InputOutput::Stderr & RPerl::InputOutput::Stdout
            $rperl_source_group->{PMC} .= $stdout_stderr_optional->{children}->[0]->{attr} . q{ };
        }

        $rperl_source_subgroup = $list_elements->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= $semicolon . "\n";
    }
    elsif ( $self_class eq 'OperatorVoid_119' ) {    # OperatorVoid -> OP01_PRINT FHREF_SYMBOL_BRACES ListElements ';'
        my string $print               = $self->{children}->[0];
        my string $fhref_symbol_braces = $self->{children}->[1];
        my object $list_elements       = $self->{children}->[2];
        my string $semicolon           = $self->{children}->[3];

        $rperl_source_group->{PMC} .= $print . q{ } . $fhref_symbol_braces . q{ };
        $rperl_source_subgroup = $list_elements->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= $semicolon . "\n";
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . $self_class
                . ' found where OperatorVoid_118 or OperatorVoid_119 expected, dying' )
            . "\n";
    }

    return $rperl_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::O::S::OV::P __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{} };
    my string_hashref $cpp_source_subgroup;

 #    RPerl::diag( 'in OperatorVoid::Print->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    # NEED FIX PARALLEL: temporarily disabled print operators while inside parallel loop to avoid pluto polycc error
    if ($modes->{_inside_parallel_loop}) {
        return $cpp_source_group;
    }

    my string $self_class = ref $self;
    if ( $self_class eq 'OperatorVoid_118' ) {    # OperatorVoid -> OP01_PRINT OPTIONAL-31 ListElements ';'
        my object $stdout_stderr_optional = $self->{children}->[1];
        my object $list_elements          = $self->{children}->[2];
        my string $semicolon              = $self->{children}->[3];

#        RPerl::diag( 'in OperatorVoid::Print->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $stdout_stderr_optional = ' . "\n" . RPerl::Parser::rperl_ast__dump($stdout_stderr_optional) . "\n" );
#        RPerl::diag( 'in OperatorVoid::Print->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $list_elements = ' . "\n" . RPerl::Parser::rperl_ast__dump($list_elements) . "\n" );

        if ( exists $stdout_stderr_optional->{children}->[0] ) {
            if ( $stdout_stderr_optional->{children}->[0]->{attr} eq '{*STDOUT}' ) {
                # DEV NOTE, CORRELATION #rp100: C++ cout w/ double-less-than << input list separators is equivalent to Perl print w/ comma separators
#                $cpp_source_group->{CPP} .= 'cout << ';
                $cpp_source_group->{CPP} .= 'print ';
            }
            elsif ( $stdout_stderr_optional->{children}->[0]->{attr} eq '{*STDERR}' ) {
                # DEV NOTE, CORRELATION #rp101: C++ cerr w/ double-less-than << input list separators is equivalent to Perl print {*STDERR} w/ comma separators
#                $cpp_source_group->{CPP} .= 'cerr << ';
                $cpp_source_group->{CPP} .= 'prerr ';
            }
            else {
                die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP28, CODE GENERATOR, ABSTRACT SYNTAX TO C++: output stream '
                        . $stdout_stderr_optional->{children}->[0]->{attr}
                        . ' found where {*STDOUT} or {*STDERR} expected, dying' )
                    . "\n";
            }
        }
        else {
#            $cpp_source_group->{CPP} .= 'cout << ';
            $cpp_source_group->{CPP} .= 'print ';
        }

# DEV NOTE: always use endl instead of "\n" for cout, because Perl immediately flushes buffers on STDOUT newline characters
# http://perl.plover.com/FAQs/Buffering.html
# When a filehandle is attached to the terminal, as STDOUT is here, it is in line buffered mode by default.
# A filehandle in line buffered mode has two special properties: It's flushed automatically whenever you print a newline character to it,
# and it's flushed automatically whenever you read from the terminal.

        # save to stack of saved flags, when needed
        if ((exists $modes->{_inside_print_operator}) and (defined $modes->{_inside_print_operator})) {
            if ((not exists $modes->{_inside_print_operator_saved}) or (not defined $modes->{_inside_print_operator_saved})) {
                $modes->{_inside_print_operator_saved} = [];
            }
            push @{$modes->{_inside_print_operator_saved}}, $modes->{_inside_print_operator};
        }
        $modes->{_inside_print_operator} = 1;

        $cpp_source_subgroup = $list_elements->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
        # replace closing "\n" with endl
        if ((substr $cpp_source_group->{CPP}, -4, 4) eq q{"\n"}) { 
#        if (0) {
            substr $cpp_source_group->{CPP}, -4, 4, q{};
            $cpp_source_group->{CPP} .= 'endl';
        }
        $cpp_source_group->{CPP} .= $semicolon . "\n";

        # restore from stack of saved flags, when needed
        delete $modes->{_inside_print_operator};
        if ((exists $modes->{_inside_print_operator_saved}) and (defined $modes->{_inside_print_operator_saved}) and (scalar $modes->{_inside_print_operator_saved})) {
            $modes->{_inside_print_operator} = pop @{$modes->{_inside_print_operator_saved}};
            if (not scalar $modes->{_inside_print_operator_saved}) { delete $modes->{_inside_print_operator_saved}; }
        }
    }
    elsif ( $self_class eq 'OperatorVoid_119' ) {    # OperatorVoid -> OP01_PRINT FHREF_SYMBOL_BRACES ListElements ';'
        $cpp_source_group->{CPP} .= '// <<< RP::O::S::OV::P __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>' . "\n";
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule '
                . $self_class
                . ' found where OperatorVoid_118 or OperatorVoid_119 expected, dying' )
            . "\n";
    }

#    RPerl::diag( 'in OperatorVoid::Print->ast_to_cpp__generate__CPPOPS_CPPTYPES(), about to return $cpp_source_group = ' . "\n" . RPerl::Parser::rperl_ast__dump($cpp_source_group) . "\n" );
    return $cpp_source_group;
};

1;    # end of class
