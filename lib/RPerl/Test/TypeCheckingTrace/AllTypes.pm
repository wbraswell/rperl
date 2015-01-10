# [[[ PREPROCESSOR ]]]
# <<< TYPE_CHECKING: TRACE >>>

# [[[ HEADER ]]]
package RPerl::Test::TypeCheckingTrace::AllTypes;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent ('RPerl::Test');
use RPerl::Test;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hash_ref $properties = {};

# [[[ SUBROUTINES ]]]

# [[ SCALARS ]]

our void $check__integer = sub {
    ( my integer $input_1) = @_;

#    RPerl::diag "in check__integer(), received \$input_1\n" . Dumper($input_1) . "\n";
    return;
};

our void $check__number = sub {
    ( my number $input_1) = @_;

#    RPerl::diag "in check__number(), received \$input_1\n" . Dumper($input_1) . "\n";
    return;
};

our void $check__string = sub {
    ( my string $input_1) = @_;

#    RPerl::diag "in check__string(), received \$input_1\n" . Dumper($input_1) . "\n";
    return;
};

# [[ ARRAY REFS ]]

our void $check__array_ref = sub {
    ( my array_ref $input_1) = @_;

#    RPerl::diag "in check__array_ref(), received \$input_1\n" . Dumper($input_1) . "\n";
    return;
};

our void $check__integer__array_ref = sub {
    ( my integer__array_ref $input_1) = @_;

#    RPerl::diag "in check__integer__array_ref(), received \$input_1\n" . Dumper($input_1) . "\n";
    return;
};

our void $check__number__array_ref = sub {
    ( my number__array_ref $input_1) = @_;

#    RPerl::diag "in check__number__array_ref(), received \$input_1\n" . Dumper($input_1) . "\n";
    return;
};

our void $check__number__array_refs = sub {
    (   my number__array_ref $input_1,
        my number__array_ref $input_2,
        my number__array_ref $input_3)
        = @_;

#    RPerl::diag "in check__number__array_refs(), received \$input_1\n" . Dumper($input_1) . "\n";
#    RPerl::diag "in check__number__array_refs(), received \$input_2\n" . Dumper($input_2) . "\n";
#    RPerl::diag "in check__number__array_refs(), received \$input_3\n" . Dumper($input_3) . "\n";

# DEPRECATED: type checking automated via <<< TYPE_CHECKING: CHECK(TRACE) >>> preprocessor directive
#    ::number__array_ref__CHECK($input_1);
#    ::number__array_ref__CHECKTRACE( $input_1, '$input_1', 'check__number__array_refs()' );
#    ::number__array_ref__CHECK($input_2);
#    ::number__array_ref__CHECKTRACE( $input_2, '$input_2', 'check__number__array_refs()' );
#    ::number__array_ref__CHECK($input_3);
#    ::number__array_ref__CHECKTRACE( $input_3, '$input_3', 'check__number__array_refs()' );
    return;
};

our void $check__string__array_ref = sub {
    ( my string__array_ref $input_1) = @_;

#    RPerl::diag "in check__string__array_ref(), received \$input_1\n" . Dumper($input_1) . "\n";
    return;
};

# [[ HASH REFS ]]

our void $check__hash_ref = sub {
    ( my hash_ref $input_1) = @_;

#    RPerl::diag "in check__hash_ref(), received \$input_1\n" . Dumper($input_1) . "\n";
    return;
};

our void $check__integer__hash_ref = sub {
    ( my integer__hash_ref $input_1) = @_;

#    RPerl::diag "in check__integer__hash_ref(), received \$input_1\n" . Dumper($input_1) . "\n";
    return;
};

our void $check__number__hash_ref = sub {
    ( my number__hash_ref $input_1) = @_;

#    RPerl::diag "in check__number__hash_ref(), received \$input_1\n" . Dumper($input_1) . "\n";
    return;
};

our void $check__number__hash_refs = sub {
    (   my number__hash_ref $input_1,
        my number__hash_ref $input_2,
        my number__hash_ref $input_3)
        = @_;

#    RPerl::diag "in check__number__hash_refs(), received \$input_1\n" . Dumper($input_1) . "\n";
#    RPerl::diag "in check__number__hash_refs(), received \$input_2\n" . Dumper($input_2) . "\n";
#    RPerl::diag "in check__number__hash_refs(), received \$input_3\n" . Dumper($input_3) . "\n";

    return;
};

our void $check__string__hash_ref = sub {
    ( my string__hash_ref $input_1) = @_;

#    RPerl::diag "in check__string__hash_ref(), received \$input_1\n" . Dumper($input_1) . "\n";
    return;
};

