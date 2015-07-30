# [[[ HEADER ]]]
package RPerl::Parser;
use strict;
use warnings;
use RPerl::AfterFilter;
our $VERSION = 0.004_070;

# [[[ OO INHERITANCE ]]]
#use RPerl::CompileUnit::Module::Class;
#use parent qw(RPerl::CompileUnit::Module::Class);

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
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

    RPerl::verbose('PARSE PHASE 0:      Check     Perl syntax...       ');

    my string $nul = $OSNAME eq 'MSWin32' ? 'NUL' : '/dev/null';
    my string $rperl_source__perl_syntax_command
        = $EXECUTABLE_NAME . q{ -Iblib/lib -M"warnings FATAL=>q(all)" -cw }
        . $rperl_source__file_name;
    my string $rperl_source__perl_syntax_command__no_output
        = $rperl_source__perl_syntax_command . ' > '.$nul.' 2> '.$nul;
    my string $rperl_source__perl_syntax_command__all_output
        = $rperl_source__perl_syntax_command . ' 2>&1';

#my string $rperl_source__perl_syntax_command = q{perl -Iblib/lib -cw } . $rperl_source__file_name;

#RPerl::diag("in rperl_source__check_syntax(), have \$rperl_source__perl_syntax_command =\n$rperl_source__perl_syntax_command\n");
#RPerl::diag("in rperl_source__check_syntax(), have \$rperl_source__perl_syntax_command__no_output =\n$rperl_source__perl_syntax_command__no_output\n\n");
#RPerl::diag("in rperl_source__check_syntax(), have \$rperl_source__perl_syntax_command__all_output =\n$rperl_source__perl_syntax_command__all_output\n\n");

#my integer $rperl_source__perl_syntax_retval = system $rperl_source__perl_syntax_command;
    my integer $rperl_source__perl_syntax_retval
        = system $rperl_source__perl_syntax_command__no_output; # don't want any messages printed here

#my string $rperl_source__perl_syntax_retstring = `echo HOWDY`;
#my string $rperl_source__perl_syntax_retstring = `$rperl_source__perl_syntax_command`;
    my string $rperl_source__perl_syntax_retstring
        = `$rperl_source__perl_syntax_command__all_output`;

#RPerl::diag("in rperl_source__check_syntax(), have \$rperl_source__perl_syntax_retval = $rperl_source__perl_syntax_retval\n");
#RPerl::diag("in rperl_source__check_syntax(), have \$rperl_source__perl_syntax_retstring =\n$rperl_source__perl_syntax_retstring\n");
#RPerl::diag("in rperl_source__check_syntax(), have \$OS_ERROR = $OS_ERROR\n");  # $OS_ERROR seems to contain random error messages that I can't trace?
#RPerl::diag("in rperl_source__check_syntax(), have \$? = $?\n");

# NEED ADD ERROR CHECKING: ECVPAPL00 FILE DOES NOT EXIST, ECVPAPL01 FILE IS EMPTY

    if ( $rperl_source__perl_syntax_retval != 0 ) {
        die "\n"
            . 'ERROR ECVPAPL02, RPERL PARSER, PERL SYNTAX ERROR' . "\n"
            . 'Failed `' . $EXECUTABLE_NAME . ' -cw` syntax check with return value '
            . ( $rperl_source__perl_syntax_retval >> 8 )
            . ' and the following message(s):' . "\n\n"

            #            . `$rperl_source__perl_syntax_command__all_output`
            . $rperl_source__perl_syntax_retstring # NEED FIX: get error return string instead of re-running command to get error string!
            . "\n";
    }

    my string_arrayref $rperl_source__perl_syntax_retstring_lines;
    @{$rperl_source__perl_syntax_retstring_lines} = split /\n/xms,
        $rperl_source__perl_syntax_retstring;

#    RPerl::diag('in rperl_source__check_syntax(), have $rperl_source__perl_syntax_retstring_lines = ' . "\n" . Dumper($rperl_source__perl_syntax_retstring_lines) . "\n");
    my string_arrayref $rperl_source__perl_syntax_retstring_warnings = [];
    foreach my string $rperl_source__perl_syntax_retstring_line (
        @{$rperl_source__perl_syntax_retstring_lines} )
    {
        if (( $rperl_source__perl_syntax_retstring_line !~ /WARNING\sW/xms ) # RPerl Warning
            and
            ( $rperl_source__perl_syntax_retstring_line !~ /ERROR\sE/xms )   # RPerl Error
            and
            ( $rperl_source__perl_syntax_retstring_line !~ /syntax\sOK/xms ) # Perl Non-Error
            )
        {
            push @{$rperl_source__perl_syntax_retstring_warnings},
                $rperl_source__perl_syntax_retstring_line;
        }
    }

    if ( ( scalar @{$rperl_source__perl_syntax_retstring_warnings} ) != 0 ) {
        die "\n"
            . 'ERROR ECVPAPL03, RPERL PARSER, PERL SYNTAX WARNING' . "\n"
            . 'Failed `' . $EXECUTABLE_NAME . ' -cw` syntax check with the following message(s): '
            . "\n\n"
            . ( join "\n", @{$rperl_source__perl_syntax_retstring_warnings} )
            . "\n";
    }

    RPerl::verbose(' done.' . "\n");
};

