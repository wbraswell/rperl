package RPerl::Parser;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.003_011;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values and print operator
## no critic qw(ProhibitBacktickOperators)  ## SYSTEM SPECIAL 11: allow system command execution

# [[[ SETUP ]]]
#use RPerl::CompileUnit::Module::Class;
#use parent ('RPerl::CompileUnit::Module::Class');

use Perl::Critic;
use RPerl::Grammar;

# [[[ PROCEDURAL SUBROUTINES ]]]

# Parse from Human-Readable RPerl Source Code File to PPI-Parsed RPerl AST Object
our object $rperl_to_ast__parse = sub {
    ( my string $rperl_source__file_name) = @_;

    # [[[ CHECK PERL SYNTAX ]]]
    # [[[ CHECK PERL SYNTAX ]]]
    # [[[ CHECK PERL SYNTAX ]]]

    rperl_source__check_syntax($rperl_source__file_name);

    # [[[ CRITICIZE PERL SYNTAX ]]]
    # [[[ CRITICIZE PERL SYNTAX ]]]
    # [[[ CRITICIZE PERL SYNTAX ]]]

    rperl_source__criticize($rperl_source__file_name);

    # [[[ PARSE RPERL SYNTAX ]]]
    # [[[ PARSE RPERL SYNTAX ]]]
    # [[[ PARSE RPERL SYNTAX ]]]

    return ( rperl_source__parse($rperl_source__file_name) );
};

# Check Perl Syntax Using Perl Interpreter
our void $rperl_source__check_syntax = sub {
    ( my string $rperl_source__file_name) = @_;

    my string $rperl_source__perl_syntax_command
        = q{perl -Iblib/lib -M'warnings FATAL=>q(all)' -cW }
        . $rperl_source__file_name;
    my string $rperl_source__perl_syntax_command__no_output
        = $rperl_source__perl_syntax_command . ' > /dev/null 2> /dev/null';
    my string $rperl_source__perl_syntax_command__all_output
        = $rperl_source__perl_syntax_command . ' 2>&1';

#my string $rperl_source__perl_syntax_command = q{perl -Iblib/lib -cW } . $rperl_source__file_name;

    RPerl::diag
        "in rperl_source__check_syntax(), have \$rperl_source__perl_syntax_command =\n$rperl_source__perl_syntax_command\n";

#RPerl::diag "in rperl_source__check_syntax(), have \$rperl_source__perl_syntax_command__no_output =\n$rperl_source__perl_syntax_command__no_output\n\n";
#RPerl::diag "in rperl_source__check_syntax(), have \$rperl_source__perl_syntax_command__all_output =\n$rperl_source__perl_syntax_command__all_output\n\n";

#my integer $rperl_source__perl_syntax_retval = system $rperl_source__perl_syntax_command;
    my integer $rperl_source__perl_syntax_retval
        = system $rperl_source__perl_syntax_command__no_output; # don't want any messages printed here

#my string $rperl_source__perl_syntax_retstring = `echo HOWDY`;
#my string $rperl_source__perl_syntax_retstring = `$rperl_source__perl_syntax_command`;
#my string $rperl_source__perl_syntax_retstring = `$rperl_source__perl_syntax_command__all_output`;

#RPerl::diag "in rperl_source__check_syntax(), have \$rperl_source__perl_syntax_retval = $rperl_source__perl_syntax_retval\n";
#RPerl::diag "in rperl_source__check_syntax(), have \$rperl_source__perl_syntax_retstring =\n$rperl_source__perl_syntax_retstring\n";
#RPerl::diag "in rperl_source__check_syntax(), have \$ERRNO = $ERRNO\n";  # $ERRNO seems to contain random error messages that I can't trace?
#RPerl::diag "in rperl_source__check_syntax(), have \$? = $?\n";

# NEED ADD ERROR CHECKING: ECVPAPL00 FILE DOES NOT EXIST, ECVPAPL01 FILE IS EMPTY

    if ( $rperl_source__perl_syntax_retval != 0 ) {
        croak(
            "\n\nERROR ECVPAPL02, RPERL PARSER, PERL SYNTAX CHECK:\nfile '$rperl_source__file_name' fails perl -cW syntax check with return value "
                . ( $rperl_source__perl_syntax_retval >> 8 )
                . " and the following messages:\n\n"
                . `$rperl_source__perl_syntax_command__all_output`

                #            . $rperl_source__perl_syntax_retstring
                . "\ncroaking"
        );
    }
    else {
        RPerl::diag
            "in rperl_source__check_syntax(), RPerl source code passes perl -cW syntax check\n";
    }
};

