#!/usr/bin/perl

# THIS FILE SHOWS HOW TO COPY ALL SUBROUTINES FROM ONE CLASS INTO ANOTHER CLASS AT RUNTIME

#=DISABLE
package ArrayDereference_220;
sub foosub { print "in foosub()!!!\n"; }
our $properties = {FAKE=>'property'};
1;

package main;
#=cut

use RPerl;
use RPerl::CompileUnit::Module::Header;
use RPerl::CompileUnit::Module::Class;
use RPerl::Parser;


=DISABLE
# LONG FORM
foreach my $symtab_entry (
    keys %RPerl::CompileUnit::Module::Header:: )
{
    print 'have $symtab_entry = ' . $symtab_entry . "\n";
    if (defined &{ $RPerl::CompileUnit::Module::Header::{ $symtab_entry} } )
    {
#        *{ ArrayDereference_220::{$symtab_entry} } = sub { return &{ $RPerl::CompileUnit::Module::Header::{$symtab_entry} }(@_); };  # DOES NOT WORK
        my $eval_string = '*{ ArrayDereference_220::' . $symtab_entry . q(} = sub { return &{ $RPerl::CompileUnit::Module::Header::{') . $symtab_entry . q<'} }(@_); };>;  # DOES WORK
        print 'have $eval_string = ' . "\n" . $eval_string . "\n";
        my $eval_retval = eval $eval_string;
        if (not defined $eval_retval) {croak $EVAL_ERROR;}
    }
}
=cut

=DISABLE
# MEDIUM FORM
foreach my $symtab_entry ( keys %RPerl::CompileUnit::Module::Header:: )
{
    if (defined &{ $RPerl::CompileUnit::Module::Header::{ $symtab_entry} } )
    {
        my $eval_string = '*{ ArrayDereference_220::' . $symtab_entry . q(} = sub { return &{ $RPerl::CompileUnit::Module::Header::{') . $symtab_entry . q<'} }(@_); };>;
        if (not defined eval $eval_string) {croak $EVAL_ERROR;}
    }
}
=cut

# SHORT FORM, DOUBLE EVAL'ED
my $class1 = 'ArrayDereference_220';
my $class2 = 'RPerl::CompileUnit::Module::Header';
my $eval_string = q[foreach my $key ( keys %] . $class2 . q[:: ) { if (defined &{ $] . $class2 . q[::{ $key} } ) { if (not defined eval q<*{] . $class1 . q[::> . $key . q<} = sub { return &{ $] . $class2 . q[::{'> . $key . q<'} }(@_); };>) {croak $EVAL_ERROR;} } }];
#print $eval_string;
eval $eval_string;

ArrayDereference_220::foosub();

#*{ArrayDereference_220::ast_to_rperl__generate} = sub {return &{ $RPerl::CompileUnit::Module::Header::{'ast_to_rperl__generate'} }(@_); };  # DOES WORK
#ArrayDereference_220::ast_to_rperl__generate({FAKE=>'object'}, {FAKE=>'ast'}, {FAKE=>'mode'});  # DOES WORK

#*{ArrayDereference_220::new} = &{$RPerl::CompileUnit::Module::Class::{'new'}};  # DOES NOT WORK?
*{ArrayDereference_220::new} = sub {return &{$RPerl::CompileUnit::Module::Class::{'new'}}(@_);};  # DOES WORK
ArrayDereference_220::new if 0;  # remove "used only once" warning

my $foo = ArrayDereference_220->new();  # DOES WORK
#my $foo = ArrayDereference_220::new('ArrayDereference_220');  # DOES WORK

$foo->ast_to_rperl__generate({FAKEMODE => 'bar'});