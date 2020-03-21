## no critic qw(ProhibitUselessNoCritic PodSpelling ProhibitExcessMainComplexity)  # DEVELOPER DEFAULT 1a: allow unreachable & POD-commented code; SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1
package RPerl::DataStructure::Array::SubTypes2D;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.018_000;

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

# [[[ ARRAY REF ARRAY (2-dimensional) ]]]
# [[[ ARRAY REF ARRAY (2-dimensional) ]]]
# [[[ ARRAY REF ARRAY (2-dimensional) ]]]

# array of (refs to arrays)
package  # hide from PAUSE indexing
    arrayref_array;
use strict;
use warnings;
use parent -norequire, qw(array);

# [[[ ARRAY REF ARRAY REF (2-dimensional) ]]]
# [[[ ARRAY REF ARRAY REF (2-dimensional) ]]]
# [[[ ARRAY REF ARRAY REF (2-dimensional) ]]]

# (ref to array) of (refs to arrays)
package  # hide from PAUSE indexing
    arrayref_arrayref;
use strict;
use warnings;
use parent -norequire, qw(arrayref);

# [[[ INTEGER ARRAY REF ARRAY (2-dimensional) ]]]
# [[[ INTEGER ARRAY REF ARRAY (2-dimensional) ]]]
# [[[ INTEGER ARRAY REF ARRAY (2-dimensional) ]]]

# no method-return-type or type-checking or stringify for array types, only arrayref types;
# DEV NOTE, CORRELATION #rp031: Perl can not pass @array or %hash by value, must always pass scalar $arrayref or $hashref by reference

# array of (refs to (arrays of integers))
package  # hide from PAUSE indexing
    integer_arrayref_array;
use strict;
use warnings;
use parent -norequire, qw(arrayref_array);

# [[[ INTEGER ARRAY REF ARRAY REF (2-dimensional) ]]]
# [[[ INTEGER ARRAY REF ARRAY REF (2-dimensional) ]]]
# [[[ INTEGER ARRAY REF ARRAY REF (2-dimensional) ]]]

# method returning (ref to array) of (refs to (arrays of integers))
package  # hide from PAUSE indexing
    integer_arrayref_arrayref::method;
use strict;
use warnings;
use parent -norequire, qw(method);

# (ref to array) of (refs to (arrays of integers))
package  # hide from PAUSE indexing
    integer_arrayref_arrayref;
use strict;
use warnings;
use parent -norequire, qw(arrayref_arrayref);

use RPerl::Config;  # for 'use English;' etc.




# START HERE: implement integer_arrayref_arrayref_CHECK*() & integer_arrayref_arrayref_to_string() & integer_arrayref_arrayref_typetest*() as in Hash/SubTypes.pm, then *_arrayref_arrayref, then *_hashref_arrayref
# START HERE: implement integer_arrayref_arrayref_CHECK*() & integer_arrayref_arrayref_to_string() & integer_arrayref_arrayref_typetest*() as in Hash/SubTypes.pm, then *_arrayref_arrayref, then *_hashref_arrayref
# START HERE: implement integer_arrayref_arrayref_CHECK*() & integer_arrayref_arrayref_to_string() & integer_arrayref_arrayref_typetest*() as in Hash/SubTypes.pm, then *_arrayref_arrayref, then *_hashref_arrayref




# emulate C++ behavior by actually creating arrays (and presumably allocating memory) at initialization time
sub new {
    { my integer_arrayref_arrayref::method $RETURN_TYPE };
    ( my integer $row_count, my integer $column_count ) = @ARG;  # row-major form (RMF)
    my integer_arrayref_arrayref $retval = [];
    for my integer $j (0 .. ($row_count - 1)) {
        my integer_arrayref $retval_row = [];
        for my integer $i (0 .. ($column_count - 1)) {
            $retval_row->[$i] = undef;
        }
        $retval->[$j] = $retval_row;
    }
    return $retval;
}

