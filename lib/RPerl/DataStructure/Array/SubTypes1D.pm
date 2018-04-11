## no critic qw(ProhibitUselessNoCritic PodSpelling ProhibitExcessMainComplexity)  # DEVELOPER DEFAULT 1a: allow unreachable & POD-commented code; SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1
package RPerl::DataStructure::Array::SubTypes1D;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.021_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitUnreachableCode RequirePodSections RequirePodAtEnd)  # DEVELOPER DEFAULT 1b: allow unreachable & POD-commented code, must be after line 1
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ EXPORTS ]]]
# DEV NOTE, CORRELATION #rp051: hard-coded list of RPerl data types and data structures
use RPerl::Exporter 'import';
our @EXPORT = qw(
    integer_arrayref_CHECK
    integer_arrayref_CHECKTRACE
    number_arrayref_CHECK
    number_arrayref_CHECKTRACE
    string_arrayref_CHECK
    string_arrayref_CHECKTRACE
    integer_arrayref_to_string_compact
    integer_arrayref_to_string
    integer_arrayref_to_string_pretty
    integer_arrayref_to_string_expand
    integer_arrayref_to_string_format
    number_arrayref_to_string_compact
    number_arrayref_to_string
    number_arrayref_to_string_pretty
    number_arrayref_to_string_expand
    number_arrayref_to_string_format
    string_arrayref_to_string_compact
    string_arrayref_to_string
    string_arrayref_to_string_pretty
    string_arrayref_to_string_expand
    string_arrayref_to_string_format
);
our @EXPORT_OK = qw(
    integer_arrayref_typetest0
    integer_arrayref_typetest1
    number_arrayref_typetest0
    number_arrayref_typetest1
    string_arrayref_typetest0
    string_arrayref_typetest1
);

# [[[ INCLUDES ]]]
use RPerl::DataType::Integer;  # for integer_CHECKTRACE(), used in *_arrayref_typetest1() 

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

# [[[ INTEGER ARRAY REF ]]]
# [[[ INTEGER ARRAY REF ]]]
# [[[ INTEGER ARRAY REF ]]]

# (ref to array) of integers
package  # hide from PAUSE indexing
    integer_arrayref;
use strict;
use warnings;
use parent -norequire, qw(arrayref);
use Carp;

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE FOR EXPORT TO WORK ]]]
package RPerl::DataStructure::Array::SubTypes1D;
use strict;
use warnings;

# [[[ TYPE-CHECKING ]]]

sub integer_arrayref_CHECK {
    { my void $RETURN_TYPE };
    ( my $possible_integer_arrayref ) = @ARG;

# DEV NOTE: the following two if() statements are functionally equivalent to the arrayref_CHECK() subroutine, but with integer-specific error codes
    if ( not( defined $possible_integer_arrayref ) ) {
        croak( "\nERROR EIVAVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger_arrayref value expected but undefined/null value found,\ncroaking" );
    }

    if ( not( main::RPerl_SvAROKp($possible_integer_arrayref) ) ) {
        croak( "\nERROR EIVAVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger_arrayref value expected but non-arrayref value found,\ncroaking" );
    }

    my integer $possible_integer;
    for my integer $i ( 0 .. ( ( scalar @{$possible_integer_arrayref} ) - 1 ) )
    {
        $possible_integer = $possible_integer_arrayref->[$i];

# DEV NOTE: the following two if() statements are functionally equivalent to the integer_CHECK() subroutine, but with array-specific error codes
        if ( not( defined $possible_integer ) ) {
            croak( "\nERROR EIVAVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger value expected but undefined/null value found at index $i,\ncroaking" );
        }
        if ( not( main::RPerl_SvIOKp($possible_integer) ) ) {
            croak( "\nERROR EIVAVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger value expected but non-integer value found at index $i,\ncroaking" );
        }
    }
    return;
};

