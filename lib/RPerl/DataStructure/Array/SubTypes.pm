## no critic qw(ProhibitUselessNoCritic PodSpelling ProhibitExcessMainComplexity)  # DEVELOPER DEFAULT 1a: allow unreachable & POD-commented code; SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1
package RPerl::DataStructure::Array::SubTypes;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.020_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitUnreachableCode RequirePodSections RequirePodAtEnd)  # DEVELOPER DEFAULT 1b: allow unreachable & POD-commented code, must be after line 1
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ EXPORTS ]]]
# DEV NOTE, CORRELATION #rp051: hard-coded list of RPerl data types and data structures
use RPerl::Exporter 'import';
our @EXPORT = qw(
    arrayref_CHECK
    arrayref_CHECKTRACE
    arrayref_to_string_compact
    arrayref_to_string
    arrayref_to_string_pretty
    arrayref_to_string_expand
    arrayref_to_string_format
);
our @EXPORT_OK = qw();

# [[[ PRE-DECLARED TYPES ]]]
package    # hide from PAUSE indexing
    boolean;
package    # hide from PAUSE indexing
    unsigned_integer;
#package     # hide from PAUSE indexing
#    integer;
package    # hide from PAUSE indexing
    number;
package    # hide from PAUSE indexing
    character;
package    # hide from PAUSE indexing
    string;
package  # hide from PAUSE indexing
    type_enum;

# [[[ ARRAY ]]]
# [[[ ARRAY ]]]
# [[[ ARRAY ]]]

# an array is a 1-dimensional list/vector/sequence/set of data types;
# DEV NOTE, CORRELATION #rp031: Perl can not pass @array or %hash by value, must always pass scalar $arrayref or $hashref by reference;
# LMPC #27: Thou Shalt Not Use Direct Access To Arrays & Hashes Stored In @ Or % Non-Scalar Variables
package  # hide from PAUSE indexing
    array;
use strict;
use warnings;
use parent qw(RPerl::DataStructure::Array);

# [[[ ARRAY REF ]]]
# [[[ ARRAY REF ]]]
# [[[ ARRAY REF ]]]

# ref to array
package  # hide from PAUSE indexing
    arrayref;
use strict;
use warnings;
#use parent -norequire, qw(ref);  # NEED REMOVE: properly replaced by line below?
use parent -norequire, qw(RPerl::DataStructure::Array::Reference);
use Carp;

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE FOR EXPORT TO WORK ]]]
package RPerl::DataStructure::Array::SubTypes;
use strict;
use warnings;

# [[[ TYPE-CHECKING ]]]

sub arrayref_CHECK {
    { my void $RETURN_TYPE };
    ( my $possible_arrayref ) = @ARG;
    if ( not( defined $possible_arrayref ) ) {
        croak( "\nERROR EAVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\narrayref value expected but undefined/null value found,\ncroaking" );
    }

#    if ( UNIVERSAL::isa( $possible_arrayref, 'ARRAY' ) ) {  # DEV NOTE: I believe these 2 lines are equivalent?
    if ( not( main::RPerl_SvAROKp($possible_arrayref) ) ) {
        croak( "\nERROR EAVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\narrayref value expected but non-arrayref value found,\ncroaking" );
    }
    return;
}

