#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'no errors' >>>
# <<< EXECUTE_SUCCESS: 'have $my_fg->get_bax() = 123' >>>
# <<< EXECUTE_SUCCESS: 'have $my_f->get_bax() = 123' >>>
# <<< EXECUTE_SUCCESS: 'have $my_f->get_xab() = 321' >>>
# <<< EXECUTE_SUCCESS: 'have $my_g->get_bax() = 123' >>>
# <<< EXECUTE_SUCCESS: 'have $my_g->get_xab() = 321' >>>
# <<< EXECUTE_SUCCESS: 'have $my_g->get_xba() = 312' >>>
# <<< EXECUTE_SUCCESS: 'have $my_fg->get_bax() = 111' >>>
# <<< EXECUTE_SUCCESS: 'have $my_f->get_bax() = 222' >>>
# <<< EXECUTE_SUCCESS: 'have $my_g->get_bax() = 333' >>>
# <<< EXECUTE_SUCCESS: 'calling $my_fg->multiply_bax_FG(22)...' >>>
# <<< EXECUTE_SUCCESS: 'have $my_fg->get_bax() = 2442' >>>
# <<< EXECUTE_SUCCESS: 'have RPerl::Test::Exporter::Class_FG_Exporter_Importer_02_Good::multiply_return_FG(11, 22) = 242' >>>
# <<< EXECUTE_SUCCESS: 'calling $my_f->multiply_bax_FG(22)...' >>>
# <<< EXECUTE_SUCCESS: 'have $my_f->get_bax() = 4884' >>>
# <<< EXECUTE_SUCCESS: 'have EXPORTED RPerl::Test::Exporter::Class_F_Exporter_Importer_02_Good::multiply_return_FG(11, 22) = 242' >>>
# <<< EXECUTE_SUCCESS: 'calling $my_f->multiply_bax_F(-1)...' >>>
# <<< EXECUTE_SUCCESS: 'have $my_f->get_bax() = -4884' >>>
# <<< EXECUTE_SUCCESS: 'have RPerl::Test::Exporter::Class_F_Exporter_Importer_02_Good::multiply_return_F(-11, 22) = -242' >>>
# <<< EXECUTE_SUCCESS: 'calling $my_g->multiply_bax_FG(22)...' >>>
# <<< EXECUTE_SUCCESS: 'have $my_g->get_bax() = 7326' >>>
# <<< EXECUTE_SUCCESS: 'have EXPORTED RPerl::Test::Exporter::Class_G_Importer_02_Good::multiply_return_FG(11, 22) = 242' >>>
# <<< EXECUTE_SUCCESS: 'calling $my_g->multiply_bax_F(-1)...' >>>
# <<< EXECUTE_SUCCESS: 'have $my_g->get_bax() = -7326' >>>
# <<< EXECUTE_SUCCESS: 'have EXPORTED RPerl::Test::Exporter::Class_G_Importer_02_Good::multiply_return_F(-11, 22) = -242' >>>
# <<< EXECUTE_SUCCESS: 'calling $my_g->multiply_bax_G(-2)...' >>>
# <<< EXECUTE_SUCCESS: 'have $my_g->get_bax() = 14652' >>>
# <<< EXECUTE_SUCCESS: 'have RPerl::Test::Exporter::Class_G_Importer_02_Good::multiply_return_G(-11, 33) = -363' >>>
# <<< EXECUTE_SUCCESS: 'still no errors' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Test::Exporter::Class_FG_Exporter_Importer_02_Good;

# [[[ OPERATIONS ]]]

# class subtype tests

my RPerl::Test::Exporter::Class_FG_Exporter_Importer_02_Good_arrayref $foo_a = [];
my RPerl::Test::Exporter::Class_FG_Exporter_Importer_02_Good_hashref $foo_h = {};
my RPerl::Test::Exporter::Class_F_Exporter_Importer_02_Good_arrayref $bar_a = [];
my RPerl::Test::Exporter::Class_F_Exporter_Importer_02_Good_hashref $bar_h = {};
my RPerl::Test::Exporter::Class_G_Importer_02_Good_arrayref $bat_a = [];
my RPerl::Test::Exporter::Class_G_Importer_02_Good_hashref $bat_h = {};
print 'no errors', "\n";

# class default constructor tests

