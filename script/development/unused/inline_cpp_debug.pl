#!/usr/bin/env perl

# AUTOMATIC CLASSES OPTION
#use Inline (CPP => 'DATA', classes => sub { join('::', split('__', shift)); } );

# MANUAL CLASSES OPTION
use Inline (CPP => 'DATA', classes => { 'RPerl__Test__Inline_CPP_Debug' => 'RPerl::Test::Inline_CPP_Debug'} );

# SUBROUTINE IS ALWAYS IN SYMBOL TABLE: "have \%main:: symbol table entry for my_subroutine() = '*main::my_subroutine'"
RPerl::diag(q{in inline_cpp_debug.pl, have \%main:: symbol table entry for my_subroutine() = '} . (\%main::)->{'my_subroutine'} . "'\n");

# METHOD CALL
my $my_object = RPerl::Test::Inline_CPP_Debug->new();
RPerl::diag("in inline_cpp_debug.pl, have \$my_object->my_method() = '" . $my_object->my_method() . "'\n");  # OO INTERFACE

# SUBROUTINE CALL
RPerl::diag(q{in inline_cpp_debug.pl, have my_subroutine() = '} . my_subroutine() . "'\n");

__DATA__
__CPP__
SV* my_subroutine() { return(newSVpv("RETVAL FROM my_subroutine()", 25)); }

class RPerl__Test__Inline_CPP_Debug
{
public:
    SV* my_method() { return my_subroutine(); }
    RPerl__Test__Inline_CPP_Debug() {}
    ~RPerl__Test__Inline_CPP_Debug() {}
};