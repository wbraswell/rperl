#!/usr/bin/perl
use strict;
use warnings;
our $VERSION = 0.001_000;

# THIS FILE SHOWS HOW TO IDENTIFY SYMBOL TABLE ENTRY TYPES FOR A CLASS
# analyze_class_symtab_entries() MOVED TO RPerl::Config 

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants
## no critic qw(ProhibitStringyEval)  # SYSTEM DEFAULT 1: allow eval()

use RPerl::Config;
use RPerl::CompileUnit::Module::Header;
use RPerl::Generator;
RPerl::Generator::grammar_rules__map();

#my $class = 'main';
#my $class = 'RPerl';
my $class = 'RPerl::CompileUnit::Module::Header';
print RPerl::analyze_class_symtab_entries($class) . "\n\n";

$class = 'ModuleHeader_23';
print RPerl::analyze_class_symtab_entries($class) . "\n\n";

exit;

print q{=} x 50;
print "\n";
print q{=} x 50;
print "\n";
my $mh21 = ModuleHeader_23->new();
print q{$mh21 =} . "\n" . Dumper($mh21) . "\n";

#my $generate_retval = ModuleHeader_23::ast_to_rperl__generate({FAKE => 'self'}, {FAKE => 'modes'});
my $generate_retval = $mh21->ast_to_rperl__generate( { FAKE => 'modes' } );
print q{$generate_retval =} . "\n" . Dumper($generate_retval) . "\n";

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
