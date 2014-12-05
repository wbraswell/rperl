package RPerl::Test::Return_00;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.002_002;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values and print operator

# NEED UPGRADE: support INCLUDE rule!
#use Data::Dumper;  # parses to PPI::FOOBAZ object, translates to RPerl::FOOBAZ::Include object

# NEED UPGRADE: support CONSTANT rule!
# DEV NOTE: Perl::Critic BUG!  ProhibitMagicNumbers conflicts with ProhibitConstantPragma
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants
use constant FNORD => 23; # parses to PPI::FOOBAZ object, translates to RPerl::FOOBAZ::Constant object

# [[[ PROCEDURAL SUBROUTINE(S) ]]]

# say what we need to say
our void $greet_planet = sub {

    # [[[ RECEIVE ARGUMENT(S) ]]]

    ( my integer $arg0 ) = @_;    # parses to 1 PPI::Statement object

    #( my integer $arg0, my string $arg1) = @_;
    #( my integer $arg0, my string $arg1, my number__array_ref $arg2) = @_;

    # [[[ TYPE-CHECK ARGUMENT(S) ]]]

    # NEED FIX: handle possibility of pre-existing CHECK/TRACEs
    #::integer__CHECK($arg0);
    #::integer__CHECKTRACE( $arg0, qw{$arg0}, 'greet_planet()' );

    #::string__CHECK($arg1);
    #::string__CHECKTRACE( $arg1, qw{$arg1}, 'greet_planet()' );

    #::number__array_ref__CHECK($arg2);
    #::number__array_ref__CHECKTRACE( $arg2, qw{$arg2}, 'greet_planet()' );

    # [[[ PRINT ARGUMENT(S) ]]]

#print;
#print 'Hello, world! dot ' . $arg0 . "\n"; # parses to 1 PPI::Statement object; NEED FIX: . dot string concatenation operator not yet implemented
#print 'Hello, world! comma ' , $arg0 , "\n"; # parses to 1 PPI::Statement object
#RPerl::diag 'Hello, world! comma ' , $arg0 , "\n"; # parses to 1 PPI::Statement object, w/ PPI::Structure::Block at child index 1
    RPerl::diag 'Hello, world! comma ', $arg0, ' and ', 42, "\n"; # parses to 1 PPI::Statement object, w/ PPI::Structure::Block at child index 1

#print 'Hello, world! ' . $arg0 . q{ } . $arg1 . "\n";
#print 'Hello, world! ' . $arg0 . q{ } . $arg1 . q{ } . ::number__array_ref__stringify($arg2) . "\n";

    print "Goodbye from PERLOPS_PERLTYPES\n"; # parses to 1 PPI::Statement object

#my integer $foo = 23;  # parses to 1 PPI::Statement::Variable object, translates to 1 RPerl::Operation::Statement object
#my integer $foo;  # parses to 1 PPI::Statement::Variable object, translates to 1 RPerl::Operation::Statement object
#$foo = 23;  # parses to 1 PPI::Statement object, translates to 1 RPerl::Operation::Statement object
#my integer__array_ref $bar = [23, 34];  # parses to 1 PPI::Statement::Variable object, translates to 1 RPerl::Operation::Statement object
#my integer__array_ref $bar;  # parses to 1 PPI::Statement::Variable object, translates to 1 RPerl::Operation::Statement object
#$bar = [23, 34];  # parses to 1 PPI::Statement object, translates to 1 RPerl::Operation::Statement object

#if(0){2;}  # parses to 1 PPI::Statement::Compound object, translates to 1 RPerl::Operation::Statement::Conditional object
#for my $i (0 .. 2){1;}  # parses to 1 PPI::Statement::Compound object, translates to 1 RPerl::Operation::Statement::Loop::For object
#for my integer $i (0 .. 2){1;} # parses to 2 PPI::Statement::Compound objects, translates to 1 RPerl::Operation::Statement::Loop::For object

    #return;  # PARSE ERROR: invalid RPerl, missing parenthesis
    #return();
    #return 23;  # PARSE ERROR: invalid RPerl, missing parenthesis
    #return(23);
    #return 23 + 12;  # PARSE ERROR: invalid RPerl, missing parenthesis
    #return(23) + 12;  # PARSE ERROR: invalid RPerl, missing parenthesis
    #return(23 + 12);
    #return 'foo';  # PARSE ERROR: invalid RPerl, missing parenthesis
    #return('foo');
    #return 'foo' . 'bar';  # PARSE ERROR: invalid RPerl, missing parenthesis
    #return('foo') . 'bar';  # PARSE ERROR: invalid RPerl, missing parenthesis
    #return('foo' . 'bar');
    #return(23, 'foo');
};

# [[[ OPERATIONS & DATA TYPES REPORTING ]]]
#our integer $RPerl_test_00__OPS_TYPES_ID = 0;    # PERLOPS_PERLTYPES is 0  # NEED FIX: allow or disallow non-subs like this var?
#our string $RPerl_test_00__ops = sub { return ('PERL'); };
#our string $RPerl_test_00__types = sub { return ('PERL'); };

1;
