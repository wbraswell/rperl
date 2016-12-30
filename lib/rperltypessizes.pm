# [[[ HEADER ]]]
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names
package  # hide from PAUSE indexing
    rperltypessizes;
use strict;
use warnings;
use RPerl::Config;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitExcessComplexity)  # SYSTEM SPECIAL 5: allow complex code inside subroutines, must be after line 1
## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
## no critic qw(ProhibitDeepNests)  # SYSTEM SPECIAL 7: allow deeply-nested code
## no critic qw(RequireBriefOpen)  # SYSTEM SPECIAL 10: allow complex processing with open filehandle
## no critic qw(ProhibitCascadingIfElse)  # SYSTEM SPECIAL 12: allow complex conditional logic

# [[[ NON-RPERL MODULES ]]]
use Config;

# [[[ PRE-DECLARED TYPES ]]]
package    # hide from PAUSE indexing
    string;
package     # hide from PAUSE indexing
    string_hashref;

# DEV NOTE, CORRELATION #rp001: keep track of all these hard-coded "semi-dynamic" integer data types
our string_hashref $ALTERNATE_TYPES_TO_PERLISH_TYPES = {
    '__int8' => 'i8',
    '__int16' => 'i16',
    '__int32' => 'i32',
    '__int64' => 'i64',
    '__int128' => 'i128',
    'int8_t' => 'i8',
    'int16_t' => 'i16',
    'int32_t' => 'i32',
    'int64_t' => 'i64',
    'int128_t' => 'i128',
#    'long long' => 'i64',  # NEED ANSWER: is it more correct to map to 'longlong' instead of 'i64', as done below?
    'long long' => 'longlong',  # DEV NOTE: on Windows OS, real type "long long" is not shortened to "longlong" as in Linux
};

# [[[ C++ TYPE SIZE REPORTING ]]]
sub type_integer_bitsize {
    type_integer_errorcheck();
    return (string_to_integer($Config{ivsize}) * 8);  # return answer in bits, not bytes
}

sub type_integer_native {
    type_integer_errorcheck();
    return $Config{ivtype};
}

sub type_integer_native_ccflag {
    type_integer_errorcheck();
    my string $ivtype = $Config{ivtype};

    # NEED ANSWER: is there some better way to support all the different types, rather than all this hard-coding?
    # DEV NOTE, CORRELATION #rp001: keep track of all these hard-coded integer data types
    if ($ivtype eq 'long') {
        return ' -D__TYPE__INTEGER__LONG';
    }
    elsif (($ivtype eq 'longlong') or ($ivtype eq 'long long')) {  # DEV NOTE: match both Linux'ish 'longlong' & Windows'ish 'long long'; 'long long' is the real type
        return ' -D__TYPE__INTEGER__LONG_LONG';
    }
    elsif ($ivtype eq '__int8') {
        return ' -D__TYPE__INTEGER____INT8';
    }
    elsif ($ivtype eq '__int16') {
        return ' -D__TYPE__INTEGER____INT16';
    }
    elsif ($ivtype eq '__int32') {
        return ' -D__TYPE__INTEGER____INT32';
    }
    elsif ($ivtype eq '__int64') {
        return ' -D__TYPE__INTEGER____INT64';
    }
    elsif ($ivtype eq '__int128') {
        return ' -D__TYPE__INTEGER____INT128';
    }
    elsif ($ivtype eq 'int8_t') {
        return ' -D__TYPE__INTEGER__INT8_T';
    }
    elsif ($ivtype eq 'int16_t') {
        return ' -D__TYPE__INTEGER__INT16_T';
    }
    elsif ($ivtype eq 'int32_t') {
        return ' -D__TYPE__INTEGER__INT32_T';
    }
    elsif ($ivtype eq 'int64_t') {
        return ' -D__TYPE__INTEGER__INT64_T';
    }
    elsif ($ivtype eq 'int128_t') {
        return ' -D__TYPE__INTEGER__INT128_T';
    }
}

