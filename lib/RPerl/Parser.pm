package RPerl::Parser;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_001;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values and print operator
## no critic qw(ProhibitBacktickOperators)  ## SYSTEM SPECIAL 11: allow system command execution

# [[[ SETUP ]]]
#use RPerl::CompileUnit::Module::Class;
#use parent ('RPerl::CompileUnit::Module::Class');

use PPI;
use PPI::Dumper;
use Scalar::Util 'blessed';
use Perl::Critic;

# [[[ PROCEDURAL SUBROUTINES ]]]

# Prune Whitespace & Comment Sub-Objects from PPI-Parsed RPerl AST Object
our void $whitespace_comments_pod__strip = sub {    # in-place algorithm

 #our object $whitespace_comments_pod__strip = sub {  # not-in-place algorithm
    ( my object $ppi_parsed) = @_;

#    print {*STDERR} "in whitespace_comments_pod__strip(), received \$ppi_parsed =\n" . Dumper($ppi_parsed) . "\n" or croak();

    # unblessed "object" is an error
    my string $object_class = blessed($ppi_parsed);
    if ( not( defined $object_class ) ) {
        croak(
            "\nERROR ECVPAPI01, RPERL PARSER, PPI OBJECT FAILURE:\nblessed object expected but non-blessed value found,\ncroaking"
        );
    }

#    print {*STDERR} "in whitespace_comments_pod__strip(), have \$object_class = '$object_class'\n";

    # no children is a no-op
    if ( not( defined $ppi_parsed->{children} ) ) {
        return ();    # in-place

        #        return ($ppi_parsed);  # not-in-place algorithm
    }

    my array_ref $children_new  = [];
    my integer $child_index_max = ( scalar @{ $ppi_parsed->{children} } ) - 1;

    for my integer $i ( 0 .. $child_index_max ) {
        my object $child       = $ppi_parsed->{children}->[$i];
        my string $child_class = blessed($child);

#        print {*STDERR} "in whitespace_comments_pod__strip(), inside for() loop $i/$child_index_max, have \$child_class = '$child_class'\n";
        if (    ( $child_class ne 'PPI::Token::Whitespace' )
            and ( $child_class ne 'PPI::Token::Comment' )
            and ( $child_class ne 'PPI::Token::Pod' ) )
        {
            whitespace_comments_pod__strip($child);
            push @{$children_new}, $child;
        }
    }

#    print {*STDERR} "in whitespace_comments_pod__strip(), after for() loop, have \$children_new =\n" . Dumper($children_new) . "\n" or croak();

    $ppi_parsed->{children} = $children_new;    # in-place

#    print {*STDERR} "in whitespace_comments_pod__strip(), returning \$ppi_parsed =\n" . Dumper($ppi_parsed) . "\n" or croak();

    return ();                                  # in-place

    #    return($ppi_parsed);  # not-in-place algorithm
};

# Parse from Human-Readable RPerl Source Code File to PPI-Parsed RPerl AST Object
our object $perl_to_ppi__parse = sub {
    ( my string $rperl_source__file_name) = @_;
    my object $rperl_parsed;

    # [[[ CHECK PERL SYNTAX ]]]
    # [[[ CHECK PERL SYNTAX ]]]
    # [[[ CHECK PERL SYNTAX ]]]

    my string $rperl_source__perl_syntax_command
        = q{perl -Iblib/lib -M'warnings FATAL=>q(all)' -cW }
        . $rperl_source__file_name;
    my string $rperl_source__perl_syntax_command__no_output
        = $rperl_source__perl_syntax_command . ' > /dev/null 2> /dev/null';
    my string $rperl_source__perl_syntax_command__all_output
        = $rperl_source__perl_syntax_command . ' 2>&1';

#my string $rperl_source__perl_syntax_command = q{perl -Iblib/lib -cW } . $rperl_source__file_name;

    print {*STDERR}
        "in perl_to_ppi__parse(), have \$rperl_source__perl_syntax_command =\n$rperl_source__perl_syntax_command\n"
        or croak();

#print {*STDERR} "in perl_to_ppi__parse(), have \$rperl_source__perl_syntax_command__no_output =\n$rperl_source__perl_syntax_command__no_output\n\n" or croak();
#print {*STDERR} "in perl_to_ppi__parse(), have \$rperl_source__perl_syntax_command__all_output =\n$rperl_source__perl_syntax_command__all_output\n\n" or croak();

#my integer $rperl_source__perl_syntax_retval = system $rperl_source__perl_syntax_command;
    my integer $rperl_source__perl_syntax_retval
        = system $rperl_source__perl_syntax_command__no_output; # don't want any messages printed here

#my string $rperl_source__perl_syntax_retstring = `echo HOWDY`;
#my string $rperl_source__perl_syntax_retstring = `$rperl_source__perl_syntax_command`;
#my string $rperl_source__perl_syntax_retstring = `$rperl_source__perl_syntax_command__all_output`;

#print {*STDERR} "in perl_to_ppi__parse(), have \$rperl_source__perl_syntax_retval = $rperl_source__perl_syntax_retval\n" or croak();
#print {*STDERR} "in perl_to_ppi__parse(), have \$rperl_source__perl_syntax_retstring =\n$rperl_source__perl_syntax_retstring\n" or croak();
#print {*STDERR} "in perl_to_ppi__parse(), have \$ERRNO = $ERRNO\n" or croak();  # $ERRNO seems to contain random error messages that I can't trace?
#print {*STDERR} "in perl_to_ppi__parse(), have \$? = $?\n" or croak();

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
        print {*STDERR}
            "in perl_to_ppi__parse(), RPerl source code passes perl -cW syntax check\n"
            or croak();
    }

    # [[[ CRITICIZE PERL SYNTAX ]]]
    # [[[ CRITICIZE PERL SYNTAX ]]]
    # [[[ CRITICIZE PERL SYNTAX ]]]

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

