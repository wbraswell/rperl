#!/usr/bin/perl
use strict;
use warnings;
our $VERSION = 0.001_000;

# THIS FILE SHOWS HOW TO IDENTIFY SYMBOL TABLE ENTRY TYPES FOR A CLASS

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants
## no critic qw(ProhibitStringyEval)  # SYSTEM DEFAULT 1: allow eval()

use Data::Dumper;
use RPerl::CompileUnit::Module::Header;
use RPerl::Generator;
RPerl::Generator::grammar_rules__map();

#my $class = 'main';
#my $class = 'RPerl';
#my $class = 'RPerl::CompileUnit::Module::Header';
my $class = 'ModuleHeader_21';

my @isa_array = eval '@' . $class . '::ISA';
#print Dumper(\@isa_array);
my $isa_string = join ', ', @isa_array;
print $class . ' ISA (' . $isa_string . ')' . "\n\n";

#foreach my $entry ( sort keys %RPerl::CompileUnit::Module::Header:: ) {
my @keys = eval q{sort keys %} . $class . q{::};
foreach my $entry (@keys) {

#    my $glob = $RPerl::CompileUnit::Module::Header::{$entry};
    my $glob = eval q{$} . $class . q{::{$entry}};

    print q{-} x 50;
    print "\n";
    print $entry, "\n";

#    print ref \$glob, "\n";  # always says GLOB

    if ( defined ${$glob} ) {
        print "\t", 'scalar';
        my $ref_type = ref ${$glob};
        if ( $ref_type ne q{} ) {
            print "\t", $ref_type, '_ref';
        }
    }
    if ( @{$glob} ) {
        print "\t", 'array';
    }
    if ( %{$glob} ) {
        print "\t", 'hash';
    }
    if ( defined &{$glob} ) {
        print "\t", 'code';
    }

    print "\n";
}

print Dumper(ModuleHeader_21::ast_to_rperl__generate({FAKE => 'self'}, {FAKE => 'modes'}));

__END__

http://perldoc.perl.org/functions/ref.html

    SCALAR
    ARRAY
    HASH
    CODE
    REF
    GLOB
    LVALUE
    FORMAT
    IO
    VSTRING
    Regexp
