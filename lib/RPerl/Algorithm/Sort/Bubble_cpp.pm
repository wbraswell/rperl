use strict; use warnings;
package RPerl::Algorithm::Sort::Bubble_cpp;

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

1;