# [[[ NUMBER ARRAY REF ARRAY (2-dimensional) ]]]
# [[[ NUMBER ARRAY REF ARRAY (2-dimensional) ]]]
# [[[ NUMBER ARRAY REF ARRAY (2-dimensional) ]]]

# no method-return-type or type-checking or stringify for array types, only arrayref types;
# DEV NOTE, CORRELATION #rp031: Perl can not pass @array or %hash by value, must always pass scalar $arrayref or $hashref by reference

# array of (refs to (arrays of numbers))
package  # hide from PAUSE indexing
    number_arrayref_array;
use strict;
use warnings;
use parent -norequire, qw(arrayref_array);

# [[[ NUMBER ARRAY REF ARRAY REF (2-dimensional) ]]]
# [[[ NUMBER ARRAY REF ARRAY REF (2-dimensional) ]]]
# [[[ NUMBER ARRAY REF ARRAY REF (2-dimensional) ]]]

# method returning (ref to array) of (refs to (arrays of numbers))
package  # hide from PAUSE indexing
    number_arrayref_arrayref::method;
use strict;
use warnings;
use parent -norequire, qw(method);

# (ref to array) of (refs to (arrays of numbers))
package  # hide from PAUSE indexing
    number_arrayref_arrayref;
use strict;
use warnings;
use parent -norequire, qw(arrayref_arrayref);

use RPerl::Config;  # for 'use English;' etc.

# emulate C++ behavior by actually creating arrays (and presumably allocating memory) at initialization time
sub new {
    { my number_arrayref_arrayref::method $RETURN_TYPE };
    ( my integer $row_count, my integer $column_count ) = @ARG;  # row-major form (RMF)
    my number_arrayref_arrayref $retval = [];
    for my integer $j (0 .. ($row_count - 1)) {
        my number_arrayref $retval_row = [];
        for my integer $i (0 .. ($column_count - 1)) {
            $retval_row->[$i] = undef;
        }
        $retval->[$j] = $retval_row;
    }
    return $retval;
}

# [[[ STRING ARRAY REF ARRAY (2-dimensional) ]]]
# [[[ STRING ARRAY REF ARRAY (2-dimensional) ]]]
# [[[ STRING ARRAY REF ARRAY (2-dimensional) ]]]

# no method-return-type or type-checking or stringify for array types, only arrayref types;
# DEV NOTE, CORRELATION #rp031: Perl can not pass @array or %hash by value, must always pass scalar $arrayref or $hashref by reference

# array of (refs to (arrays of strings))
package  # hide from PAUSE indexing
    string_arrayref_array;
use strict;
use warnings;
use parent -norequire, qw(arrayref_array);

# [[[ STRING ARRAY REF ARRAY REF (2-dimensional) ]]]
# [[[ STRING ARRAY REF ARRAY REF (2-dimensional) ]]]
# [[[ STRING ARRAY REF ARRAY REF (2-dimensional) ]]]

# method returning (ref to array) of (refs to (arrays of strings))
package  # hide from PAUSE indexing
    string_arrayref_arrayref::method;
use strict;
use warnings;
use parent -norequire, qw(method);

# (ref to array) of (refs to (arrays of strings))
package  # hide from PAUSE indexing
    string_arrayref_arrayref;
use strict;
use warnings;
use parent -norequire, qw(arrayref_arrayref);

use RPerl::Config;  # for 'use English;' etc.

# emulate C++ behavior by actually creating arrays (and presumably allocating memory) at initialization time
sub new {
    { my string_arrayref_arrayref::method $RETURN_TYPE };
    ( my integer $row_count, my integer $column_count ) = @ARG;  # row-major form (RMF)
    my string_arrayref_arrayref $retval = [];
    for my integer $j (0 .. ($row_count - 1)) {
        my string_arrayref $retval_row = [];
        for my integer $i (0 .. ($column_count - 1)) {
            $retval_row->[$i] = undef;
        }
        $retval->[$j] = $retval_row;
    }
    return $retval;
}

