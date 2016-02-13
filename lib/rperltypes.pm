# [[[ HEADER ]]]
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names
package  # hide from PAUSE indexing
    rperltypes;
use strict;
use warnings;
use RPerl::Config;
our $VERSION = 0.002_300;

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

# DEV NOTE, CORRELATION #rp08: can't use Exporter here
# [[[ EXPORTS ]]]
#use Exporter 'import';
#our @EXPORT = qw(type types ETC);

# all following type lists lowest-to-highest level

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
use RPerl::DataStructure::Array::Reference;
use RPerl::DataStructure::Hash;
use RPerl::DataStructure::Hash::Reference;

#use RPerl::DataStructure::LinkedList;
#use RPerl::DataStructure::LinkedList::Node;
#use RPerl::DataStructure::Graph;
#use RPerl::DataStructure::Graph::Tree;
#use RPerl::DataStructure::Graph::Tree::Binary;
#use RPerl::DataStructure::Graph::Tree::Binary::Node;

# [[[ OBJECT-ORIENTED ]]]
use RPerl::Object;
use RPerl::CodeBlock::Subroutine::Method;    # Method is the only item that is both a Data Type & a Grammar Rule???

# these types are currently implemented for all 3 primary RPerl modes: PERLOPS_PERLTYPES, CPPOPS_PERLTYPES, CPPOPS_CPPTYPES
# NEED REMOVE: hard-coded list
# MISSING: boolean, unsigned_integer, char, *_arrayref, *_hashref
our string_arrayref $SUPPORTED = [
    qw(
        void
        integer
        number
        string
        integer_arrayref
        number_arrayref
        string_arrayref
        integer_hashref
        number_hashref
        string_hashref
        )
];

# DEV NOTE, CORRELATION #rp08: export to_string(), class(), type() and types() to main:: namespace;
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

# NEED UPGRADE: don't fall back to Perl qq{} string interpolation or Dumper() for stringification;
# Dumper will fail to call *_to_string() until stringification overloading is implemented
#my string $to_string = sub {
sub to_string {
    ( my unknown $variable) = @_;
    if ( not defined $variable ) { return 'undef'; }
    my string $type = type($variable);
    if    ( $type eq 'unknown' ) { return qq{$variable}; }
    elsif ( $type eq 'boolean' )    { return boolean_to_string($variable); }
#    elsif ( $type eq 'unsigned_integer' ) { return unsigned_integer_to_string($variable); }  # DEV NOTE: causes auto-vivification of empty unsigned_integer_to_string() if not already properly bound
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
}

# DEV NOTE: class() is a wrapper around blessed() from Scalar::Util, class() is preferred for readability, 
# blessed() and class() both generate as classname() in C++ to avoid conflict with 'class' C++ reserved word
#my string $class = sub {
sub class {
    ( my unknown $object ) = @_;
    return blessed($object);
}

# DEV NOTE: type() and types() are more powerful replacements for ref(), and ref() is not supported in RPerl
#my string $type = sub {
sub type {
    ( my unknown $variable, my integer $recurse_level ) = @_;
    if ( not defined $variable ) { return 'unknown'; }
    if ( not defined $recurse_level ) { $recurse_level = 10; }    # default to limited recursion
    my integer_hashref $is_type = build_is_type($variable);
    # DEV NOTE, CORRELATION #rp25: only report core types integer, number, string, arrayref, hashref, object;
    # do NOT report non-core types boolean, unsigned_integer, char, etc.
    if ( $is_type->{integer} ) { return 'integer'; }
    elsif ( $is_type->{number} )  { return 'number'; }
    elsif ( $is_type->{string} )  { return 'string'; }
    else {    # arrayref, hashref, or blessed object
        my arrayref $types = types_recurse( $variable, $recurse_level, $is_type );
        return $types->[0];    # only return flat type string, discard nested type hashref
    }
}

#my string_hashref $types = sub {
sub types {
    ( my unknown $variable, my integer $recurse_level ) = @_;
    if ( not defined $variable ) { return 'unknown'; }
    if ( not defined $recurse_level ) { $recurse_level = 10; }    # default to limited recursion
    my integer_hashref $is_type = build_is_type($variable);
    # DEV NOTE, CORRELATION #rp25: only report core types integer, number, string, arrayref, hashref, object;
    # do NOT report non-core types boolean, unsigned_integer, char, etc.
    if ( $is_type->{integer} ) { return { 'integer' => undef }; }
    elsif ( $is_type->{number} )  { return { 'number'  => undef }; }
    elsif ( $is_type->{string} )  { return { 'string'  => undef }; }
    else {    # arrayref, hash, or blessed object
        my arrayref $types = types_recurse( $variable, $recurse_level, $is_type );
        return $types->[1];    # only return nested type hashref, discard flat type string
    }
}

#my integer_hashref build_is_type = sub {
sub build_is_type {
    ( my unknown $variable ) = @_;

    my integer_hashref $is_type = {
        boolean   => main::RPerl_SvBOKp($variable),
        unsigned_integer  => main::RPerl_SvUIOKp($variable),
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

#my string_hashref $types_recurse = sub {
sub types_recurse {
    ( my unknown $variable, my integer $recurse_level, my integer_hashref $is_type ) = @_;

    #    RPerl::diag('in rperltypes::types_recurse(), received $variable =' . "\n" . Dumper($variable) . "\n");

    if ( not defined $recurse_level ) { $recurse_level = 999; }                        # default to full recursion
    if ( not defined $is_type )       { $is_type       = build_is_type($variable); }

    #    RPerl::diag('in rperltypes::types_recurse(), have $recurse_level = ' . $recurse_level . "\n");

    #    RPerl::diag('in rperltypes::types_recurse(), have $is_type =' . "\n" . Dumper($is_type) . "\n");

    my string $type          = undef;
    my string_hashref $types = undef;

    # DEV NOTE, CORRELATION #rp25: only report core types integer, number, string, arrayref, hashref, object;
    # do NOT report non-core types boolean, unsigned_integer, character, etc.
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

#our void $types_input_enable = sub { (my $types_input) = @_;  # NEED FIX: RPerl typed functions not working in types.pm, must call as normal Perl function
sub types_enable {
    ( my $types_input ) = @_;

#	RPerl::diag('in rperltypes::types_enable(), received $types_input = ' . $types_input . "\n");

    if (($types_input ne 'PERL') and ($types_input ne 'CPP')) {
        croak q{ERROR ERPTY00: Invalid RPerl types '} . $types_input . q{' specified where PERL or CPP expected, croaking};
    }

    $RPerl::TYPES_CCFLAG = ' -D__' . $types_input . '__TYPES';
    return;
}

1;  # end of package
