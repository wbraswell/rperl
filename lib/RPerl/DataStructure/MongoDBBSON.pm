# [[[ HEADER ]]]
package RPerl::DataStructure::MongoDBBSON;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ SUB-TYPES ]]]
package    # hide from PAUSE indexing
    bson_document;
1;    # end of class

package    # hide from PAUSE indexing
    bson_document__optional;
1;    # end of class

package    # hide from PAUSE indexing
    bson_arrayref;
1;    # end of class

package    # hide from PAUSE indexing
    bson_hashref;
1;    # end of class



# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE ]]]
package RPerl::DataStructure::MongoDBBSON;
use strict;
use warnings;

# [[[ EXPORTS ]]]
use RPerl::Exporter 'import';
our @EXPORT = qw(
    bson_build
    bson_Dumper
);

# DEV NOTE: do nothing in Perl, this subroutine is only used in C++
sub bson_build {
    { my bson_document $RETURN_TYPE };
    ( my hashref $bson_document_raw ) = @ARG;
    return $bson_document_raw;
}

sub bson_Dumper {
    { my string $RETURN_TYPE };
    ( my bson_document $bson_document ) = @ARG;
    return Dumper($bson_document);
}

1;    # end of class
