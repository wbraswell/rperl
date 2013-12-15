#!/usr/bin/perl
## no critic qw(ProhibitUselessNoCritic)  ## RPERL allow disabled test code
## no critic qw(ProhibitMagicNumbers)  ## RPERL allow numeric test values
## no critic qw(ProhibitUnreachableCode)  ## RPERL allow unreachable test code
## no critic qw(ProhibitStringySplit)  ## RPERL allow string test values
## no critic qw(ProhibitInterpolationOfLiterals)  ## RPERL allow string test values
## no critic qw(RequireInterpolationOfMetachars)  ## RPERL allow string test values
use strict;
use warnings;
use version; our $VERSION = qv('0.2.7');
use Carp;

# [[[ SETUP ]]]

# RPERL DRTIVER BOILERPLATE
BEGIN { package main;  our $RPERL_INCLUDE_PATH = '/tmp/RPerl-latest/lib'; }  # NEED REMOVE hard-coded path
BEGIN { use lib $main::RPERL_INCLUDE_PATH . '/CPAN/';  use MyConfig; }  # RPerl's MyConfig.pm 
BEGIN { use lib $main::RPERL_INCLUDE_PATH;  use RPerl;  use parent ('RPerl');  $RPerl::INCLUDE_PATH = $main::RPERL_INCLUDE_PATH; }  # RPerl system files
BEGIN { use Data::Dumper;  our $AUTOLOAD;  sub AUTOLOAD { croak("AUTOLOAD purposefully disabled for debugging, have \$AUTOLOAD = '$AUTOLOAD' and \@_ = \n" . Dumper(\@_) . ', croaking'); } }  ## no critic qw(ProhibitAutoloading RequireArgUnpacking)  ## RPERL SYSTEM allow autoload  ## RPERL SYSTEM allow read-only @_

# UNCOMMENT TO ENABLE PERL TYPES FOR C++ OPS
#types::types_enable('PERL');

# UNCOMMENT TO ENABLE C++ TYPES FOR C++ OPS
#types::types_enable('CPP');

# UNCOMMENT TO ENABLE C++ OPS
#use RPerl::DataType::Integer_cpp;  RPerl::DataType::Integer_cpp::cpp_load();  RPerl::DataType::Integer_cpp::cpp_link();
#use RPerl::DataType::Number_cpp;  RPerl::DataType::Number_cpp::cpp_load();  RPerl::DataType::Number_cpp::cpp_link();
#use RPerl::DataType::String_cpp;  RPerl::DataType::String_cpp::cpp_load();  RPerl::DataType::String_cpp::cpp_link();

