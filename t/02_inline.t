#!/usr/bin/perl
use strict;  use warnings;

#use Test::More tests => 1;
use Test::More;

# MyConfig
BEGIN { use lib '/tmp/RPerl-latest/lib/CPAN/';  use_ok('MyConfig'); }

# greet()
eval 'use Inline C=>q{char* greet(){return("Hello, world");}};';  ## no critic
is($@, '', 'Inline::C, define greet()');
my $greet_retval = eval 'greet();';  ## no critic
is($@, '', 'Inline::C, call greet(), no error');
is($greet_retval, 'Hello, world', 'Inline::C, call greet(), proper return value');

# JAxH()
eval 'use Inline C=>q{SV*JAxH(char*x){return newSVpvf("Just Another %s Hacker",x);}};';  ## no critic
is($@, '', 'Inline::C, define JAxH()');
my $jaxh_retval = eval 'JAxH("Perl");';  ## no critic
is($@, '', 'Inline::C, call JAxH(), no error');
is($jaxh_retval, 'Just Another Perl Hacker', 'Inline::C, call JAxH(), proper return value');

# greetings()
my $greetings_eval_string =<<'EOF';
use Inline C => <<'END_OF_C_CODE';
//SV* greetings(SV* name1, ...) {
char* greetings(SV* name1, ...) {
	Inline_Stack_Vars;
	int i;
	SV* retval = newSVpv("", 0);
	for (i = 0; i < Inline_Stack_Items; i++)
	{
		retval = newSVpvf("%sHello %s!  ", SvPV(retval, PL_na), SvPV(Inline_Stack_Item(i), PL_na));
//		printf("in greetings(), for() loop i = %d, have retval ='%s'\n", i, SvPV_nolen(retval));
	}
//	Inline_Stack_Void;
//	Inline_Stack_Reset;
//	Inline_Stack_Push(sv_2mortal(retval));
//	Inline_Stack_Done;	
	return(SvPV_nolen(retval));
}
END_OF_C_CODE
EOF
eval $greetings_eval_string;  ## no critic
is($@, '', 'Inline::C, define greetings()');
my $greetings_retval = eval 'greetings("Larry", "Ingy", "Reini", "Neil", "Sisyphus", "Davido");';  ## no critic
is($@, '', 'Inline::C, call greetings(), no error');
is($greetings_retval, 'Hello Larry!  Hello Ingy!  Hello Reini!  Hello Neil!  Hello Sisyphus!  Hello Davido!  ', 'Inline::C, call greetings(), proper return value');

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
cmp_ok($change_retval, '==', 1, 'Inline::C, call change(), proper return value');
is($foo, 'Perl Rocks!', 'Inline::C, call change(), properly changed $foo');
is($bar, 'Inline Rules!', 'Inline::C, call change(), properly changed $bar');


# START HERE, CREATE C++ TESTS
# START HERE, CREATE C++ TESTS
# START HERE, CREATE C++ TESTS


done_testing();