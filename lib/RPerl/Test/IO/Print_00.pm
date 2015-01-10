package RPerl::Test::IO::Print_00;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.003_010;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator

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
};

1;