print q{in scalar_test.pl, have integer::ops() = '} . integer::ops() . "'\n" or croak();
print q{in scalar_test.pl, have integer::types() = '} . integer::types() . "'\n" or croak();
print q{in scalar_test.pl, have number::ops() = '} . number::ops() . "'\n" or croak();
print q{in scalar_test.pl, have number::types() = '} . number::types() . "'\n" or croak();
print q{in scalar_test.pl, have string::ops() = '} . string::ops() . "'\n" or croak();
print q{in scalar_test.pl, have string::types() = '} . string::types() . "'\n" or croak();

# variable declarations
my integer $integer_retval;
my number $number_retval;
my string $string_retval;
my string $my_string;
my string $dumper_string;

# loop to test for memory leaks
my const_integer $i_MAX = 1;
for my integer $i ( 0 .. $i_MAX ) {
	print "in scalar_test.pl, top of for() loop $i/$i_MAX\n\n" or croak();

    # [[[ INTEGER TESTS ]]]

#	$string_retval = integer::stringify();  # TIV00; error PERLOPS EIV00, CPPOPS "Usage: main::integer::stringify(input_integer)"
#	$string_retval = integer::stringify(undef);  # TIV01; error EIV00
#	$string_retval = integer::stringify(3);  # TIV02
#	$string_retval = integer::stringify(-17);  # TIV03
#	$string_retval = integer::stringify(-17.3);  # TIV04; error EIV01
#	$string_retval = integer::stringify('-17.3');  # TIV05; error EIV01
#	$string_retval = integer::stringify([3]);  # TIV06; error EIV01
#	$string_retval = integer::stringify({a_key => 3});  # TIV07; error EIV01
#	$string_retval = integer::stringify(-1_234_567_890);  # TIV08
#	$string_retval = integer::stringify(-1_234_567_890_000);  # TIV09; error EIV01
#	print "in scalar_test.pl $i/$i_MAX, have \$string_retval = '$string_retval'\n" or croak();

#	$integer_retval = integer::typetest___void__in();  # TIV10
#	print "in scalar_test.pl $i/$i_MAX, have \$integer_retval = $integer_retval\n" or croak();

#	$integer_retval = integer::typetest___integer__in();  # TIV20; error PERLOPS EIV00, CPPOPS "Usage: main::integer::typetest___integer__in(lucky_integer)"
#	$integer_retval = integer::typetest___integer__in(undef);  # TIV21; error EIV00
#	$integer_retval = integer::typetest___integer__in(3);  # TIV22
#	$integer_retval = integer::typetest___integer__in(-17);  # TIV23
#	$integer_retval = integer::typetest___integer__in(-17.3);  # TIV24; error EIV01
#	$integer_retval = integer::typetest___integer__in('-17.3');  # TIV25; error EIV01
#	$integer_retval = integer::typetest___integer__in([3]);  # TIV26; error EIV01
#	$integer_retval = integer::typetest___integer__in({a_key => 3});  # TIV27; error EIV01
##	$integer_retval = integer::typetest___integer__in(-1_234_567_890);  # NOT TEST-WORTHY: arithmetic overflow, incorrect results
#	$integer_retval = integer::typetest___integer__in(-234_567_890);  # TIV28
#	$integer_retval = integer::typetest___integer__in(-1_234_567_890_000);  # TIV29; error EIV01
#	print "in scalar_test.pl $i/$i_MAX, have \$integer_retval = $integer_retval\n" or croak();

    # [[[ NUMBER TESTS ]]]

#	$string_retval = number::stringify();  # TNV00; error PERLOPS ENV00, CPPOPS "Usage: main::number::stringify(input_number)"
#	$string_retval = number::stringify(undef);  # TNV01; error ENV00
#	$string_retval = number::stringify(3);  # TNV02
#	$string_retval = number::stringify(-17);  # TNV03
#	$string_retval = number::stringify(-17.3);  # TNV04
#	$string_retval = number::stringify('-17.3');  # TNV05; error ENV01
#	$string_retval = number::stringify([3]);  # TNV06; error ENV01
#	$string_retval = number::stringify({a_key => 3});  # TNV07; error ENV01
#	$string_retval = number::stringify(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679);  # TNV08
#	print "in scalar_test.pl $i/$i_MAX, have \$string_retval = '$string_retval'\n" or croak();

#	$number_retval = number::typetest___void__in();  # TNV10
#	print "in scalar_test.pl $i/$i_MAX, have \$number_retval = $number_retval\n" or croak();

#	$number_retval = number::typetest___number__in();  # TNV20; error PERLOPS ENV00, CPPOPS "Usage: main::number::typetest___number__in(lucky_number)"
#	$number_retval = number::typetest___number__in(undef);  # TNV21; error ENV00
#	$number_retval = number::typetest___number__in(3);  # TNV22
#	$number_retval = number::typetest___number__in(-17);  # TNV23
#	$number_retval = number::typetest___number__in(-17.3);  # TNV24
#	$number_retval = number::typetest___number__in('-17.3');  # TNV25; error ENV01
#	$number_retval = number::typetest___number__in([3]);  # TNV26; error ENV01
#	$number_retval = number::typetest___number__in({a_key => 3});  # TNV27; error ENV01
#	$number_retval = number::typetest___number__in(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679);  # TNV28
#	print "in scalar_test.pl $i/$i_MAX, have \$number_retval = $number_retval\n" or croak();

croak('Done for now, croaking');




# FIRST! 
# Ambiguous use of *{main::CHECK_HASH_REF} resolved to *main::CHECK_HASH_REF at (eval 286) line 1, <MODULE_FILE> line 46.
# Ambiguous use of ${main::CHECK_HASH_REF} resolved to $main::CHECK_HASH_REF at (eval 286) line 1, <MODULE_FILE> line 46.
# Subroutine main::CHECK_HASH_REF redefined at (eval 286) line 1, <MODULE_FILE> line 46.
    

    # START HERE: format string tests below, update 04*.t; check if additional string hash tests are needed, update 06*.t; update arrays; FINISH TYPE-CHECKING
    # START HERE: format string tests below, update 04*.t; check if additional string hash tests are needed, update 06*.t; update arrays; FINISH TYPE-CHECKING
    # START HERE: format string tests below, update 04*.t; check if additional string hash tests are needed, update 06*.t; update arrays; FINISH TYPE-CHECKING
 



    # [[[ STRING TESTS ]]]

#	$string_retval = stringify_string();  # TPV00; error PERLOPS EPV00, CPPOPS "Usage: main::stringify_string(input_string)"
#	$string_retval = stringify_string(undef);  # TPV01; error EPV00
#	$string_retval = stringify_string(3);  # TPV02; error EPV01
#	$string_retval = stringify_string(-17);  # TPV03; error EPV01
#	$string_retval = stringify_string(-17.3);  # TPV04; error EPV01
#	$string_retval = stringify_string('-17.3');  # TPV05
#	$string_retval = stringify_string([3]);  # TPV06; error EPV01
#	$string_retval = stringify_string({a_key => 3});  # TPV07; error EPV01

    # DEV NOTE: in English grammar, I prefer the comma after the right-quote
	$my_string = '\'I am a single-quoted string, in a single-quoted string with back-slash control chars\', the first string said introspectively.';  # TPVXX
#	$my_string = '"I am a double-quoted string, in a single-quoted string with no back-slash chars", the second string observed.';  # TPVXX
#	$my_string = "'I am a single-quoted string, in a double-quoted string with no back-slash chars', the third string added.";  # TPVXX
#	$my_string = "\"I am a double-quoted string, in a double-quoted string with back-slash control chars\", the fourth string offered.";  # TPVXX

#	$my_string = '\'I am a single-quoted string, in a single-quoted string with back-slash control and \ display \ chars\', the fifth string shouted.';  # TPVXX
#	$my_string = '"I am a double-quoted string, in a single-quoted string with back-slash \ display \ chars", the sixth string hollered.';  # TPVXX
#	$my_string = "'I am a single-quoted string, in a double-quoted string with back-slash \\ display \\ chars', the seventh string yelled.";  # TPVXX
#	$my_string = "\"I am a double-quoted string, in a double-quoted string with back-slash control and \\ display \\ chars\", the eighth string belted.";  # TPVXX

#	$my_string = q{'I am a single-quoted string, in a single-quoted q{} string with no back-slash chars', the ninth string chimed in.};  # TPVXX
#	$my_string = q{"I am a double-quoted string, in a single-quoted q{} string with no back-slash chars", the tenth string opined.};  # TPVXX
#	$my_string = qq{'I am a single-quoted string, in a double-quoted qq{} string with no back-slash chars', the eleventh string asserted.};  # TPVXX
#	$my_string = qq{"I am a double-quoted string, in a double-quoted qq{} string with no back-slash chars", the twelfth string insisted.};  # TPVXX

#	$my_string = q{'I am a single-quoted string, in a single-quoted q{} string with back-slash \ display \ chars', the thirteenth string whispered.};  # TPVXX
#	$my_string = q{"I am a double-quoted string, in a single-quoted q{} string with back-slash \ display \ chars", the fourteenth string breathed.};  # TPVXX
#	$my_string = qq{'I am a single-quoted string, in a double-quoted qq{} string with back-slash \\ display \\ chars', the fifteenth string mouthed.};  # TPVXX
#	$my_string = qq{"I am a double-quoted string, in a double-quoted qq{} string with back-slash \\ display \\ chars", the sixteenth string implied.};  # TPVXX

	print "in scalar_test.pl $i/$i_MAX, have \$my_string =\n$my_string\n\n" or croak();
	$dumper_string = Dumper([$my_string]);
	$dumper_string =~ s/^\s+|\s+$//xmsg;
	my @dumper_split = split "\n", $dumper_string;
	$dumper_string = $dumper_split[1];
#	print "in scalar_test.pl $i/$i_MAX, have Dumper([\$my_string]) =\n" . Dumper([$my_string]) . "\n" or croak();

    $string_retval = stringify_string($my_string);
	print "in scalar_test.pl $i/$i_MAX, have \$string_retval =\n$string_retval STRINGIFY\n\n" or croak();
	print "in scalar_test.pl $i/$i_MAX, have \$dumper_string =\n$dumper_string DUMPERIFY\n\n" or croak();

#	$string_retval = typetest___void__in___string__out();  # TPV00
#	print "in scalar_test.pl $i/$i_MAX, have \$string_retval = '$string_retval'\n" or croak();

#	$string_retval = typetest___string__in___string__out();  # TPV10; error PERLOPS EPV00, CPPOPS "Usage: main::typetest___string__in___string__out(lucky_string)"
#	$string_retval = typetest___string__in___string__out(undef);  # TPV11; error EPV00
#	$string_retval = typetest___string__in___string__out(3);  # TPV12; error EPV01
#	$string_retval = typetest___string__in___string__out(-17);  # TPV13; error EPV01
#	$string_retval = typetest___string__in___string__out(-17.3);  # TPV14; error EPV01
#	$string_retval = typetest___string__in___string__out('-17.3');  # TPV15
#	$string_retval = typetest___string__in___string__out([3]);  # TPV16; error EPV01
#	$string_retval = typetest___string__in___string__out({a_key => 3});  # TPV17; error EPV01
#	$string_retval = typetest___string__in___string__out('Melange');  # TPV18
#	$string_retval = typetest___string__in___string__out("\nThe Spice Extends Life\nThe Spice Expands Consciousness\nThe Spice Is Vital To Space Travel\n");  # TPV19
#	print "in scalar_test.pl $i/$i_MAX, have \$string_retval = '$string_retval'\n" or croak();
}

#croak('Done for now, croaking');




