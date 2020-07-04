# [[[ HEADER ]]]
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names
package  # hide from PAUSE indexing
    rperltypes;
use strict;
use warnings;
use RPerl::Config;
our $VERSION = 0.018_000;

# NEED UPGRADE: create GrammarComponents
#use parent qw(RPerl::GrammarComponent)

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitExcessComplexity)  # SYSTEM SPECIAL 5: allow complex code inside subroutines, must be after line 1
## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
## no critic qw(ProhibitDeepNests)  # SYSTEM SPECIAL 7: allow deeply-nested code
## no critic qw(RequireBriefOpen)  # SYSTEM SPECIAL 10: allow complex processing with open filehandle
## no critic qw(ProhibitCascadingIfElse)  # SYSTEM SPECIAL 12: allow complex conditional logic

# [[[ NON-RPERL MODULES ]]]
use File::Copy qw(copy);
use Scalar::Util qw(blessed);
use Config;

# all following type lists lowest-to-highest level

use rperltypessizes;

# DEV NOTE, CORRELATION #rp012: type system includes, hard-copies in rperltypes.pm & rperltypesconv.pm & Class.pm

# [[[ DATA TYPES ]]]
use RPerl::DataType::Void;
use RPerl::DataType::Boolean;
use RPerl::DataType::UnsignedInteger;
use RPerl::DataType::Integer;
use RPerl::DataType::Number;
use RPerl::DataType::Character;
use RPerl::DataType::String;
use RPerl::DataType::Scalar;
use RPerl::DataType::Unknown;
use RPerl::DataType::FileHandle;

# [[[ DATA STRUCTURES ]]]
use RPerl::DataStructure::Array;
use RPerl::DataStructure::Array::SubTypes;
use RPerl::DataStructure::Array::SubTypes1D;
use RPerl::DataStructure::Array::SubTypes2D;
use RPerl::DataStructure::Array::SubTypes3D;
use RPerl::DataStructure::Array::Reference;
use RPerl::DataStructure::Hash;
use RPerl::DataStructure::Hash::SubTypes;
use RPerl::DataStructure::Hash::SubTypes1D;
use RPerl::DataStructure::Hash::SubTypes2D;
use RPerl::DataStructure::Hash::SubTypes3D;
use RPerl::DataStructure::Hash::Reference;

#use RPerl::DataStructure::LinkedList;
#use RPerl::DataStructure::LinkedList::Node;
#use RPerl::DataStructure::Graph;
#use RPerl::DataStructure::Graph::Tree;
#use RPerl::DataStructure::Graph::Tree::Binary;
#use RPerl::DataStructure::Graph::Tree::Binary::Node;

# DEV NOTE, CORRELATION #rp008: use RPerl::Exporter here instead of rperltypesconv.pm

# [[[ EXPORTS ]]]
use RPerl::Exporter 'import';
our @EXPORT = (
    @RPerl::DataType::Void::EXPORT,
    @RPerl::DataType::Boolean::EXPORT,
    @RPerl::DataType::UnsignedInteger::EXPORT,
    @RPerl::DataType::Integer::EXPORT,
    @RPerl::DataType::Number::EXPORT,
    @RPerl::DataType::Character::EXPORT,
    @RPerl::DataType::String::EXPORT,
    @RPerl::DataType::Scalar::EXPORT,
    @RPerl::DataType::Unknown::EXPORT,
    @RPerl::DataStructure::Array::SubTypes::EXPORT,
    @RPerl::DataStructure::Array::SubTypes1D::EXPORT,
    @RPerl::DataStructure::Array::SubTypes2D::EXPORT,
    @RPerl::DataStructure::Array::SubTypes3D::EXPORT,
    @RPerl::DataStructure::Hash::SubTypes::EXPORT,
    @RPerl::DataStructure::Hash::SubTypes1D::EXPORT,
    @RPerl::DataStructure::Hash::SubTypes2D::EXPORT,
    @RPerl::DataStructure::Hash::SubTypes3D::EXPORT
);
our @EXPORT_OK = (
    @RPerl::DataType::Void::EXPORT_OK,
    @RPerl::DataType::Boolean::EXPORT_OK,
    @RPerl::DataType::UnsignedInteger::EXPORT_OK,
    @RPerl::DataType::Integer::EXPORT_OK,
    @RPerl::DataType::Number::EXPORT_OK,
    @RPerl::DataType::Character::EXPORT_OK,
    @RPerl::DataType::String::EXPORT_OK,
    @RPerl::DataType::Scalar::EXPORT_OK,
    @RPerl::DataType::Unknown::EXPORT_OK,
    @RPerl::DataStructure::Array::SubTypes::EXPORT_OK,
    @RPerl::DataStructure::Array::SubTypes1D::EXPORT_OK,
    @RPerl::DataStructure::Array::SubTypes2D::EXPORT_OK,
    @RPerl::DataStructure::Array::SubTypes3D::EXPORT_OK,
    @RPerl::DataStructure::Hash::SubTypes::EXPORT_OK,
    @RPerl::DataStructure::Hash::SubTypes1D::EXPORT_OK,
    @RPerl::DataStructure::Hash::SubTypes2D::EXPORT_OK,
    @RPerl::DataStructure::Hash::SubTypes3D::EXPORT_OK
);