sub integer_arrayref_CHECKTRACE {
    { my void $RETURN_TYPE };
    ( my $possible_integer_arrayref, my $variable_name, my $subroutine_name ) = @ARG;
    if ( not( defined $possible_integer_arrayref ) ) {
        croak( "\nERROR EIVAVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger_arrayref value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
    }
    if ( not( main::RPerl_SvAROKp($possible_integer_arrayref) ) ) {
        croak( "\nERROR EIVAVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger_arrayref value expected but non-arrayref value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
    }

    my integer $possible_integer;
    for my integer $i ( 0 .. ( ( scalar @{$possible_integer_arrayref} ) - 1 ) )
    {
        $possible_integer = $possible_integer_arrayref->[$i];
        if ( not( defined $possible_integer ) ) {
            croak( "\nERROR EIVAVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger value expected but undefined/null value found at index $i,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
        }
        if ( not( main::RPerl_SvIOKp($possible_integer) ) ) {
            croak( "\nERROR EIVAVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ninteger value expected but non-integer value found at index $i,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
        }
    }
    return;
}

# [[[ STRINGIFY ]]]

# DEV NOTE: 1-D format levels are 1 less than 2-D format levels

# call actual stringify routine, format level -2 (compact), indent level 0
sub integer_arrayref_to_string_compact {
    { my string $RETURN_TYPE };
    ( my $input_avref ) = @ARG;
    return integer_arrayref_to_string_format($input_avref, -2, 0);
}

# call actual stringify routine, format level -1 (normal), indent level 0, DEFAULT
sub integer_arrayref_to_string {
    { my string $RETURN_TYPE };
    ( my $input_avref ) = @ARG;
    return integer_arrayref_to_string_format($input_avref, -1, 0);
}

# call actual stringify routine, format level 0 (pretty), indent level 0
sub integer_arrayref_to_string_pretty {
    { my string $RETURN_TYPE };
    ( my $input_avref ) = @ARG;
    return integer_arrayref_to_string_format($input_avref, 0, 0);
}

# call actual stringify routine, format level 1 (expand), indent level 0
sub integer_arrayref_to_string_expand {
    { my string $RETURN_TYPE };
    ( my $input_avref ) = @ARG;
    return integer_arrayref_to_string_format($input_avref, 1, 0);
}

# convert from (Perl SV containing RV to (Perl AV of (Perl SVs containing IVs))) to Perl-parsable (Perl SV containing PV)
# stringify an integer_arrayref
sub integer_arrayref_to_string_format {
    { my string $RETURN_TYPE };
    ( my integer_arrayref $input_avref, my integer $format_level, my integer $indent_level ) = @ARG;

#    RPerl::diag("in PERLOPS_PERLTYPES integer_arrayref_to_string_format(), top of subroutine\n");
#    RPerl::diag('in PERLOPS_PERLTYPES integer_arrayref_to_string_format(), received $format_level = ', $format_level, "\n");
#    RPerl::diag('in PERLOPS_PERLTYPES integer_arrayref_to_string_format(), received $indent_level = ', $indent_level, "\n");

#    integer_arrayref_CHECK($input_avref);
    integer_arrayref_CHECKTRACE( $input_avref, '$input_avref', 'integer_arrayref_to_string_format()' );

    # declare local variables, av & sv mean "array value" & "scalar value" as used in Perl core
#    my @input_av;  # DEV NOTE: match CPPOPS_*TYPES code
    my integer $input_av_length;
    my integer $input_av_element;
    my string $output_sv = q{};
    my boolean $i_is_0 = 1;

    # generate indent
    my string $indent = q{    } x $indent_level;

    # compute length of (number of elements in) input array
#    @input_av        = @{$input_avref};  # DEV NOTE: match CPPOPS_*TYPES code
#    $input_av_length = scalar @input_av;  # DEV NOTE: match CPPOPS_*TYPES code
    $input_av_length = scalar @{$input_avref};

#	RPerl::diag("in PERLOPS_PERLTYPES integer_arrayref_to_string_format(), have \$input_av_length = $input_av_length\n");

    # pre-begin with optional indent, depending on format level
    if ($format_level >= 1) { $output_sv .= $indent; }

    # begin output string with left-square-bracket, as required for all RPerl arrays
    $output_sv .= '[';

    # loop through all valid values of $i for use as index to input array
    for my integer $i ( 0 .. ( $input_av_length - 1 ) ) {

        # retrieve input array's element at index $i
#        $input_av_element = $input_av[$i];  # DEV NOTE: match CPPOPS_*TYPES code
        $input_av_element = $input_avref->[$i];

# DEV NOTE: type-checking already done as part of integer_arrayref_CHECKTRACE()
#        integer_CHECK($input_av_element);
#integer_CHECKTRACE( $input_av_element, "\$input_av_element at index $i", 'integer_arrayref_to_string_format()' );

        # append comma to output string for all elements except index 0
        if ($i_is_0) { $i_is_0 = 0; }
        else         { $output_sv .= ','; }

        # append newline-indent-tab or space, depending on format level
        if    ($format_level >=  1) { $output_sv .= "\n" . $indent . q{    }; }
        elsif ($format_level >= -1) { $output_sv .= q{ }; }

        # stringify individual element, append to output string
#        $output_sv .= $input_av_element;  # NO UNDERSCORES
        $output_sv .= ::integer_to_string($input_av_element);  # YES UNDERSCORES
    }

    # append newline-indent or space, depending on format level
    if    ($format_level >=  1) { $output_sv .= "\n" . $indent; }
    elsif ($format_level >= -1) { $output_sv .= q{ }; }

    # end output string with right-square-bracket, as required for all RPerl arrays
    $output_sv .= ']';

#    RPerl::diag("in PERLOPS_PERLTYPES integer_arrayref_to_string_format(), after for() loop, have \$output_sv =\n$output_sv\n");
#    RPerl::diag("in PERLOPS_PERLTYPES integer_arrayref_to_string_format(), bottom of subroutine\n");

    # return output string, containing stringified input array
    return $output_sv;
}

# [[[ TYPE TESTING ]]]

sub integer_arrayref_typetest0 {
    { my string $RETURN_TYPE };
    ( my integer_arrayref $lucky_integers) = @ARG;

    #    integer_arrayref_CHECK($lucky_integers);
    integer_arrayref_CHECKTRACE( $lucky_integers, '$lucky_integers', 'integer_arrayref_typetest0()' );

#    my integer $how_lucky = scalar @{$lucky_integers};
#    for my integer $i ( 0 .. ( $how_lucky - 1 ) ) {
#        my $lucky_integer = $lucky_integers->[$i];
#        RPerl::diag("in PERLOPS_PERLTYPES integer_arrayref_typetest0(), have lucky integer $i/" . ( $how_lucky - 1 ) . ' = ' . $lucky_integers->[$i] . ", BARBAT\n");
#    }
#    RPerl::diag("in PERLOPS_PERLTYPES integer_arrayref_typetest0(), bottom of subroutine\n");
    return ( integer_arrayref_to_string($lucky_integers) . 'PERLOPS_PERLTYPES' );
}

sub integer_arrayref_typetest1 {
    { my integer_arrayref $RETURN_TYPE };
    ( my integer $my_size) = @ARG;

    #    integer_CHECK($my_size);
    integer_CHECKTRACE( $my_size, '$my_size', 'integer_arrayref_typetest1()' );
    my integer_arrayref $new_array = [];
    for my integer $i ( 0 .. ( $my_size - 1 ) ) {
        $new_array->[$i] = $i * 5;

#        RPerl::diag("in PERLOPS_PERLTYPES integer_arrayref_typetest1(), setting element $i/" . ( $my_size - 1 ) . ' = ' . $new_array->[$i] . ", BARBAT\n");
    }
    return ($new_array);
}

# [[[ NUMBER ARRAY REF ]]]
# [[[ NUMBER ARRAY REF ]]]
# [[[ NUMBER ARRAY REF ]]]

# (ref to array) of numbers
package  # hide from PAUSE indexing
    number_arrayref;
use strict;
use warnings;
use parent -norequire, qw(arrayref);
use Carp;

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE FOR EXPORT TO WORK ]]]
package RPerl::DataStructure::Array::SubTypes1D;
use strict;
use warnings;

# [[[ TYPE-CHECKING ]]]

sub number_arrayref_CHECK {
    { my void $RETURN_TYPE };
    ( my $possible_number_arrayref ) = @ARG;
    if ( not( defined $possible_number_arrayref ) ) {
        croak( "\nERROR ENVAVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber_arrayref value expected but undefined/null value found,\ncroaking" );
    }

    if ( not( main::RPerl_SvAROKp($possible_number_arrayref) ) ) {
        croak( "\nERROR ENVAVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber_arrayref value expected but non-arrayref value found,\ncroaking" );
    }

    my number $possible_number;
    for my integer $i ( 0 .. ( ( scalar @{$possible_number_arrayref} ) - 1 ) )
    {
        $possible_number = $possible_number_arrayref->[$i];
        if ( not( defined $possible_number ) ) {
            croak( "\nERROR ENVAVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber value expected but undefined/null value found at index $i,\ncroaking" );
        }
        if (not(   main::RPerl_SvNOKp($possible_number)
                || main::RPerl_SvIOKp($possible_number) )
            )
        {
            croak( "\nERROR ENVAVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber value expected but non-number value found at index $i,\ncroaking" );
        }
    }
    return;
}

sub number_arrayref_CHECKTRACE {
    { my void $RETURN_TYPE };
    ( my $possible_number_arrayref, my $variable_name, my $subroutine_name ) = @ARG;
    if ( not( defined $possible_number_arrayref ) ) {
        croak( "\nERROR ENVAVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber_arrayref value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
    }
    if ( not( main::RPerl_SvAROKp($possible_number_arrayref) ) ) {
        croak( "\nERROR ENVAVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber_arrayref value expected but non-arrayref value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
    }

    my number $possible_number;
    for my integer $i ( 0 .. ( ( scalar @{$possible_number_arrayref} ) - 1 ) )
    {
        $possible_number = $possible_number_arrayref->[$i];
        if ( not( defined $possible_number ) ) {
            croak( "\nERROR ENVAVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber value expected but undefined/null value found at index $i,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
        }
        if (not(   main::RPerl_SvNOKp($possible_number)
                || main::RPerl_SvIOKp($possible_number) ) ) {
            croak( "\nERROR ENVAVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nnumber value expected but non-number value found at index $i,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
        }
    }
    return;
}

# [[[ STRINGIFY ]]]

# DEV NOTE: 1-D format levels are 1 less than 2-D format levels

# call actual stringify routine, format level -2 (compact), indent level 0
sub number_arrayref_to_string_compact {
    { my string $RETURN_TYPE };
    ( my $input_avref ) = @ARG;
    return number_arrayref_to_string_format($input_avref, -2, 0);
}

# call actual stringify routine, format level -1 (normal), indent level 0, DEFAULT
sub number_arrayref_to_string {
    { my string $RETURN_TYPE };
    ( my $input_avref ) = @ARG;
    return number_arrayref_to_string_format($input_avref, -1, 0);
}

# call actual stringify routine, format level 0 (pretty), indent level 0
sub number_arrayref_to_string_pretty {
    { my string $RETURN_TYPE };
    ( my $input_avref ) = @ARG;
    return number_arrayref_to_string_format($input_avref, 0, 0);
}

# call actual stringify routine, format level 1 (expand), indent level 0
sub number_arrayref_to_string_expand {
    { my string $RETURN_TYPE };
    ( my $input_avref ) = @ARG;
    return number_arrayref_to_string_format($input_avref, 1, 0);
}

# convert from (Perl SV containing RV to (Perl AV of (Perl SVs containing NVs))) to Perl-parsable (Perl SV containing PV)
# stringify a number_arrayref
sub number_arrayref_to_string_format {
    { my string $RETURN_TYPE };
    ( my number_arrayref $input_avref, my integer $format_level, my integer $indent_level ) = @ARG;

#    RPerl::diag("in PERLOPS_PERLTYPES number_arrayref_to_string_format(), top of subroutine\n");
#    RPerl::diag('in PERLOPS_PERLTYPES number_arrayref_to_string_format(), received $format_level = ', $format_level, "\n");
#    RPerl::diag('in PERLOPS_PERLTYPES number_arrayref_to_string_format(), received $indent_level = ', $indent_level, "\n");

#    number_arrayref_CHECK($input_avref);
    number_arrayref_CHECKTRACE( $input_avref, '$input_avref', 'number_arrayref_to_string_format()' );

    # declare local variables, av & sv mean "array value" & "scalar value" as used in Perl core
#    my @input_av;  # DEV NOTE: match CPPOPS_*TYPES code
    my integer $input_av_length;
    my integer $input_av_element;
    my string $output_sv = q{};
    my boolean $i_is_0 = 1;

    # generate indent
    my string $indent = q{    } x $indent_level;

    # compute length of (number of elements in) input array
#    @input_av        = @{$input_avref};  # DEV NOTE: match CPPOPS_*TYPES code
#    $input_av_length = scalar @input_av;  # DEV NOTE: match CPPOPS_*TYPES code
    $input_av_length = scalar @{$input_avref};

#   RPerl::diag("in PERLOPS_PERLTYPES number_arrayref_to_string_format(), have \$input_av_length = $input_av_length\n");

    # pre-begin with optional indent, depending on format level
    if ($format_level >= 1) { $output_sv .= $indent; }

    # begin output string with left-square-bracket, as required for all RPerl arrays
    $output_sv .= '[';

    # loop through all valid values of $i for use as index to input array
    for my integer $i ( 0 .. ( $input_av_length - 1 ) ) {

        # retrieve input array's element at index $i
#        $input_av_element = $input_av[$i];  # DEV NOTE: match CPPOPS_*TYPES code
        $input_av_element = $input_avref->[$i];

# DEV NOTE: type-checking already done as part of number_arrayref_CHECKTRACE()
#        number_CHECK($input_av_element);
#number_CHECKTRACE( $input_av_element, "\$input_av_element at index $i", 'number_arrayref_to_string_format()' );

        # append comma to output string for all elements except index 0
        if ($i_is_0) { $i_is_0 = 0; }
        else         { $output_sv .= ','; }

        # append newline-indent-tab or space, depending on format level
        if    ($format_level >=  1) { $output_sv .= "\n" . $indent . q{    }; }
        elsif ($format_level >= -1) { $output_sv .= q{ }; }

        # stringify individual element, append to output string
#        $output_sv .= $input_av_element;  # NO UNDERSCORES
        $output_sv .= RPerl::DataType::Number::number_to_string($input_av_element);  # YES UNDERSCORES
    }

    # append newline-indent or space, depending on format level
    if    ($format_level >=  1) { $output_sv .= "\n" . $indent; }
    elsif ($format_level >= -1) { $output_sv .= q{ }; }

    # end output string with right-square-bracket, as required for all RPerl arrays
    $output_sv .= ']';

#    RPerl::diag("in PERLOPS_PERLTYPES number_arrayref_to_string_format(), after for() loop, have \$output_sv =\n$output_sv\n");
#    RPerl::diag("in PERLOPS_PERLTYPES number_arrayref_to_string_format(), bottom of subroutine\n");

    # return output string, containing stringified input array
    return $output_sv;
}

# [[[ TYPE TESTING ]]]

sub number_arrayref_typetest0 {
    { my string $RETURN_TYPE };
    ( my number_arrayref $lucky_numbers) = @ARG;

    #    number_arrayref_CHECK($lucky_numbers);
    number_arrayref_CHECKTRACE( $lucky_numbers, '$lucky_numbers', 'number_arrayref_typetest0()' );

#    my integer $how_lucky = scalar @{$lucky_numbers};
#    for my integer $i ( 0 .. ( $how_lucky - 1 ) ) {
#        my $lucky_number = $lucky_numbers->[$i];
#        RPerl::diag("in PERLOPS_PERLTYPES number_arrayref_typetest0(), have lucky number $i/" . ( $how_lucky - 1 ) . ' = ' . $lucky_numbers->[$i] . ", BARBAZ\n");
#    }
#    RPerl::diag("in PERLOPS_PERLTYPES number_arrayref_typetest0(), bottom of subroutine\n");
    return ( number_arrayref_to_string($lucky_numbers) . 'PERLOPS_PERLTYPES' );
}

sub number_arrayref_typetest1 {
    { my number_arrayref $RETURN_TYPE };
    ( my integer $my_size) = @ARG;

    #    integer_CHECK($my_size);
    integer_CHECKTRACE( $my_size, '$my_size', 'number_arrayref_typetest1()' );
    my number_arrayref $new_array = [];
    for my integer $i ( 0 .. ( $my_size - 1 ) ) {
        $new_array->[$i] = $i * 5.123456789;

#        RPerl::diag("in PERLOPS_PERLTYPES number_arrayref_typetest1(), setting element $i/" . ( $my_size - 1 ) . ' = ' . $new_array->[$i] . ", BARBAZ\n");
    }
    return ($new_array);
}

# [[[ CHARACTER ARRAY REF ]]]
# [[[ CHARACTER ARRAY REF ]]]
# [[[ CHARACTER ARRAY REF ]]]

# (ref to array) of chars
package  # hide from PAUSE indexing
    character_arrayref;
use strict;
use warnings;
use parent -norequire, qw(arrayref);

# [[[ STRING ARRAY REF ]]]
# [[[ STRING ARRAY REF ]]]
# [[[ STRING ARRAY REF ]]]

# (ref to array) of strings
package  # hide from PAUSE indexing
    string_arrayref;
use strict;
use warnings;
use parent -norequire, qw(arrayref);
use Carp;

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE FOR EXPORT TO WORK ]]]
package RPerl::DataStructure::Array::SubTypes1D;
use strict;
use warnings;

# [[[ TYPE-CHECKING ]]]

sub string_arrayref_CHECK {
    { my void $RETURN_TYPE };
    ( my $possible_string_arrayref ) = @ARG;
    if ( not( defined $possible_string_arrayref ) ) {
        croak( "\nERROR EPVAVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring_arrayref value expected but undefined/null value found,\ncroaking" );
    }

    if ( not( main::RPerl_SvAROKp($possible_string_arrayref) ) ) {
        croak( "\nERROR EPVAVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring_arrayref value expected but non-arrayref value found,\ncroaking" );
    }

    my string $possible_string;
    for my integer $i ( 0 .. ( ( scalar @{$possible_string_arrayref} ) - 1 ) )
    {
        $possible_string = $possible_string_arrayref->[$i];
        if ( not( defined $possible_string ) ) {
            croak( "\nERROR EPVAVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring value expected but undefined/null value found at index $i,\ncroaking" );
        }
        if ( not( main::RPerl_SvPOKp($possible_string) ) ) {
            croak( "\nERROR EPVAVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring value expected but non-string value found at index $i,\ncroaking" );
        }
    }
    return;
}

sub string_arrayref_CHECKTRACE {
    { my void $RETURN_TYPE };
    ( my $possible_string_arrayref, my $variable_name, my $subroutine_name ) = @ARG;
    if ( not( defined $possible_string_arrayref ) ) {
        croak( "\nERROR EPVAVRV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring_arrayref value expected but undefined/null value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
    }
    if ( not( main::RPerl_SvAROKp($possible_string_arrayref) ) ) {
        croak( "\nERROR EPVAVRV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring_arrayref value expected but non-arrayref value found,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
    }

    my string $possible_string;
    for my integer $i ( 0 .. ( ( scalar @{$possible_string_arrayref} ) - 1 ) )
    {
        $possible_string = $possible_string_arrayref->[$i];
        if ( not( defined $possible_string ) ) {
            croak( "\nERROR EPVAVRV02, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring value expected but undefined/null value found at index $i,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
        }
        if ( not( main::RPerl_SvPOKp($possible_string) ) ) {
            croak( "\nERROR EPVAVRV03, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\nstring value expected but non-string value found at index $i,\nin variable $variable_name from subroutine $subroutine_name,\ncroaking" );
        }
    }
    return;
}

# [[[ STRINGIFY ]]]

# DEV NOTE: 1-D format levels are 1 less than 2-D format levels

# call actual stringify routine, format level -2 (compact), indent level 0
sub string_arrayref_to_string_compact {
    { my string $RETURN_TYPE };
    ( my $input_avref ) = @ARG;
    return string_arrayref_to_string_format($input_avref, -2, 0);
}

# call actual stringify routine, format level -1 (normal), indent level 0, DEFAULT
sub string_arrayref_to_string {
    { my string $RETURN_TYPE };
    ( my $input_avref ) = @ARG;
    return string_arrayref_to_string_format($input_avref, -1, 0);
}

# call actual stringify routine, format level 0 (pretty), indent level 0
sub string_arrayref_to_string_pretty {
    { my string $RETURN_TYPE };
    ( my $input_avref ) = @ARG;
    return string_arrayref_to_string_format($input_avref, 0, 0);
}

# call actual stringify routine, format level 1 (expand), indent level 0
sub string_arrayref_to_string_expand {
    { my string $RETURN_TYPE };
    ( my $input_avref ) = @ARG;
    return string_arrayref_to_string_format($input_avref, 1, 0);
}

# convert from (Perl SV containing RV to (Perl AV of (Perl SVs containing PVs))) to Perl-parsable (Perl SV containing PV)
# stringify a string_arrayref
sub string_arrayref_to_string_format {
    { my string $RETURN_TYPE };
    ( my string_arrayref $input_avref, my integer $format_level, my integer $indent_level ) = @ARG;

#    RPerl::diag("in PERLOPS_PERLTYPES string_arrayref_to_string_format(), top of subroutine\n");
#    RPerl::diag('in PERLOPS_PERLTYPES string_arrayref_to_string_format(), received $format_level = ', $format_level, "\n");
#    RPerl::diag('in PERLOPS_PERLTYPES string_arrayref_to_string_format(), received $indent_level = ', $indent_level, "\n");

#    string_arrayref_CHECK($input_avref);
    string_arrayref_CHECKTRACE( $input_avref, '$input_avref', 'string_arrayref_to_string_format()' );

    # declare local variables, av & sv mean "array value" & "scalar value" as used in Perl core
#    my @input_av;  # DEV NOTE: match CPPOPS_*TYPES code
    my integer $input_av_length;
    my integer $input_av_element;
    my string $output_sv = q{};
    my boolean $i_is_0 = 1;

    # generate indent
    my string $indent = q{    } x $indent_level;

    # compute length of (number of elements in) input array
#    @input_av        = @{$input_avref};  # DEV NOTE: match CPPOPS_*TYPES code
#    $input_av_length = scalar @input_av;  # DEV NOTE: match CPPOPS_*TYPES code
    $input_av_length = scalar @{$input_avref};

#   RPerl::diag("in PERLOPS_PERLTYPES string_arrayref_to_string_format(), have \$input_av_length = $input_av_length\n");

    # pre-begin with optional indent, depending on format level
    if ($format_level >= 1) { $output_sv .= $indent; }

    # begin output string with left-square-bracket, as required for all RPerl arrays
    $output_sv .= '[';

    # loop through all valid values of $i for use as index to input array
    for my integer $i ( 0 .. ( $input_av_length - 1 ) ) {

        # retrieve input array's element at index $i
#        $input_av_element = $input_av[$i];  # DEV NOTE: match CPPOPS_*TYPES code
        $input_av_element = $input_avref->[$i];

# DEV NOTE: type-checking already done as part of string_arrayref_CHECKTRACE()
#        string_CHECK($input_av_element);
#string_CHECKTRACE( $input_av_element, "\$input_av_element at index $i", 'string_arrayref_to_string_format()' );

        # append comma to output string for all elements except index 0
        if ($i_is_0) { $i_is_0 = 0; }
        else         { $output_sv .= ','; }

        # append newline-indent-tab or space, depending on format level
        if    ($format_level >=  1) { $output_sv .= "\n" . $indent . q{    }; }
        elsif ($format_level >= -1) { $output_sv .= q{ }; }

        # stringify individual element, append to output string
        $input_av_element =~ s/\\/\\\\/gxms; # escape all back-slash \ characters with another back-slash \ character
        $input_av_element =~ s/\'/\\\'/gxms; # escape all single-quote ' characters with a back-slash \ character
        $output_sv .= "'$input_av_element'";
    }

    # append newline-indent or space, depending on format level
    if    ($format_level >=  1) { $output_sv .= "\n" . $indent; }
    elsif ($format_level >= -1) { $output_sv .= q{ }; }

    # end output string with right-square-bracket, as required for all RPerl arrays
    $output_sv .= ']';

#    RPerl::diag("in PERLOPS_PERLTYPES string_arrayref_to_string_format(), after for() loop, have \$output_sv =\n$output_sv\n");
#    RPerl::diag("in PERLOPS_PERLTYPES string_arrayref_to_string_format(), bottom of subroutine\n");

    # return output string, containing stringified input array
    return $output_sv;
}

# [[[ TYPE TESTING ]]]

sub string_arrayref_typetest0 {
    { my string $RETURN_TYPE };
    ( my string_arrayref $people) = @ARG;

    #    string_arrayref_CHECK($people);
    string_arrayref_CHECKTRACE( $people, '$people', 'string_arrayref_typetest0()' );

#    my integer $how_crowded = scalar @{$people};
#    for my integer $i ( 0 .. ( $how_crowded - 1 ) ) {
#        my $person = $people->[$i];
#        RPerl::diag("in PERLOPS_PERLTYPES string_arrayref_typetest0(), have person $i/" . ( $how_crowded - 1 ) . ' = ' . $people->[$i] . ", BARBAR\n");
#    }
#    RPerl::diag("in PERLOPS_PERLTYPES string_arrayref_typetest0(), bottom of subroutine\n");
    return ( string_arrayref_to_string($people) . 'PERLOPS_PERLTYPES' );
}

sub string_arrayref_typetest1 {
    { my string_arrayref $RETURN_TYPE };
    ( my integer $my_size) = @ARG;

    #    integer_CHECK($my_size);
    integer_CHECKTRACE( $my_size, '$my_size', 'string_arrayref_typetest1()' );
    my string_arrayref $new_array = [];
    for my integer $i ( 0 .. ( $my_size - 1 ) ) {
        $new_array->[$i] = "Jeffy Ten! $i/" . ( $my_size - 1 ) . ' PERLOPS_PERLTYPES';

#        RPerl::diag("in PERLOPS_PERLTYPES string_arrayref_typetest1(), bottom of for() loop, have i = $i, just set another Jeffy, BARBAR\n");
    }
    return ($new_array);
}

=block_comment
THIS IS AN EXAMPLE BLOCK COMMENT
it's purpose is to keep from triggering the UselessNoCritic rule,
so we can keep the no critic sections at the top of the file for reference
=cut

# [[[ SCALAR ARRAY REF ]]]
# [[[ SCALAR ARRAY REF ]]]
# [[[ SCALAR ARRAY REF ]]]

# (ref to array) of scalartypes
package  # hide from PAUSE indexing
    scalartype_arrayref;
use strict;
use warnings;
use parent -norequire, qw(arrayref);

1;  # end of package
