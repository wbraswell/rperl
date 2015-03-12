# [[[ HEADER ]]]
package RPerl::Parser;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.004_000;

# [[[ OO INHERITANCE ]]]
#use RPerl::CompileUnit::Module::Class;
#use parent ('RPerl::CompileUnit::Module::Class');

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitBacktickOperators)  ## SYSTEM SPECIAL 11: allow system command execution
## no critic qw(RequireCarping)  # SYSTEM SPECIAL 13: allow die instead of croak

# [[[ INCLUDES ]]]
use Perl::Critic;
use RPerl::Grammar;

# [[[ SUBROUTINES ]]]

# Parse from Human-Readable RPerl Source Code File to Eyapp-Parsed RPerl AST Object
our object $rperl_to_ast__parse = sub {
    ( my string $rperl_source__file_name) = @_;

    # [[[ PARSE PHASE 0: CHECK PERL SYNTAX ]]]
    # [[[ PARSE PHASE 0: CHECK PERL SYNTAX ]]]
    # [[[ PARSE PHASE 0: CHECK PERL SYNTAX ]]]

    rperl_source__check_syntax($rperl_source__file_name);

    # [[[ PARSE PHASE 1: CRITICIZE PERL SYNTAX ]]]
    # [[[ PARSE PHASE 1: CRITICIZE PERL SYNTAX ]]]
    # [[[ PARSE PHASE 1: CRITICIZE PERL SYNTAX ]]]

    rperl_source__criticize($rperl_source__file_name);

    # [[[ PARSE PHASE 2: PARSE RPERL SYNTAX ]]]
    # [[[ PARSE PHASE 2: PARSE RPERL SYNTAX ]]]
    # [[[ PARSE PHASE 2: PARSE RPERL SYNTAX ]]]

    return ( rperl_source__parse($rperl_source__file_name) );
};

# Check Perl Syntax Using Perl Interpreter
our void $rperl_source__check_syntax = sub {
    ( my string $rperl_source__file_name) = @_;

    RPerl::verbose 'PARSE PHASE 0: Check Perl syntax...';

    my string $rperl_source__perl_syntax_command
        = q{perl -Iblib/lib -M'warnings FATAL=>q(all)' -cW }
        . $rperl_source__file_name;
    my string $rperl_source__perl_syntax_command__no_output
        = $rperl_source__perl_syntax_command . ' > /dev/null 2> /dev/null';
    my string $rperl_source__perl_syntax_command__all_output
        = $rperl_source__perl_syntax_command . ' 2>&1';

#my string $rperl_source__perl_syntax_command = q{perl -Iblib/lib -cW } . $rperl_source__file_name;

#RPerl::diag "in rperl_source__check_syntax(), have \$rperl_source__perl_syntax_command =\n$rperl_source__perl_syntax_command\n";
#RPerl::diag "in rperl_source__check_syntax(), have \$rperl_source__perl_syntax_command__no_output =\n$rperl_source__perl_syntax_command__no_output\n\n";
#RPerl::diag "in rperl_source__check_syntax(), have \$rperl_source__perl_syntax_command__all_output =\n$rperl_source__perl_syntax_command__all_output\n\n";

#my integer $rperl_source__perl_syntax_retval = system $rperl_source__perl_syntax_command;
    my integer $rperl_source__perl_syntax_retval
        = system $rperl_source__perl_syntax_command__no_output; # don't want any messages printed here

#my string $rperl_source__perl_syntax_retstring = `echo HOWDY`;
#my string $rperl_source__perl_syntax_retstring = `$rperl_source__perl_syntax_command`;
    my string $rperl_source__perl_syntax_retstring
        = `$rperl_source__perl_syntax_command__all_output`;

#RPerl::diag "in rperl_source__check_syntax(), have \$rperl_source__perl_syntax_retval = $rperl_source__perl_syntax_retval\n";
#RPerl::diag "in rperl_source__check_syntax(), have \$rperl_source__perl_syntax_retstring =\n$rperl_source__perl_syntax_retstring\n";
#RPerl::diag "in rperl_source__check_syntax(), have \$OS_ERROR = $OS_ERROR\n";  # $OS_ERROR seems to contain random error messages that I can't trace?
#RPerl::diag "in rperl_source__check_syntax(), have \$? = $?\n";

# NEED ADD ERROR CHECKING: ECVPAPL00 FILE DOES NOT EXIST, ECVPAPL01 FILE IS EMPTY

    if ( $rperl_source__perl_syntax_retval != 0 ) {
        die "\n"
            . 'ERROR ECVPAPL02, RPERL PARSER, PERL SYNTAX ERROR' . "\n"
            . 'Failed `perl -cW` syntax check with return value '
            . ( $rperl_source__perl_syntax_retval >> 8 )
            . ' and the following message(s):' . "\n\n"

            #            . `$rperl_source__perl_syntax_command__all_output`
            . $rperl_source__perl_syntax_retstring # NEED FIX: get error return string instead of re-running command to get error string!
            . "\n";
    }

    my string__array_ref $rperl_source__perl_syntax_retstring_lines;
    @{$rperl_source__perl_syntax_retstring_lines} = split "\n",
        $rperl_source__perl_syntax_retstring;
#    RPerl::diag 'in rperl_source__check_syntax(), have $rperl_source__perl_syntax_retstring_lines = ', "\n", Dumper($rperl_source__perl_syntax_retstring_lines), "\n";
    my string__array_ref $rperl_source__perl_syntax_retstring_warnings = [];
    foreach my string $rperl_source__perl_syntax_retstring_line (
        @{$rperl_source__perl_syntax_retstring_lines} )
    {
        if (( $rperl_source__perl_syntax_retstring_line !~ /WARNING W/ ) and # RPerl Warning
            ( $rperl_source__perl_syntax_retstring_line !~ /ERROR E/ ) # RPerl Error
            and ( $rperl_source__perl_syntax_retstring_line !~ /syntax OK/ ) # Perl Non-Error
            )
        {
            push @{$rperl_source__perl_syntax_retstring_warnings},
                $rperl_source__perl_syntax_retstring_line;
        }
    }

    if ( (scalar @{$rperl_source__perl_syntax_retstring_warnings}) != 0 ) {
        die "\n"
            . 'ERROR ECVPAPL03, RPERL PARSER, PERL SYNTAX WARNING' . "\n"
            . 'Failed `perl -cW` syntax check with the following message(s): ' . "\n\n"
            . (join "\n", @{$rperl_source__perl_syntax_retstring_warnings})
            . "\n";
    }

    RPerl::verbose ' done.' . "\n";
};

