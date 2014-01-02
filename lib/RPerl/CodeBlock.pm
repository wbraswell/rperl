## no critic qw(ProhibitMultiplePackages)  ## RPERL SYSTEM types, allow multiple packages
## no critic qw(Capitalization)  ## RPERL SYSTEM types, allow lowercase packages
package RPerl::CodeBlock;
use strict;
use warnings;
our $VERSION = 0.000_010;
use Carp;
use RPerl;
use parent qw(RPerl::GrammarRule);
our %properties = (); ## no critic qw(ProhibitPackageVars)  ## RPERL SYSTEM, allow OO properties

# [[[ SUB-TYPES ]]]

package RPerl::CodeReference;

# NEED ADDRESS: which inheritance???
use parent qw(RPerl::DataStructure RPerl::DataType::Modifier::Reference);

#use parent qw(RPerl::DataType::Modifier::Reference);

# code is runnable source code or some derivative thereof
# ref to code
package code_ref;

#use parent qw(RPerl::DataStructure::CodeReference);
use base qw(RPerl::DataStructure::CodeReference);

# ref to (code with const contents)
package const_code_ref;

#use parent qw(code_ref const);
use base qw(code_ref const);

# NEED UPGRADE: mst wants us to fake %INC instead of use base here

1;
