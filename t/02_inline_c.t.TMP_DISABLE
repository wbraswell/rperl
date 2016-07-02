#!/usr/bin/perl
use strict;
use warnings;
our $VERSION = 0.001_010;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitStringyEval)  # SYSTEM DEFAULT 1: allow eval()
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

use Test::More tests => 16;
use Test::Exception;
use Carp;
use English qw(-no_match_vars);

#$SIG{__WARN__}=sub {cluck $_[0]};  # DEBUGGING

BEGIN {
    if ( $ENV{RPERL_VERBOSE} ) {
        diag('[[[ Beginning Inline::C Pre-Test Loading ]]]');
    }
}
if ( $ENV{RPERL_VERBOSE} ) {
    diag('[[[ Beginning Selection Of Tests From The Inline::C Cookbook ]]]');
}

# Inline::C examples from:  http://search.cpan.org/~sisyphus/Inline-0.53/C/C-Cookbook.pod
# Note: I excluded the Inline::C examples which required reading files, loading 3rd-party libraries, and other weirdness not suitable for testing.

# greet()
#lives_ok( sub { use Inline C => q{charge* greet(){return("Hello, world");}}; }, q{Inline::C, define greet() lives} );  # bad: invokes Inline during syntax check and crashes all tests
lives_and(
    sub {
        my $EVAL_RETVAL = eval 'use Inline C=>q{char* greet(){return("Hello, world");}};';

        #            '$SIG{__WARN__}=sub {cluck $_[0]};  use Inline C=>q{char* greet(){return("Hello, world");}};';
        if ( $EVAL_ERROR ne q{} ) {
            croak("Error in eval, have \$EVAL_ERROR =\n\nBEGIN EVAL ERROR\n\n$EVAL_ERROR\n\nEND EVAL ERROR\n\ncroaking");
        }
        is( $EVAL_RETVAL, undef, q{Inline::C, define greet() returns correct value} );
    },
    q{Inline::C, define greet() lives}
);
lives_and(
    sub {
        my $EVAL_RETVAL = eval 'greet();';
        if ( $EVAL_ERROR ne q{} ) {
            croak("Error in eval, have \$EVAL_ERROR =\n\nBEGIN EVAL ERROR\n\n$EVAL_ERROR\n\nEND EVAL ERROR\n\ncroaking");
        }
        is( $EVAL_RETVAL, 'Hello, world', q{Inline::C, call greet() returns correct value} );
    },
    q{Inline::C, call greet() lives}
);

# greet_bind()
lives_and(
    sub {
        my $EVAL_RETVAL = eval 'use Inline; Inline->bind(C=>q{char* greet_bind(){return("Hello again, world");}})';
        if ( $EVAL_ERROR ne q{} ) {
            croak("Error in eval, have \$EVAL_ERROR =\n\nBEGIN EVAL ERROR\n\n$EVAL_ERROR\n\nEND EVAL ERROR\n\ncroaking");
        }
        like(
            $EVAL_RETVAL, '/HASH\(0x\w*\)/',    ## RPERL SYSTEM allow like() regex
            q{Inline::C, define greet_bind() returns correct value}
        );
    },
    q{Inline::C, define greet_bind() lives}
);
lives_and(
    sub {
        my $EVAL_RETVAL = eval 'greet_bind();';
        if ( $EVAL_ERROR ne q{} ) {
            croak("Error in eval, have \$EVAL_ERROR =\n\nBEGIN EVAL ERROR\n\n$EVAL_ERROR\n\nEND EVAL ERROR\n\ncroaking");
        }
        is( $EVAL_RETVAL, 'Hello again, world', q{Inline::C, call greet_bind() returns correct value} );
    },
    q{Inline::C, call greet_bind() lives}
);

# JAxH()
lives_and(
    sub {
        my $EVAL_RETVAL = eval 'use Inline C=>q{SV*JAxH(char*x){return newSVpvf("Just Another %s Hacker",x);}};';
        if ( $EVAL_ERROR ne q{} ) {
            croak("Error in eval, have \$EVAL_ERROR =\n\nBEGIN EVAL ERROR\n\n$EVAL_ERROR\n\nEND EVAL ERROR\n\ncroaking");
        }
        is( $EVAL_RETVAL, undef, q{Inline::C, define JAxH() returns correct value} );
    },
    q{Inline::C, define JAxH() lives}
);
lives_and(
    sub {
        my $EVAL_RETVAL = eval 'JAxH("Perl");';
        if ( $EVAL_ERROR ne q{} ) {
            croak("Error in eval, have \$EVAL_ERROR =\n\nBEGIN EVAL ERROR\n\n$EVAL_ERROR\n\nEND EVAL ERROR\n\ncroaking");
        }
        is( $EVAL_RETVAL, 'Just Another Perl Hacker', q{Inline::C, call JAxH() returns correct value} );
    },
    q{Inline::C, call JAxH() lives}
);

