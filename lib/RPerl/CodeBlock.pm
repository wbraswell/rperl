package RPerl::CodeBlock;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.000_011;

## no critic qw(Capitalization ProhibitMultiplePackages)  # SYSTEM DEFAULT 3: allow multiple lower case package names

use parent qw(RPerl::GrammarRule);
our %properties = (); ## no critic qw(ProhibitPackageVars)  # USER DEFAULT 3: allow OO properties

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
