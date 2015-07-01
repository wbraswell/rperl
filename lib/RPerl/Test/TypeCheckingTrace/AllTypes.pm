# [[[ PREPROCESSOR ]]]
# <<< TYPE_CHECKING: TRACE >>>

# [[[ HEADER ]]]
package RPerl::Test::TypeCheckingTrace::AllTypes;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_001;

# [[[ OO INHERITANCE ]]]
use parent ('RPerl::Test');
use RPerl::Test;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES ]]]

# [[ SCALARS ]]

our void $check_integer = sub {
    ( my integer $input_1) = @_;

#    RPerl::diag("in check_integer(), received \$input_1\n" . Dumper($input_1) . "\n");
    return;
};

our void $check_number = sub {
    ( my number $input_1) = @_;

#    RPerl::diag("in check_number(), received \$input_1\n" . Dumper($input_1) . "\n");
    return;
};

our void $check_string = sub {
    ( my string $input_1) = @_;

#    RPerl::diag("in check_string(), received \$input_1\n" . Dumper($input_1) . "\n");
    return;
};

# [[ ARRAY REFS ]]

our void $check_arrayref = sub {
    ( my arrayref $input_1) = @_;

#    RPerl::diag("in check_arrayref(), received \$input_1\n" . Dumper($input_1) . "\n");
    return;
};

our void $check_integer_arrayref = sub {
    ( my integer_arrayref $input_1) = @_;

#    RPerl::diag("in check_integer_arrayref(), received \$input_1\n" . Dumper($input_1) . "\n");
    return;
};

our void $check_number_arrayref = sub {
    ( my number_arrayref $input_1) = @_;

#    RPerl::diag("in check_number_arrayref(), received \$input_1\n" . Dumper($input_1) . "\n");
    return;
};

our void $check_number_arrayrefs = sub {
    (   my number_arrayref $input_1,
        my number_arrayref $input_2,
        my number_arrayref $input_3)
        = @_;

#    RPerl::diag("in check_number_arrayrefs(), received \$input_1\n" . Dumper($input_1) . "\n");
#    RPerl::diag("in check_number_arrayrefs(), received \$input_2\n" . Dumper($input_2) . "\n");
#    RPerl::diag("in check_number_arrayrefs(), received \$input_3\n" . Dumper($input_3) . "\n");

# DEPRECATED: type checking automated via <<< TYPE_CHECKING: CHECK(TRACE) >>> preprocessor directive
#    ::number_arrayref_CHECK($input_1);
#    ::number_arrayref_CHECKTRACE( $input_1, '$input_1', 'check_number_arrayrefs()' );
#    ::number_arrayref_CHECK($input_2);
#    ::number_arrayref_CHECKTRACE( $input_2, '$input_2', 'check_number_arrayrefs()' );
#    ::number_arrayref_CHECK($input_3);
#    ::number_arrayref_CHECKTRACE( $input_3, '$input_3', 'check_number_arrayrefs()' );
    return;
};

our void $check_string_arrayref = sub {
    ( my string_arrayref $input_1) = @_;

#    RPerl::diag("in check_string_arrayref(), received \$input_1\n" . Dumper($input_1) . "\n");
    return;
};

# [[ HASH REFS ]]

our void $check_hashref = sub {
    ( my hashref $input_1) = @_;

#    RPerl::diag("in check_hashref(), received \$input_1\n" . Dumper($input_1) . "\n");
    return;
};

our void $check_integer_hashref = sub {
    ( my integer_hashref $input_1) = @_;

#    RPerl::diag("in check_integer_hashref(), received \$input_1\n" . Dumper($input_1) . "\n");
    return;
};

our void $check_number_hashref = sub {
    ( my number_hashref $input_1) = @_;

#    RPerl::diag("in check_number_hashref(), received \$input_1\n" . Dumper($input_1) . "\n");
    return;
};

our void $check_number_hashrefs = sub {
    (   my number_hashref $input_1,
        my number_hashref $input_2,
        my number_hashref $input_3)
        = @_;

#    RPerl::diag("in check_number_hashrefs(), received \$input_1\n" . Dumper($input_1) . "\n");
#    RPerl::diag("in check_number_hashrefs(), received \$input_2\n" . Dumper($input_2) . "\n");
#    RPerl::diag("in check_number_hashrefs(), received \$input_3\n" . Dumper($input_3) . "\n");

    return;
};

our void $check_string_hashref = sub {
    ( my string_hashref $input_1) = @_;

#    RPerl::diag("in check_string_hashref(), received \$input_1\n" . Dumper($input_1) . "\n");
    return;
};

# [[ MIXED TYPES ]]

our void $check__mixed_00 = sub {
    ( my integer $input_1, my number $input_2, my string $input_3) = @_;

#    RPerl::diag("in check__mixed_00(), received \$input_1\n" . Dumper($input_1) . "\n");
#    RPerl::diag("in check__mixed_00(), received \$input_2\n" . Dumper($input_2) . "\n");
#    RPerl::diag("in check__mixed_00(), received \$input_3\n" . Dumper($input_3) . "\n");

    return;
};

our void $check__mixed_01 = sub {
    (   my arrayref $input_1,
        my integer_arrayref $input_2,
        my number_arrayref $input_3,
        my string_arrayref $input_4)
        = @_;

#    RPerl::diag("in check__mixed_01(), received \$input_1\n" . Dumper($input_1) . "\n");
#    RPerl::diag("in check__mixed_01(), received \$input_2\n" . Dumper($input_2) . "\n");
#    RPerl::diag("in check__mixed_01(), received \$input_3\n" . Dumper($input_3) . "\n");
#    RPerl::diag("in check__mixed_01(), received \$input_4\n" . Dumper($input_4) . "\n");

    return;
};

our void $check__mixed_02 = sub {
    (   my hashref $input_1,
        my integer_hashref $input_2,
        my number_hashref $input_3,
        my string_hashref $input_4)
        = @_;

#    RPerl::diag("in check__mixed_02(), received \$input_1\n" . Dumper($input_1) . "\n");
#    RPerl::diag("in check__mixed_02(), received \$input_2\n" . Dumper($input_2) . "\n");
#    RPerl::diag("in check__mixed_02(), received \$input_3\n" . Dumper($input_3) . "\n");
#    RPerl::diag("in check__mixed_02(), received \$input_4\n" . Dumper($input_4) . "\n");

    return;
};

our void $check__mixed_03 = sub {
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
    ) = @_;

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
};

1;    # end of class

__END__

integer_CHECK
integer_CHECKTRACE
number_CHECK
number_CHECKTRACE
string_CHECK
string_CHECKTRACE

arrayref_CHECK
arrayref_CHECKTRACE
integer_arrayref_CHECK
integer_arrayref_CHECKTRACE
number_arrayref_CHECK
number_arrayref_CHECKTRACE
string_arrayref_CHECK
string_arrayref_CHECKTRACE

hashref_CHECK
hashref_CHECKTRACE
hashentry_CHECK       [NOT A DATA TYPE]
hashentry_CHECKTRACE  [NOT A DATA TYPE]
integer_hashref_CHECK
integer_hashref_CHECKTRACE
number_hashref_CHECK
number_hashref_CHECKTRACE
string_hashref_CHECK
string_hashref_CHECKTRACE