# greetings_char()
my $greetings_char_eval_string = <<'EOF';
#use Inline C => <<'END_OF_C_CODE';  # NEED FIX: Inline::C pegex elipses issue https://github.com/ingydotnet/inline-c-pm/issues/25
use Inline C => <<'END_OF_C_CODE' => using => 'ParseRecDescent';
char* greetings_char(SV* name1, ...) {
	Inline_Stack_Vars;
	int i;
	SV* retval = newSVpv("", 0);
	for (i = 0; i < Inline_Stack_Items; i++)
	{
		retval = newSVpvf("%sHello %s!  ", SvPV(retval, PL_na), SvPV(Inline_Stack_Item(i), PL_na));
//		printf("in greetings_char(), for() loop i = %ld, have retval ='%s'\n", i, SvPV_nolen(retval));
	}
	return(SvPV_nolen(retval));
}
END_OF_C_CODE
EOF
lives_and(
    sub {
        my $EVAL_RETVAL = eval $greetings_char_eval_string;
        if ( $EVAL_ERROR ne q{} ) {
            croak("Error in eval, have \$EVAL_ERROR =\n\nBEGIN EVAL ERROR\n\n$EVAL_ERROR\n\nEND EVAL ERROR\n\ncroaking");
        }
        is( $EVAL_RETVAL, undef, q{Inline::C, define greetings_char() returns correct value} );
    },
    q{Inline::C, define greetings_char() lives}
);
lives_and(
    sub {
        my $EVAL_RETVAL = eval 'greetings_char("Larry", "Ingy", "Reini", "Neil", "Sisyphus", "Davido");';
        if ( $EVAL_ERROR ne q{} ) {
            croak("Error in eval, have \$EVAL_ERROR =\n\nBEGIN EVAL ERROR\n\n$EVAL_ERROR\n\nEND EVAL ERROR\n\ncroaking");
        }
        is( $EVAL_RETVAL,
            'Hello Larry!  Hello Ingy!  Hello Reini!  Hello Neil!  Hello Sisyphus!  Hello Davido!  ',
            q{Inline::C, call greetings_char() returns correct value}
        );
    },
    q{Inline::C, call greetings_char() lives}
);

# greetings_sv()
my $greetings_sv_eval_string = <<'EOF';
#use Inline C => <<'END_OF_C_CODE';  # NEED FIX: Inline::C pegex elipses issue https://github.com/ingydotnet/inline-c-pm/issues/25
use Inline C => <<'END_OF_C_CODE' => using => 'ParseRecDescent';
SV* greetings_sv(SV* retval, SV* name1, ...) {
	Inline_Stack_Vars;
	int i;
	for (i = 1; i < Inline_Stack_Items; i++)
	{
		retval = newSVpvf("%sHello %s!  ", SvPV(retval, PL_na), SvPV(Inline_Stack_Item(i), PL_na));
//		printf("in greetings_sv(), for() loop i = %ld, have retval ='%s'\n", i, SvPV_nolen(retval));
	}
	return retval;
}
END_OF_C_CODE
EOF
lives_and(
    sub {
        my $EVAL_RETVAL = eval $greetings_sv_eval_string;
        if ( $EVAL_ERROR ne q{} ) {
            croak("Error in eval, have \$EVAL_ERROR =\n\nBEGIN EVAL ERROR\n\n$EVAL_ERROR\n\nEND EVAL ERROR\n\ncroaking");
        }
        is( $EVAL_RETVAL, undef, q{Inline::C, define greetings_sv() returns correct value} );
    },
    q{Inline::C, define greetings_sv() lives}
);
lives_and(
    sub {
        my $greetings_sv_retval = q{};
        my $EVAL_RETVAL         = eval 'greetings_sv($greetings_sv_retval, "Larry", "Ingy", "Reini", "Neil", "Sisyphus", "Davido");';
        if ( $EVAL_ERROR ne q{} ) {
            croak("Error in eval, have \$EVAL_ERROR =\n\nBEGIN EVAL ERROR\n\n$EVAL_ERROR\n\nEND EVAL ERROR\n\ncroaking");
        }
        is( $EVAL_RETVAL,
            'Hello Larry!  Hello Ingy!  Hello Reini!  Hello Neil!  Hello Sisyphus!  Hello Davido!  ',
            q{Inline::C, call greetings_sv() returns correct value}
        );
    },
    q{Inline::C, call greetings_sv() lives}
);

