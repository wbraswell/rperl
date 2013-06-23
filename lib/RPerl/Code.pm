use strict;  use warnings; 
package RPerl::Code;

package RPerl::CodeReference;
# NEED ADDRESS: which inheritance???
our @ISA = ('RPerl::DataStructure', 'RPerl::DataType::Modifier::Reference');
#our @ISA = ('RPerl::DataType::Modifier::Reference');
use RPerl::DataStructure;

# code is runnable source code or some derivative thereof
# ref to code
package code_ref;
our @ISA = ('RPerl::DataStructure::CodeReference'); 

# ref to (code with const contents)
package const_code_ref;
our @ISA = ('code_ref', 'const');