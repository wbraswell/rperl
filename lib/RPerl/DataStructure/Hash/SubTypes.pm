## no critic qw(ProhibitUselessNoCritic PodSpelling ProhibitExcessMainComplexity)  # DEVELOPER DEFAULT 1a: allow unreachable & POD-commented code; SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1
package RPerl::DataStructure::Hash::SubTypes;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.016_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitUnreachableCode RequirePodSections RequirePodAtEnd)  # DEVELOPER DEFAULT 1b: allow unreachable & POD-commented code, must be after line 1
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ EXPORTS ]]]
# DEV NOTE, CORRELATION #rp051: hard-coded list of RPerl data types and data structures
use RPerl::Exporter 'import';
our @EXPORT = qw(
    hashref_CHECK
    hashref_CHECKTRACE
);
our @EXPORT_OK = qw();

# [[[ HASH ]]]
# [[[ HASH ]]]
# [[[ HASH ]]]

# a hash is an associative array, meaning a 1-dimensional list/vector/sequence/set of (key, value) pairs;
# we never use this type directly, instead we always use the hashref type,
# per LMPC #27: Thou Shalt Not Use Direct Access To Arrays & Hashes Stored In @ Or % Non-Scalar Variables
package  # hide from PAUSE indexing
    hash;
use strict;
use warnings;
use parent qw(RPerl::DataStructure::Hash);

# [[[ HASH REF ]]]
# [[[ HASH REF ]]]
# [[[ HASH REF ]]]

# ref to hash
package  # hide from PAUSE indexing
    hashref;
use strict;
use warnings;
#use parent -norequire, qw(ref);  # NEED REMOVE: properly replaced by line below?
use parent -norequire, qw(RPerl::DataStructure::Hash::Reference);
use Carp;

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE FOR EXPORT TO WORK ]]]
package RPerl::DataStructure::Hash::SubTypes;
use strict;
use warnings;

use RPerl::Config;  # for 'use English;' etc.

# [[[ TYPE-CHECKING ]]]

sub hashref_CHECK {
    { my void $RETURN_TYPE };
    ( my $possible_hashref ) = @ARG;
    if ( not( defined $possible_hashref ) ) {
        croak(
            "\nERROR EHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nhashref value expected but undefined/null value found,\ncroaking"
        );
    }

#    if ( UNIVERSAL::isa( $possible_hashref, 'HASH' ) ) {  # DEV NOTE: I believe these 2 lines are equivalent?
    if ( not( main::RPerl_SvHROKp($possible_hashref) ) ) {
        croak(
            "\nERROR EHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nhashref value expected but non-hashref value found,\ncroaking"
        );
    }
    return;
}

sub hashref_CHECKTRACE {
    { my void $RETURN_TYPE };
    ( my $possible_hashref, my $variable_name, my $subroutine_name ) = @ARG;
    if ( not( defined $possible_hashref ) ) {
        croak(
            "\nERROR EHVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nhashref value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }
    if ( not( main::RPerl_SvHROKp($possible_hashref) ) ) {
        croak(
            "\nERROR EHVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nhashref value expected but non-hashref value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }
    return;
}

1;  # end of package
