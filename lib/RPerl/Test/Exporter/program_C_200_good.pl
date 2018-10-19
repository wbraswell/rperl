#!/usr/bin/env perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: "in Class_C_Exporter_20_NotBad::exported(), received $arg = 17" >>>
# <<< EXECUTE_SUCCESS: "after exported(17), received $exported_retval = 2040" >>>
# <<< EXECUTE_SUCCESS: "have $RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_scalar = -2112" >>>
# <<< EXECUTE_SUCCESS: "have @RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_array = [ -10, -20, -30, -40 ]" >>>
# <<< EXECUTE_SUCCESS: "have %RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_hash = { 'a' => -15, 'b' => -25, 'c' => -35 }" >>>
# <<< EXECUTE_SUCCESS: "have *RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_typeglob execution... I am an anonymous subroutine inside an exported typeglob." >>>
# <<< EXECUTE_SUCCESS: "have $exported_scalar = -2112" >>>
# <<< EXECUTE_SUCCESS: "have @exported_array = [ -10, -20, -30, -40 ]" >>>
# <<< EXECUTE_SUCCESS: "have %exported_hash = { 'a' => -15, 'b' => -25, 'c' => -35 }" >>>
# <<< EXECUTE_SUCCESS: "have *exported_typeglob execution... I am an anonymous subroutine inside an exported typeglob." >>>
# <<< EXECUTE_SUCCESS: "have $RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_scalar = -4224" >>>
# <<< EXECUTE_SUCCESS: "have @RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_array = [ -20, -20, -30, -40 ]" >>>
# <<< EXECUTE_SUCCESS: "have %RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_hash = { 'a' => -30, 'b' => -25, 'c' => -35 }" >>>
# <<< EXECUTE_SUCCESS: "have *RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_typeglob execution... I am another different anonymous subroutine." >>>
# <<< EXECUTE_SUCCESS: "have $exported_scalar = -4224" >>>
# <<< EXECUTE_SUCCESS: "have @exported_array = [ -20, -20, -30, -40 ]" >>>
# <<< EXECUTE_SUCCESS: "have %exported_hash = { 'a' => -30, 'b' => -25, 'c' => -35 }" >>>
# <<< EXECUTE_SUCCESS: "have *exported_typeglob execution... I am another different anonymous subroutine." >>>
# <<< EXECUTE_SUCCESS: "have $RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_scalar = -8448" >>>
# <<< EXECUTE_SUCCESS: "have @RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_array = [ -40, -20, -30, -40 ]" >>>
# <<< EXECUTE_SUCCESS: "have %RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_hash = { 'a' => -60, 'b' => -25, 'c' => -35 }" >>>
# <<< EXECUTE_SUCCESS: "have *RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_typeglob execution... I am yet another different anonymous subroutine." >>>
# <<< EXECUTE_SUCCESS: "have $exported_scalar = -8448" >>>
# <<< EXECUTE_SUCCESS: "have @exported_array = [ -40, -20, -30, -40 ]" >>>
# <<< EXECUTE_SUCCESS: "have %exported_hash = { 'a' => -60, 'b' => -25, 'c' => -35 }" >>>
# <<< EXECUTE_SUCCESS: "have *exported_typeglob execution... I am yet another different anonymous subroutine." >>>

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
use RPerl::Test::Exporter::Class_C_Exporter_20_NotBad;

# [[[ SUBROUTINES ]]]

sub not_exported {
    { my integer $RETURN_TYPE };
    ( my integer $arg ) = @ARG;
    print 'in main::not_exported(), received $arg = ', $arg, "\n";
    return ($arg * 430);
}

# [[[ OPERATIONS ]]]

my integer $exported_retval = exported(17);
print 'after exported(17), received $exported_retval = ', $exported_retval, "\n";







