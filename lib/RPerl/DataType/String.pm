# [[[ HEADER ]]]
package RPerl::DataType::String;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.010_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::DataType::Scalar);
use RPerl::DataType::Scalar;

# [[[ CRITICS ]]]
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ SUB-TYPES ]]]
# a string is 0 or more letters, digits, or other ASCII (Unicode???) symbols
package  # hide from PAUSE indexing
    string;
use strict;
use warnings;
use parent qw(RPerl::DataType::String);

# [[[ PRE-DECLARED TYPES ]]]
package    # hide from PAUSE indexing
    boolean;
package     # hide from PAUSE indexing
    unsigned_integer;
package     # hide from PAUSE indexing
    integer;
package    # hide from PAUSE indexing
    number;
package    # hide from PAUSE indexing
    character;

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE ]]]
package RPerl::DataType::String;
use strict;
use warnings;

# [[[ INCLUDES ]]]
use POSIX qw(floor);

# DEV NOTE: do not put inside INIT{} block, because it will be "too late to run INIT block" in some cases, such as inside Catalyst
# DEV NOTE, CORRELATION #rp040: fix recursive dependencies of String.pm & HelperFunctions_cpp.pm, as triggered by ingy's Inline::create_config_file() `system` call
# NEED REMOVE: this code no longer appears to be necessary?
#if (not ((exists $ARGV[0]) and (defined $ARGV[0]) and ((substr $ARGV[0], -7, 7) eq '_Inline'))) {
#if (0) {
#    use RPerl::HelperFunctions_cpp;  # main::RPerl_SvPOKp
#    RPerl::HelperFunctions_cpp::cpp_load();
#}

# [[[ EXPORTS ]]]
use Exporter 'import';
our @EXPORT = qw(string_CHECK string_CHECKTRACE string_to_boolean string_to_unsigned_integer string_to_integer string_to_number string_to_character string_to_string);

# [[[ TYPE CHECKING ]]]
#our void $string_CHECK = sub {
sub string_CHECK {
    ( my $possible_string ) = @_;
    if ( not( defined $possible_string ) ) {
        croak(
            "\nERROR EPV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring value expected but undefined/null value found,\ncroaking"
        );
    }
    if ( not( main::RPerl_SvPOKp($possible_string) ) ) {
        croak(
            "\nERROR EPV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring value expected but non-string value found,\ncroaking"
        );
    }
}

# DEV NOTE: avoid error for those packages which do NOT 'use RPerl', but instead do 'use RPerl::AfterSubclass' and 'use RPerl::Config' and 'use rperltypesconv' etc.
# "Undefined subroutine &RPerl::DataType::String::string_CHECKTRACE called at lib/RPerl/DataType/String.pm line XYZ   [ in string_to_integer() below ]
#our void $string_CHECKTRACE = sub {
sub string_CHECKTRACE {
    ( my $possible_string, my $variable_name, my $subroutine_name ) = @_;
    if ( not( defined $possible_string ) ) {
        croak(
            "\nERROR EPV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }
    if ( not( main::RPerl_SvPOKp($possible_string) ) ) {
        croak(
            "\nERROR EPV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring value expected but non-string value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking"
        );
    }
}

# [[[ BOOLEANIFY ]]]
#our boolean $string_to_boolean = sub {
sub string_to_boolean {
    (my string $input_string) = @_;
#    string_CHECK($input_string);
    string_CHECKTRACE( $input_string, '$input_string', 'string_to_boolean()' );
    $input_string =~ s/_//gxms;  # remove underscores to allow them in $input_string, fixes "Argument isn't numeric in multiplication (*)"
    if (($input_string * 1) == 0) { return 0; }
    else { return 1; }
}

# [[[ UNSIGNED INTEGERIFY ]]]
#our integer $string_to_unsigned_integer = sub {
sub string_to_unsigned_integer {
    (my string $input_string) = @_;
#    string_CHECK($input_string);
    string_CHECKTRACE( $input_string, '$input_string', 'string_to_unsigned_integer()' );
    $input_string =~ s/_//gxms;  # remove underscores to allow them in $input_string, fixes "Argument isn't numeric in multiplication (*)"
    return (floor abs ($input_string * 1)) * 1;
}

# [[[ INTEGERIFY ]]]
#our integer $string_to_integer = sub {
sub string_to_integer {
    (my string $input_string) = @_;
#    string_CHECK($input_string);
    string_CHECKTRACE( $input_string, '$input_string', 'string_to_integer()' );
    # DEV NOTE: must use double-casting via '* 1' below to avoid following errors
    # ERROR EIV01, TYPE-CHECKING MISMATCH, CPPOPS_PERLTYPES & CPPOPS_CPPTYPES:
    # integer value expected but non-integer value found,
    # in variable input_sv from subroutine XS_unpack_integer(),
    $input_string =~ s/_//gxms;  # remove underscores to allow them in $input_string, fixes "Argument isn't numeric in multiplication (*)"
#    return floor ($input_string * 1);
    return (floor ($input_string * 1)) * 1;
}

# [[[ NUMBERIFY ]]]
#our number $string_to_number = sub {
sub string_to_number {
    (my string $input_string) = @_;
#    string_CHECK($input_string);
    string_CHECKTRACE( $input_string, '$input_string', 'string_to_number()' );
    $input_string =~ s/_//gxms;  # remove underscores to allow them in $input_string, fixes "Argument isn't numeric in multiplication (*)"
    return $input_string * 1.0;
}

# [[[ CHARACTERIFY ]]]
#our character $string_to_character = sub {
sub string_to_character {
    (my string $input_string) = @_;
#    string_CHECK($input_string);
    string_CHECKTRACE( $input_string, '$input_string', 'string_to_character()' );
    if ($input_string eq q{}) { return q{}; }
    else { return substr $input_string, 0, 1; }
}

# [[[ STRINGIFY ]]]
#our string $string_to_string = sub {
sub string_to_string {
    ( my string $input_string ) = @_;
#    string_CHECK($input_string);
    string_CHECKTRACE( $input_string, '$input_string', 'string_to_string()' );

#    RPerl::diag("in PERLOPS_PERLTYPES string_to_string(), received \$input_string =\n$input_string\n\n");
    $input_string =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
    $input_string =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
    $input_string = "'$input_string'";

#    RPerl::diag("in PERLOPS_PERLTYPES string_to_string(), bottom of subroutine, returning possibly-modified \$input_string =\n$input_string\n\n");

    return ($input_string);
}

# [[[ TYPE TESTING ]]]
our string $string__typetest0 = sub {
    my string $retval = 'Spice PERLOPS_PERLTYPES';

#    RPerl::diag("in PERLOPS_PERLTYPES string__typetest0(), have \$retval = '$retval'\n");
    return ($retval);
};
our string $string__typetest1 = sub {
    ( my string $lucky_string ) = @_;
#    string_CHECK($lucky_string);
    string_CHECKTRACE( $lucky_string, '$lucky_string',
        'string__typetest1()' );

#    RPerl::diag("in PERLOPS_PERLTYPES string__typetest1(), received \$lucky_string = '$lucky_string'\n");
    return ( string_to_string($lucky_string) . ' PERLOPS_PERLTYPES' );
};

1;  # end of class
