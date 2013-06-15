use strict; use warnings;
package RPerl::Algorithm::Sort::Bubble_cpp;
package RPerl::Algorithm::Sort;  # begin namespace hack, want to use ...Sort::Bubble->new(), not ...Sort::Bubble_cpp::Bubble->new()

use Inline
(
#        CPP => './Bubble.cpp',
#        CPP => 'RPerl/Algorithm/Sort/Bubble.cpp',
        CPP => '/home/wbraswell/austin_perl_mongers/compiler/RPerl/RPerl-latest/lib/RPerl/Algorithm/Sort/Bubble.cpp',
        CCFLAGS => '-Wno-deprecated',  # old-style-header warnings, suppress
        BUILD_NOISY => 1,
        CLEAN_AFTER_BUILD => 0,
        WARNINGS => 1,
);

package RPerl::Algorithm::Sort::Bubble_cpp;  # end namespace hack
1;