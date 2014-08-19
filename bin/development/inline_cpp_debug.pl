#!/usr/bin/perl

# AUTOMATIC CLASSES OPTION CAUSES SUBROUTINE CALL TO FAIL
use Inline (CPP => 'DATA', classes => sub { @_ = split( '__', shift ); ( pop, join( '::', @_ ) ); } );

# MANUAL CLASSES OPTION ALLOWS SUBROUTINE AND METHOD CALLS TO SUCCEED
#use Inline (CPP => 'DATA', classes => { 'RPerl__Test__Inline_CPP_Debug' => 'RPerl::Test::Inline_CPP_Debug'} );

# SUBROUTINE IS ALWAYS IN SYMBOL TABLE: "have \%main:: symbol table entry for my_subroutine() = '*main::my_subroutine'"
print STDERR q{in inline_cpp_debug.pl, have \%main:: symbol table entry for my_subroutine() = '} . (\%main::)->{'my_subroutine'} . "'\n" or croak();

# METHOD CALL ALWAYS SUCCEEDS: "have $my_object->my_method() = 'RETVAL FROM my_subroutine()'"
my $my_object = RPerl::Test::Inline_CPP_Debug->new();
print STDERR "in inline_cpp_debug.pl, have \$my_object->my_method() = '" . $my_object->my_method() . "'\n" or croak();  # OO INTERFACE

# SUBROUTINE CALL FAILS WITH AUTOMATIC CLASSES OPTION: "Undefined subroutine &main::my_subroutine called"
print STDERR q{in inline_cpp_debug.pl, have my_subroutine() = '} . my_subroutine() . "'\n" or croak();

__DATA__
__CPP__
SV* my_subroutine() { return(newSVpv("RETVAL FROM my_subroutine()", 25)); }

// DELETING C++ CLASS BELOW (AND OBJECT/METHOD CALLS IN PERL ABOVE) ALLOWS SUBROUTINE CALL TO SUCCEED, REGARDLESS OF CLASSES OPTION
class RPerl__Test__Inline_CPP_Debug
{
public:
    SV* my_method() { return my_subroutine(); }
    RPerl__Test__Inline_CPP_Debug() {}
    ~RPerl__Test__Inline_CPP_Debug() {}
};