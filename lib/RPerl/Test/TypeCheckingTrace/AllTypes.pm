# [[[ PREPROCESSOR ]]]
# <<< TYPE_CHECKING: TRACE >>>

# the following subroutines are automatically called when 1 or more of the subroutines in this file are called:

# integer_CHECKTRACE()
# number_CHECKTRACE()
# string_CHECKTRACE()

# arrayref_CHECKTRACE()
# integer_arrayref_CHECKTRACE()
# number_arrayref_CHECKTRACE()
# string_arrayref_CHECKTRACE()

# hashref_CHECKTRACE()
# hashentry_CHECKTRACE()  [NOT A DATA TYPE]
# integer_hashref_CHECKTRACE()
# number_hashref_CHECKTRACE()
# string_hashref_CHECKTRACE()

# [[[ HEADER ]]]
use RPerl;
package RPerl::Test::TypeCheckingTrace::AllTypes;
use strict;
use warnings;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Test);
use RPerl::Test;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES ]]]

# [[ SCALARS ]]

sub check_integer {
    { my void $RETURN_TYPE };
    ( my integer $input_1) = @ARG;

#    RPerl::diag("in check_integer(), received \$input_1\n" . Dumper($input_1) . "\n");
    return;
}

sub check_number {
    { my void $RETURN_TYPE };
    ( my number $input_1) = @ARG;

#    RPerl::diag("in check_number(), received \$input_1\n" . Dumper($input_1) . "\n");
    return;
}

sub check_string {
    { my void $RETURN_TYPE };
    ( my string $input_1) = @ARG;

#    RPerl::diag("in check_string(), received \$input_1\n" . Dumper($input_1) . "\n");
    return;
}

# [[ ARRAY REFS ]]

sub check_arrayref {
    { my void $RETURN_TYPE };
    ( my arrayref $input_1) = @ARG;

#    RPerl::diag("in check_arrayref(), received \$input_1\n" . Dumper($input_1) . "\n");
    return;
}

sub check_integer_arrayref {
    { my void $RETURN_TYPE };
    ( my integer_arrayref $input_1) = @ARG;

#    RPerl::diag("in check_integer_arrayref(), received \$input_1\n" . Dumper($input_1) . "\n");
    return;
}

sub check_number_arrayref {
    { my void $RETURN_TYPE };
    ( my number_arrayref $input_1) = @ARG;

#    RPerl::diag("in check_number_arrayref(), received \$input_1\n" . Dumper($input_1) . "\n");
    return;
}

sub check_number_arrayrefs {
    { my void $RETURN_TYPE };
    (   my number_arrayref $input_1,
        my number_arrayref $input_2,
        my number_arrayref $input_3)
        = @ARG;

#    RPerl::diag("in check_number_arrayrefs(), received \$input_1\n" . Dumper($input_1) . "\n");
#    RPerl::diag("in check_number_arrayrefs(), received \$input_2\n" . Dumper($input_2) . "\n");
#    RPerl::diag("in check_number_arrayrefs(), received \$input_3\n" . Dumper($input_3) . "\n");

# DEPRECATED: type checking automated via <<< TYPE_CHECKING: CHECK(TRACE) >>> preprocessor directive
#    ::number_arrayref_CHECKTRACE( $input_1, '$input_1', 'check_number_arrayrefs()' );
#    ::number_arrayref_CHECKTRACE( $input_2, '$input_2', 'check_number_arrayrefs()' );
#    ::number_arrayref_CHECKTRACE( $input_3, '$input_3', 'check_number_arrayrefs()' );
    return;
}

sub check_string_arrayref {
    { my void $RETURN_TYPE };
    ( my string_arrayref $input_1) = @ARG;

#    RPerl::diag("in check_string_arrayref(), received \$input_1\n" . Dumper($input_1) . "\n");
    return;
}

# [[ HASH REFS ]]

sub check_hashref {
    { my void $RETURN_TYPE };
    ( my hashref $input_1) = @ARG;

#    RPerl::diag("in check_hashref(), received \$input_1\n" . Dumper($input_1) . "\n");
    return;
}

sub check_integer_hashref {
    { my void $RETURN_TYPE };
    ( my integer_hashref $input_1) = @ARG;

#    RPerl::diag("in check_integer_hashref(), received \$input_1\n" . Dumper($input_1) . "\n");
    return;
}

sub check_number_hashref {
    { my void $RETURN_TYPE };
    ( my number_hashref $input_1) = @ARG;

#    RPerl::diag("in check_number_hashref(), received \$input_1\n" . Dumper($input_1) . "\n");
    return;
}

