#!/usr/bin/perl
use strict;
use warnings;
our $VERSION = 0.001_004;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values and print operator
## no critic qw(ProhibitStringyEval)  # SYSTEM DEFAULT 1: allow eval()

use Test::More tests => 17;
use Test::Exception;
use Carp;
use English qw(-no_match_vars);
my $ERROR_MAX = 0.00000001;

BEGIN {
    if ( $ENV{TEST_VERBOSE} ) {
        diag('[[[ Beginning Inline::CPP Pre-Test Loading ]]]');
    }
}

if ( $ENV{TEST_VERBOSE} ) {
    diag('[[[ Beginning Entirety Of Tests From The Inline::CPP POD ]]]');
}

# Inline::CPP examples from:  http://search.cpan.org/~davido/Inline-CPP-0.44/lib/Inline/CPP.pod
# Note: I did not exclude any Inline::CPP examples, they are all suitable for testing.

# class Farmer, AKA "Farmer Bob"
my $farmer_define_eval_string = <<'EOF';
use Inline CPP => Config => CCFLAGSEX => '-DNO_XSLOCKS';
use Inline CPP => <<'END_OF_CPP_CODE';
class Farmer {
	public:
		Farmer(char *name, int age);
		~Farmer();

		int how_tired() { return tiredness; }
		int how_long() { return howlong; }
		void do_chores(int howlong);

	private:
		char *name;
		int age;
		int tiredness;
		int howlong;
};
Farmer::Farmer(char *name, int age) {
	this->name = strdup(name);
	this->age = age;
	tiredness = 0;
	howlong = 0;
}
Farmer::~Farmer() { free(name); }
void Farmer::do_chores(int hl) {
	howlong += hl;
	tiredness += (age * hl);
}
END_OF_CPP_CODE
EOF
lives_and(
    sub {
        my $EVAL_RETVAL = eval $farmer_define_eval_string;
        if ( $EVAL_ERROR ne q{} ) {
            croak(
                "Error in eval, have \$EVAL_ERROR =\n\nBEGIN EVAL ERROR\n\n$EVAL_ERROR\n\nEND EVAL ERROR\n\ncroaking"
            );
        }
        is( $EVAL_RETVAL, undef,
            q{Inline::CPP, define class Farmer returns correct value} );
    },
    q{Inline::CPP, define class Farmer lives}
);
my $farmer_call_eval_string = <<'EOF';
my $farmer = new Farmer("Ingy", 42);
my $slavedriver = 1;
while($farmer->how_tired < 420) {
	$farmer->do_chores($slavedriver);
	$slavedriver <<= 1;
}
return("Wow!  The farmer worked " . $farmer->how_long . " hours!");
EOF
lives_and(
    sub {
        my $EVAL_RETVAL = eval $farmer_call_eval_string;
        if ( $EVAL_ERROR ne q{} ) {
            croak(
                "Error in eval, have \$EVAL_ERROR =\n\nBEGIN EVAL ERROR\n\n$EVAL_ERROR\n\nEND EVAL ERROR\n\ncroaking"
            );
        }
        is( $EVAL_RETVAL,
            'Wow!  The farmer worked 15 hours!',
            q{Inline::CPP, call Farmer methods returns correct value}
        );
    },
    q{Inline::CPP, call Farmer methods lives}
);

