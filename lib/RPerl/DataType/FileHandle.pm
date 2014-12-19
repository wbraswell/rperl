# [[[ HEADER ]]]
package RPerl::DataType::FileHandle;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values and print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages)  # SYSTEM DEFAULT 3: allow multiple lower case package names

# [[[ OO INHERITANCE ]]]
use parent ('RPerl::DataType');
use RPerl::DataType;

# [[[ SUB-TYPES BEFORE SETUP ]]]
# a filehandle_ref is "a reference to a newly allocated anonymous filehandle";  http://perldoc.perl.org/functions/open.html
# we do not ever directly use filehandle type, only filehandle_ref
package filehandle_ref;
use parent -norequire, ('ref');

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE ]]]
package RPerl::DataType::FileHandle;

# [[[ OO INHERITANCE ]]]
use parent ('RPerl::DataType');
use RPerl::DataType;

# NEED FIX: is a filehandle_ref really an integer?!?

# [[[ TYPE-CHECKING ]]]
our void $filehandle_ref__CHECK = sub {
    ( my $possible_filehandle_ref ) = @_;
    if ( not( defined $possible_filehandle_ref ) ) {
        croak(
            "\nERROR EFH00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nfilehandle_ref value expected but undefined/null value found,\ncroaking"
        );
    }
    if ( not( main::RPerl_SvIOKp($possible_filehandle_ref) ) ) {
        croak(
            "\nERROR EFH01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nfilehandle_ref value expected but non-filehandle_ref value found,\ncroaking"
        );
    }
};
our void $filehandle_ref__CHECKTRACE = sub {
    ( my $possible_filehandle_ref, my $variable_name, my $subroutine_name )
        = @_;
    if ( not( defined $possible_filehandle_ref ) ) {
        croak(
            "\nERROR EFH00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nfilehandle_ref value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }
    if ( not( main::RPerl_SvIOKp($possible_filehandle_ref) ) ) {
        croak(
            "\nERROR EFH01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nfilehandle_ref value expected but non-filehandle_ref value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }
};

# [[[ OPERATIONS & DATA TYPES REPORTING ]]]
our integer $filehandle__OPS_TYPES_ID = 0;    # PERLOPS_PERLTYPES is 0
our string $filehandle__ops = sub { return ('PERL'); };
our string $filehandle__types = sub { return ('PERL'); };

1;                                            # end of class
