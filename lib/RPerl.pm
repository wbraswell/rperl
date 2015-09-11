# [[[ HEADER SPECIAL ]]]
package RPerl;
use strict;
use warnings;

# DEV NOTE, CORRELATION #rp16: RPerl's underscore-is-comma (not CPAN's underscore-is-beta) numbering scheme utilized here
our $VERSION = 1.100_002;    # CODENAME JUPITER

#our $VERSION = 20150911;    # NON-RELEASE VERSION NUMBER, OFFICIAL LONGDATE
#our $VERSION = 2015.254;    # NON-RELEASE VERSION NUMBER, OFFICIAL STARDATE

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants
## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt
## no critic qw(ProhibitStringyEval)  # SYSTEM DEFAULT 1: allow eval()
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]

# NEED FIX: pre-load all RPerl deps instead of only these?
# force pre-loading so they make it into $inc_skip
use parent qw();
use IPC::Cmd;
use English;
#use re 'strict';  # doesn't work in all versions of Perl
use re 'taint';  # hopefully doesn't actually do anything!

# actually used in this file
use Data::Dumper;

#use base qw(Exporter);
use Filter::Simple;

#use Carp;
$Data::Dumper::Sortkeys = 1;    # Dumper() output must be sorted for lib/RPerl/Tests/Type_Types/* etc.

#use Exporter 'import';

#our @EXPORT = qw(croak Dumper $OSNAME);

FILTER { $_ = filter($_) };

use rperlnamespaces;

# DEV NOTE: causes circular (or other weird) dependencies, error "Subroutine import redefined...",
# so we can't use RPerl::diag, RPerl types, or subroutines in this files;
# UPDATE: and yet now it works (and in fact seems required) after further development, gotta love unpredictable high-magic code!  :-/
use RPerl::AfterSubclass;

use Module::ScanDeps;

our $INC_SCANNED = {};    # global variable to avoid repeated calls to scan_deps()

