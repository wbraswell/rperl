#!/usr/bin/perl
use strict;  use warnings;

use Test::More tests => 48;
#use Test::More;

# MyConfig
BEGIN { use lib '/tmp/RPerl-latest/lib/CPAN/';  use_ok('MyConfig'); }


# Inline::C examples from:  http://search.cpan.org/~sisyphus/Inline-0.53/C/C-Cookbook.pod
# Note: I excluded the Inline::C examples which required reading files, loading 3rd-party libraries, and other weirdness not suitable for testing.

# greet()
eval 'use Inline C=>q{char* greet(){return("Hello, world");}};';  ## no critic
is($@, '', 'Inline::C, define greet()');
my $greet_retval = eval 'greet();';  ## no critic
is($@, '', 'Inline::C, call greet(), no error');
is($greet_retval, 'Hello, world', 'Inline::C, call greet(), correct return value');

# greet_bind()
eval 'use Inline; Inline->bind(C=>q{char* greet_bind(){return("Hello again, world");}})';  ## no critic
is($@, '', 'Inline::C, define greet_bind()');
my $greet_bind_retval = eval 'greet_bind();';  ## no critic
is($@, '', 'Inline::C, call greet_bind(), no error');
is($greet_bind_retval, 'Hello again, world', 'Inline::C, call greet_bind(), correct return value');

# JAxH()
eval 'use Inline C=>q{SV*JAxH(char*x){return newSVpvf("Just Another %s Hacker",x);}};';  ## no critic
is($@, '', 'Inline::C, define JAxH()');
my $jaxh_retval = eval 'JAxH("Perl");';  ## no critic
is($@, '', 'Inline::C, call JAxH(), no error');
is($jaxh_retval, 'Just Another Perl Hacker', 'Inline::C, call JAxH(), correct return value');

# greetings_char()
my $greetings_char_eval_string =<<'EOF';
use Inline C => <<'END_OF_C_CODE';
char* greetings_char(SV* name1, ...) {
	Inline_Stack_Vars;
	int i;
	SV* retval = newSVpv("", 0);
	for (i = 0; i < Inline_Stack_Items; i++)
	{
		retval = newSVpvf("%sHello %s!  ", SvPV(retval, PL_na), SvPV(Inline_Stack_Item(i), PL_na));
//		printf("in greetings_char(), for() loop i = %d, have retval ='%s'\n", i, SvPV_nolen(retval));
	}
	return(SvPV_nolen(retval));
}
END_OF_C_CODE
EOF
eval $greetings_char_eval_string;  ## no critic
is($@, '', 'Inline::C, define greetings_char()');
my $greetings_char_retval = eval 'greetings_char("Larry", "Ingy", "Reini", "Neil", "Sisyphus", "Davido");';  ## no critic
is($@, '', 'Inline::C, call greetings_char(), no error');
is($greetings_char_retval, 'Hello Larry!  Hello Ingy!  Hello Reini!  Hello Neil!  Hello Sisyphus!  Hello Davido!  ', 'Inline::C, call greetings_char(), correct return value');

# greetings_sv()
my $greetings_sv_eval_string =<<'EOF';
use Inline C => <<'END_OF_C_CODE';
SV* greetings_sv(SV* retval, SV* name1, ...) {
	Inline_Stack_Vars;
	int i;
	for (i = 1; i < Inline_Stack_Items; i++)
	{
		retval = newSVpvf("%sHello %s!  ", SvPV(retval, PL_na), SvPV(Inline_Stack_Item(i), PL_na));
//		printf("in greetings_sv(), for() loop i = %d, have retval ='%s'\n", i, SvPV_nolen(retval));
	}
	return(retval);
}
END_OF_C_CODE
EOF
eval $greetings_sv_eval_string;  ## no critic
is($@, '', 'Inline::C, define greetings_sv()');
my $greetings_sv_retval = '';
$greetings_sv_retval = eval 'greetings_sv($greetings_sv_retval, "Larry", "Ingy", "Reini", "Neil", "Sisyphus", "Davido");';  ## no critic
is($@, '', 'Inline::C, call greetings_sv(), no error');
is($greetings_sv_retval, 'Hello Larry!  Hello Ingy!  Hello Reini!  Hello Neil!  Hello Sisyphus!  Hello Davido!  ', 'Inline::C, call greetings_sv(), correct return value');