my RPerl::Test::Exporter::Class_FG_Exporter_Importer_02_Good $my_fg = RPerl::Test::Exporter::Class_FG_Exporter_Importer_02_Good->new();
my RPerl::Test::Exporter::Class_F_Exporter_Importer_02_Good $my_f = RPerl::Test::Exporter::Class_F_Exporter_Importer_02_Good->new();
my RPerl::Test::Exporter::Class_G_Importer_02_Good $my_g = RPerl::Test::Exporter::Class_G_Importer_02_Good->new();

# class default properties tests

print 'have $my_fg->get_bax() = ', $my_fg->get_bax(), "\n";
print 'have $my_f->get_bax() = ', $my_f->get_bax(), "\n";
print 'have $my_f->get_xab() = ', $my_f->get_xab(), "\n";
print 'have $my_g->get_bax() = ', $my_g->get_bax(), "\n";
print 'have $my_g->get_xab() = ', $my_g->get_xab(), "\n";
print 'have $my_g->get_xba() = ', $my_g->get_xba(), "\n";

$my_fg->set_bax(111);
$my_f->set_bax(222);
$my_g->set_bax(333);

print 'have $my_fg->get_bax() = ', $my_fg->get_bax(), "\n";
print 'have $my_f->get_bax() = ', $my_f->get_bax(), "\n";
print 'have $my_g->get_bax() = ', $my_g->get_bax(), "\n";

# subroutine & class method tests

print 'calling $my_fg->multiply_bax_FG(22)...', "\n";
$my_fg->multiply_bax_FG(22);
print 'have $my_fg->get_bax() = ', $my_fg->get_bax(), "\n";
print 'have RPerl::Test::Exporter::Class_FG_Exporter_Importer_02_Good::multiply_return_FG(11, 22) = ', RPerl::Test::Exporter::Class_FG_Exporter_Importer_02_Good::multiply_return_FG(11, 22), "\n";

print 'calling $my_f->multiply_bax_FG(22)...', "\n";
$my_f->multiply_bax_FG(22);
print 'have $my_f->get_bax() = ', $my_f->get_bax(), "\n";
print 'have EXPORTED RPerl::Test::Exporter::Class_F_Exporter_Importer_02_Good::multiply_return_FG(11, 22) = ', RPerl::Test::Exporter::Class_F_Exporter_Importer_02_Good::multiply_return_FG(11, 22), "\n";  # ERROR HERE, MOVE TO EXPORTER EXAMPLE

print 'calling $my_f->multiply_bax_F(-1)...', "\n";
$my_f->multiply_bax_F(-1);
print 'have $my_f->get_bax() = ', $my_f->get_bax(), "\n";
print 'have RPerl::Test::Exporter::Class_F_Exporter_Importer_02_Good::multiply_return_F(-11, 22) = ', RPerl::Test::Exporter::Class_F_Exporter_Importer_02_Good::multiply_return_F(-11, 22), "\n";

print 'calling $my_g->multiply_bax_FG(22)...', "\n";
$my_g->multiply_bax_FG(22);
print 'have $my_g->get_bax() = ', $my_g->get_bax(), "\n";
print 'have EXPORTED RPerl::Test::Exporter::Class_G_Importer_02_Good::multiply_return_FG(11, 22) = ', RPerl::Test::Exporter::Class_G_Importer_02_Good::multiply_return_FG(11, 22), "\n";  # ERROR HERE, MOVE TO EXPORTER EXAMPLE

print 'calling $my_g->multiply_bax_F(-1)...', "\n";
$my_g->multiply_bax_F(-1);
print 'have $my_g->get_bax() = ', $my_g->get_bax(), "\n";
print 'have EXPORTED RPerl::Test::Exporter::Class_G_Importer_02_Good::multiply_return_F(-11, 22) = ', RPerl::Test::Exporter::Class_G_Importer_02_Good::multiply_return_F(-11, 22), "\n";  # ERROR HERE, MOVE TO EXPORTER EXAMPLE

print 'calling $my_g->multiply_bax_G(-2)...', "\n";
$my_g->multiply_bax_G(-2);
print 'have $my_g->get_bax() = ', $my_g->get_bax(), "\n";
print 'have RPerl::Test::Exporter::Class_G_Importer_02_Good::multiply_return_G(-11, 33) = ', RPerl::Test::Exporter::Class_G_Importer_02_Good::multiply_return_G(-11, 33), "\n";

print 'still no errors', "\n";