sub filter {
    ( my $input ) = @_;

    my $output = q{};
    my $namespace_root;
    my $package = q{};
    my $package_line = q{};
    my $post_package_lines = q{};
    my $use_parent_line = q{};

        my $dependencies;
    #    my $dependencies_rperl                   = {};
    #    my $dependencies_rperl_package_names     = [];
    #    my $dependencies_nonsystem               = {};
    #    my $dependencies_nonsystem_package_names = [];
    my $inc_skip = {};

    my $rand_serial = rand();

    # pre-generate $inc_skip to use in this file and in Module::ScanDeps::scan_deps()
    foreach my $included_filename_short ( sort keys %INC ) {
#        print {*STDERR} 'in RPerl::filter(), $rand_serial = ' . $rand_serial . ', top of $inc_skip loop, have $included_filename_short = ' . $included_filename_short . "\n";
        $namespace_root = filename_short_to_namespace_root_guess($included_filename_short);
#        print {*STDERR} 'in RPerl::filter(), $rand_serial = ' . $rand_serial . ', in $inc_skip loop, have $namespace_root = ' . $namespace_root . "\n";
        if (( $namespace_root ne q{} )
            and (  ( exists $rperlnamespaces_generated::CORE->{$namespace_root} )
                or ( exists $rperlnamespaces_generated::RPERL_DEPS->{$namespace_root} )
                or ( exists $rperlnamespaces_generated::RPERL->{$namespace_root} ) )
            )
        {
            # DEV NOTE, CORRELATION #rp19: need remove hard-coded allowance of RPerl::Test namespace, at least move to rperlnamespaces.pm or friends
            if ( $namespace_root eq 'RPerl::' ) {
#                $package = filename_short_to_package_guess($included_filename_short);
#                if ( $package !~ /^RPerl::Test/xms ) {
                if ( $included_filename_short !~ /^RPerl[\\\/]Test/xms ) {
#                    print {*STDERR} 'in RPerl::filter(), $rand_serial = ' . $rand_serial . ', in $inc_skip loop, noting-to-skip RPerl non-RPerl::Test $included_filename_short = ' . $included_filename_short . "\n";
                    $inc_skip->{$included_filename_short} = $INC{$included_filename_short};
                }
            }
            else {
#                print {*STDERR} 'in RPerl::filter(), $rand_serial = ' . $rand_serial . ', in $inc_skip loop, noting-to-skip non-RPerl $included_filename_short = ' . $included_filename_short . "\n";
                $inc_skip->{$included_filename_short} = $INC{$included_filename_short};
            }
        }
#        else { print {*STDERR} 'in RPerl::filter(), $rand_serial = ' . $rand_serial . ', in $inc_skip loop, NOT noting-to-skip $included_filename_short = ' . $included_filename_short . "\n"; }
    }
    $inc_skip = { %{$inc_skip}, %{$INC_SCANNED} };
    $package = q{};

#    print {*STDERR} 'in RPerl::filter(), $rand_serial = ' . $rand_serial . ', have $INC_SCANNED = ' . Dumper( $INC_SCANNED ) . "\n";
#    print {*STDERR} 'in RPerl::filter(), have $inc_skip = ' . Dumper( $inc_skip ) . "\n";
#    print {*STDERR} 'in RPerl::filter(), have [sort keys %{$inc_skip}] = ' . Dumper( [ sort keys %{$inc_skip} ] ) . "\n";

    # ORIGINAL PURPOSE: generate $dependencies_rperl & $dependencies_nonsystem
    # NEW PURPOSE: recursively filter all non-skipped dependencies and sub-dependencies
    foreach my $included_filename_short ( sort keys %INC ) {
        if ( not exists $inc_skip->{$included_filename_short} ) {
            $INC_SCANNED->{$included_filename_short} = $INC{$included_filename_short};

#            print {*STDERR} 'in RPerl::filter(), $rand_serial = ' . $rand_serial . ', SCANNING non-system $included_filename_short = ' . $included_filename_short . "\n";

            # DEV NOTE: Easter Egg!!  scan_deps() plus filter() equals recursive source filtering!!!
            $dependencies = scan_deps( files => [ $INC{$included_filename_short} ], skip => { reverse %{$inc_skip} }, recurse => 1, execute => 0 );
#            scan_deps( files => [ $INC{$included_filename_short} ], skip => { reverse %{$inc_skip} }, recurse => 1, execute => 0 );

#            print {*STDERR} 'in RPerl::filter(), have $INC{$included_filename_short} = ' . $INC{$included_filename_short} . ' and $dependencies = ' . Dumper($dependencies) . "\n";
#            print {*STDERR} 'in RPerl::filter(), have $INC{$included_filename_short} = ' . $INC{$included_filename_short} . ' and [sort keys %{$dependencies}] = ' . Dumper( [ sort keys %{$dependencies} ] ) . "\n";

        }
#        else { print {*STDERR} 'in RPerl::filter(), SKIPPING system $included_filename_short = ' . $included_filename_short . "\n"; }
    }

#    print {*STDERR} 'in RPerl::filter(), have $INC_SCANNED = ' . Dumper( $INC_SCANNED ) . "\n";
    #    print {*STDERR} 'in RPerl::filter(), have %INC = ' . Dumper( \%INC ) . "\n";
    #    print {*STDERR} 'in RPerl::filter(), have [sort keys %{$dependencies_rperl}] = ' . Dumper(     [ sort keys %{$dependencies_rperl} ] ) . "\n";
    #    print {*STDERR} 'in RPerl::filter(), have [sort keys %{$dependencies_nonsystem}] = ' . Dumper( [ sort keys %{$dependencies_nonsystem} ] ) . "\n";

    #    print {*STDERR} 'in RPerl::filter(), have $dependencies_rperl = ' . Dumper($dependencies_rperl) . "\n";
    #    print {*STDERR} 'in RPerl::filter(), have $dependencies_nonsystem = ' . Dumper($dependencies_nonsystem) . "\n";

#    print {*STDERR} "\n" . 'in RPerl::filter(), have pre-modification $input = ' . "\n" . '<<<<<<<<<<<<<<<<================ BEGIN INPUT FILE ================>>>>>>>>>>>>>>' . "\n" . $input . '<<<<<<<<<<<<<<<<================ END INPUT FILE ================>>>>>>>>>>>>>>' . "\n\n";

    # look for all user-defined classes, create subclasses
    foreach my $input_line ( split /\n/, $input ) {
        if ( $input_line =~ /^\s*package\s+(.*)\s*;/xms ) {

            # not all packages are classes
            $package_line = $input_line;
            $package = $1;
            $post_package_lines = q{};
            $output .= '# [[[ HEADER, PART 1 ]]]' . "\n";
            $output .= $input_line . "\n";

#            print {*STDERR} 'in RPerl::filter(), found $package_line = ' . $package_line . "\n";
#            print {*STDERR} 'in RPerl::filter(), found $package = ' . $package . "\n";
        }
        elsif ( ( $input_line =~ /^\s*use\s+parent/xms ) and ( $package ne q{} ) ) {
            # all classes are packages
            $use_parent_line = $input_line;
            $namespace_root = package_to_namespace_root($package);

#            print {*STDERR} q{in RPerl::filter(), have $namespace_root = '} . $namespace_root . "'\n";
#            print {*STDERR} 'in RPerl::filter(), have $rperlnamespaces_generated::CORE = ' . Dumper($rperlnamespaces_generated::CORE) . "\n";
#            print {*STDERR} 'in RPerl::filter(), have $rperlnamespaces_generated::RPERL_DEPS = ' . Dumper($rperlnamespaces_generated::RPERL_DEPS) . "\n";
#            print {*STDERR} 'in RPerl::filter(), have $rperlnamespaces_generated::RPERL = ' . Dumper($rperlnamespaces_generated::RPERL) . "\n";
#            print {*STDERR} 'in RPerl::filter(), have $rperlnamespaces_generated::CORE->{' . $namespace_root . '} = ' . Dumper($rperlnamespaces_generated::CORE->{$namespace_root}) . "\n";
#            print {*STDERR} 'in RPerl::filter(), have $rperlnamespaces_generated::RPERL_DEPS->{' . $namespace_root . '} = ' . Dumper($rperlnamespaces_generated::RPERL_DEPS->{$namespace_root}) . "\n";
#            print {*STDERR} 'in RPerl::filter(), have $rperlnamespaces_generated::RPERL->{' . $namespace_root . '} = ' . Dumper($rperlnamespaces_generated::RPERL->{$namespace_root}) . "\n";

            # DEV NOTE, CORRELATION #rp19: need remove hard-coded allowance of RPerl::Test namespace, at least move to rperlnamespaces.pm or friends
            if (    ($package =~ /RPerl::Test/xms)
                or ( ( not exists $rperlnamespaces_generated::CORE->{$namespace_root} )
                and ( not exists $rperlnamespaces_generated::RPERL_DEPS->{$namespace_root} )
                and ( not exists $rperlnamespaces_generated::RPERL->{$namespace_root} ) ) )
            {
#                print {*STDERR} 'in RPerl::filter(), enabling subclasses for $package = ' . $package . "\n";

                my $input_line_prepend = q{};
                $input_line_prepend .= '# <<<=== BEGIN $input_line_prepend ===>>>' . "\n";
                $input_line_prepend .= 'use RPerl::Config;' . "\n";
                $input_line_prepend .= 'use RPerl::AfterSubclass;' . "\n";
                $input_line_prepend .= '1;  # end class, original' . "\n";
                my $subclasses = {
                    '_raw'              => [ 'RPerl::DataType::Modifier::Reference', 'ref' ],
                    '_arrayref'         => [ 'RPerl::DataStructure::Array',          'arrayref' ],
                    '_hashref'          => [ 'RPerl::DataStructure::Hash',           'hashref' ],
                    '::method'          => [ 'RPerl::CodeBlock::Subroutine::Method', 'method' ],
                    '_arrayref::method' => [ 'RPerl::CodeBlock::Subroutine::Method', 'method' ],
                    '_hashref::method'  => [ 'RPerl::CodeBlock::Subroutine::Method', 'method' ],
                };
                $input_line_prepend .= "\n" . '# [[[ SUBCLASSES, AUTO-GENERATED ]]]' . "\n";
                foreach my $subclass_key ( sort keys %{$subclasses} ) {
                    $input_line_prepend .= 'package ' . $package . $subclass_key . ';' . "\n";

                    #                    $input_line_prepend .= 'use strict;' . "\n";
                    #                    $input_line_prepend .= 'use warnings;' . "\n";
                    #                    $input_line_prepend .= 'use RPerl::AfterSubclass;' . "\n";
                    $input_line_prepend .= 'use ' . $subclasses->{$subclass_key}->[0] . ';' . "\n";
                    $input_line_prepend .= 'use parent -norequire, qw(' . $subclasses->{$subclass_key}->[1] . ');' . "\n";
                    $input_line_prepend .= '1;  # end class, auto-generated subclass' . "\n";
                }
                $input_line_prepend .= '# <<<=== END $input_line_prepend ===>>>' . "\n";
                $input_line = $input_line_prepend . "\n";
                $input_line .= '# [[[ HEADER, PART 2 ]]]' . "\n";
                $input_line .= $package_line . "\n";
                $input_line .= '# <<<=== BEGIN $post_package_lines ===>>>' . "\n";
                $input_line .= $post_package_lines;  # append even if we don't enable subclasses
                $input_line .= '# <<<=== END $post_package_lines ===>>>' . "\n"; 
                $input_line .= $use_parent_line . "\n";

                # DEV NOTE: perl calls filter() but perlcritic does not, '## no critic...' & 'use strict' can be passed to perl but not perlcritic,
                # so we must still put critics & strict in every RPerl file;
                # 'use warnings' is checked by perl but not perlcritic, so it can be passed to perl and not put in every RPerl file;
                #                $input_line .= 'use strict;' . "\n";
                #                $input_line .= 'use warnings;' . "\n";
                $input_line .= 'use RPerl::Config;' . "\n";
                $input_line .= 'use RPerl::AfterSubclass;';

#               print {*STDERR} 'in RPerl::filter(), have modified $input_line = ' . "\n" . $input_line . "\n";
            }
#            else { print {*STDERR} 'in RPerl::filter(), NOT enabling subclasses or RPerl::AfterSubclass for $package = ' . $package . "\n"; }
            $output .= $input_line . "\n";
            $package = q{};
            $package_line = q{};
            $post_package_lines = q{};
        }
        elsif ( $package ne q{} ) {
            $post_package_lines .= $input_line . "\n";
        }
        else {
            $output .= $input_line . "\n";
        }
    }

    # package but not a class
    $output .= $post_package_lines;
    
    # replace fake SSE infix operators with their actually-overloaded single-character selves
    foreach my $sse_define_pair (['sse_add', '+'], ['sse_sub', '-'], ['sse_mul', '*'], ['sse_div', '/']) {
        $output =~ s/$sse_define_pair->[0]/$sse_define_pair->[1]/gxms;
    }

#    print {*STDERR} "\n" . 'in RPerl::filter(), have post-modification $output = ' . "\n" . '<<<<<<<<<<<<<<<<================ BEGIN OUTPUT FILE ================>>>>>>>>>>>>>>' . "\n" . $output . '<<<<<<<<<<<<<<<<================ END OUTPUT FILE ================>>>>>>>>>>>>>>' . "\n\n";

    return $output;
}

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

L<rperl>

=head1 AUTHOR

B<William N. Braswell, Jr.>

L<mailto:wbraswell@NOSPAM.cpan.org>

=cut
