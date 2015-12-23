# [[[ HEADER ]]]
package RPerl::DataType::Character;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.005_100;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::DataType::String);
use RPerl::DataType::String;

# [[[ SUB-TYPES ]]]
# a character is a string of length 0 or 1, meaning a single letter, digit, or other ASCII (Unicode???) symbol
package  # hide from PAUSE indexing
    character;
use strict;
use warnings;
use parent qw(RPerl::DataType::Integer);

# [[[ PRE-DECLARED TYPES ]]]
package    # hide from PAUSE indexing
    boolean;
package    # hide from PAUSE indexing
    unsigned_integer;
package     # hide from PAUSE indexing
    integer;
package    # hide from PAUSE indexing
    gmp_integer;
package    # hide from PAUSE indexing
    number;
package    # hide from PAUSE indexing
    string;

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE ]]]
package RPerl::DataType::Character;
use strict;
use warnings;

# [[[ EXPORTS ]]]
use Exporter 'import';
our @EXPORT = qw(character_to_boolean character_to_unsigned_integer character_to_integer character_to_number character_to_string);

# [[[ TYPE-CHECKING ]]]
our void $character_CHECK = sub {
    ( my $possible_character ) = @_;
    if ( not( defined $possible_character ) ) { croak( "\nERROR ECV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ncharacter value expected but undefined/null value found,\ncroaking" ); }
    if ( not( main::RPerl_SvCOKp($possible_character) ) ) { croak( "\nERROR ECV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ncharacter value expected but non-character value found,\ncroaking" ); }
};
our void $character_CHECKTRACE = sub {
    ( my $possible_character, my $variable_name, my $subroutine_name ) = @_;
    if ( not( defined $possible_character ) ) { croak( "\nERROR ECV00, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ncharacter value expected but undefined/null value found,\nin variable " . $variable_name . " from subroutine " . $subroutine_name . ",\ncroaking" ); }
    if ( not( main::RPerl_SvCOKp($possible_character) ) ) { croak( "\nERROR ECV01, TYPE-CHECKING MISMATCH, PERLOPS_PERLTYPES:\ncharacter value expected but non-character value found,\nin variable " . $variable_name . " from subroutine " . $subroutine_name . ",\ncroaking" ); }
};

# [[[ BOOLEANIFY ]]]
#our boolean $character_to_boolean = sub {
sub character_to_boolean {
    (my character $input_character) = @_;
    if (($input_character * 1) == 0) { return 0; }
    else { return 1; }
}

# [[[ UNSIGNED INTEGERIFY ]]]
#our unsigned_integer $character_to_unsigned_integer = sub {
sub character_to_unsigned_integer {
    (my character $input_character) = @_;
    return floor abs ($input_character * 1);
}

# [[[ INTEGERIFY ]]]
#our integer $character_to_integer = sub {
sub character_to_integer {
    (my character $input_character) = @_;
    return floor ($input_character * 1);
}

# [[[ NUMBERIFY ]]]
#our number $character_to_number = sub {
sub character_to_number {
    (my character $input_character) = @_;
    return $input_character * 1.0;
}

# [[[ STRINGIFY ]]]
#our string $character_to_string = sub {
sub character_to_string {
    (my character $input_character) = @_;
    return $input_character;
}

# [[[ TYPE TESTING ]]]
our character $character__typetest0 = sub {
	return chr(main::RPerl__DataType__Character__MODE_ID() + (ord '0'));
};
our character $character__typetest1 = sub {
    (my character $lucky_character) = @_;
    return chr((ord $lucky_character) + main::RPerl__DataType__Character__MODE_ID());
};

1;  # end of class