# DISPLAY, EXPORTER, DELTA 0
print 'have $RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_scalar = ', $RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_scalar, "\n";
print 'have @RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_array = ', integer_arrayref_to_string(\@RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_array), "\n";
print 'have %RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_hash = ', integer_hashref_to_string(\%RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_hash), "\n";
print 'have *RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_typeglob execution... ', &{*RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_typeglob}(), "\n";

# DISPLAY, IMPORTER, DELTA 0
print 'have $exported_scalar = ', $exported_scalar, "\n";
print 'have @exported_array = ', integer_arrayref_to_string(\@exported_array), "\n";
print 'have %exported_hash = ', integer_hashref_to_string(\%exported_hash), "\n";
print 'have *exported_typeglob execution... ', &{*exported_typeglob}(), "\n";

# MODIFY, EXPORTER, DELTA 1
$RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_scalar *= 2;
$RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_array[0] *= 2;
$RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_hash{a} *= 2;
{
    # AVOID ERROR: Subroutine ... redefined
    no strict;
    no warnings;
    *RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_typeglob = sub { return 'I am another different anonymous subroutine.'; };
}

# DISPLAY, EXPORTER, DELTA 1
print 'have $RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_scalar = ', $RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_scalar, "\n";
print 'have @RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_array = ', integer_arrayref_to_string(\@RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_array), "\n";
print 'have %RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_hash = ', integer_hashref_to_string(\%RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_hash), "\n";
print 'have *RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_typeglob execution... ', &{*RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_typeglob}(), "\n";

# DISPLAY, IMPORTER, DELTA 1
print 'have $exported_scalar = ', $exported_scalar, "\n";
print 'have @exported_array = ', integer_arrayref_to_string(\@exported_array), "\n";
print 'have %exported_hash = ', integer_hashref_to_string(\%exported_hash), "\n";
print 'have *exported_typeglob execution... ', &{*exported_typeglob}(), "\n";

# MODIFY, IMPORTER, DELTA 2
$exported_scalar *= 2;
$exported_array[0] *= 2;
$exported_hash{a} *= 2;
{
    # AVOID ERROR: Subroutine ... redefined
    no strict;
    no warnings;
    *exported_typeglob = sub { return 'I am yet another different anonymous subroutine.'; };
}

# DISPLAY, EXPORTER, DELTA 2
print 'have $RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_scalar = ', $RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_scalar, "\n";
print 'have @RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_array = ', integer_arrayref_to_string(\@RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_array), "\n";
print 'have %RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_hash = ', integer_hashref_to_string(\%RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_hash), "\n";
print 'have *RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_typeglob execution... ', &{*RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_typeglob}(), "\n";

# DISPLAY, IMPORTER, DELTA 2
print 'have $exported_scalar = ', $exported_scalar, "\n";
print 'have @exported_array = ', integer_arrayref_to_string(\@exported_array), "\n";
print 'have %exported_hash = ', integer_hashref_to_string(\%exported_hash), "\n";
print 'have *exported_typeglob execution... ', &{*exported_typeglob}(), "\n";





__END__


print 'have $exported_scalar = ', $exported_scalar, "\n";
print 'have @exported_array = ', integer_arrayref_to_string(\@exported_array), "\n";
print 'have %exported_hash = ', integer_hashref_to_string(\%exported_hash), "\n";
print 'have *exported_typeglob execution... ', &{*exported_typeglob}(), "\n";

$RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_scalar *= 2;
$RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_array[0] *= 2;
$RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_hash{a} *= 2;
{
    # AVOID ERROR: Subroutine ... redefined
    no strict;
    no warnings;
    *RPerl::Test::Exporter::Class_C_Exporter_20_NotBad::exported_typeglob = sub { return 'I am a different anonymous subroutine.'; };
}

print 'have $exported_scalar = ', $exported_scalar, "\n";
print 'have @exported_array = ', integer_arrayref_to_string(\@exported_array), "\n";
print 'have %exported_hash = ', integer_hashref_to_string(\%exported_hash), "\n";
print 'have *exported_typeglob execution... ', &{*exported_typeglob}(), "\n";