# class Airplane, AKA "Plane and Simple"
my $airplane_define_eval_string = <<'EOF';
use Inline CPP => Config => CCFLAGSEX => '-DNO_XSLOCKS';
use Inline CPP => <<'END_OF_CPP_CODE';
using namespace std;
#include <sstream>
/* Abstract class (interface) */
class Object {
	public:
		virtual void print() { cout << "Object (" << this << ")" << endl; }
		virtual char* nonprint() { ostringstream oretval;  oretval << "Object (" << this << ")";  return((char*)oretval.str().c_str()); }
		virtual void info() = 0;
		virtual bool isa(char *klass) = 0;
		virtual bool can(char *method) = 0;
};
class Airplane : public Object {
	public:
		Airplane() {}
		~Airplane() {}
		virtual void info() { print(); }
		virtual bool isa(char *klass) { return strcmp(klass, "Object")==0; }
		virtual bool can(char *method) {
			bool yes = false;
			yes |= strcmp(method, "print")==0;
			yes |= strcmp(method, "info")==0;
			yes |= strcmp(method, "isa")==0;
			yes |= strcmp(method, "can")==0;
			return yes;
		}
};
END_OF_CPP_CODE
EOF
lives_and(
    sub {
        my $EVAL_RETVAL = eval $airplane_define_eval_string;
        if ( $EVAL_ERROR ne q{} ) {
            croak(
                "Error in eval, have \$EVAL_ERROR =\n\nBEGIN EVAL ERROR\n\n$EVAL_ERROR\n\nEND EVAL ERROR\n\ncroaking"
            );
        }
        is( $EVAL_RETVAL, undef,
            q{Inline::CPP, define class Airplane returns correct value} );
    },
    q{Inline::CPP, define class Airplane lives}
);
my $airplane_call_eval_string = <<'EOF';
my $plane = new Airplane;
my $plane_retval1 = $plane->nonprint;
my $plane_retval2 = '';
if ($plane->isa("Object")) { $plane_retval2 .= "Plane is an Object!"; }
unless ($plane->can("fly")) { $plane_retval2 .= "  This plane sucks!"; }
return($plane_retval1, $plane_retval2);
EOF
lives_and(
    sub {
        my ( $airplane_retval1, $airplane_retval2 )
            = eval $airplane_call_eval_string;
        if ( $EVAL_ERROR ne q{} ) {
            croak(
                "Error in eval, have \$EVAL_ERROR =\n\nBEGIN EVAL ERROR\n\n$EVAL_ERROR\n\nEND EVAL ERROR\n\ncroaking"
            );
        }
        like(
            $airplane_retval1,
            '/Object\ \(0x\w*\)/',
            'Inline::CPP, call Airplane methods, return correct value 1'
        );
        is( $airplane_retval2,
            'Plane is an Object!  This plane sucks!',
            'Inline::CPP, call Airplane methods, return correct value 2'
        );
    },
    q{Inline::CPP, call Airplane methods lives}
);

# average() VS avg(), AKA "The Ellipsis Abridged"
my $average_define_eval_string = <<'EOF';
sub average {
	my $average = 0;
	for (my $i=0; $i<@_; $i++) {
		$average *= $i;
		$average += $_[$i];
		$average /= $i + 1;
	}
	return $average;
}
use Inline CPP => Config => CCFLAGSEX => '-DNO_XSLOCKS';
use Inline CPP => <<'END_OF_CPP_CODE';
double avg(...) {
	Inline_Stack_Vars;
	double avg = 0.0;
	for (int i=0; i<items; i++) {
		avg *= i;
		avg += SvNV(ST(i));
		avg /= i + 1;
	}
	return avg;
}
END_OF_CPP_CODE
EOF
lives_and(
    sub {
        my $EVAL_RETVAL = eval $average_define_eval_string;
        if ( $EVAL_ERROR ne q{} ) {
            croak(
                "Error in eval, have \$EVAL_ERROR =\n\nBEGIN EVAL ERROR\n\n$EVAL_ERROR\n\nEND EVAL ERROR\n\ncroaking"
            );
        }
        is( $EVAL_RETVAL, undef,
            q{Inline::CPP, define average() and avg() returns correct value}
        );
    },
    q{Inline::CPP, define average() and avg() lives}
);
my $average_call_eval_string = <<'EOF';
my @numbers = map { rand } (1 .. 10000);
my $average_retval = average(@numbers);
my $avg_retval = avg(@numbers);
my $average_retval_string = "The Perl average of 10000 random numbers is: " . $average_retval;
my $avg_retval_string = "The C/C++ average of 10000 random numbers is: " . $avg_retval;
return($average_retval, $avg_retval, $average_retval_string, $avg_retval_string);
EOF
lives_and(
    sub {
        my ($average_retval,        $avg_retval,
            $average_retval_string, $avg_retval_string
        ) = eval $average_call_eval_string;
        if ( $EVAL_ERROR ne q{} ) {
            croak(
                "Error in eval, have \$EVAL_ERROR =\n\nBEGIN EVAL ERROR\n\n$EVAL_ERROR\n\nEND EVAL ERROR\n\ncroaking"
            );
        }
        like(
            $average_retval_string,
            '/The Perl average of 10000 random numbers is: \d+.\d+/',
            q{Inline::CPP, call average() and avg() returns correct value 1}
        );
        like(
            $avg_retval_string,
            '/The C\/C\+\+ average of 10000 random numbers is: \d+.\d+/',
            q{Inline::CPP, call average() and avg() returns correct value 2}
        );
        cmp_ok( abs( $average_retval - $avg_retval ), '<', $ERROR_MAX,
            q{Inline::CPP, call average() and avg() return values are equivalent}
        );
    },
    q{Inline::CPP, call average() and avg() lives}
);

