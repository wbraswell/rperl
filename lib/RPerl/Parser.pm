# [[[ HEADER ]]]
package RPerl::Parser;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.014_000;

# [[[ OO INHERITANCE ]]]
#use RPerl::CompileUnit::Module::Class;
#use parent qw(RPerl::CompileUnit::Module::Class);

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants
## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
## no critic qw(ProhibitBacktickOperators)  ## SYSTEM SPECIAL 11: allow system command execution
## no critic qw(RequireCarping)  # SYSTEM SPECIAL 13: allow die instead of croak

# [[[ INCLUDES ]]]
use Perl::Critic;
use RPerl::Grammar;

# [[[ CONSTANTS ]]]
use constant MAX_SINGLE_ERROR_LINE_LENGTH  => my integer $TYPED_MAX_SINGLE_ERROR_LINE_LENGTH = 120;

# [[[ SUBROUTINES ]]]

# Parse from Human-Readable RPerl Source Code File to Eyapp-Parsed RPerl AST Object
sub rperl_to_ast__parse {
    { my object $RETURN_TYPE };
    ( my string $rperl_source__file_name) = @ARG;

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
}

# Check Perl Syntax Using Perl Interpreter
sub rperl_source__check_syntax {
    { my void $RETURN_TYPE };
    ( my string $rperl_source__file_name) = @ARG;
    RPerl::diag('in rperl_source__check_syntax(), received $rperl_source__file_name = ' . q{'} . $rperl_source__file_name . q{'} . "\n");

    RPerl::verbose('PARSE PHASE 0:      Check     Perl syntax...       ');

    my string $nul = $OSNAME eq 'MSWin32' ? 'NUL' : '/dev/null';
    my string $rperl_source__perl_syntax_command
        # DEV NOTE: inclusion of '-Mstrict' alters propagation of error messages through eval() to die()
        = $EXECUTABLE_NAME . q{ -Iblib/lib -M"warnings FATAL=>q(all)" -Mstrict -cw }
#        = $EXECUTABLE_NAME . q{ -Iblib/lib -M"warnings FATAL=>q(all)" -cw }
        . $rperl_source__file_name;
    my string $rperl_source__perl_syntax_command__no_output = $rperl_source__perl_syntax_command . ' > '.$nul.' 2> '.$nul;
    my string $rperl_source__perl_syntax_command__all_output = $rperl_source__perl_syntax_command . ' 2>&1';

#my string $rperl_source__perl_syntax_command = q{perl -Iblib/lib -cw } . $rperl_source__file_name;

RPerl::diag("in rperl_source__check_syntax(), have \$rperl_source__perl_syntax_command =\n$rperl_source__perl_syntax_command\n");
RPerl::diag("in rperl_source__check_syntax(), have \$rperl_source__perl_syntax_command__no_output =\n$rperl_source__perl_syntax_command__no_output\n\n");
RPerl::diag("in rperl_source__check_syntax(), have \$rperl_source__perl_syntax_command__all_output =\n$rperl_source__perl_syntax_command__all_output\n\n");

#my integer $rperl_source__perl_syntax_retval = system $rperl_source__perl_syntax_command;
    my integer $rperl_source__perl_syntax_retval
        = system $rperl_source__perl_syntax_command__no_output; # don't want any messages printed here

#my string $rperl_source__perl_syntax_retstring = `echo HOWDY`;
#my string $rperl_source__perl_syntax_retstring = `$rperl_source__perl_syntax_command`;
    my string $rperl_source__perl_syntax_retstring
        = `$rperl_source__perl_syntax_command__all_output`;

RPerl::diag("in rperl_source__check_syntax(), have \$rperl_source__perl_syntax_retval = $rperl_source__perl_syntax_retval\n");
RPerl::diag("in rperl_source__check_syntax(), have \$rperl_source__perl_syntax_retstring =\n$rperl_source__perl_syntax_retstring\n");
RPerl::diag("in rperl_source__check_syntax(), have \$OS_ERROR = $OS_ERROR\n");  # $OS_ERROR seems to contain random error messages that I can't trace?
RPerl::diag("in rperl_source__check_syntax(), have \$? = $?\n");

# NEED ADD ERROR CHECKING: ECOPAPL00 FILE DOES NOT EXIST, ECOPAPL01 FILE IS EMPTY

    if ( $rperl_source__perl_syntax_retval != 0 ) {
        my $error_pretty = "\n\n"
            . 'ERROR ECOPAPL02, RPERL PARSER, PERL SYNTAX ERROR' . "\n"
            . 'Failed normal Perl strictures-and-fatal-warnings syntax check with the following information:' . "\n\n" 
            . '    File Name:        ' . $rperl_source__file_name . "\n"
            . '    Return Value:     ' . ( $rperl_source__perl_syntax_retval >> 8 ) . "\n"
            . '    Error Message(s): ';
        if ( (length $rperl_source__perl_syntax_retstring) < MAX_SINGLE_ERROR_LINE_LENGTH() ) {
            $error_pretty .= $rperl_source__perl_syntax_retstring . "\n\n";
        }
        else {
            $error_pretty .= "\n\n" . $rperl_source__perl_syntax_retstring . "\n\n";
        }
          
        die $error_pretty;
    }

    my string_arrayref $rperl_source__perl_syntax_retstring_lines;
    @{$rperl_source__perl_syntax_retstring_lines} = split /\n/xms,
        $rperl_source__perl_syntax_retstring;

    RPerl::diag('in rperl_source__check_syntax(), have $rperl_source__perl_syntax_retstring_lines = ' . "\n" . Dumper($rperl_source__perl_syntax_retstring_lines) . "\n");
    my string_arrayref $rperl_source__perl_syntax_retstring_warnings = [];
    foreach my string $rperl_source__perl_syntax_retstring_line (
        @{$rperl_source__perl_syntax_retstring_lines} )
    {
        if (( $rperl_source__perl_syntax_retstring_line !~ m/WARNING\sW/xms ) # RPerl Warning
            and
            ( $rperl_source__perl_syntax_retstring_line !~ m/ERROR\sE/xms )   # RPerl Error
            and
            ( $rperl_source__perl_syntax_retstring_line !~ m/\[\[\[\ BEGIN\s/xms )   # RPerl Non-Error Debug Info
            and
            ( $rperl_source__perl_syntax_retstring_line !~ m/\[\[\[\ END\s/xms )   # RPerl Non-Error Debug Info
            and
            ( $rperl_source__perl_syntax_retstring_line !~ m/syntax\sOK/xms ) # Perl Non-Error
            )
        {
            push @{$rperl_source__perl_syntax_retstring_warnings},
                $rperl_source__perl_syntax_retstring_line;
        }
    }
    
    if (((scalar @{$rperl_source__perl_syntax_retstring_warnings}) == 1) and 
        ((substr $rperl_source__perl_syntax_retstring_warnings->[0], 0, 59) eq 'Name "Win32::Locale::Lexicon" used only once: possible typo')) {
        # this issue should affect Perl v5.12 only, patched here:
        # https://www.nntp.perl.org/group/perl.perl5.changes/2011/01/msg28822.html
        RPerl::warning("\n", q{WARNING WCOPAPL00, RPERL PARSER, PERL SYNTAX WARNING: Non-fatal Perl v5.12 warning, 'Name "Win32::Locale::Lexicon" used only once', ignoring}, "\n");
    }
    elsif ( ( scalar @{$rperl_source__perl_syntax_retstring_warnings} ) != 0 ) {
        my $error_pretty = "\n"
            . 'ERROR ECOPAPL03, RPERL PARSER, PERL SYNTAX WARNING' . "\n"
            . 'Failed normal Perl strictures-and-fatal-warnings syntax check with the following information:' . "\n\n" 
            . '    File Name:          ' . $rperl_source__file_name . "\n"
            . '    Warning Message(s): ';
           
        if ( ( ( scalar @{$rperl_source__perl_syntax_retstring_warnings} ) == 1 )
            and ( (length $rperl_source__perl_syntax_retstring_warnings->[0]) < MAX_SINGLE_ERROR_LINE_LENGTH() ) ) {
            $error_pretty .= $rperl_source__perl_syntax_retstring_warnings->[0] . "\n\n";
        }
        else {
            $error_pretty .=  "\n\n" . ( join "\n", @{$rperl_source__perl_syntax_retstring_warnings} ) . "\n\n";
        } 
        die $error_pretty;
    }

    RPerl::verbose(' done.' . "\n");
    RPerl::diag('in rperl_source__check_syntax(), about to return void...' . "\n");
}

# Criticize Perl Syntax Using Perl::Critic
sub rperl_source__criticize {
    { my void $RETURN_TYPE };
    ( my string $rperl_source__file_name) = @ARG;
    RPerl::diag('in rperl_source__criticize(), received $rperl_source__file_name = ' . q{'} . $rperl_source__file_name . q{'} . "\n");

    RPerl::verbose('PARSE PHASE 1:      Criticize Perl syntax...       ');

    # pre-critic error, begin check to ensure file ends with newline character or all-whitespace line
    if ( not -f $rperl_source__file_name ) {
        die 'ERROR ECOPAPC10, RPERL PARSER, PERL CRITIC VIOLATION: File not found, ' . q{'} . $rperl_source__file_name . q{'} . ', dying' . "\n";
    }

    open my filehandleref $FILE_HANDLE, '<', $rperl_source__file_name
        or die 'ERROR ECOPAPC11, RPERL PARSER, PERL CRITIC VIOLATION: Cannot open file ' . q{'} . $rperl_source__file_name . q{'} . ' for reading, ' . $OS_ERROR . ', dying' . "\n";

    my string $file_line = undef;
    my string $file_line_last = undef;

    while ( $file_line = <$FILE_HANDLE> ) {
        RPerl::diag('in rperl_source__criticize(), top of while loop, have $file_line = ' . q{'} . $file_line . q{'} . "\n");
        $file_line_last = $file_line;
    }

#    RPerl::diag('in rperl_source__criticize(), have last $file_line = ' . q{'} . $file_line . q{'} . "\n");  # error, uninitialized value
    RPerl::diag('in rperl_source__criticize(), have $file_line_last = ' . q{'} . $file_line_last . q{'} . "\n");

    close $FILE_HANDLE or die 'ERROR ECOPAPC12, RPERL PARSER, PERL CRITIC VIOLATION: Cannot close file ' . q{'} . $rperl_source__file_name . q{'} . ' after reading, ' . $OS_ERROR . ', dying' . "\n";

RPerl::diag('in rperl_source__criticize(), CHECKPOINT 00' . "\n");
#    RPerl::diag('in rperl_source__criticize(), CHECKPOINT 00' . q{'} . $file_line_last . q{'} . "\n");

    # DEV NOTE: the last line of all RPerl input files must either end with a newline character or be all-whitespace characters,
    # in order to avoid false positives triggered by Perl::Critic
    if (((substr $file_line_last, -1, 1) ne "\n") and ( $file_line_last !~ m/^\s+$/xms )) {
        die 'ERROR ECOPAPC13, RPERL PARSER, PERL CRITIC VIOLATION: RPerl source code input file ' . q{'} . $rperl_source__file_name . q{'} . ' does not end with newline character or line of all-whitespace characters, dying' . "\n";
    }

RPerl::diag('in rperl_source__criticize(), CHECKPOINT 01' . "\n");

# DEV NOTE: disable RequireTidyCode because perltidy may not be stable
#    my object $rperl_source__critic = Perl::Critic->new( -severity => 'brutal' );
#    my object $rperl_source__critic = Perl::Critic->new( -exclude => ['RequireTidyCode'] -severity => 'brutal' );  # DEV NOTE: Perl::Critic's own docs-recommended syntax throws a violation
    my object $rperl_source__critic = Perl::Critic->new(
        # DEV NOTE: disable RequireTidyCode because Perl::Tidy is not perfect and may complain even if the code is tidy;
        # disable PodSpelling because calling the external spellchecker can cause errors such as aspell's "No word lists can be found for the language FOO";
        # disable RequireExplicitPackage because 'use RPerl;' comes before package name(s), and Grammar.eyp will catch any other violations
        # NEED REMOVE HARD-CODED TEMPORARY WORK-AROUND:  https://github.com/autinitysystems/Perl-Critic-Policy-Documentation-RequirePod/issues/1
        # NEED REMOVE HARD-CODED TEMPORARY WORK-AROUND:  https://github.com/petdance/perl-critic-bangs/issues/16
        # disable RequirePod because it is not part of Perl::Critic & wrongly includes itself in themes 'core' & 'php' & 'maintenance'
        # disable all non-core additional policies which may be installed, such as Perlsecret, etc.
        '-exclude'  => ['RequireTidyCode', 'PodSpelling', 'RequireExplicitPackage', 'RequirePod', 'ProhibitBitwiseOperators'],
        '-severity' => 'brutal',
        '-theme'    => 'core',
        '-verbose'  => 11
    );
#RPerl::diag('in rperl_source__criticize(), CHECKPOINT 02, have $rperl_source__critic = ' . Dumper($rperl_source__critic) . "\n");
RPerl::diag('in rperl_source__criticize(), CHECKPOINT 02' . "\n");

    my @rperl_source__critic_violations = $rperl_source__critic->critique($rperl_source__file_name);
RPerl::diag('in rperl_source__criticize(), CHECKPOINT 03, have @rperl_source__critic_violations = ' . Dumper(\@rperl_source__critic_violations) . "\n");

    my integer $rperl_source__critic_num_violations = scalar @rperl_source__critic_violations;
RPerl::diag('in rperl_source__criticize(), CHECKPOINT 04, have $rperl_source__critic_num_violations = ' . $rperl_source__critic_num_violations . "\n");

RPerl::diag("in rperl_source__criticize(), have \$rperl_source__critic_num_violations = $rperl_source__critic_num_violations\n");
    my string $rperl_source__critic_dumperified_violations = Dumper( \@rperl_source__critic_violations );
RPerl::diag("in rperl_source__criticize(), have Dumper(\\\@rperl_source__critic_violations) =\n" . $rperl_source__critic_dumperified_violations . "\n");

# NEED ADD ERROR CHECKING: ECOPAPC00 FILE DOES NOT EXIST, ECOPAPC01 FILE IS EMPTY; or would that be redundant with ECOPAPL0x error checking when added above?

    if ( $rperl_source__critic_num_violations > 0 ) {
        my string $violation_pretty = q{};
        foreach my object $violation (@rperl_source__critic_violations) {
            $violation_pretty .= '    File Name:    ' . $rperl_source__file_name . "\n";
            $violation_pretty .= '    Line number:  ' . $violation->{_location}->[0] . "\n";
            $violation_pretty .= '    Policy:       ' . $violation->{_policy} . "\n";
            $violation_pretty .= '    Description:  ' . $violation->{_description} . "\n";
            if ( ref( $violation->{_explanation} ) eq 'ARRAY' ) {
                $violation_pretty .= '    Explanation:  See Perl Best Practices page(s) ' . join( ', ', @{ $violation->{_explanation} } ) . "\n\n";
            }
            else {
                $violation_pretty .= '    Explanation:  ' . $violation->{_explanation} . "\n\n";
            }
        }
        die "\n"
            . 'ERROR ECOPAPC02, RPERL PARSER, PERL CRITIC VIOLATION'
            . "\n"
            . 'Failed Perl::Critic brutal review with the following information:'
            . "\n\n"
            . $violation_pretty;
    }
    else {
        RPerl::verbose(' done.' . "\n");
    }

    RPerl::diag('in rperl_source__criticize(), about to return void...' . "\n");
}

# Die On RPerl Grammar Error
sub rperl_grammar_error {
    { my void $RETURN_TYPE };
    ( my array $argument ) = @ARG;

    my string $value = $argument->YYCurval;
    if ( not( defined $value ) ) {
        $value = '<<< NO TOKEN FOUND >>>';
    }
    my string $helpful_hint = q{};
    if ( $value =~ /\d/xms ) {
        $helpful_hint
            = q{    Helpful Hint:      Possible case of PBP RequireNumberSeparators (see below)} . "\n"
            . q{    Policy:            Perl::Critic::Policy::ValuesAndExpressions::RequireNumberSeparators} . "\n"
            . q{    Description:       Long number not separated with underscores} . "\n"
            . q{    Explanation:       See Perl Best Practices page(s) 59} . "\n";
    }

    my integer $line_number = $argument->{TOKENLINE};
    my string $rperl_source__file_name = $argument->{rperl_source__file_name};

#    die( "\n" . 'ERROR ECOPARP00, RPERL PARSER, SYNTAX ERROR; have $argument =' . "\n" . Dumper($argument) . "\n" );
#    die( "\n" . 'ERROR ECOPARP00, RPERL PARSER, SYNTAX ERROR; have $argument->{rperl_source__file_name} = ' . $argument->{rperl_source__file_name} . "\n" );

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
        . 'ERROR ECOPARP00, RPERL PARSER, RPERL SYNTAX ERROR' . "\n"
        . 'Failed RPerl grammar syntax check with the following information:'
        . "\n\n"
        . '    File Name:         ' . $rperl_source__file_name . "\n"
        . '    Line Number:       ' . $line_number . "\n"
        . '    Unexpected Token:  ' . $value . "\n"
        . '    Expected Token(s): ' . $expected_tokens
        . $helpful_hint . "\n";
}

# Parse RPerl Syntax Using Eyapp Grammar
sub rperl_source__parse {
    { my void $RETURN_TYPE };
    ( my string $rperl_source__file_name) = @ARG;

    RPerl::verbose('PARSE PHASE 2:      Parse    RPerl syntax...       ');

    my object $eyapp_parser = RPerl::Grammar->new();
    $eyapp_parser->{rperl_source__file_name} = $rperl_source__file_name;
    $eyapp_parser->YYSlurpFile($rperl_source__file_name);
    my object $rperl_ast = $eyapp_parser->YYParse(
        yydebug => 0x00,    # disable eyapp DBG DEBUGGING

#        yydebug => 0xFF,  # full eyapp DBG DEBUGGING, USE FOR DEBUGGING GRAMMAR
        yyerror => \&rperl_grammar_error
    );

    RPerl::verbose(' done.' . "\n");

#    RPerl::diag("in rperl_source__parse(), have \$rperl_ast->str() =\n" . $rperl_ast->str() . "\n\n");
#    RPerl::diag("in rperl_source__parse(), have \$rperl_ast =\n" . rperl_ast__dump($rperl_ast) . "\n\n");
#    die 'TMP DEBUG';

    return ($rperl_ast);
}

# condense AST dump, replace all instances of RPerl rule(s) with more meaningful RPerl class(es)
sub rperl_ast__dump {
    { my string $RETURN_TYPE };
    ( my object $rperl_ast) = @ARG;
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
}

# replace all instances of RPerl rule(s) with more meaningful RPerl class(es)
sub rperl_rule__replace {
    { my string $RETURN_TYPE };
    ( my string $rperl_rule_string) = @ARG;
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
}

1;    # end of class
