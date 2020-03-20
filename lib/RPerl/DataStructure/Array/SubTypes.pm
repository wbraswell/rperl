## no critic qw(ProhibitUselessNoCritic PodSpelling ProhibitExcessMainComplexity)  # DEVELOPER DEFAULT 1a: allow unreachable & POD-commented code; SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1
package RPerl::DataStructure::Array::SubTypes;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.017_000;

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

1;  # end of package