# [[[ OBJECT-ORIENTED ]]]
use RPerl::Object;
use RPerl::CodeBlock::Subroutine::Method;    # Method is the only item that is both a Data Type & a Grammar Rule???

# DEV NOTE, CORRELATION #rp051: hard-coded list of RPerl data types and data structures
# these types are currently implemented for the 2 primary RPerl modes: PERLOPS_PERLTYPES, CPPOPS_CPPTYPES
# MISSING: boolean, unsigned_integer, character, *_arrayref, *_hashref
our string_arrayref $SUPPORTED = [
    qw(
        void
        integer
        number
        string
        arrayref
        integer_arrayref
        number_arrayref
        string_arrayref
        hashref
        integer_hashref
        number_hashref
        string_hashref
        integer_arrayref_hashref
        number_arrayref_hashref
        string_arrayref_hashref
        integer_arrayref_hashref_hashref
        number_arrayref_hashref_hashref
        string_arrayref_hashref_hashref
    )
];
our string_arrayref $SUPPORTED_SPECIAL = [
    qw(
        sse_number_pair
        gmp_integer
        gsl_matrix
    )
];

# DEV NOTE, CORRELATION #rp008: export to_number() and to_string() to main:: namespace;
# can't achieve via Exporter due to circular dependency issue caused by Exporter in Config.pm and solved by 'require rperltypes;' in RPerl.pm
package main;
use RPerl::Config;
use Scalar::Util qw(blessed);

# for type-checking via SvIOKp(), SvNOKp(), and SvPOKp(); inside INIT to delay until after 'use MyConfig'
#INIT { RPerl::diag("in rperltypes.pm, loading C++ helper functions for type-checking...\n"); }
INIT {
    use RPerl::HelperFunctions_cpp;
    RPerl::HelperFunctions_cpp::cpp_load();
}

# [[[ GENERIC OVERLOADED TYPE CONVERSION ]]]
# [[[ GENERIC OVERLOADED TYPE CONVERSION ]]]
# [[[ GENERIC OVERLOADED TYPE CONVERSION ]]]

sub to_number {
    { my number $RETURN_TYPE };
    ( my unknown $variable) = @ARG;
    if ( not defined $variable ) { return 0; }
    my string $type = type($variable);
    if    ( $type eq 'unknown' ) { return ($variable + 0); }
    elsif ( $type eq 'boolean' )    { return boolean_to_number($variable); }
#    elsif ( $type eq 'unsigned_integer' ) { return unsigned_integer_to_number($variable); }  # DEV NOTE: causes auto-vivification of empty unsigned_integer_to_number() if not already properly bound
#    elsif ( $type eq 'gmp_integer' ) { return gmp_integer_to_number($variable); }  # NEED IMPLEMENT 
    elsif ( $type eq 'integer' ) { return integer_to_number($variable); }
#    elsif ( $type eq 'number' )  { return number_to_number($variable); }  # NEED ANSWER: is this totally unneeded, and should it be deleted?
    elsif ( $type eq 'character' )    { return character_to_number($variable); }
    elsif ( $type eq 'string' )  { return string_to_number($variable); }
    else {
        croak q{ERROR ERPTY01: Invalid data type '} . $type . q{' specified, croaking};
    }
    return;
}

# NEED UPGRADE: don't fall back to Perl qq{} string interpolation or Dumper() for stringification;
# Dumper will fail to call *_to_string() until stringification overloading is implemented
sub to_string {
    { my string $RETURN_TYPE };
    ( my unknown $variable) = @ARG;
#    RPerl::diag('in rperltypes::to_string(), received $variable = ' . $variable . "\n");
    if ( not defined $variable ) { return 'undef'; }
    my string $type = type($variable);
#    RPerl::diag('in rperltypes::to_string(), have $type = ' . $type . "\n");

    if    ( $type eq 'unknown' ) { return qq{$variable}; }
    elsif ( $type eq 'boolean' )    { return boolean_to_string($variable); }
#    elsif ( $type eq 'unsigned_integer' ) { return unsigned_integer_to_string($variable); }  # DEV NOTE: causes auto-vivification of empty unsigned_integer_to_string() if not already properly bound
#    elsif ( $type eq 'gmp_integer' ) { return gmp_integer_to_string($variable); }  # NEED IMPLEMENT 
    elsif ( $type eq 'integer' ) { return integer_to_string($variable); }
    elsif ( $type eq 'number' )  { return number_to_string($variable); }
    elsif ( $type eq 'character' )    { return character_to_string($variable); }
    elsif ( $type eq 'string' )  { return string_to_string($variable); }
    else {
        my $retval = Dumper($variable);
        $retval =~ s/\$VAR1\ =\ //gxms;
        chomp $retval;
        chop $retval;
        return $retval;
    }
    return;
}

