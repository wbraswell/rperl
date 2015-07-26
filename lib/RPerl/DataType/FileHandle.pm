# [[[ HEADER ]]]
package RPerl::DataType::FileHandle;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.002_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ OO INHERITANCE ]]]
use parent ('RPerl::DataType');
use RPerl::DataType;

# [[[ SUB-TYPES BEFORE SETUP ]]]
# a filehandleref is "a reference to a newly allocated anonymous filehandle";  http://perldoc.perl.org/functions/open.html
# we do not ever directly use filehandle type, only filehandleref
package  # hide from PAUSE indexing
    filehandleref;
use strict;
use warnings;
use RPerl;
use parent -norequire, ('ref');

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE ]]]
package RPerl::DataType::FileHandle;
use strict;
use warnings;
use RPerl;

# [[[ OO INHERITANCE ]]]
use parent ('RPerl::DataType');
use RPerl::DataType;

# NEED FIX: is a filehandleref really an integer?!?

# [[[ TYPE-CHECKING ]]]
our void $filehandleref_CHECK = sub {
    ( my $possible_filehandleref ) = @_;
    if ( not( defined $possible_filehandleref ) ) {
        croak(
            "\nERROR EFH00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nfilehandleref value expected but undefined/null value found,\ncroaking"
        );
    }
    if ( not( main::RPerl_SvIOKp($possible_filehandleref) ) ) {
        croak(
            "\nERROR EFH01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nfilehandleref value expected but non-filehandleref value found,\ncroaking"
        );
    }
};
our void $filehandleref_CHECKTRACE = sub {
    ( my $possible_filehandleref, my $variable_name, my $subroutine_name )
        = @_;
    if ( not( defined $possible_filehandleref ) ) {
        croak(
            "\nERROR EFH00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nfilehandleref value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }
    if ( not( main::RPerl_SvIOKp($possible_filehandleref) ) ) {
        croak(
            "\nERROR EFH01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nfilehandleref value expected but non-filehandleref value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }
};

1;                                            # end of class