# [[ MIXED TYPES ]]

our void $check__mixed_00 = sub {
    ( my integer $input_1, my number $input_2, my string $input_3) = @_;

#    RPerl::diag "in check__mixed_00(), received \$input_1\n" . Dumper($input_1) . "\n";
#    RPerl::diag "in check__mixed_00(), received \$input_2\n" . Dumper($input_2) . "\n";
#    RPerl::diag "in check__mixed_00(), received \$input_3\n" . Dumper($input_3) . "\n";

    return;
};

our void $check__mixed_01 = sub {
    (   my array_ref $input_1,
        my integer__array_ref $input_2,
        my number__array_ref $input_3,
        my string__array_ref $input_4)
        = @_;

#    RPerl::diag "in check__mixed_01(), received \$input_1\n" . Dumper($input_1) . "\n";
#    RPerl::diag "in check__mixed_01(), received \$input_2\n" . Dumper($input_2) . "\n";
#    RPerl::diag "in check__mixed_01(), received \$input_3\n" . Dumper($input_3) . "\n";
#    RPerl::diag "in check__mixed_01(), received \$input_4\n" . Dumper($input_4) . "\n";

    return;
};

our void $check__mixed_02 = sub {
    (   my hash_ref $input_1,
        my integer__hash_ref $input_2,
        my number__hash_ref $input_3,
        my string__hash_ref $input_4)
        = @_;

#    RPerl::diag "in check__mixed_02(), received \$input_1\n" . Dumper($input_1) . "\n";
#    RPerl::diag "in check__mixed_02(), received \$input_2\n" . Dumper($input_2) . "\n";
#    RPerl::diag "in check__mixed_02(), received \$input_3\n" . Dumper($input_3) . "\n";
#    RPerl::diag "in check__mixed_02(), received \$input_4\n" . Dumper($input_4) . "\n";

    return;
};

our void $check__mixed_03 = sub {
    (   my integer $input_1,
        my number $input_2,
        my string $input_3,
        my array_ref $input_4,
        my integer__array_ref $input_5,
        my number__array_ref $input_6,
        my string__array_ref $input_7,
        my hash_ref $input_8,
        my integer__hash_ref $input_9,
        my number__hash_ref $input_10,
        my string__hash_ref $input_11
    ) = @_;

#    RPerl::diag "in check__mixed_03(), received \$input_1\n" . Dumper($input_1) . "\n";
#    RPerl::diag "in check__mixed_03(), received \$input_2\n" . Dumper($input_2) . "\n";
#    RPerl::diag "in check__mixed_03(), received \$input_3\n" . Dumper($input_3) . "\n";
#    RPerl::diag "in check__mixed_03(), received \$input_4\n" . Dumper($input_4) . "\n";
#    RPerl::diag "in check__mixed_03(), received \$input_5\n" . Dumper($input_5) . "\n";
#    RPerl::diag "in check__mixed_03(), received \$input_6\n" . Dumper($input_6) . "\n";
#    RPerl::diag "in check__mixed_03(), received \$input_7\n" . Dumper($input_7) . "\n";
#    RPerl::diag "in check__mixed_03(), received \$input_8\n" . Dumper($input_8) . "\n";
#    RPerl::diag "in check__mixed_03(), received \$input_9\n" . Dumper($input_9) . "\n";
#    RPerl::diag "in check__mixed_03(), received \$input_10\n" . Dumper($input_10) . "\n";
#    RPerl::diag "in check__mixed_03(), received \$input_11\n" . Dumper($input_11) . "\n";

    return;
};

1;    # end of class

__END__

integer__CHECK
integer__CHECKTRACE
number__CHECK
number__CHECKTRACE
string__CHECK
string__CHECKTRACE

array_ref__CHECK
array_ref__CHECKTRACE
integer__array_ref__CHECK
integer__array_ref__CHECKTRACE
number__array_ref__CHECK
number__array_ref__CHECKTRACE
string__array_ref__CHECK
string__array_ref__CHECKTRACE

hash_ref__CHECK
hash_ref__CHECKTRACE
hash_entry__CHECK       [NOT A DATA TYPE]
hash_entry__CHECKTRACE  [NOT A DATA TYPE]
integer__hash_ref__CHECK
integer__hash_ref__CHECKTRACE
number__hash_ref__CHECK
number__hash_ref__CHECKTRACE
string__hash_ref__CHECK
string__hash_ref__CHECKTRACE