sub arrayref_CHECKTRACE {
    { my void $RETURN_TYPE };
    ( my $possible_arrayref, my $variable_name, my $subroutine_name ) = @ARG;
    if ( not( defined $possible_arrayref ) ) {
        croak( "\nERROR EAVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\narrayref value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
    }
    if ( not( main::RPerl_SvAROKp($possible_arrayref) ) ) {
        croak( "\nERROR EAVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\narrayref value expected but non-arrayref value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
    }
    return;
}

# [[[ STRINGIFY ]]]

# DEV NOTE, CORRELATION #rp321, DYNAMIC DISPATCH: list order must match exactly between LIST_OF_TYPES_SCALAR & LIST_OF_TYPES_ARRAYREF & LIST_OF_TYPES_HASHREF
my $TYPED_arrayref_to_string_format = [
    \&main::string_arrayref_to_string_format,  # NEED UPGRADE: implement void_to_string()???
#   \&main::boolean_arrayref_to_string_format,
#   \&main::unsigned_integer_arrayref_to_string_format,
    \&main::integer_arrayref_to_string_format,
    \&main::number_arrayref_to_string_format,
#   \&main::character_arrayref_to_string_format,
    \&main::string_arrayref_to_string_format,
    \&main::string_arrayref_to_string_format,  # NEED UPGRADE: implement unknown_to_string()???
];

sub DYNAMIC_arrayref_to_string_format {
    { my string $RETURN_TYPE };
    ( my arrayref $input_avref, my integer $format_level, my integer $indent_level, my boolean $is_reference, my type_enum $input_avref_type) = @ARG;
    RPerl::diag('in PERLOPS_PERLTYPES DYNAMIC_arrayref_to_string_format(), received $input_avref_type = ', $input_avref_type, "\n");
#    RPerl::diag('in PERLOPS_PERLTYPES DYNAMIC_arrayref_to_string_format(), have $main::string_to_type_enum->{$input_avref_type} = ', $main::string_to_type_enum->{$input_avref_type}, "\n");  # DOES NOT WORK: string_to_type_enum() is in rperltypes, rperltypes uses this file, not vice-versa

    return &{$TYPED_arrayref_to_string_format->[$input_avref_type]}($input_avref, $format_level, $indent_level, $is_reference);
}

# call DYNAMIC stringify routine, format level -2 (compact), indent level 0, is reference 1 (true)
sub arrayref_to_string_compact {
    { my string $RETURN_TYPE };
    ( my arrayref $input_avref ) = @ARG;
    RPerl::diag("in PERLOPS_PERLTYPES arrayref_to_string_compact(), about to call DYNAMIC_arrayref_to_string_format() & return value\n");

    return DYNAMIC_arrayref_to_string_format($input_avref, -2, 0, 1, main::type_fast_enum__upgrade_integer_to_number($input_avref->[0]));
}

# call DYNAMIC stringify routine, format level -1 (normal), indent level 0, is reference 1 (true); DEFAULT
sub arrayref_to_string {
    { my string $RETURN_TYPE };
    ( my arrayref $input_avref ) = @ARG;
    RPerl::diag("in PERLOPS_PERLTYPES arrayref_to_string(), about to call DYNAMIC_arrayref_to_string_format() & return value\n");

    return DYNAMIC_arrayref_to_string_format($input_avref, -1, 0, 1, main::type_fast_enum__upgrade_integer_to_number($input_avref->[0]));
}

# call DYNAMIC stringify routine, format level 0 (pretty), indent level 0, is reference 1 (true)
sub arrayref_to_string_pretty {
    { my string $RETURN_TYPE };
    ( my arrayref $input_avref ) = @ARG;
    RPerl::diag("in PERLOPS_PERLTYPES arrayref_to_string_pretty(), about to call DYNAMIC_arrayref_to_string_format() & return value\n");

    return DYNAMIC_arrayref_to_string_format($input_avref, 0, 0, 1, main::type_fast_enum__upgrade_integer_to_number($input_avref->[0]));
}

# call DYNAMIC stringify routine, format level 1 (expand), indent level 0, is reference 1 (true)
sub arrayref_to_string_expand {
    { my string $RETURN_TYPE };
    ( my arrayref $input_avref ) = @ARG;
    RPerl::diag("in PERLOPS_PERLTYPES arrayref_to_string_expand(), about to call DYNAMIC_arrayref_to_string_format() & return value\n");

    return DYNAMIC_arrayref_to_string_format($input_avref, 1, 0, 1, main::type_fast_enum__upgrade_integer_to_number($input_avref->[0]));
}

# convert from (Perl SV containing RV to (Perl AV of (Perl SVs containing IVs))) to Perl-parsable (Perl SV containing PV)
# stringify a integer_arrayref
sub arrayref_to_string_format {
    { my string $RETURN_TYPE };
    ( my arrayref $input_avref, my integer $format_level, my integer $indent_level ) = @ARG;

#    RPerl::diag("in PERLOPS_PERLTYPES arrayref_to_string_format(), top of subroutine\n");
#    RPerl::diag('in PERLOPS_PERLTYPES arrayref_to_string_format(), received $format_level = ', $format_level, "\n");
#    RPerl::diag('in PERLOPS_PERLTYPES arrayref_to_string_format(), received $indent_level = ', $indent_level, "\n");
    RPerl::diag("in PERLOPS_PERLTYPES arrayref_to_string_format(), about to call DYNAMIC_arrayref_to_string_format() & return value\n");

    return DYNAMIC_arrayref_to_string_format($input_avref, $format_level, $indent_level, 1, main::type_fast_enum__upgrade_integer_to_number($input_avref->[0]));
}

1;  # end of package
