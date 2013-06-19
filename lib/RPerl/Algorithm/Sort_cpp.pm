use strict; use warnings;
package RPerl::Algorithm::Sort_cpp;
package RPerl::Algorithm;  # begin namespace hack

use Inline
(
#        CPP => './Sort.cpp',
#        CPP => 'RPerl/Algorithm/Sort.cpp',
        CPP => '/home/wbraswell/austin_perl_mongers/compiler/RPerl/RPerl-latest/lib/RPerl/Algorithm/Sort.cpp',
        CCFLAGS => '-Wno-deprecated',  # old-style-header warnings, suppress
        BUILD_NOISY => 1,
        CLEAN_AFTER_BUILD => 0,
        WARNINGS => 1,
);


package RPerl::Algorithm::Sort_cpp;  # end namespace hack
1;