# [[[ TYPE DETERMINATION ]]]
# [[[ TYPE DETERMINATION ]]]
# [[[ TYPE DETERMINATION ]]]

# enumeration of RPerl types
package  # hide from PAUSE indexing
    type_enum;
use strict;
use warnings;
use parent -norequire, qw(integer);

# [[[ SWITCH CONTEXT BACK TO PRIMARY PACKAGE FOR EXPORT TO WORK ]]]
# DEV NOTE, CORRELATION #rp008: export class() and type*() and types() to main:: namespace;
# can't achieve via Exporter due to circular dependency issue caused by Exporter in Config.pm and solved by 'require rperltypes;' in RPerl.pm
package main;

# DEV NOTE: class() is a wrapper around blessed() from Scalar::Util, class() is preferred for readability, 
# blessed() and class() both generate as classname() in C++ to avoid conflict with 'class' C++ reserved word
sub class {
    { my string $RETURN_TYPE };
    ( my unknown $object ) = @ARG;
    return blessed($object);
}

# DEV NOTE, CORRELATION #rp321, DYNAMIC DISPATCH: list order must match exactly between LIST_OF_TYPES_SCALAR & LIST_OF_TYPES_ARRAYREF & LIST_OF_TYPES_HASHREF
use constant {
    TYPE_void             => 0,
#   TYPE_boolean          => x,
#   TYPE_unsigned_integer => x,
    TYPE_integer          => 1,
    TYPE_number           => 2,
#   TYPE_character        => x,
    TYPE_string           => 3,
#   TYPE_scalar           => x,
    TYPE_unknown          => 4
};

# DEV NOTE, CORRELATION #rp321, DYNAMIC DISPATCH: list order must match exactly between LIST_OF_TYPES_SCALAR & LIST_OF_TYPES_ARRAYREF & LIST_OF_TYPES_HASHREF
my string_hashref $string_to_type_enum = {
    TYPE_void             => 0,
#   TYPE_boolean          => x,
#   TYPE_unsigned_integer => x,
    TYPE_integer          => 1,
    TYPE_number           => 2,
#   TYPE_character        => x,
    TYPE_string           => 3,
#   TYPE_scalar           => x,
    TYPE_unknown          => 4
};

# DEV NOTE, CORRELATION #rp321, DYNAMIC DISPATCH: list order must match exactly between LIST_OF_TYPES_SCALAR & LIST_OF_TYPES_ARRAYREF & LIST_OF_TYPES_HASHREF
my string_arrayref $type_enum_to_string = [ qw(
    TYPE_void


    TYPE_integer
    TYPE_number

    TYPE_string

    TYPE_unknown
)];

=NEED DELETE, UNUSED???
# DEV NOTE, CORRELATION #rp321, DYNAMIC DISPATCH: list order must match exactly between LIST_OF_TYPES_SCALAR & LIST_OF_TYPES_ARRAYREF & LIST_OF_TYPES_HASHREF
my $type_enum = [
    TYPE_void(),
#    TYPE_boolean(),
#    TYPE_unsigned_integer(),
    TYPE_integer(),
    TYPE_number(),
#    TYPE_character(),
    TYPE_string(),
#    TYPE_scalar(),
    TYPE_unknown()
];
=cut

# a short-circuited, non-recursive version of type() subroutine
sub type_fast {
    { my string $RETURN_TYPE };
    ( my unknown $variable ) = @ARG;

    # DEV NOTE, CORRELATION #rp322: only subroutines/functions can have a void return value; variables can not be type void; no such types as void_arrayref, void_hashref, etc
#    if ( not defined $variable ) { return 'void'; }
    if ( not defined $variable ) { return 'unknown'; }

    # DEV NOTE, CORRELATION #rp025: only report core types integer, number, string, arrayref, hashref, object;
    # do NOT report non-core types boolean, unsigned_integer, char, etc.
    # DEV NOTE: Perl's implicit casting can cause 1 constant or variable to report multiple types, 
    # always report number before integer to avoid incorrect to_string() formatting
    if    ( main::RPerl_SvNOKp($variable) ) { return 'number'; }
    elsif ( main::RPerl_SvIOKp($variable) ) { return 'integer'; }
    elsif ( main::RPerl_SvPOKp($variable) ) { return 'string'; }
    else                                    { return 'unknown'; }
}

