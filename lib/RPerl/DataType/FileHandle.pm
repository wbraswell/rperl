# [[[ HEADER ]]]
package RPerl::DataType::FileHandle;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.004_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::DataType);
use RPerl::DataType;

# [[[ SUB-TYPES BEFORE SETUP ]]]
# a filehandleref is "a reference to a newly allocated anonymous filehandle";  http://perldoc.perl.org/functions/open.html
# we do not ever directly use filehandle type, only filehandleref
package  # hide from PAUSE indexing
    filehandleref;
use strict;
use warnings;
use parent -norequire, qw(ref);

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE ]]]
package RPerl::DataType::FileHandle;
use strict;
use warnings;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::DataType);
use RPerl::DataType;

# NEED FIX: is a filehandleref really an integer?!?

# [[[ TYPE-CHECKING ]]]
sub filehandleref_CHECK {
    { my void $RETURN_TYPE };
    ( my $possible_filehandleref ) = @ARG;
    if ( not( defined $possible_filehandleref ) ) {
#        croak( "\nERROR EFH00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nfilehandleref value expected but undefined/null value found,\ncroaking" );
        die( "\nERROR EFH00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nfilehandleref value expected but undefined/null value found,\ndying\n" );
    }
    if ( not( main::RPerl_SvIOKp($possible_filehandleref) ) ) {
#        croak( "\nERROR EFH01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nfilehandleref value expected but non-filehandleref value found,\ncroaking" );
        die( "\nERROR EFH01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nfilehandleref value expected but non-filehandleref value found,\ndying\n" );
    }
    return;
}

sub filehandleref_CHECKTRACE {
    { my void $RETURN_TYPE };
    ( my $possible_filehandleref, my $variable_name, my $subroutine_name ) = @ARG;
    if ( not( defined $possible_filehandleref ) ) {
#        croak( "\nERROR EFH00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nfilehandleref value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
        die( "\nERROR EFH00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nfilehandleref value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ndying\n" );
    }
    if ( not( main::RPerl_SvIOKp($possible_filehandleref) ) ) {
#        croak( "\nERROR EFH01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nfilehandleref value expected but non-filehandleref value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
        die( "\nERROR EFH01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nfilehandleref value expected but non-filehandleref value found,\nin variable $variable_name from subroutine $subroutine_name,\ndying\n" );
    }
    return;
}

1;  # end of class