# greetings_void()
my $greetings_void_eval_string =<<'EOF';
use Inline C => <<'END_OF_C_CODE';
void greetings_void(SV* name1, ...) {
	Inline_Stack_Vars;
	int i;
	SV* retval = newSVpv("", 0);
	for (i = 0; i < Inline_Stack_Items; i++)
	{
		retval = newSVpvf("%sHello %s!  ", SvPV(retval, PL_na), SvPV(Inline_Stack_Item(i), PL_na));
//		printf("in greetings_void(), for() loop i = %d, have retval ='%s'\n", i, SvPV_nolen(retval));
	}
	Inline_Stack_Reset;
	Inline_Stack_Push(sv_2mortal(retval));
	Inline_Stack_Done;
}
END_OF_C_CODE
EOF
eval $greetings_void_eval_string;  ## no critic
is($@, '', 'Inline::C, define greetings_void()');
my $greetings_void_retval = eval 'greetings_void("Larry", "Ingy", "Reini", "Neil", "Sisyphus", "Davido");';  ## no critic
is($@, '', 'Inline::C, call greetings_void(), no error');
is($greetings_void_retval, 'Hello Larry!  Hello Ingy!  Hello Reini!  Hello Neil!  Hello Sisyphus!  Hello Davido!  ', 'Inline::C, call greetings_void(), correct return value');

# change()
my $change_eval_string =<<'EOF';
use Inline C => <<'END_OF_C_CODE';
int change(SV* var1, SV* var2) {
	sv_setpvn(var1, "Perl Rocks!", 11);
	sv_setpvn(var2, "Inline Rules!", 13);
	return 1;
}
END_OF_C_CODE
EOF
eval $change_eval_string;  ## no critic
is($@, '', 'Inline::C, define change()');
my ($foo, $bar);
my $change_retval = eval 'change($foo, $bar);';  ## no critic
is($@, '', 'Inline::C, call change(), no error');
cmp_ok($change_retval, '==', 1, 'Inline::C, call change(), correct return value');
is($foo, 'Perl Rocks!', 'Inline::C, call change(), correctly changed $foo');
is($bar, 'Inline Rules!', 'Inline::C, call change(), correctly changed $bar');


# Inline::CPP examples from:  http://search.cpan.org/~davido/Inline-CPP-0.44/lib/Inline/CPP.pod
# Note: I did not exclude any Inline::CPP examples, they are all suitable for testing.

# class Farmer, AKA "Farmer Bob"
my $farmer_define_eval_string =<<'EOF';
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
eval $farmer_define_eval_string;  ## no critic
is($@, '', 'Inline::CPP, define class Farmer');
my $farmer_call_eval_string =<<'EOF';
my $farmer = new Farmer("Ingy", 42);
my $slavedriver = 1;
while($farmer->how_tired < 420) {
	$farmer->do_chores($slavedriver);
	$slavedriver <<= 1;
}
return("Wow!  The farmer worked " . $farmer->how_long . " hours!");
EOF
my $farmer_retval = eval "$farmer_call_eval_string";  ## no critic
is($@, '', 'Inline::CPP, call Farmer methods, no error');
is($farmer_retval, 'Wow!  The farmer worked 15 hours!', 'Inline::CPP, call Farmer methods, correct return value');

# class Airplane, AKA "Plane and Simple"
my $airplane_define_eval_string =<<'EOF';
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
eval $airplane_define_eval_string;  ## no critic
is($@, '', 'Inline::CPP, define class Airplane');
my $airplane_call_eval_string =<<'EOF';
my $plane = new Airplane;
my $plane_retval1 = $plane->nonprint;
my $plane_retval2 = '';
if ($plane->isa("Object")) { $plane_retval2 .= "Plane is an Object!"; }
unless ($plane->can("fly")) { $plane_retval2 .= "  This plane sucks!"; }
return($plane_retval1, $plane_retval2);
EOF
my ($airplane_retval1, $airplane_retval2) = eval "$airplane_call_eval_string";  ## no critic
is($@, '', 'Inline::CPP, call Airplane methods, no error');
like($airplane_retval1, '/Object\ \(0x\w*\)/', 'Inline::CPP, call Airplane methods, correct return value 1');
is($airplane_retval2, 'Plane is an Object!  This plane sucks!', 'Inline::CPP, call Airplane methods, correct return value 2');

# average() VS avg(), AKA "The Ellipsis Abridged"
my $average_define_eval_string =<<'EOF';
sub average {
	my $average = 0;
	for (my $i=0; $i<@_; $i++) {
		$average *= $i;
		$average += $_[$i];
		$average /= $i + 1;
	}
	return $average;
}
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
eval $average_define_eval_string;  ## no critic
is($@, '', 'Inline::CPP, define average() and avg()');
my $average_call_eval_string =<<'EOF';
my @numbers = map { rand } (1 .. 10000);
my $average_retval = average(@numbers);
my $avg_retval = avg(@numbers);
my $average_retval_string = "The Perl average of 10000 random numbers is: " . $average_retval;
my $avg_retval_string = "The C/C++ average of 10000 random numbers is: " . $avg_retval;
return($average_retval, $avg_retval, $average_retval_string, $avg_retval_string);
EOF
my ($average_retval, $avg_retval, $average_retval_string, $avg_retval_string) = eval "$average_call_eval_string";  ## no critic
is($@, '', 'Inline::CPP, call average() and avg(), no error');
like($average_retval_string, '/The Perl average of 10000 random numbers is: \d+.\d+/', 'Inline::CPP, call average() and avg(), correct Perl string return value');
like($avg_retval_string, '/The C\/C\+\+ average of 10000 random numbers is: \d+.\d+/', 'Inline::CPP, call average() and avg(), correct C/C++ string return value');
cmp_ok(abs($average_retval - $avg_retval), '<', 0.000000001, 'Inline::CPP, call average() and avg(), Perl and C/C++ numeric return values are equivalent (enough)');