#print {*STDERR} "in perl_to_ppi__parse(), have \$rperl_source__critic_num_violations = $rperl_source__critic_num_violations\n" or croak();

    my string $rperl_source__critic_dumperified_violations
        = Dumper( \@rperl_source__critic_violations );

#print {*STDERR} "in perl_to_ppi__parse(), have Dumper(\\\@rperl_source__critic_violations) =\n" . $rperl_source__critic_dumperified_violations . "\n" or croak();

# NEED ADD ERROR CHECKING: ECVPAPC00 FILE DOES NOT EXIST, ECVPAPC01 FILE IS EMPTY; or would that be redundant with ECVPAPL0x error checking when added above?

    if ( $rperl_source__critic_num_violations > 0 ) {
        croak(
            "\n\nERROR ECVPAPC02, RPERL PARSER, PERL CRITIC VIOLATION:\nfile '$rperl_source__file_name' fails Perl::Critic brutal review with the following violations:\n\n"
                . $rperl_source__critic_dumperified_violations
                . "\ncroaking" );
    }
    else {
        print {*STDERR}
            "in perl_to_ppi__parse(), RPerl source code passes Perl::Critic brutal review\n"
            or croak();
    }

    # [[[ PARSE PPI SYNTAX ]]]
    # [[[ PARSE PPI SYNTAX ]]]
    # [[[ PARSE PPI SYNTAX ]]]

    # NEED UPGRADE: utilize already-parsed PPI from Perl::Critic???

    my object $rperl_source__ppi_parsed
        = PPI::Document->new($rperl_source__file_name);

    my object $rperl_source__ppi_parsed_dumper
        = PPI::Dumper->new($rperl_source__ppi_parsed);

#my object $rperl_source__ppi_parsed_dumper = PPI::Dumper->new($rperl_source__ppi_parsed, whitespace=>0);
#print {*STDERR} "in perl_to_ppi__parse(), have \$rperl_source__ppi_parsed_dumper->print() =\n\n";
#$rperl_source__ppi_parsed_dumper->print();
#print {*STDERR} "\n";
#print {*STDERR} "in perl_to_ppi__parse(), have Dumper(\$rperl_source__ppi_parsed) =\n" . Dumper($rperl_source__ppi_parsed) . "\n";

    my string $rperl_source__ppi_parsed__first_package_statement
        = $rperl_source__ppi_parsed->find_first('PPI::Statement::Package')
        ->namespace;
    print {*STDERR}
        "in perl_to_ppi__parse(), have \$rperl_source__ppi_parsed__first_package_statement = '$rperl_source__ppi_parsed__first_package_statement'\n"
        or croak();

    whitespace_comments_pod__strip($rperl_source__ppi_parsed);

#    print {*STDERR} "in perl_to_ppi__parse(), after whitespace_comments_pod__strip(), have Dumper(\$rperl_source__ppi_parsed) =\n" . Dumper($rperl_source__ppi_parsed) . "\n" or croak();

    $rperl_source__ppi_parsed_dumper
        = PPI::Dumper->new($rperl_source__ppi_parsed);
    print {*STDERR}
        "in perl_to_ppi__parse(), after whitespace_comments_pod__strip(), have \$rperl_source__ppi_parsed_dumper->print() =\n\n"
        or croak();
    $rperl_source__ppi_parsed_dumper->print();
    print {*STDERR} "\n" or croak();

# NEED ADD ERROR CHECKING: ECVPAPI00 FILE DOES NOT EXIST, ECVPAPI01 FILE IS EMPTY; or would that be redundant with ECVPAPL0x error checking when added above?
# NEED ADD ERROR CHECKING: ECVPAPI02 FAILED TO PARSE PPI; is this even possible?

    return ($rperl_source__ppi_parsed);
};

1;