# classes Queue and Stack, AKA "Stacks and Queues"
my $queuestack_define_eval_string = <<'EOF';
use Inline CPP => Config => CCFLAGSEX => '-DNO_XSLOCKS';
use Inline CPP => <<'END_OF_CPP_CODE';
class Queue {
	public:
		Queue(int sz=0) { q = newAV(); if (sz) av_extend(q, sz-1); }
		~Queue() { av_undef(q); }
		int size() {return av_len(q) + 1; }
		int enqueue(SV* item) { av_push(q, SvREFCNT_inc(item)); return av_len(q)+1; }
		SV* dequeue() { return av_shift(q); }
		SV* peek() { return size() ? SvREFCNT_inc(*av_fetch(q,0,0)): &PL_sv_undef;}
	private:
		AV* q;
};
class Stack {
	public:
		Stack(int sz=0) { s = newAV(); if (sz) av_extend(s, sz-1); }
		~Stack() { av_undef(s); }
		int size() { return av_len(s) + 1; }
		int push(SV* i) { av_push(s, SvREFCNT_inc(i)); return av_len(s)+1; }
		SV* pop() { return av_pop(s); }
		SV* peek() { return size() ? SvREFCNT_inc(*av_fetch(s,size()-1,0)) : &PL_sv_undef; }
	private:
		AV* s;
};
END_OF_CPP_CODE
EOF
lives_and(
    sub {
        my $EVAL_RETVAL = eval $queuestack_define_eval_string;
        if ( $EVAL_ERROR ne q{} ) {
            croak(
                "Error in eval, have \$EVAL_ERROR =\n\nBEGIN EVAL ERROR\n\n$EVAL_ERROR\n\nEND EVAL ERROR\n\ncroaking"
            );
        }
        is( $EVAL_RETVAL, undef,
            q{Inline::CPP, define classes Queue and Stack returns correct value}
        );
    },
    q{Inline::CPP, define classes Queue and Stack lives}
);
my $queuestack_call_eval_string = <<'EOF';
my $q = new Queue;
my $queue_retval = '';
$q->enqueue(50);
$q->enqueue("Where am I?");
$q->enqueue("In a queue.");
#RPerl::diag "There are ", $q->size, " items in the queue\n";
while($q->size) {
#	RPerl::diag "About to dequeue: ", $q->peek, "\n";
#	RPerl::diag "Actually dequeued: ", $q->dequeue, "\n";
	$queue_retval .= $q->dequeue . '  ';
}
my $s = new Stack;
my $stack_retval = '';
$s->push(42);
$s->push("What?");
#RPerl::diag "There are ", $s->size, " items on the stack\n";
while($s->size) {
#	RPerl::diag "About to pop: ", $s->peek, "\n";
#	RPerl::diag "Actually popped: ", $s->pop, "\n";
	$stack_retval .= $s->pop . '  ';
}
return($queue_retval, $stack_retval);
EOF
lives_and(
    sub {
        my ( $queue_retval, $stack_retval )
            = eval $queuestack_call_eval_string;
        if ( $EVAL_ERROR ne q{} ) {
            croak(
                "Error in eval, have \$EVAL_ERROR =\n\nBEGIN EVAL ERROR\n\n$EVAL_ERROR\n\nEND EVAL ERROR\n\ncroaking"
            );
        }
        is( $queue_retval,
            '50  Where am I?  In a queue.  ',
            q{Inline::CPP, call Queue and Stack methods returns correct value 1}
        );
        is( $stack_retval,
            'What?  42  ',
            q{Inline::CPP, call Queue and Stack methods returns correct value 2}
        );
    },
    q{Inline::CPP, call Queue and Stack methods lives}
);