# Criticize Perl Syntax Using Perl::Critic
our void $rperl_source__criticize = sub {
    ( my string $rperl_source__file_name) = @_;

# DEV NOTE: disable RequireTidyCode because perltidy may not be stable
#    my object $rperl_source__critic = Perl::Critic->new( -severity => 'brutal' );
#    my object $rperl_source__critic = Perl::Critic->new( -exclude => ['RequireTidyCode'] -severity => 'brutal' );  # DEV NOTE: Perl::Critic's own docs-recommended syntax throws a violation
    my object $rperl_source__critic = Perl::Critic->new(
        '-exclude'  => ['RequireTidyCode'],
        '-severity' => 'brutal'
    );
    my @rperl_source__critic_violations
        = $rperl_source__critic->critique($rperl_source__file_name);

    my integer $rperl_source__critic_num_violations
        = scalar @rperl_source__critic_violations;

#RPerl::diag "in rperl_source__criticize(), have \$rperl_source__critic_num_violations = $rperl_source__critic_num_violations\n";

    my string $rperl_source__critic_dumperified_violations
        = Dumper( \@rperl_source__critic_violations );

#RPerl::diag "in rperl_source__criticize(), have Dumper(\\\@rperl_source__critic_violations) =\n" . $rperl_source__critic_dumperified_violations . "\n";

# NEED ADD ERROR CHECKING: ECVPAPC00 FILE DOES NOT EXIST, ECVPAPC01 FILE IS EMPTY; or would that be redundant with ECVPAPL0x error checking when added above?

    if ( $rperl_source__critic_num_violations > 0 ) {
        croak(
            "\n\nERROR ECVPAPC02, RPERL PARSER, PERL CRITIC VIOLATION:\nfile '$rperl_source__file_name' fails Perl::Critic brutal review with the following violations:\n\n"
                . $rperl_source__critic_dumperified_violations
                . "\ncroaking" );
    }
    else {
        RPerl::diag
            "in rperl_source__criticize(), RPerl source code passes Perl::Critic brutal review\n";
    }
};

# Croak On RPerl Grammar Error
our void $rperl_grammar_error = sub {
    ( my array $argument ) = @_;
    my string $value = $argument->YYCurval;
    if (not(defined($value))) {
        $value = '';
    }

#    croak( "ERROR ECVPARP00, RPERL PARSER, RPERL GRAMMAR VIOLATION: have possible token '$value', croaking\n" );
#    croak( "ERROR ECVPARP00, RPERL PARSER, RPERL GRAMMAR VIOLATION: have possible token '$value', have \$argument =\n" . Dumper($argument) . "\ncroaking\n" );

    my $current_state_num = $argument->{STACK}[-1][0];
    my $current_state = $argument->{STATES}[$current_state_num];
    my $expected_tokens = '';
    foreach my $expected_token (keys %{$current_state->{ACTIONS}}) {
        $expected_tokens .= '    ' . $expected_token . "\n";
    }

    croak( "ERROR ECVPARP00, RPERL PARSER, RPERL GRAMMAR VIOLATION: have possible token '$value', expected one of the following:\n\n" . $expected_tokens . "\ncroaking" );
};

# Parse RPerl Syntax Using Eyapp Grammar
our void $rperl_source__parse = sub {
    ( my string $rperl_source__file_name) = @_;

    my object $eyapp_parser = RPerl::Grammar->new();
    $eyapp_parser->YYSlurpFile($rperl_source__file_name);
    my object $rperl_ast = $eyapp_parser->YYParse(
        yydebug => 0x00,  # disable eyapp DBG DEBUGGING
#        yydebug => 0xFF,  # full eyapp DBG DEBUGGING
        yyerror => $rperl_grammar_error
    );

#    RPerl::diag "in rperl_source__parse(), have \$rperl_ast->str() =\n" . $rperl_ast->str() . "\n\n";
    RPerl::diag "in rperl_source__parse(), have \$rperl_ast =\n"
        . Dumper($rperl_ast) . "\n\n";

    return ($rperl_ast);
};

1;
1;
