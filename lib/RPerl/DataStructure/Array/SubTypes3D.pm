## no critic qw(ProhibitUselessNoCritic PodSpelling ProhibitExcessMainComplexity)  # DEVELOPER DEFAULT 1a: allow unreachable & POD-commented code; SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1
package RPerl::DataStructure::Array::SubTypes3D;
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
our @EXPORT = qw();
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

# [[[ ARRAY REF ARRAY REF ARRAY REF ]]]
# [[[ ARRAY REF ARRAY REF ARRAY REF ]]]
# [[[ ARRAY REF ARRAY REF ARRAY REF ]]]

# (ref to array) of (refs to arrays) of (refs to arrays)
package  # hide from PAUSE indexing
    arrayref_arrayref_arrayref;
use strict;
use warnings;
use parent -norequire, qw(arrayref);

# (ref to array) of (refs to arrays) of (refs to (arrays of integers))
package  # hide from PAUSE indexing
    integer_arrayref_arrayref_arrayref;
use strict;
use warnings;
use parent -norequire, qw(arrayref_arrayref_arrayref);

# (ref to array) of (refs to arrays) of (refs to (arrays of numbers))
package  # hide from PAUSE indexing
    number_arrayref_arrayref_arrayref;
use strict;
use warnings;
use parent -norequire, qw(arrayref_arrayref_arrayref);

# (ref to array) of (refs to arrays) of (refs to (arrays of strings))
package  # hide from PAUSE indexing
    string_arrayref_arrayref_arrayref;
use strict;
use warnings;
use parent -norequire, qw(arrayref_arrayref_arrayref);

# (ref to array) of (refs to arrays) of (refs to (arrays of scalars))
package  # hide from PAUSE indexing
    scalartype_arrayref_arrayref_arrayref;
use strict;
use warnings;
use parent -norequire, qw(arrayref_arrayref_arrayref);

1;  # end of package