# a short-circuited, non-recursive version of type() subroutine; returns type enum raw value instead of type name string
sub type_fast_enum {
    { my type_enum $RETURN_TYPE };
    ( my unknown $variable ) = @ARG;
    RPerl::diag("in rperltypes::type_fast_enum(), top of subroutine\n");
    RPerl::diag('in rperltypes::type_fast_enum(), received $variable = ' . $variable . "\n");

    # DEV NOTE, CORRELATION #rp322: only subroutines/functions can have a void return value; variables can not be type void; no such types as void_arrayref, void_hashref, etc
#    if (not defined($variable))      { return TYPE_void(); }
    if (not defined($variable))      { return TYPE_unknown(); }

    # DEV NOTE, CORRELATION #rp025: only report core types integer, number, string, arrayref, hashref, object;
    # do NOT report non-core types boolean, unsigned_integer, char, etc.
    # DEV NOTE: Perl's implicit casting can cause 1 constant or variable to report multiple types,
    # always report number before integer to avoid incorrect to_string() formatting
    if    ( RPerl_SvNOKp($variable) ) { return TYPE_number();  }
    elsif ( RPerl_SvIOKp($variable) ) { return TYPE_integer(); }
    elsif ( RPerl_SvPOKp($variable) ) { return TYPE_string();  }
    else                             { return TYPE_unknown(); }
}

# upgrade TYPE_integer to TYPE_number, to avoid finding an integer element at index 0 and incorrectly assuming other number elements are also integers
sub type_fast_enum__upgrade_integer_to_number {
    { my type_enum $RETURN_TYPE };
    ( my unknown $variable ) = @ARG;
    RPerl::diag("in rperltypes::type_fast_enum__upgrade_integer_to_number(), top of subroutine\n");

    my type_enum $variable_type = type_fast_enum($variable);
    if ($variable_type == TYPE_integer()) {
        RPerl::diag("in rperltypes::type_fast_enum__upgrade_integer_to_number(), YES UPGRADE\n");
        return TYPE_number();
    }
    elsif ($variable_type == TYPE_integer_arrayref()) {
        return TYPE_number_arrayref();
    }
# NEED ENABLE, hashref types
#    elsif ($variable_type == TYPE_integer_hashref()) {
#        return TYPE_number_hashref();
#    }

    RPerl::diag("in rperltypes::type_fast_enum__upgrade_integer_to_number(), NO UPGRADE\n");
    return $variable_type;
}


# DEV NOTE: type() and types() are more powerful replacements for ref(), and ref() is not supported in RPerl
sub type {
    { my string $RETURN_TYPE };
    ( my unknown $variable, my integer $recurse_level ) = @ARG;

    # DEV NOTE, CORRELATION #rp322: only subroutines/functions can have a void return value; variables can not be type void; no such types as void_arrayref, void_hashref, etc
#    if ( not defined $variable ) { return 'void'; }
    if ( not defined $variable ) { return 'unknown'; }

    if ( not defined $recurse_level ) { $recurse_level = 10; }    # default to limited recursion
    my integer_hashref $is_type = build_is_type($variable);
#    RPerl::diag('in rperltypes::type(), have $is_type = ' . Dumper($is_type) . "\n");
    # DEV NOTE, CORRELATION #rp025: only report core types integer, number, string, arrayref, hashref, object;
    # do NOT report non-core types boolean, unsigned_integer, char, etc.
    # DEV NOTE: Perl's implicit casting can cause 1 constant or variable to report multiple types, 
    # always report number before integer to avoid incorrect to_string() formatting
    if ( $is_type->{number} )  { return 'number'; }
    elsif ( $is_type->{integer} ) { return 'integer'; }
    elsif ( $is_type->{string} )  { return 'string'; }
    else {    # arrayref, hashref, or blessed object
        my arrayref $types = types_recurse( $variable, $recurse_level, $is_type );
        return $types->[0];    # only return flat type string, discard nested type hashref
    }
    return;
}

