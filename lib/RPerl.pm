# [[[ HEADER SPECIAL ]]]
package RPerl;
use strict;
use warnings;

# DEV NOTE, CORRELATION #16: RPerl's underscore-is-comma (not CPAN's underscore-is-beta) numbering scheme utilized here
our $VERSION = 1.000_003;    # ONE POINT OH FULL RELEASE!!  It may not be Christmas, but it sure is INDEPENDENCE DAY!!!
#our $VERSION = 20150707;    # NON-RELEASE VERSION NUMBER, OFFICIAL LONGDATE
#our $VERSION = 2015.188;    # NON-RELEASE VERSION NUMBER, OFFICIAL STARDATE

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt
## no critic qw(ProhibitStringyEval)  # SYSTEM DEFAULT 1: allow eval()
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES SPECIAL ]]]
require RPerl::Config;

#BEGIN { use Data::Dumper; print 'in RPerl.pm, have @INC = ' . "\n" . Dumper(\@INC) . "\n"; }

#no magic;  # require data types, full declarations, other non-magic
# DEV NOTE, CORRELATION #08: circular dependency causes "subroutine FOO redefined" errors, solved by replacing use with require below
#use rperltypes;
require rperltypes;
#require rperloperations;
#require rperlrules;
require rperlnames;
#require rperlnamespaces;

# NEED ADD: use/require HelperFunctions*.pm here (not just in rperltypes.pm) to match dependency path of C++ code?

1;    # end of class

__END__
=head1 NAME

RPerl Back-End Module

Restricted Perl, The Optimizing Perl 5 Compiler

=head1 SYNOPSIS

        use RPerl;

=head1 DESCRIPTION

B<RPerl> is a compiler.  For more info:

L<https://github.com/wbraswell/rperl/blob/master/README.md>

=head1 SEE ALSO

L<distribution/RPerl/script/rperl>

=head1 AUTHOR

B<William N. Braswell, Jr.>

L<mailto:wbraswell@NOSPAM.cpan.org>

=cut
