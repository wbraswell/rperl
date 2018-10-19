#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: "in Class_A_Exporter_20_NotBad::exported_ok(), received $arg = 17" >>>
# <<< EXECUTE_SUCCESS: "after exported_ok(17), received $exported_ok_retval = 714" >>>
# <<< EXECUTE_SUCCESS: "have $RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_scalar = 2112" >>>
# <<< EXECUTE_SUCCESS: "have @RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_array = [ 10, 20, 30, 40 ]" >>>
# <<< EXECUTE_SUCCESS: "have %RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_hash = { 'a' => 15, 'b' => 25, 'c' => 35 }" >>>
# <<< EXECUTE_SUCCESS: "have *RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_typeglob execution... I am an anonymous subroutine inside an exported ok typeglob." >>>
# <<< EXECUTE_SUCCESS: "have $exported_ok_scalar = 2112" >>>
# <<< EXECUTE_SUCCESS: "have @exported_ok_array = [ 10, 20, 30, 40 ]" >>>
# <<< EXECUTE_SUCCESS: "have %exported_ok_hash = { 'a' => 15, 'b' => 25, 'c' => 35 }" >>>
# <<< EXECUTE_SUCCESS: "have *exported_ok_typeglob execution... I am an anonymous subroutine inside an exported ok typeglob." >>>
# <<< EXECUTE_SUCCESS: "have $RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_scalar = 4224" >>>
# <<< EXECUTE_SUCCESS: "have @RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_array = [ 20, 20, 30, 40 ]" >>>
# <<< EXECUTE_SUCCESS: "have %RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_hash = { 'a' => 30, 'b' => 25, 'c' => 35 }" >>>
# <<< EXECUTE_SUCCESS: "have *RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_typeglob execution... I am another different anonymous subroutine." >>>
# <<< EXECUTE_SUCCESS: "have $exported_ok_scalar = 4224" >>>
# <<< EXECUTE_SUCCESS: "have @exported_ok_array = [ 20, 20, 30, 40 ]" >>>
# <<< EXECUTE_SUCCESS: "have %exported_ok_hash = { 'a' => 30, 'b' => 25, 'c' => 35 }" >>>
# <<< EXECUTE_SUCCESS: "have *exported_ok_typeglob execution... I am another different anonymous subroutine." >>>
# <<< EXECUTE_SUCCESS: "have $RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_scalar = 8448" >>>
# <<< EXECUTE_SUCCESS: "have @RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_array = [ 40, 20, 30, 40 ]" >>>
# <<< EXECUTE_SUCCESS: "have %RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_hash = { 'a' => 60, 'b' => 25, 'c' => 35 }" >>>
# <<< EXECUTE_SUCCESS: "have *RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_typeglob execution... I am yet another different anonymous subroutine." >>>
# <<< EXECUTE_SUCCESS: "have $exported_ok_scalar = 8448" >>>
# <<< EXECUTE_SUCCESS: "have @exported_ok_array = [ 40, 20, 30, 40 ]" >>>
# <<< EXECUTE_SUCCESS: "have %exported_ok_hash = { 'a' => 60, 'b' => 25, 'c' => 35 }" >>>
# <<< EXECUTE_SUCCESS: "have *exported_ok_typeglob execution... I am yet another different anonymous subroutine." >>>

# DEV NOTE: medium magic grammar required to parse etc.
# <<< PARSE: OFF >>>
# <<< GENERATE: OFF >>>
# <<< COMPILE: OFF >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Test::Exporter::Class_A_Exporter_20_NotBad qw(&exported_ok $exported_ok_scalar @exported_ok_array %exported_ok_hash *exported_ok_typeglob);

# [[[ SUBROUTINES ]]]

sub not_exported {
    { my integer $RETURN_TYPE };
    ( my integer $arg ) = @ARG;
    print 'in main::not_exported(), received $arg = ', $arg, "\n";
    return ($arg * 43);
}

# [[[ OPERATIONS ]]]

my integer $exported_ok_retval = exported_ok(17);
print 'after exported_ok(17), received $exported_ok_retval = ', $exported_ok_retval, "\n";

# DISPLAY, EXPORTER, DELTA 0
print 'have $RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_scalar = ', $RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_scalar, "\n";
print 'have @RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_array = ', integer_arrayref_to_string(\@RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_array), "\n";
print 'have %RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_hash = ', integer_hashref_to_string(\%RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_hash), "\n";
print 'have *RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_typeglob execution... ', &{*RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_typeglob}(), "\n";

# DISPLAY, IMPORTER, DELTA 0
print 'have $exported_ok_scalar = ', $exported_ok_scalar, "\n";
print 'have @exported_ok_array = ', integer_arrayref_to_string(\@exported_ok_array), "\n";
print 'have %exported_ok_hash = ', integer_hashref_to_string(\%exported_ok_hash), "\n";
print 'have *exported_ok_typeglob execution... ', &{*exported_ok_typeglob}(), "\n";

# MODIFY, EXPORTER, DELTA 1
$RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_scalar *= 2;
$RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_array[0] *= 2;
$RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_hash{a} *= 2;
{
    # AVOID ERROR: Subroutine ... redefined
    no strict;
    no warnings;
    *RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_typeglob = sub { return 'I am another different anonymous subroutine.'; };
}

# DISPLAY, EXPORTER, DELTA 1
print 'have $RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_scalar = ', $RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_scalar, "\n";
print 'have @RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_array = ', integer_arrayref_to_string(\@RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_array), "\n";
print 'have %RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_hash = ', integer_hashref_to_string(\%RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_hash), "\n";
print 'have *RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_typeglob execution... ', &{*RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_typeglob}(), "\n";

# DISPLAY, IMPORTER, DELTA 1
print 'have $exported_ok_scalar = ', $exported_ok_scalar, "\n";
print 'have @exported_ok_array = ', integer_arrayref_to_string(\@exported_ok_array), "\n";
print 'have %exported_ok_hash = ', integer_hashref_to_string(\%exported_ok_hash), "\n";
print 'have *exported_ok_typeglob execution... ', &{*exported_ok_typeglob}(), "\n";

# MODIFY, IMPORTER, DELTA 2
$exported_ok_scalar *= 2;
$exported_ok_array[0] *= 2;
$exported_ok_hash{a} *= 2;
{
    # AVOID ERROR: Subroutine ... redefined
    no strict;
    no warnings;
    *exported_ok_typeglob = sub { return 'I am yet another different anonymous subroutine.'; };
}

# DISPLAY, EXPORTER, DELTA 2
print 'have $RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_scalar = ', $RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_scalar, "\n";
print 'have @RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_array = ', integer_arrayref_to_string(\@RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_array), "\n";
print 'have %RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_hash = ', integer_hashref_to_string(\%RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_hash), "\n";
print 'have *RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_typeglob execution... ', &{*RPerl::Test::Exporter::Class_A_Exporter_20_NotBad::exported_ok_typeglob}(), "\n";

# DISPLAY, IMPORTER, DELTA 2
print 'have $exported_ok_scalar = ', $exported_ok_scalar, "\n";
print 'have @exported_ok_array = ', integer_arrayref_to_string(\@exported_ok_array), "\n";
print 'have %exported_ok_hash = ', integer_hashref_to_string(\%exported_ok_hash), "\n";
print 'have *exported_ok_typeglob execution... ', &{*exported_ok_typeglob}(), "\n";