sub types {
    { my string_hashref $RETURN_TYPE };
    ( my unknown $variable, my integer $recurse_level ) = @ARG;
 
    # DEV NOTE, CORRELATION #rp322: only subroutines/functions can have a void return value; variables can not be type void; no such types as void_arrayref, void_hashref, etc
#    if ( not defined $variable ) { return 'void'; }
    if ( not defined $variable ) { return 'unknown'; }

    if ( not defined $recurse_level ) { $recurse_level = 10; }    # default to limited recursion
    my integer_hashref $is_type = build_is_type($variable);
    # DEV NOTE, CORRELATION #rp025: only report core types integer, number, string, arrayref, hashref, object;
    # do NOT report non-core types boolean, unsigned_integer, char, etc.
    if ( $is_type->{integer} ) { return { 'integer' => undef }; }
    elsif ( $is_type->{number} )  { return { 'number'  => undef }; }
    elsif ( $is_type->{string} )  { return { 'string'  => undef }; }
    else {    # arrayref, hash, or blessed object
        my arrayref $types = types_recurse( $variable, $recurse_level, $is_type );
        return $types->[1];    # only return nested type hashref, discard flat type string
    }
    return;
}

sub build_is_type {
    { my integer_hashref $RETURN_TYPE };
    ( my unknown $variable ) = @ARG;

    my integer_hashref $is_type = {
        boolean   => main::RPerl_SvBOKp($variable),
        unsigned_integer  => main::RPerl_SvUIOKp($variable),

# START HERE: figure out why SvIOKp() below is returning true for floating-point number Pi()
# START HERE: figure out why SvIOKp() below is returning true for floating-point number Pi()
# START HERE: figure out why SvIOKp() below is returning true for floating-point number Pi()

        integer   => main::RPerl_SvIOKp($variable),
        number    => main::RPerl_SvNOKp($variable),
        character => main::RPerl_SvCOKp($variable),
        string    => main::RPerl_SvPOKp($variable),
        arrayref  => main::RPerl_SvAROKp($variable),
        hashref   => main::RPerl_SvHROKp($variable),
        blessed   => 0,
        class     => blessed $variable
    };
    if ( defined $is_type->{class} ) { $is_type->{blessed} = 1; }

    #    RPerl::diag('in rperltypes::build_is_type(), have $is_type =' . "\n" . Dumper($is_type) . "\n");
    return $is_type;
}

