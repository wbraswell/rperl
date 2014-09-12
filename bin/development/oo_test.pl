#!/usr/bin/perl
# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_012;

# [[[ CRITICS, INCLUDES ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values and print operator
## no critic qw(ProhibitUnreachableCode RequirePodSections RequirePodAtEnd PodSpelling) # DEVELOPER DEFAULT 1: allow unreachable & POD-commented code

# [[[ OPERATIONS ]]]

# UNCOMMENT TO ENABLE PERL TYPES FOR C++ OPS
rperltypes::types_enable('PERL');

# UNCOMMENT TO ENABLE C++ TYPES FOR C++ OPS
#rperltypes::types_enable('CPP');


# START HERE: get CPPOPS working
# START HERE: get CPPOPS working
# START HERE: get CPPOPS working


# UNCOMMENT TO CHOOSE PERL OPS OR C++ OPS
#use RPerl::Algorithm::Sort::Bubble;  # choose ONE of this
use RPerl::Algorithm::Sort::Bubble_cpp;
RPerl::Algorithm::Sort::Bubble_cpp::cpp_load(); # OR this

#print q{in oo_test.pl, have RPerl__Algorithm__Sort__Bubble__OPS_TYPES_ID = '} . $RPerl::Algorithm::Sort::Bubble::RPerl__Algorithm__Sort__Bubble__OPS_TYPES_ID . "'\n";  # PERL/PERL ONLY
print q{in oo_test.pl, have RPerl__Algorithm__Sort__Bubble__ops() = '}
    . RPerl__Algorithm__Sort__Bubble__ops() . "'\n";
print q{in oo_test.pl, have RPerl__Algorithm__Sort__Bubble__types() = '}
    . RPerl__Algorithm__Sort__Bubble__types() . "'\n";

# variable declarations
my object $sorter;

# loop to test for memory leaks
my const_integer $i_MAX = 1;
for my integer $i ( 0 .. $i_MAX ) {
    print "in oo_test.pl, top of for() loop $i/$i_MAX\n";

    $sorter = RPerl::Algorithm::Sort::Bubble->new();
    print "in oo_test.pl, have \$i = $i and pre-data \$sorter =\n",
        Dumper($sorter), "\n";

    $sorter->inherited__Algorithm('Frozen');      # RPerl yes, C++ yes
#    $sorter->inherited__Inefficient('Frozen');    # RPerl yes, C++ yes  # NEED UPGRADE: multiple inheritance not currently supported by Inline::CPP
    $sorter->inherited__Sort('Frozen');           # RPerl yes, C++ yes
    $sorter->inherited__Bubble('Frozen');         # RPerl yes, C++ yes
    print "\n";

#	RPerl::Algorithm::Sort::inherited($sorter, 'Jean Gray');  # RPerl yes, C++ no
#	RPerl::Algorithm::Sort->inherited('Scott Summers');  # RPerl yes, C++ no
    $sorter->inherited('Logan');    # RPerl yes, C++ yes

#	inherited('MANORBEAST?', 'Dr. Hank McCoy');  # RPerl no, C++ no; inherited method should only work as method!
    print "\n";
    uninherited__Algorithm('Claws');      # RPerl yes, C++ yes
#    uninherited__Inefficient('Claws');    # RPerl yes, C++ yes  # NEED UPGRADE: multiple inheritance not currently supported by Inline::CPP
    uninherited__Sort('Claws');           # RPerl yes, C++ yes
    uninherited__Bubble('Claws');         # RPerl yes, C++ yes
    print "\n";
    uninherited('Wolverine');             # RPerl yes, C++ yes

#	RPerl::Algorithm::Sort::uninherited('Phoenix');  # RPerl yes, C++ no; bypass RPerl POST-INIT symbol table entries that put non-method uninherited() in main::, use AUTOLOAD
    main::uninherited('Wolvie');          # RPerl yes, C++ yes
    ::uninherited('wlverine');            # RPerl yes, C++ yes

# HASH FOR REFERENCE
# HASH FOR REFERENCE
# HASH FOR REFERENCE
#	$retval_stringify = stringify_int__hash_ref(2);  # HVIV00; raise/throw exception
#	$retval_stringify = stringify_int__hash_ref({a_key => 23});  # HVIV01
#	print "in oo_test.pl $i/$i_MAX, have \$retval_stringify =\n$retval_stringify\n";
#	$retval_jeffys = typetest___int__in___string__hash_ref__out(5);  # HVPV20
#	print "in type_test.pl, have \$retval_jeffys =\n" . Dumper($retval_jeffys) . "\n";

    croak('Done for now, croaking');
}

#croak('Done for now, croaking');
