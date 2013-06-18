package RPerl::DataStructure::Code;
use strict;  use warnings; 


package RPerl::DataStructure::CodeReference;
our @ISA = ('RPerl::DataStructure', 'RPerl::DataType::Reference');
use RPerl::DataStructure;
use RPerl::DataType::Reference;


package code_ref;
our @ISA = ('RPerl::DataStructure::CodeReference'); 
use RPerl::DataStructure::Code;


package code_ref__method;
our @ISA = ('method');