# multiadd(), AKA "Elipses Revisited (and Overloading or Templates)"
my $multiadd_define_eval_string = <<'EOF';
use Inline CPP => Config => CCFLAGSEX => '-DNO_XSLOCKS';
use Inline CPP => <<'END_OF_CPP_CODE';
#include <stdexcept>
// Inline::CPP won't create predictable bindings to overloaded functions.
int add ( int a, int b ) { return a + b; }
int add ( int a, int b, int c ) { return a + b + c; }
// But a function call with elipses can dispatch to overloaded functions since
// no Perl binding is required in reaching those functions.
int multiadd ( SV*  a, ... ) {
	dXSARGS;  // Creates a variable 'items' that contains a paramater count.
	try{
		switch ( items ) {
			case 1:  return SvIV(ST(0));
			case 2:  return add( SvIV(ST(0)), SvIV(ST(1)) );
			case 3:  return add( SvIV(ST(0)), SvIV(ST(1)), SvIV(ST(2)) );
			default: throw std::runtime_error( "multiadd() - Too many args in function call" );
		}
	}
	catch ( std::runtime_error msg ) { croak( msg.what() );  }  // Perl likes croak for exceptions.
}
END_OF_CPP_CODE
EOF
lives_and(
    sub {
        my $EVAL_RETVAL = eval $multiadd_define_eval_string;
        if ( $EVAL_ERROR ne q{} ) {
            croak(
                "Error in eval, have \$EVAL_ERROR =\n\nBEGIN EVAL ERROR\n\n$EVAL_ERROR\n\nEND EVAL ERROR\n\ncroaking"
            );
        }
        is( $EVAL_RETVAL, undef,
            q{Inline::CPP, define multiadd() returns correct value} );
    },
    q{Inline::CPP, define multiadd() lives}
);
lives_and(
    sub {
        my $EVAL_RETVAL = eval
            'return(multiadd(1));  # No dispatch; just return the value';
        if ( $EVAL_ERROR ne q{} ) {
            croak(
                "Error in eval, have \$EVAL_ERROR =\n\nBEGIN EVAL ERROR\n\n$EVAL_ERROR\n\nEND EVAL ERROR\n\ncroaking"
            );
        }
        cmp_ok( $EVAL_RETVAL, q{==}, 1,
            q{Inline::CPP, call multiadd(1) returns correct value} );
    },
    q{Inline::CPP, call multiadd(1) lives}
);
lives_and(
    sub {
        my $EVAL_RETVAL = eval 'multiadd(1, 2);  # Dispatch add(int, int)';
        if ( $EVAL_ERROR ne q{} ) {
            croak(
                "Error in eval, have \$EVAL_ERROR =\n\nBEGIN EVAL ERROR\n\n$EVAL_ERROR\n\nEND EVAL ERROR\n\ncroaking"
            );
        }
        cmp_ok( $EVAL_RETVAL, q{==}, 3,
            q{Inline::CPP, call multiadd(1, 2) returns correct value} );
    },
    q{Inline::CPP, call multiadd(1, 2) lives}
);
lives_and(
    sub {
        my $EVAL_RETVAL
            = eval 'multiadd(1, 2, 3);  # Dispatch add(int, int, int)';
        if ( $EVAL_ERROR ne q{} ) {
            croak(
                "Error in eval, have \$EVAL_ERROR =\n\nBEGIN EVAL ERROR\n\n$EVAL_ERROR\n\nEND EVAL ERROR\n\ncroaking"
            );
        }
        cmp_ok( $EVAL_RETVAL, q{==}, 6,
            q{Inline::CPP, call multiadd(1, 2, 3) returns correct value} );
    },
    q{Inline::CPP, call multiadd(1, 2, 3) lives}
);
lives_and( # can't use throws_ok() because we are trapping the exception inside of eval
    sub {
        my $EVAL_RETVAL
            = eval 'multiadd(1, 2, 3, 4);  # No dispatch; throw an exception';
        like(
            $EVAL_ERROR,
            '/^multiadd\(\) \- Too many args in function call at/',
            q{Inline::CPP, call multiadd(1, 2, 3, 4) throws correct exception}
        );
    },
    q{Inline::CPP, call multiadd(1, 2, 3, 4) lives}
);

done_testing();