# [[[ SCALAR ARRAY REF ARRAY (2-dimensional) ]]]
# [[[ SCALAR ARRAY REF ARRAY (2-dimensional) ]]]
# [[[ SCALAR ARRAY REF ARRAY (2-dimensional) ]]]

# no method-return-type or type-checking or stringify for array types, only arrayref types;
# DEV NOTE, CORRELATION #rp031: Perl can not pass @array or %hash by value, must always pass scalar $arrayref or $hashref by reference

# array of (refs to (arrays of scalartypes))
package  # hide from PAUSE indexing
    scalartype_arrayref_array;
use strict;
use warnings;
use parent -norequire, qw(arrayref_array);

# [[[ SCALAR ARRAY REF ARRAY REF (2-dimensional) ]]]
# [[[ SCALAR ARRAY REF ARRAY REF (2-dimensional) ]]]
# [[[ SCALAR ARRAY REF ARRAY REF (2-dimensional) ]]]

# method returning (ref to array) of (refs to (arrays of scalartypes))
package  # hide from PAUSE indexing
    scalartype_arrayref_arrayref::method;
use strict;
use warnings;
use parent -norequire, qw(method);

# (ref to array) of (refs to (arrays of scalars))
package  # hide from PAUSE indexing
    scalartype_arrayref_arrayref;
use strict;
use warnings;
use parent -norequire, qw(arrayref_arrayref);

use RPerl::Config;  # for 'use English;' etc.

# emulate C++ behavior by actually creating arrays (and presumably allocating memory) at initialization time
sub new {
    { my scalartype_arrayref_arrayref::method $RETURN_TYPE };
    ( my integer $row_count, my integer $column_count ) = @ARG;  # row-major form (RMF)
    my scalartype_arrayref_arrayref $retval = [];
    for my integer $j (0 .. ($row_count - 1)) {
        my scalartype_arrayref $retval_row = [];
        for my integer $i (0 .. ($column_count - 1)) {
            $retval_row->[$i] = undef;
        }
        $retval->[$j] = $retval_row;
    }
    return $retval;
}

# [[[ HASH REF ARRAY (2-dimensional) ]]]
# [[[ HASH REF ARRAY (2-dimensional) ]]]
# [[[ HASH REF ARRAY (2-dimensional) ]]]

# no method-return-type or type-checking or stringify for array types, only arrayref types;
# DEV NOTE, CORRELATION #rp031: Perl can not pass @array or %hash by value, must always pass scalar $arrayref or $hashref by reference

# array of (refs to hashes)
package  # hide from PAUSE indexing
    hashref_array;
use strict;
use warnings;
use parent -norequire, qw(array);

# [[[ HASH REF ARRAY REF (2-dimensional) ]]]
# [[[ HASH REF ARRAY REF (2-dimensional) ]]]
# [[[ HASH REF ARRAY REF (2-dimensional) ]]]

# (ref to array) of (refs to hashs)
package  # hide from PAUSE indexing
    hashref_arrayref;
use strict;
use warnings;
use parent -norequire, qw(arrayref);


# NEED ANSWER: are object arrays really 2-D, or are they 1-D???
# NEED ANSWER: are object arrays really 2-D, or are they 1-D???
# NEED ANSWER: are object arrays really 2-D, or are they 1-D???

# [[[ OBJECT ARRAY ]]]
# [[[ OBJECT ARRAY ]]]
# [[[ OBJECT ARRAY ]]]

# array of objects
package  # hide from PAUSE indexing
    object_array;
use strict;
use warnings;
use parent -norequire, qw(array);

# [[[ OBJECT ARRAY REF ]]]
# [[[ OBJECT ARRAY REF ]]]
# [[[ OBJECT ARRAY REF ]]]

# (ref to array) of objects
package  # hide from PAUSE indexing
    object_arrayref;
use strict;
use warnings;
use parent -norequire, qw(arrayref);

1;  # end of package