sub check_number_hashrefs {
    { my void $RETURN_TYPE };
    (   my number_hashref $input_1,
        my number_hashref $input_2,
        my number_hashref $input_3)
        = @ARG;

#    RPerl::diag("in check_number_hashrefs(), received \$input_1\n" . Dumper($input_1) . "\n");
#    RPerl::diag("in check_number_hashrefs(), received \$input_2\n" . Dumper($input_2) . "\n");
#    RPerl::diag("in check_number_hashrefs(), received \$input_3\n" . Dumper($input_3) . "\n");
    return;
}

sub check_string_hashref {
    { my void $RETURN_TYPE };
    ( my string_hashref $input_1) = @ARG;

#    RPerl::diag("in check_string_hashref(), received \$input_1\n" . Dumper($input_1) . "\n");
    return;
}

# [[ MIXED TYPES ]]

sub check__mixed_00 {
    { my void $RETURN_TYPE };
    ( my integer $input_1, my number $input_2, my string $input_3) = @ARG;

#    RPerl::diag("in check__mixed_00(), received \$input_1\n" . Dumper($input_1) . "\n");
#    RPerl::diag("in check__mixed_00(), received \$input_2\n" . Dumper($input_2) . "\n");
#    RPerl::diag("in check__mixed_00(), received \$input_3\n" . Dumper($input_3) . "\n");
    return;
}

sub check__mixed_01 {
    { my void $RETURN_TYPE };
    (   my arrayref $input_1,
        my integer_arrayref $input_2,
        my number_arrayref $input_3,
        my string_arrayref $input_4)
        = @ARG;

#    RPerl::diag("in check__mixed_01(), received \$input_1\n" . Dumper($input_1) . "\n");
#    RPerl::diag("in check__mixed_01(), received \$input_2\n" . Dumper($input_2) . "\n");
#    RPerl::diag("in check__mixed_01(), received \$input_3\n" . Dumper($input_3) . "\n");
#    RPerl::diag("in check__mixed_01(), received \$input_4\n" . Dumper($input_4) . "\n");
    return;
}

sub check__mixed_02 {
    { my void $RETURN_TYPE };
    (   my hashref $input_1,
        my integer_hashref $input_2,
        my number_hashref $input_3,
        my string_hashref $input_4)
        = @ARG;

#    RPerl::diag("in check__mixed_02(), received \$input_1\n" . Dumper($input_1) . "\n");
#    RPerl::diag("in check__mixed_02(), received \$input_2\n" . Dumper($input_2) . "\n");
#    RPerl::diag("in check__mixed_02(), received \$input_3\n" . Dumper($input_3) . "\n");
#    RPerl::diag("in check__mixed_02(), received \$input_4\n" . Dumper($input_4) . "\n");
    return;
}

sub check__mixed_03 {
    { my void $RETURN_TYPE };
    (   my integer $input_1,
        my number $input_2,
        my string $input_3,
        my arrayref $input_4,
        my integer_arrayref $input_5,
        my number_arrayref $input_6,
        my string_arrayref $input_7,
        my hashref $input_8,
        my integer_hashref $input_9,
        my number_hashref $input_10,
        my string_hashref $input_11
    ) = @ARG;

#    RPerl::diag("in check__mixed_03(), received \$input_1\n" . Dumper($input_1) . "\n");
#    RPerl::diag("in check__mixed_03(), received \$input_2\n" . Dumper($input_2) . "\n");
#    RPerl::diag("in check__mixed_03(), received \$input_3\n" . Dumper($input_3) . "\n");
#    RPerl::diag("in check__mixed_03(), received \$input_4\n" . Dumper($input_4) . "\n");
#    RPerl::diag("in check__mixed_03(), received \$input_5\n" . Dumper($input_5) . "\n");
#    RPerl::diag("in check__mixed_03(), received \$input_6\n" . Dumper($input_6) . "\n");
#    RPerl::diag("in check__mixed_03(), received \$input_7\n" . Dumper($input_7) . "\n");
#    RPerl::diag("in check__mixed_03(), received \$input_8\n" . Dumper($input_8) . "\n");
#    RPerl::diag("in check__mixed_03(), received \$input_9\n" . Dumper($input_9) . "\n");
#    RPerl::diag("in check__mixed_03(), received \$input_10\n" . Dumper($input_10) . "\n");
#    RPerl::diag("in check__mixed_03(), received \$input_11\n" . Dumper($input_11) . "\n");
    return;
}

1;    # end of class