sub type_integer_errorcheck {
    # NEED ANSWER: should we be checking $Config{use64bitint}, $Config{use64bitall}, $Config{i64size}, $Config{i64type}???
    if ((not exists $Config{ivsize}) or (not defined $Config{ivsize})) {
        croak 'ERROR ERPTYREI00: Non-existent or undefined Perl config value $Config{ivsize}, croaking';
    }
    my string $ivsize = $Config{ivsize};

    if ((not exists $Config{ivtype}) or (not defined $Config{ivtype})) {
        croak 'ERROR ERPTYREI01: Non-existent or undefined Perl config value $Config{ivtype}, croaking';
    }
    my string $ivtype = $Config{ivtype};

    if (exists $ALTERNATE_TYPES_TO_PERLISH_TYPES->{$ivtype}) {
        $ivtype = $ALTERNATE_TYPES_TO_PERLISH_TYPES->{$ivtype};
    }

    my string $ivtypesize_key = $ivtype . 'size';
 
    if ((not exists $Config{$ivtypesize_key}) or (not defined $Config{$ivtypesize_key})) {
        croak 'ERROR ERPTYREI02: Non-existent or undefined Perl config value $Config{' . $ivtypesize_key . '}, croaking';
    }
    my string $ivtypesize = $Config{$ivtypesize_key};

    if ($ivsize ne $ivtypesize) {
        croak 'ERROR ERPTYREI03: Mis-matching Perl config values, $Config{ivsize} = ' . $ivsize . ', $Config{' . $ivtypesize_key . '} = ' . $ivtypesize . ', croaking';
    }
}

sub type_integer_bitsize_dump {
    foreach my $o (qw(ivsize ivtype use64bitint use64bitall intsize longsize longlongsize d_longlong i8size i8type i16size i16type i32size i32type i64size i64type)) { 
        print q($Config{) . $o . q(} = ) . $Config{$o} . "\n";
    }
}

sub type_number_bitsize {
    type_number_errorcheck();
    return (string_to_integer($Config{nvsize}) * 8);  # return answer in bits, not bytes
}

sub type_number_native {
    type_number_errorcheck();
    return $Config{nvtype};
}

sub type_number_native_ccflag {
    type_number_errorcheck();
    if ($Config{nvtype} eq 'double') {
        return ' -D__TYPE__NUMBER__DOUBLE';
    }
    elsif ($Config{nvtype} eq 'longdbl') {
        return ' -D__TYPE__NUMBER__LONG__DOUBLE';
    }
}

sub type_number_errorcheck {
    # NEED ANSWER: should we be checking $Config{use64bitall}???
    if ((not exists $Config{nvsize}) or (not defined $Config{nvsize})) {
        croak 'ERROR ERPTYREN00: Non-existent or undefined Perl config value $Config{nvsize}, croaking';
    }
    my string $nvsize = $Config{nvsize};

    if ((not exists $Config{nvtype}) or (not defined $Config{nvtype})) {
        croak 'ERROR ERPTYREN01: Non-existent or undefined Perl config value $Config{nvtype}, croaking';
    }
    my string $nvtypesize_key = $Config{nvtype} . 'size';
 
    if ((not exists $Config{$nvtypesize_key}) or (not defined $Config{$nvtypesize_key})) {
        croak 'ERROR ERPTYREN02: Non-existent or undefined Perl config value $Config{' . $nvtypesize_key . '}, croaking';
    }
    my string $nvtypesize = $Config{$nvtypesize_key};

    if ($nvsize ne $nvtypesize) {
        croak 'ERROR ERPTYREN03: Mis-matching Perl config values, $Config{nvsize} = ' . $nvsize . ', $Config{' . $nvtypesize_key . '} = ' . $nvtypesize . ', croaking';
    }
}

sub type_number_bitsize_dump {
    foreach my $o (qw(nvsize nvtype use64bitall doublesize longdblsize d_longdbl)) { 
        print q($Config{) . $o . q(} = ) . $Config{$o} . "\n";
    }
}

1;  # end of package