# classes Queue and Stack, AKA "Stacks and Queues"
my $queuestack_define_eval_string =<<'EOF';
use Inline CPP => <<'END_OF_CPP_CODE';
class Queue {
	public:
		Queue(int sz=0) { q = newAV(); if (sz) av_extend(q, sz-1); }
		~Queue() { av_undef(q); }
		int size() {return av_len(q) + 1; }
		int enqueue(SV *item) { av_push(q, SvREFCNT_inc(item)); return av_len(q)+1; }
		SV *dequeue() { return av_shift(q); }
		SV *peek() { return size() ? SvREFCNT_inc(*av_fetch(q,0,0)): &PL_sv_undef;}
	private:
		AV *q;
};
class Stack {
	public:
		Stack(int sz=0) { s = newAV(); if (sz) av_extend(s, sz-1); }
		~Stack() { av_undef(s); }
		int size() { return av_len(s) + 1; }
		int push(SV *i) { av_push(s, SvREFCNT_inc(i)); return av_len(s)+1; }
		SV *pop() { return av_pop(s); }
		SV *peek() { return size() ? SvREFCNT_inc(*av_fetch(s,size()-1,0)) : &PL_sv_undef; }
	private:
		AV *s;
};
END_OF_CPP_CODE
EOF
eval $queuestack_define_eval_string;  ## no critic
is($@, '', 'Inline::CPP, define classes Queue and Stack');
my $queuestack_call_eval_string =<<'EOF';
my $q = new Queue;
my $queue_retval = '';
$q->enqueue(50);
$q->enqueue("Where am I?");
$q->enqueue("In a queue.");
#print "There are ", $q->size, " items in the queue\n";
while($q->size) {
#	print "About to dequeue: ", $q->peek, "\n";
#	print "Actually dequeued: ", $q->dequeue, "\n";
	$queue_retval .= $q->dequeue . '  ';
}
my $s = new Stack;
my $stack_retval = '';
$s->push(42);
$s->push("What?");
#print "There are ", $s->size, " items on the stack\n";
while($s->size) {
#	print "About to pop: ", $s->peek, "\n";
#	print "Actually popped: ", $s->pop, "\n";
	$stack_retval .= $s->pop . '  ';
}
return($queue_retval, $stack_retval);
EOF
my ($queue_retval, $stack_retval) = eval "$queuestack_call_eval_string";  ## no critic
is($@, '', 'Inline::CPP, call Queue and Stack methods, no error');
is($queue_retval, '50  Where am I?  In a queue.  ', 'Inline::CPP, call Queue and Stack methods, correct Queue return value');
is($stack_retval, 'What?  42  ', 'Inline::CPP, call Queue and Stack methods, correct Stack return value');

# multiadd(), AKA "Elipses Revisited (and Overloading or Templates)"
my $multiadd_define_eval_string =<<'EOF';
use Inline CPP => <<'END_OF_CPP_CODE';
#include <stdexcept>
// Inline::CPP won't create predictable bindings to overloaded functions.
int add ( int a, int b ) { return a + b; }
int add ( int a, int b, int c ) { return a + b + c; }
// But a function call with elipses can dispatch to overloaded functions since
// no Perl binding is required in reaching those functions.
int multiadd ( SV * a, ... ) {
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
eval $multiadd_define_eval_string;  ## no critic
is($@, '', 'Inline::CPP, define multiadd()');
my $multiadd_retval;
$multiadd_retval = eval 'return(multiadd(1));  # No dispatch; just return the value';  ## no critic
is($@, '', 'Inline::CPP, call multiadd(1), no error');
cmp_ok($multiadd_retval, '==', 1, 'Inline::CPP, call multiadd(1), correct return value');
$multiadd_retval = eval 'multiadd(1, 2);  # Dispatch add(int, int)';  ## no critic
is($@, '', 'Inline::CPP, call multiadd(1, 2), no error');
cmp_ok($multiadd_retval, '==', 3, 'Inline::CPP, call multiadd(1, 2), correct return value');
$multiadd_retval = eval 'multiadd(1, 2, 3);  # Dispatch add(int, int, int)';  ## no critic
is($@, '', 'Inline::CPP, call multiadd(1, 2, 3), no error');
cmp_ok($multiadd_retval, '==', 6, 'Inline::CPP, call multiadd(1, 2, 3), correct return value');
$multiadd_retval = eval 'multiadd(1, 2, 3, 4);  # No dispatch; throw an exception';  ## no critic
like($@, '/^multiadd\(\) \- Too many args in function call at/', 'Inline::CPP, call multiadd(1, 2, 3, 4), correct exception thrown and caught');

#done_testing();