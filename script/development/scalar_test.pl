#!/usr/bin/perl
use strict;
use warnings;
use RPerl;
our $VERSION = 0.003_003;

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitUnreachableCode RequirePodSections RequirePodAtEnd PodSpelling) # DEVELOPER DEFAULT 1: allow unreachable & POD-commented code
## no critic qw(ProhibitStringySplit ProhibitInterpolationOfLiterals)  # DEVELOPER DEFAULT 2: allow string test values
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# UNCOMMENT TO ENABLE PERL TYPES FOR C++ OPS
#rperltypes::types_enable('PERL');

# UNCOMMENT TO ENABLE C++ TYPES FOR C++ OPS
rperltypes::types_enable('CPP');

# UNCOMMENT TO ENABLE C++ OPS
#use RPerl::DataType::Integer_cpp;  RPerl::DataType::Integer_cpp::cpp_load();
#use RPerl::DataType::Number_cpp;  RPerl::DataType::Number_cpp::cpp_load();
use RPerl::DataType::String_cpp;
RPerl::DataType::String_cpp::cpp_load();

RPerl::diag q{in scalar_test.pl, have integer__ops() = '} . integer__ops() . "'\n" or croak();
RPerl::diag q{in scalar_test.pl, have integer__types() = '} . integer__types() . "'\n" or croak();
RPerl::diag q{in scalar_test.pl, have number__ops() = '} . number__ops() . "'\n" or croak();
RPerl::diag q{in scalar_test.pl, have number__types() = '} . number__types() . "'\n" or croak();
RPerl::diag q{in scalar_test.pl, have string__ops() = '} . string__ops() . "'\n" or croak();
RPerl::diag q{in scalar_test.pl, have string__types() = '} . string__types() . "'\n" or croak();

# use Data::Dumper() to to stringify a string
#our string $string__dumperify = sub {  # NEED FIX: RPerl subroutines disabled here
sub string__dumperify {
    ( my string $input_string ) = @_;
        RPerl::diag "in scalar_test.pl string__dumperify(), received have \$input_string =\n$input_string\n\n" or croak();
        $input_string = Dumper( [$input_string] );
        $input_string =~ s/^\s+|\s+$//xmsg;         # strip leading whitespace
        my @input_string_split = split "\n", $input_string;
        $input_string = $input_string_split[1];    # only select the data line
        return $input_string;
}

# variable declarations
my integer $integer_retval;
my number $number_retval;
my string $string_retval;
my string $my_string;
my string $dumper_string;

# loop to test for memory leaks
my const_integer $i_MAX = 0;
for my integer $i ( 0 .. $i_MAX ) {
    RPerl::diag "in scalar_test.pl, top of for() loop $i/$i_MAX\n\n" or croak();

    # [[[ INTEGER TESTS ]]]

#    $string_retval = integer__stringify();  # TIV00; error PERLOPS EIV00, CPPOPS "Usage: main::integer__stringify(input_integer)"
#    $string_retval = integer__stringify(undef);  # TIV01; error EIV00
#    $string_retval = integer__stringify(3);  # TIV02
#    $string_retval = integer__stringify(-17);  # TIV03
#    $string_retval = integer__stringify(-17.3);  # TIV04; error EIV01
#    $string_retval = integer__stringify('-17.3');  # TIV05; error EIV01
#    $string_retval = integer__stringify([3]);  # TIV06; error EIV01
#    $string_retval = integer__stringify({a_key => 3});  # TIV07; error EIV01
#    $string_retval = integer__stringify(-1_234_567_890);  # TIV08
#    $string_retval = integer__stringify(-1_234_567_890_000);  # TIV09; error EIV01
#    RPerl::diag "in scalar_test.pl $i/$i_MAX, have \$string_retval = '$string_retval'\n" or croak();

#    $integer_retval = integer__typetest0();  # TIV10
#    RPerl::diag "in scalar_test.pl $i/$i_MAX, have \$integer_retval = $integer_retval\n" or croak();

#    $integer_retval = integer__typetest1();  # TIV20; error PERLOPS EIV00, CPPOPS "Usage: main::integer__typetest1(lucky_integer)"
#    $integer_retval = integer__typetest1(undef);  # TIV21; error EIV00
#    $integer_retval = integer__typetest1(3);  # TIV22
#    $integer_retval = integer__typetest1(-17);  # TIV23
#    $integer_retval = integer__typetest1(-17.3);  # TIV24; error EIV01
#    $integer_retval = integer__typetest1('-17.3');  # TIV25; error EIV01
#    $integer_retval = integer__typetest1([3]);  # TIV26; error EIV01
#    $integer_retval = integer__typetest1({a_key => 3});  # TIV27; error EIV01
##    $integer_retval = integer__typetest1(-1_234_567_890);  # NOT TEST-WORTHY: arithmetic overflow, incorrect results
#    $integer_retval = integer__typetest1(-234_567_890);  # TIV28
#    $integer_retval = integer__typetest1(-1_234_567_890_000);  # TIV29; error EIV01
#    RPerl::diag "in scalar_test.pl $i/$i_MAX, have \$integer_retval = $integer_retval\n" or croak();

    # [[[ NUMBER TESTS ]]]

#    $string_retval = number__stringify();  # TNV00; error PERLOPS ENV00, CPPOPS "Usage: main::number__stringify(input_number)"
#    $string_retval = number__stringify(undef);  # TNV01; error ENV00
#    $string_retval = number__stringify(3);  # TNV02
#    $string_retval = number__stringify(-17);  # TNV03
#    $string_retval = number__stringify(-17.3);  # TNV04
#    $string_retval = number__stringify('-17.3');  # TNV05; error ENV01
#    $string_retval = number__stringify([3]);  # TNV06; error ENV01
#    $string_retval = number__stringify({a_key => 3});  # TNV07; error ENV01
#    $string_retval = number__stringify(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679);  # TNV08
#    RPerl::diag "in scalar_test.pl $i/$i_MAX, have \$string_retval = '$string_retval'\n" or croak();

#    $number_retval = number__typetest0();  # TNV10
#    RPerl::diag "in scalar_test.pl $i/$i_MAX, have \$number_retval = $number_retval\n" or croak();

#    $number_retval = number__typetest1();  # TNV20; error PERLOPS ENV00, CPPOPS "Usage: main::number__typetest1(lucky_number)"
#    $number_retval = number__typetest1(undef);  # TNV21; error ENV00
#    $number_retval = number__typetest1(3);  # TNV22
#    $number_retval = number__typetest1(-17);  # TNV23
#    $number_retval = number__typetest1(-17.3);  # TNV24
#    $number_retval = number__typetest1('-17.3');  # TNV25; error ENV01
#    $number_retval = number__typetest1([3]);  # TNV26; error ENV01
#    $number_retval = number__typetest1({a_key => 3});  # TNV27; error ENV01
#    $number_retval = number__typetest1(3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679);  # TNV28
#    RPerl::diag "in scalar_test.pl $i/$i_MAX, have \$number_retval = $number_retval\n" or croak();

    # [[[ STRING TESTS ]]]

#    $string_retval = string__stringify();  # TPV00; error PERLOPS EPV00, CPPOPS "Usage: main::string__stringify(input_string)"
#    $string_retval = string__stringify(undef);  # TPV01; error EPV00
#    $string_retval = string__stringify(3);  # TPV02; error EPV01
#    $string_retval = string__stringify(-17);  # TPV03; error EPV01
#    $string_retval = string__stringify(-17.3);  # TPV04; error EPV01
#    $string_retval = string__stringify('-17.3');  # TPV05
#    $string_retval = string__stringify([3]);  # TPV06; error EPV01
#    $string_retval = string__stringify({a_key => 3});  # TPV07; error EPV01
#    $string_retval = string__stringify('Melange');  # TPV08
#    $string_retval = string__stringify("\nThe Spice Extends Life\nThe Spice Expands Consciousness\nThe Spice Is Vital To Space Travel\n");  # TPV09
#    RPerl::diag "in scalar_test.pl $i/$i_MAX, have \$string_retval =\n$string_retval\n" or croak();

    # DEV NOTE: in English grammar, I prefer the comma after the right-quote
    $my_string = '\'I am a single-quoted string, in a single-quoted string with back-slash control chars\', the first string said introspectively.' ;    # TPV10
#    $my_string = '"I am a double-quoted string, in a single-quoted string with no back-slash chars", the second string observed.';  # TPV11
#    $my_string = "'I am a single-quoted string, in a double-quoted string with no back-slash chars', the third string added.";  # TPV12
#    $my_string = "\"I am a double-quoted string, in a double-quoted string with back-slash control chars\", the fourth string offered.";  # TPV13
#    $my_string = '\'I am a single-quoted string, in a single-quoted string with back-slash control and \ display \ chars\', the fifth string shouted.';  # TPV14
#    $my_string = '"I am a double-quoted string, in a single-quoted string with back-slash \ display \ chars", the sixth string hollered.';  # TPV15
#    $my_string = "'I am a single-quoted string, in a double-quoted string with back-slash \\ display \\ chars', the seventh string yelled.";  # TPV16
#    $my_string = "\"I am a double-quoted string, in a double-quoted string with back-slash control and \\ display \\ chars\", the eighth string belted.";  # TPV17

#    $my_string = q{'I am a single-quoted string, in a single-quoted q{} string with no back-slash chars', the ninth string chimed in.};  # TPV20
#    $my_string = q{"I am a double-quoted string, in a single-quoted q{} string with no back-slash chars", the tenth string opined.};  # TPV21
#    $my_string = qq{'I am a single-quoted string, in a double-quoted qq{} string with no back-slash chars', the eleventh string asserted.};  # TPV22
#    $my_string = qq{"I am a double-quoted string, in a double-quoted qq{} string with no back-slash chars", the twelfth string insisted.};  # TPV23
#    $my_string = q{'I am a single-quoted string, in a single-quoted q{} string with back-slash \ display \ chars', the thirteenth string whispered.};  # TPV24
#    $my_string = q{"I am a double-quoted string, in a single-quoted q{} string with back-slash \ display \ chars", the fourteenth string breathed.};  # TPV25
#    $my_string = qq{'I am a single-quoted string, in a double-quoted qq{} string with back-slash \\ display \\ chars', the fifteenth string mouthed.};  # TPV26
#    $my_string = qq{"I am a double-quoted string, in a double-quoted qq{} string with back-slash \\ display \\ chars", the sixteenth string implied.};  # TPV27

=disable
    RPerl::diag "in scalar_test.pl $i/$i_MAX, have \$my_string =\n$my_string\n\n" or croak();
    $dumper_string = Dumper([$my_string]);  # retrieve Dumper()'s version of the stringified string
    $dumper_string =~ s/^\s+|\s+$//xmsg;  # strip leading whitespace
    my @dumper_split = split "\n", $dumper_string;
    $dumper_string = $dumper_split[1];  # only select the data line
#    RPerl::diag "in scalar_test.pl $i/$i_MAX, have Dumper([\$my_string]) =\n" . Dumper([$my_string]) . "\n" or croak();
=cut

    $dumper_string = string__dumperify($my_string);
    $string_retval = string__stringify($my_string);
    RPerl::diag "in scalar_test.pl $i/$i_MAX, have \$string_retval =\n$string_retval STRINGIFY\n\n" or croak();
    RPerl::diag "in scalar_test.pl $i/$i_MAX, have \$dumper_string =\n$dumper_string DUMPERIFY\n\n" or croak();

#    $string_retval = string__typetest0();  # TPV30
#    RPerl::diag "in scalar_test.pl $i/$i_MAX, have \$string_retval =\n$string_retval\n" or croak();

#    $string_retval = string__typetest1();  # TPV40; error PERLOPS EPV00, CPPOPS "Usage: main::string__typetest1(lucky_string)"
#    $string_retval = string__typetest1(undef);  # TPV41; error EPV00
#    $string_retval = string__typetest1(3);  # TPV42; error EPV01
#    $string_retval = string__typetest1(-17);  # TPV43; error EPV01
#    $string_retval = string__typetest1(-17.3);  # TPV44; error EPV01
#    $string_retval = string__typetest1('-17.3');  # TPV45
#    $string_retval = string__typetest1([3]);  # TPV46; error EPV01
#    $string_retval = string__typetest1({a_key => 3});  # TPV47; error EPV01
#    $string_retval = string__typetest1('Melange');  # TPV48
#    $string_retval = string__typetest1("\nThe Spice Extends Life\nThe Spice Expands Consciousness\nThe Spice Is Vital To Space Travel\n");  # TPV49
#    RPerl::diag "in scalar_test.pl $i/$i_MAX, have \$string_retval =\n$string_retval\n" or croak();

    croak('Done for now, croaking');
}

#croak('Done for now, croaking');