# Criticize Perl Syntax Using Perl::Critic
our void $rperl_source__criticize = sub {
    ( my string $rperl_source__file_name) = @_;

    RPerl::verbose('PARSE PHASE 1:      Criticize Perl syntax...       ');

# DEV NOTE: disable RequireTidyCode because perltidy may not be stable
#    my object $rperl_source__critic = Perl::Critic->new( -severity => 'brutal' );
#    my object $rperl_source__critic = Perl::Critic->new( -exclude => ['RequireTidyCode'] -severity => 'brutal' );  # DEV NOTE: Perl::Critic's own docs-recommended syntax throws a violation
    my object $rperl_source__critic = Perl::Critic->new(
        # DEV NOTE: disable RequireTidyCode because Perl::Tidy is not perfect and may complain even if the code is tidy;
        # disable PodSpelling because calling the external spellchecker can cause errors such as aspell's "No word lists can be found for the language FOO"
        '-exclude'  => ['RequireTidyCode', 'PodSpelling'],
#        '-exclude'  => ['RequireTidyCode'],
        '-severity' => 'brutal'
    );
    my @rperl_source__critic_violations
        = $rperl_source__critic->critique($rperl_source__file_name);

    my integer $rperl_source__critic_num_violations
        = scalar @rperl_source__critic_violations;

#RPerl::diag("in rperl_source__criticize(), have \$rperl_source__critic_num_violations = $rperl_source__critic_num_violations\n");
#    my string $rperl_source__critic_dumperified_violations = Dumper( \@rperl_source__critic_violations );
#RPerl::diag("in rperl_source__criticize(), have Dumper(\\\@rperl_source__critic_violations) =\n" . $rperl_source__critic_dumperified_violations . "\n");

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
        RPerl::verbose(' done.' . "\n");
    }
};

# Die On RPerl Grammar Error
our void $rperl_grammar_error = sub {
    ( my array $argument ) = @_;

    my string $value = $argument->YYCurval;
    if ( not( defined $value ) ) {
        $value = '<<< NO TOKEN FOUND >>>';
    }
    my string $helpful_hint = q{};
    if ( $value =~ /\d/xms ) {
        $helpful_hint
            = q{Helpful Hint:      Possible case of PBP RequireNumberSeparators (see below)}
            . q{Policy:            Perl::Critic::Policy::ValuesAndExpressions::RequireNumberSeparators}
            . q{Description:       Long number not separated with underscores}
            . q{Explanation:       See Perl Best Practices page(s) 59};
    }

    my integer $line_number = $argument->{TOKENLINE};

#    die( "\nERROR ECVPARP00, RPERL PARSER, SYNTAX ERROR; have \$argument =\n" . Dumper($argument) . "\n" );

    my $current_state_num        = $argument->{STACK}[-1][0];
    my $current_state            = $argument->{STATES}[$current_state_num];
    my $expected_tokens          = q{};
    my number $is_first_expected = 1;

    foreach my $expected_token ( sort keys %{ $current_state->{ACTIONS} } ) {
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
        . '    Line Number:       '
        . $line_number . "\n"
        . '    Unexpected Token:  '
        . $value . "\n"
        . '    Expected Token(s): '
        . $expected_tokens
        . $helpful_hint . "\n";
};

# Parse RPerl Syntax Using Eyapp Grammar
our void $rperl_source__parse = sub {
    ( my string $rperl_source__file_name) = @_;

    RPerl::verbose('PARSE PHASE 2:      Parse    RPerl syntax...       ');

    my object $eyapp_parser = RPerl::Grammar->new();
    $eyapp_parser->YYSlurpFile($rperl_source__file_name);
    my object $rperl_ast = $eyapp_parser->YYParse(
        yydebug => 0x00,    # disable eyapp DBG DEBUGGING

#        yydebug => 0xFF,  # full eyapp DBG DEBUGGING, USE FOR DEBUGGING GRAMMAR
        yyerror => $rperl_grammar_error
    );

    RPerl::verbose(' done.' . "\n");

#    RPerl::diag("in rperl_source__parse(), have \$rperl_ast->str() =\n" . $rperl_ast->str() . "\n\n");
#    RPerl::diag("in rperl_source__parse(), have \$rperl_ast =\n" . rperl_ast__dump($rperl_ast) . "\n\n");

    return ($rperl_ast);
};

# condense AST dump, replace all instances of RPerl rule(s) with more meaningful RPerl class(es)
our string $rperl_ast__dump = sub {
    ( my object $rperl_ast) = @_;
    $Data::Dumper::Indent = 1; # do not attempt to align hash values based on hash key length
    my string $rperl_ast_dumped = Dumper($rperl_ast);
    $Data::Dumper::Indent = 2;    # restore default

#    $rperl_ast_dumped =~ s/\ \ /\ \ \ \ /gxms;   # set tabs from 2 to 4 spaces
    $rperl_ast_dumped =~ s/[ ]{2}/    /gxms;    # set tabs from 2 to 4 spaces
    my string $replacee;
    my string $replacer;
    foreach my string $rule ( sort keys %{$RPerl::Grammar::RULES} ) {
        $replacee = q{'} . $rule . q{'};
        $replacer
            = q{'} . $rule . ' ISA ' . $RPerl::Grammar::RULES->{$rule} . q{'};
        $rperl_ast_dumped =~ s/$replacee/$replacer/gxms;
    }
    return $rperl_ast_dumped;
};

# replace all instances of RPerl rule(s) with more meaningful RPerl class(es)
our string $rperl_rule__replace = sub {
    ( my string $rperl_rule_string) = @_;
    my string $replacer;
    foreach my string $rule ( sort keys %{$RPerl::Grammar::RULES} ) {
        if ( $RPerl::Grammar::RULES->{$rule} ne 'RPerl::NonGenerator' ) {
            $replacer
                = q{(}
                . $rule . ' ISA '
                . $RPerl::Grammar::RULES->{$rule} . q{)};
            $replacer =~ s/RPerl:://gxms;
            $rperl_rule_string =~ s/$rule/$replacer/gxms;
        }
    }
    return $rperl_rule_string;
};

1;    # end of class