# Criticize Perl Syntax Using Perl::Critic
our void $rperl_source__criticize = sub {
    ( my string $rperl_source__file_name) = @_;

    RPerl::verbose 'PARSE PHASE 1: Criticize Perl syntax...';

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
#    my string $rperl_source__critic_dumperified_violations = Dumper( \@rperl_source__critic_violations );
#RPerl::diag "in rperl_source__criticize(), have Dumper(\\\@rperl_source__critic_violations) =\n" . $rperl_source__critic_dumperified_violations . "\n";

# NEED ADD ERROR CHECKING: ECVPAPC00 FILE DOES NOT EXIST, ECVPAPC01 FILE IS EMPTY; or would that be redundant with ECVPAPL0x error checking when added above?

    if ( $rperl_source__critic_num_violations > 0 ) {
        my string $violation_pretty = q{};
        foreach my object $violation (@rperl_source__critic_violations) {
            $violation_pretty
                .= '    Line number:  ' . $violation->{_location}->[0] . "\n";
            $violation_pretty
                .= '    Policy:       ' . $violation->{_policy} . "\n";
            $violation_pretty
                .= '    Description:  ' . $violation->{_description} . "\n";
            if ( ref( $violation->{_explanation} ) eq 'ARRAY' ) {
                $violation_pretty
                    .= '    Explanation:  See Perl Best Practices page(s) '
                    . join( ', ', @{ $violation->{_explanation} } ) . "\n\n";
            }
            else {
                $violation_pretty .= '    Explanation:  '
                    . $violation->{_explanation} . "\n\n";
            }
        }
        die "\n"
            . 'ERROR ECVPAPC02, RPERL PARSER, PERL CRITIC VIOLATION'
            . "\n"
            . 'Failed Perl::Critic brutal review with the following message:'
            . "\n\n"
            . $violation_pretty;
    }
    else {
        RPerl::verbose ' done.' . "\n";
    }
};

# Die On RPerl Grammar Error
our void $rperl_grammar_error = sub {
    ( my array $argument ) = @_;

    my string $value = $argument->YYCurval;
    if ( not( defined $value ) ) {
        $value = '<<< NO TOKEN FOUND >>>';
    }
    my integer $line_number = $argument->{TOKENLINE};

#    die( "\nERROR ECVPARP00, RPERL PARSER, SYNTAX ERROR; have \$argument =\n" . Dumper($argument) . "\n" );

    my $current_state_num        = $argument->{STACK}[-1][0];
    my $current_state            = $argument->{STATES}[$current_state_num];
    my $expected_tokens          = q{};
    my number $is_first_expected = 1;
    foreach my $expected_token ( keys %{ $current_state->{ACTIONS} } ) {
        if ($is_first_expected) {
            $is_first_expected = 0;
            $expected_tokens .= $expected_token . "\n";
        }
        else {
            $expected_tokens
                .= q{                       } . $expected_token . "\n";
        }
    }

    die "\n"
        . 'ERROR ECVPARP00, RPERL PARSER, RPERL SYNTAX ERROR' . "\n"
        . 'Failed RPerl grammar syntax check with the following message:'
        . "\n\n"
        . '    Line number:       '
        . $line_number . "\n"
        . '    Unexpected token:  '
        . $value . "\n"
        . '    Expected token(s): '
        . $expected_tokens . "\n";
};

# Parse RPerl Syntax Using Eyapp Grammar
our void $rperl_source__parse = sub {
    ( my string $rperl_source__file_name) = @_;

    RPerl::verbose 'PARSE PHASE 2: Parse RPerl syntax...';

    my object $eyapp_parser = RPerl::Grammar->new();
    $eyapp_parser->YYSlurpFile($rperl_source__file_name);
    my object $rperl_ast = $eyapp_parser->YYParse(
        yydebug => 0x00,    # disable eyapp DBG DEBUGGING

        #        yydebug => 0xFF,  # full eyapp DBG DEBUGGING
        yyerror => $rperl_grammar_error
    );

    RPerl::verbose ' done.' . "\n";

    RPerl::diag "in rperl_source__parse(), have \$rperl_ast->str() =\n" . $rperl_ast->str() . "\n\n";
    RPerl::diag "in rperl_source__parse(), have \$rperl_ast =\n" . Dumper($rperl_ast) . "\n\n";

    return ($rperl_ast);
};

1;    # end of class
