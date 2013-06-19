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

# NEED ANSWER: only include through Perl because of namespace hack?
####use RPerl::Algorithm::Sort;
#use RPerl::Algorithm::Sort__cpp;


=DEBUG
use Data::Dumper;
#print "in Bubble_cpp.pm, after use Inline(...), have \%INC =\n" . Dumper(\%INC) . "\n";
no strict;
foreach my $entry ( keys %main:: )
{
	if (defined(${$entry})) { print "in Bubble_cpp.pm, after use Inline(...), symtab entry '$entry' is defined scalar\n"; }
    elsif (defined(@{$entry})) { print "in Bubble_cpp.pm, after use Inline(...), symtab entry '$entry' is defined array\n"; }
    elsif (defined(%{$entry})) { print "in Bubble_cpp.pm, after use Inline(...), symtab entry '$entry' is defined hash\n"; }
    elsif (defined(&{$entry})) { print "in Bubble_cpp.pm, after use Inline(...), symtab entry '$entry' is defined sub\n"; }
    else { print "in Bubble_cpp.pm, after use Inline(...), symtab entry '$entry' is SOMETHING ELSE\n"; }
}
=cut

package RPerl::Algorithm::Sort::Bubble_cpp;  # end namespace hack
1;