# greetings_void()
my $greetings_void_eval_string = <<'EOF';
#use Inline C => <<'END_OF_C_CODE';  # NEED FIX: Inline::C pegex elipses issue https://github.com/ingydotnet/inline-c-pm/issues/25
use Inline C => <<'END_OF_C_CODE' => using => 'ParseRecDescent';
void greetings_void(SV* name1, ...) {
	Inline_Stack_Vars;
	int i;
	SV* retval = newSVpv("", 0);
	for (i = 0; i < Inline_Stack_Items; i++)
	{
		retval = newSVpvf("%sHello %s!  ", SvPV(retval, PL_na), SvPV(Inline_Stack_Item(i), PL_na));
//		printf("in greetings_void(), for() loop i = %ld, have retval ='%s'\n", i, SvPV_nolen(retval));
	}
	Inline_Stack_Reset;
	Inline_Stack_Push(sv_2mortal(retval));
	Inline_Stack_Done;
}
END_OF_C_CODE
EOF
lives_and(
    sub {
        my $EVAL_RETVAL = eval $greetings_void_eval_string;
        if ( $EVAL_ERROR ne q{} ) {
            croak("Error in eval, have \$EVAL_ERROR =\n\nBEGIN EVAL ERROR\n\n$EVAL_ERROR\n\nEND EVAL ERROR\n\ncroaking");
        }
        is( $EVAL_RETVAL, undef, q{Inline::C, define greetings_void() returns correct value} );
    },
    q{Inline::C, define greetings_void() lives}
);
lives_and(
    sub {
        my $EVAL_RETVAL = eval 'greetings_void("Larry", "Ingy", "Reini", "Neil", "Sisyphus", "Davido");';
        if ( $EVAL_ERROR ne q{} ) {
            croak("Error in eval, have \$EVAL_ERROR =\n\nBEGIN EVAL ERROR\n\n$EVAL_ERROR\n\nEND EVAL ERROR\n\ncroaking");
        }
        is( $EVAL_RETVAL,
            'Hello Larry!  Hello Ingy!  Hello Reini!  Hello Neil!  Hello Sisyphus!  Hello Davido!  ',
            q{Inline::C, call greetings_void() returns correct value}
        );
    },
    q{Inline::C, call greetings_void() lives}
);

# change()
my $change_eval_string = <<'EOF';
use Inline C => <<'END_OF_C_CODE';
int change(SV* var1, SV* var2) {
	sv_setpvn(var1, "Perl Rocks!", 11);
	sv_setpvn(var2, "Inline Rules!", 13);
	return 1;
}
END_OF_C_CODE
EOF
lives_and(
    sub {
        my $EVAL_RETVAL = eval $change_eval_string;
        if ( $EVAL_ERROR ne q{} ) {
            croak("Error in eval, have \$EVAL_ERROR =\n\nBEGIN EVAL ERROR\n\n$EVAL_ERROR\n\nEND EVAL ERROR\n\ncroaking");
        }
        is( $EVAL_RETVAL, undef, q{Inline::C, define change() returns correct value} );
    },
    q{Inline::C, define change() lives}
);
lives_and(
    sub {
        my ( $foo, $bar );
        my $EVAL_RETVAL = eval 'change($foo, $bar);';
        if ( $EVAL_ERROR ne q{} ) {
            croak("Error in eval, have \$EVAL_ERROR =\n\nBEGIN EVAL ERROR\n\n$EVAL_ERROR\n\nEND EVAL ERROR\n\ncroaking");
        }
        cmp_ok( $EVAL_RETVAL, q{==}, 1, q{Inline::C, call change() returns correct value} );
        is( $foo, 'Perl Rocks!',   'Inline::C, call change(), correctly change variable 1' );
        is( $bar, 'Inline Rules!', 'Inline::C, call change(), correctly change variable 2' );
    },
    q{Inline::C, call change() lives}
);

done_testing();