sub types_recurse {
    { my string_hashref $RETURN_TYPE };
    ( my unknown $variable, my integer $recurse_level, my integer_hashref $is_type ) = @ARG;

    #    RPerl::diag('in rperltypes::types_recurse(), received $variable =' . "\n" . Dumper($variable) . "\n");

    if ( not defined $recurse_level ) { $recurse_level = 999; }                        # default to full recursion
    if ( not defined $is_type )       { $is_type       = build_is_type($variable); }

    #    RPerl::diag('in rperltypes::types_recurse(), have $recurse_level = ' . $recurse_level . "\n");

    #    RPerl::diag('in rperltypes::types_recurse(), have $is_type =' . "\n" . Dumper($is_type) . "\n");

    my string $type          = undef;
    my string_hashref $types = undef;

    # DEV NOTE, CORRELATION #rp025: only report core types integer, number, string, arrayref, hashref, object;
    # do NOT report non-core types boolean, unsigned_integer, character, etc.

    # DEV NOTE, CORRELATION #rp322: only subroutines/functions can have a void return value; variables can not be type void; no such types as void_arrayref, void_hashref, etc
#    if    ( not defined $variable ) { $type = 'void'; }
    if    ( not defined $variable ) { $type = 'unknown'; }
    
    elsif ( $is_type->{integer} )   { $type = 'integer'; }
    elsif ( $is_type->{number} )    { $type = 'number'; }
    elsif ( $is_type->{string} )    { $type = 'string'; }

    if ( defined $type ) {

        #        RPerl::diag('in rperltypes::types_recurse(), about to return undef or scalar $type = ' . $type . "\n");
        return [ $type, $types ];
    }
    elsif ( $recurse_level <= 0 ) {

        # blessed class must be tested first, because it also matches on hashref
        if ( $is_type->{blessed} ) {
            $type = 'object';
            $types = { $type => { '__CLASS' => $is_type->{class} } };
        }
        elsif ( $is_type->{arrayref} ) { $type = 'arrayref'; }
        elsif ( $is_type->{hashref} )  { $type = 'hashref'; }
        else                           { $type = '__UNRECOGNIZED_TYPE'; }

        #        RPerl::diag('in rperltypes::types_recurse(), max recurse reached, about to return unrecognized or non-scalar $type = ' . $type . "\n");
        return [ $type, $types ];
    }
    else {
        $recurse_level--;

        # blessed class must be tested first, because it also matches on hashref
        # DEV NOTE: objects don't inherit subtypes of their $properties hash entries, even if homogeneous;
        # no such thing as integer_object even if all $properties are integers, etc.
        if ( $is_type->{blessed} ) {
            $type  = 'object';
            $types = {};
            $types->{$type} = { '__CLASS' => $is_type->{class} };

            #            RPerl::diag('in rperltypes::types_recurse(), top of blessed class...' . "\n");

            foreach my $hash_key ( sort keys %{$variable} ) {
                my hashref $subtypes = types_recurse( $variable->{$hash_key}, $recurse_level );
                if ( not defined $subtypes->[1] ) {

                    # for scalar subtypes or non-scalar subtypes w/ max recurse reached, discard undef nested type hashref
                    $types->{$type}->{$hash_key} = $subtypes->[0];
                }
                else {
                    # for non-scalar subtypes w/out max recurse reached, append nested subtype hashref to list of types for this arrayref
                    $types->{$type}->{$hash_key} = $subtypes->[1];
                }
                RPerl::diag('in rperltypes::types_recurse(), inside blessed class, have $types = ' . "\n" . Dumper($types) . "\n");
                RPerl::diag('in rperltypes::types_recurse(), inside blessed class, have $subtypes = ' . "\n" . Dumper($subtypes) . "\n");

            }

            #            RPerl::diag('in rperltypes::types_recurse(), bottom of blessed class, have $type = ' . $type . "\n");
        }
        elsif ( $is_type->{arrayref} ) {
            $type           = 'arrayref';
            $types          = {};
            $types->{$type} = [];
            my string $subtype          = undef;
            my string $subtype_class    = undef;
            my integer $object_mismatch = 0;
            my integer $is_homogeneous  = 1;

            #            RPerl::diag('in rperltypes::types_recurse(), top of arrayref...' . "\n");

            foreach my $array_element ( @{$variable} ) {
                my hashref $subtypes = types_recurse( $array_element, $recurse_level );
                if ( not defined $subtypes->[1] ) {

                    # for scalar subtypes or non-scalar subtypes w/ max recurse reached, discard undef nested type hashref
                    push @{ $types->{$type} }, $subtypes->[0];
                }
                else {
                    # for non-scalar subtypes w/out max recurse reached, append nested subtype hashref to list of types for this arrayref
                    push @{ $types->{$type} }, $subtypes->[1];
                }

                #                RPerl::diag('in rperltypes::types_recurse(), inside arrayref, have $types = ' . "\n" . Dumper($types) . "\n");
                #                RPerl::diag('in rperltypes::types_recurse(), inside arrayref, have $subtypes = ' . "\n" . Dumper($subtypes) . "\n");

                # use first element's type as test for remaining element types
                if ( not defined $subtype ) {
                    $subtype = $subtypes->[0];
                    if ( $subtype eq 'object' ) {
                        $subtype_class = $subtypes->[1]->{object}->{__CLASS};
                    }
                }
                elsif ($is_homogeneous) {

                    #                    RPerl::diag('in rperltypes::types_recurse(), inside arrayref, have $subtype = ' . $subtype . "\n");
                    #                    RPerl::diag('in rperltypes::types_recurse(), inside arrayref, have $subtypes->[0] = ' . $subtypes->[0] . "\n");

#                    RPerl::diag('in rperltypes::types_recurse(), inside arrayref, have $subtype_class = ' . $subtype_class . "\n");
#                    RPerl::diag('in rperltypes::types_recurse(), inside arrayref, have $subtypes->[1]->{object}->{__CLASS} = ' . $subtypes->[1]->{object}->{__CLASS} . "\n");
# object classes must match for homogeneity
                    if ( ( $subtype eq 'object' ) and ( $subtypes->[0] eq 'object' ) and ( $subtype_class ne $subtypes->[1]->{object}->{__CLASS} ) ) {

                    #                        RPerl::diag('in rperltypes::types_recurse(), inside arrayref, MISMATCH OF OBJECT CLASSES' . "\n");
                    #                        RPerl::diag('in rperltypes::types_recurse(), inside arrayref, have $types = ' . "\n" . Dumper($types) . "\n");
                    #                        RPerl::diag('in rperltypes::types_recurse(), inside arrayref, have $subtypes = ' . "\n" . Dumper($subtypes) . "\n");
                        $object_mismatch = 1;
                    }
                    else { $object_mismatch = 0; }

                    if ( $object_mismatch or ( $subtype ne $subtypes->[0] ) ) {
                        my string_arrayref $reverse_split_subtype    = [ reverse split /_/xms, $subtype ];
                        my string_arrayref $reverse_split_subtypes_0 = [ reverse split /_/xms, $subtypes->[0] ];

#                        RPerl::diag('in rperltypes::types_recurse(), inside arrayref, have $reverse_split_subtype = ' . "\n" . Dumper($reverse_split_subtype) . "\n");
#                        RPerl::diag('in rperltypes::types_recurse(), inside arrayref, have $reverse_split_subtypes_0 = ' . "\n" . Dumper($reverse_split_subtypes_0) . "\n");
# discard non-matching 'object' subtype
                        if ($object_mismatch) {
                            pop @{$reverse_split_subtype};
                            pop @{$reverse_split_subtypes_0};
                            $object_mismatch = 0;
                        }
                        my string $new_subtype           = q{};
                        my integer $shorter_split_length = scalar @{$reverse_split_subtype};
                        if ( scalar @{$reverse_split_subtypes_0} < $shorter_split_length ) {
                            $shorter_split_length = scalar @{$reverse_split_subtypes_0};
                        }
                        for my integer $i ( 0 .. ( $shorter_split_length - 1 ) ) {

#                            RPerl::diag('in rperltypes::types_recurse(), inside arrayref, have $reverse_split_subtype->[' . $i . '] = ' . $reverse_split_subtype->[$i] . "\n");
#                            RPerl::diag('in rperltypes::types_recurse(), inside arrayref, have $reverse_split_subtypes_0->[' . $i . '] = ' . $reverse_split_subtypes_0->[$i] . "\n");
                            if ( $reverse_split_subtype->[$i] eq $reverse_split_subtypes_0->[$i] ) {
                                if ( $new_subtype eq q{} ) {
                                    $new_subtype = $reverse_split_subtype->[$i];
                                }
                                else {
                                    $new_subtype = $reverse_split_subtype->[$i] . '_' . $new_subtype;
                                }
                            }
                        }
                        if ( $new_subtype ne q{} ) {
                            $subtype = $new_subtype;
                        }
                        else {
                            $is_homogeneous = 0;
                        }
                    }
                }

                #                RPerl::diag('in rperltypes::types_recurse(), inside arrayref, have $subtype = ' . $subtype . "\n");
            }
            if ($is_homogeneous) {

                # DEV NOTE: flatten unknown_hashref to hashref
                if ( ( not defined $subtype ) or ( $subtype eq 'unknown' ) ) { $subtype = q{} }
                if ( $subtype ne q{} ) {
                    my string $type_old = $type;
                    $type = $subtype . '_' . $type;
                    $types->{$type} = $types->{$type_old};
                    delete $types->{$type_old};
                }
            }

            #            RPerl::diag('in rperltypes::types_recurse(), bottom of arrayref, have $type = ' . $type . "\n");
        }
        elsif ( $is_type->{hashref} ) {
            $type           = 'hashref';
            $types          = {};
            $types->{$type} = {};
            my string $subtype          = undef;
            my string $subtype_class    = undef;
            my integer $object_mismatch = 0;
            my integer $is_homogeneous  = 1;

            #            RPerl::diag('in rperltypes::types_recurse(), top of hashref...' . "\n");

            foreach my $hash_key ( sort keys %{$variable} ) {
                my hashref $subtypes = types_recurse( $variable->{$hash_key}, $recurse_level );
                if ( not defined $subtypes->[1] ) {

                    # for scalar subtypes or non-scalar subtypes w/ max recurse reached, discard undef nested type hashref
                    $types->{$type}->{$hash_key} = $subtypes->[0];
                }
                else {
                    # for non-scalar subtypes w/out max recurse reached, append nested subtype hashref to list of types for this hashref
                    $types->{$type}->{$hash_key} = $subtypes->[1];
                }

                #                RPerl::diag('in rperltypes::types_recurse(), inside hashref, have $types = ' . "\n" . Dumper($types) . "\n");
                #                RPerl::diag('in rperltypes::types_recurse(), inside hashref, have $subtypes = ' . "\n" . Dumper($subtypes) . "\n");

                # use first element's type as test for remaining element types
                if ( not defined $subtype ) {
                    $subtype = $subtypes->[0];
                    if ( $subtype eq 'object' ) {
                        $subtype_class = $subtypes->[1]->{object}->{__CLASS};
                    }
                }
                elsif ($is_homogeneous) {

                    #                    RPerl::diag('in rperltypes::types_recurse(), inside hashref, have $subtype = ' . $subtype . "\n");
                    #                    RPerl::diag('in rperltypes::types_recurse(), inside hashref, have $subtypes->[0] = ' . $subtypes->[0] . "\n");

#                    RPerl::diag('in rperltypes::types_recurse(), inside hashref, have $subtype_class = ' . $subtype_class . "\n");
#                    RPerl::diag('in rperltypes::types_recurse(), inside hashref, have $subtypes->[1]->{object}->{__CLASS} = ' . $subtypes->[1]->{object}->{__CLASS} . "\n");
# object classes must match for homogeneity
                    if ( ( $subtype eq 'object' ) and ( $subtypes->[0] eq 'object' ) and ( $subtype_class ne $subtypes->[1]->{object}->{__CLASS} ) ) {

                     #                        RPerl::diag('in rperltypes::types_recurse(), inside hashref, MISMATCH OF OBJECT CLASSES' . "\n");
                     #                        RPerl::diag('in rperltypes::types_recurse(), inside hashref, have $types = ' . "\n" . Dumper($types) . "\n");
                     #                        RPerl::diag('in rperltypes::types_recurse(), inside hashref, have $subtypes = ' . "\n" . Dumper($subtypes) . "\n");
                        $object_mismatch = 1;
                    }
                    else { $object_mismatch = 0; }

                    if ( $object_mismatch or ( $subtype ne $subtypes->[0] ) ) {
                        my string_arrayref $reverse_split_subtype    = [ reverse split /_/xms, $subtype ];
                        my string_arrayref $reverse_split_subtypes_0 = [ reverse split /_/xms, $subtypes->[0] ];

#                        RPerl::diag('in rperltypes::types_recurse(), inside hashref, have $reverse_split_subtype = ' . "\n" . Dumper($reverse_split_subtype) . "\n");
#                        RPerl::diag('in rperltypes::types_recurse(), inside hashref, have $reverse_split_subtypes_0 = ' . "\n" . Dumper($reverse_split_subtypes_0) . "\n");
# discard non-matching 'object' subtype
                        if ($object_mismatch) {
                            pop @{$reverse_split_subtype};
                            pop @{$reverse_split_subtypes_0};
                            $object_mismatch = 0;
                        }
                        my string $new_subtype           = q{};
                        my integer $shorter_split_length = scalar @{$reverse_split_subtype};
                        if ( scalar @{$reverse_split_subtypes_0} < $shorter_split_length ) {
                            $shorter_split_length = scalar @{$reverse_split_subtypes_0};
                        }
                        for my integer $i ( 0 .. ( $shorter_split_length - 1 ) ) {

#                            RPerl::diag('in rperltypes::types_recurse(), inside hashref, have $reverse_split_subtype->[' . $i . '] = ' . $reverse_split_subtype->[$i] . "\n");
#                            RPerl::diag('in rperltypes::types_recurse(), inside hashref, have $reverse_split_subtypes_0->[' . $i . '] = ' . $reverse_split_subtypes_0->[$i] . "\n");
                            if ( $reverse_split_subtype->[$i] eq $reverse_split_subtypes_0->[$i] ) {
                                if ( $new_subtype eq q{} ) {
                                    $new_subtype = $reverse_split_subtype->[$i];
                                }
                                else {
                                    $new_subtype = $reverse_split_subtype->[$i] . '_' . $new_subtype;
                                }
                            }
                        }
                        if ( $new_subtype ne q{} ) {
                            $subtype = $new_subtype;
                        }
                        else {
                            $is_homogeneous = 0;
                        }
                    }
                }

                #                RPerl::diag('in rperltypes::types_recurse(), inside hashref, have $subtype = ' . $subtype . "\n");
            }
            if ($is_homogeneous) {

                # DEV NOTE: flatten unknown_arrayref to arrayref
                if ( ( not defined $subtype ) or ( $subtype eq 'unknown' ) ) { $subtype = q{} }
                if ( $subtype ne q{} ) {
                    my string $type_old = $type;
                    $type = $subtype . '_' . $type;
                    $types->{$type} = $types->{$type_old};
                    delete $types->{$type_old};
                }
            }

            #            RPerl::diag('in rperltypes::types_recurse(), bottom of hashref, have $type = ' . $type . "\n");
        }
        else {
            $type = '__UNRECOGNIZED_TYPE';
        }
        return [ $type, $types ];
    }
    return;
}
1;


# [[[ C++ TYPE CONTROL ]]]
package RPerl;
if ( not defined $RPerl::INCLUDE_PATH ) {
    our $INCLUDE_PATH = '/FAILURE/BECAUSE/RPERL/INCLUDE/PATH/NOT/YET/SET';
}
1;    # suppress warnings about typo in types_enable() below

package  # hide from PAUSE indexing
    rperltypes;

sub types_enable {
    { my void $RETURN_TYPE };
    ( my $types_input ) = @ARG;

#    RPerl::diag('in rperltypes::types_enable(), received $types_input = ' . $types_input . "\n");

    if (($types_input ne 'PERL') and ($types_input ne 'CPP')) {
        croak q{ERROR ERPTY00: Invalid RPerl types '} . $types_input . q{' specified where PERL or CPP expected, croaking};
    }

    $RPerl::TYPES_CCFLAG = ' -D__' . $types_input . '__TYPES';

#    RPerl::diag('in rperltypes::types_enable(), set $RPerl::TYPES_CCFLAG = ' . $RPerl::TYPES_CCFLAG . "\n");
    return;
}

1;  # end of package

