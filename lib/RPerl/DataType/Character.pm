# [[[ HEADER ]]]
package RPerl::DataType::Character;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.010_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::DataType::String);
use RPerl::DataType::String;

# [[[ SUB-TYPES ]]]

# a character is a string of length 0 or 1, meaning a single letter, digit, or other ASCII (Unicode???) symbol
package  # hide from PAUSE indexing
    character;
use strict;
use warnings;
use parent qw(RPerl::DataType::Character);

# method with character return type
package  # hide from PAUSE indexing
    character::method;
use strict;
use warnings;
use parent -norequire, qw(method);

# [[[ PRE-DECLARED TYPES ]]]
package    # hide from PAUSE indexing
    boolean;
package    # hide from PAUSE indexing
    unsigned_integer;
package     # hide from PAUSE indexing
    integer;
package    # hide from PAUSE indexing
    number;
package    # hide from PAUSE indexing
    string;

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE ]]]
package RPerl::DataType::Character;
use strict;
use warnings;

# [[[ EXPORTS ]]]
use RPerl::Exporter 'import';
our @EXPORT = qw(character_CHECK character_CHECKTRACE character_to_boolean character_to_unsigned_integer character_to_integer character_to_number character_to_string);
our @EXPORT_OK = qw(character_typetest0 character_typetest1);

# [[[ TYPE-CHECKING ]]]
sub character_CHECK {
    { my void $RETURN_TYPE };
    ( my $possible_character ) = @ARG;
    if ( not( defined $possible_character ) ) {
#        croak( "\nERROR ETV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ncharacter value expected but undefined/null value found,\ncroaking" );
        die( "\nERROR ETV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ncharacter value expected but undefined/null value found,\ndying\n" );
    }
    if ( not( main::RPerl_SvCOKp($possible_character) ) ) {
#        croak( "\nERROR ETV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ncharacter value expected but non-character value found,\ncroaking" );
        die( "\nERROR ETV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ncharacter value expected but non-character value found,\ndying\n" );
    }
    return;
}
sub character_CHECKTRACE {
    { my void $RETURN_TYPE };
    ( my $possible_character, my $variable_name, my $subroutine_name ) = @ARG;
    if ( not( defined $possible_character ) ) {
#        croak( "\nERROR ETV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ncharacter value expected but undefined/null value found,\nin variable " . $variable_name . " from subroutine " . $subroutine_name . ",\ncroaking" );
        die( "\nERROR ETV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ncharacter value expected but undefined/null value found,\nin variable " . $variable_name . " from subroutine " . $subroutine_name . ",\ndying\n" );
    }
    if ( not( main::RPerl_SvCOKp($possible_character) ) ) {
#        croak( "\nERROR ETV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ncharacter value expected but non-character value found,\nin variable " . $variable_name . " from subroutine " . $subroutine_name . ",\ncroaking" );
        die( "\nERROR ETV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ncharacter value expected but non-character value found,\nin variable " . $variable_name . " from subroutine " . $subroutine_name . ",\ndying\n" );
    }
    return;
}

# [[[ BOOLEANIFY ]]]
sub character_to_boolean {
    { my boolean $RETURN_TYPE };
    (my character $input_character) = @ARG;
#    character_CHECK($lucky_character);
    character_CHECKTRACE( $input_character, '$input_character', 'character_to_boolean()' );
    if (($input_character * 1) == 0) { return 0; }
    else { return 1; }
    return;
}

# [[[ UNSIGNED INTEGERIFY ]]]
sub character_to_unsigned_integer {
    { my unsigned_integer $RETURN_TYPE };
    (my character $input_character) = @ARG;
#    character_CHECK($lucky_character);
    character_CHECKTRACE( $input_character, '$input_character', 'character_to_unsigned_integer()' );
    return floor abs ($input_character * 1);
}

# [[[ INTEGERIFY ]]]
sub character_to_integer {
    { my integer $RETURN_TYPE };
    (my character $input_character) = @ARG;
#    character_CHECK($lucky_character);
    character_CHECKTRACE( $input_character, '$input_character', 'character_to_integer()' );
    return floor ($input_character * 1);
}

# [[[ NUMBERIFY ]]]
sub character_to_number {
    { my number $RETURN_TYPE };
    (my character $input_character) = @ARG;
#    character_CHECK($lucky_character);
    character_CHECKTRACE( $input_character, '$input_character', 'character_to_number()' );
    return $input_character * 1.0;
}

# [[[ STRINGIFY ]]]
sub character_to_string {
    { my string $RETURN_TYPE };
    (my character $input_character) = @ARG;
#    character_CHECK($lucky_character);
    character_CHECKTRACE( $input_character, '$input_character', 'character_to_string()' );
    return $input_character;
}

# [[[ TYPE TESTING ]]]
sub character_typetest0 { { my character $RETURN_TYPE }; return chr(main::RPerl__DataType__Character__MODE_ID() + (ord '0')); }
sub character_typetest1 {
    { my character $RETURN_TYPE };
    (my character $lucky_character) = @ARG;
#    character_CHECK($lucky_character);
    character_CHECKTRACE( $lucky_character, '$lucky_character', 'character_typetest1()' );
    return chr((ord $lucky_character) + main::RPerl__DataType__Character__MODE_ID());
}

1;  # end of class
