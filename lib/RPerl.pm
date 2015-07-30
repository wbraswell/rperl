# [[[ HEADER SPECIAL ]]]
package RPerl;
use strict;
use warnings;

# DEV NOTE, CORRELATION #16: RPerl's underscore-is-comma (not CPAN's underscore-is-beta) numbering scheme utilized here
our $VERSION = 1.000_007;    # ONE POINT OH FULL RELEASE!!  It may not be Christmas, but it sure is INDEPENDENCE DAY!!!

#our $VERSION = 20150709;    # NON-RELEASE VERSION NUMBER, OFFICIAL LONGDATE
#our $VERSION = 2015.190;    # NON-RELEASE VERSION NUMBER, OFFICIAL STARDATE

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
use re;
use IPC::Cmd;
use English;

# actually used in this file
use File::Basename;
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
# so we can't use RPerl::diag, RPerl types, or subroutines in this files
use RPerl::AfterFilter;

use Module::ScanDeps;

our $INC_SCANNED = {};  # global variable to avoid repeated calls to scan_deps()

sub filter {
    ( my $input ) = @_;

    my $output = q{};

    my $namespace_guess;
    my $dependencies;
    my $dependencies_rperl                   = {};
    my $dependencies_rperl_package_names     = [];
    my $dependencies_nonsystem               = {};
    my $dependencies_nonsystem_package_names = [];
    my $inc_skip                             = {};

    # pre-generate $inc_skip to use in this file and in Module::ScanDeps::scan_deps()
    foreach my $included_filename_short ( sort keys %INC ) {

# START HERE: remove split strategy here (and elsewhere), replace with fileparse strategy from below in this file, allow full filter() on RPerl::Test::*
# START HERE: remove split strategy here (and elsewhere), replace with fileparse strategy from below in this file, allow full filter() on RPerl::Test::*
# START HERE: remove split strategy here (and elsewhere), replace with fileparse strategy from below in this file, allow full filter() on RPerl::Test::*

        my $included_filename_short_split = [ ( split /\./, $included_filename_short ) ];
        $namespace_guess               = $included_filename_short_split->[0];
        $included_filename_short_split = [ ( split /\//, $namespace_guess ) ];
        $namespace_guess               = $included_filename_short_split->[0];
        $namespace_guess .= '::';
        if (   ( exists $rperlnamespaces_generated::CORE->{$namespace_guess} )
            or ( exists $rperlnamespaces_generated::RPERL_DEPS->{$namespace_guess} )
            or ( exists $rperlnamespaces_generated::RPERL->{$namespace_guess} ) )
        {
            $inc_skip->{$included_filename_short} = $INC{$included_filename_short};
        }
    }
    $inc_skip = {%{$inc_skip}, %{$INC_SCANNED}};

#    my $rand_serial = rand();
#    print {*STDERR} 'in RPerl::filter(), $rand_serial = ' . $rand_serial . ', have $INC_SCANNED = ' . Dumper( $INC_SCANNED ) . "\n";
#    print {*STDERR} 'in RPerl::filter(), have $inc_skip = ' . Dumper( $inc_skip ) . "\n";
#    print {*STDERR} 'in RPerl::filter(), have [sort keys %{$inc_skip}] = ' . Dumper( [ sort keys %{$inc_skip} ] ) . "\n";

    # generate $dependencies_rperl & $dependencies_nonsystem
    foreach my $included_filename_short ( sort keys %INC ) {
        if ( not exists $inc_skip->{$included_filename_short} ) {
            $INC_SCANNED->{$included_filename_short} = $INC{$included_filename_short};
#            print {*STDERR} 'in RPerl::filter(), $rand_serial = ' . $rand_serial . ', SCANNING non-system $included_filename_short = ' . $included_filename_short . "\n";

            # DEV NOTE: Easter Egg!!  scan_deps() plus filter() equals recursive source filtering!!!
            $dependencies = scan_deps( files => [ $INC{$included_filename_short} ], skip => { reverse %{$inc_skip} }, recurse => 1, execute => 0 );

#            print {*STDERR} 'in RPerl::filter(), have $INC{$included_filename_short} = ' . $INC{$included_filename_short} . ' and $dependencies = ' . Dumper($dependencies) . "\n";
#            print {*STDERR} 'in RPerl::filter(), have $INC{$included_filename_short} = ' . $INC{$included_filename_short} . ' and [sort keys %{$dependencies}] = ' . Dumper( [ sort keys %{$dependencies} ] ) . "\n";

=DISABLE
            foreach my $dependency_filename_short ( sort keys %{$dependencies} ) {
                my $dependency_filename_short_split = [ ( split /\./, $dependency_filename_short ) ];
                $namespace_guess                 = $dependency_filename_short_split->[0];
                $dependency_filename_short_split = [ ( split /\//, $namespace_guess ) ];
                $namespace_guess                 = $dependency_filename_short_split->[0];
                $namespace_guess .= '::';

                if ( exists $rperlnamespaces_generated::RPERL->{$namespace_guess} ) {
                    $dependencies_rperl->{$dependency_filename_short} = $dependencies->{$dependency_filename_short};
                }
                elsif ( ( not exists $rperlnamespaces_generated::CORE->{$namespace_guess} )
                    and ( not exists $rperlnamespaces_generated::RPERL_DEPS->{$namespace_guess} )
                    and ( not exists $rperlnamespaces_generated::RPERL->{$namespace_guess} )
                    and ( $dependency_filename_short ne $included_filename_short )
                    and ( not exists $dependencies_nonsystem->{$dependency_filename_short} ) )
                {
                    $dependencies_nonsystem->{$dependency_filename_short} = $dependencies->{$dependency_filename_short};
                }
            }
=cut
        }

        #        else { print {*STDERR} 'in RPerl::filter(), SKIPPING system $included_filename_short = ' . $included_filename_short . "\n"; }
    }

#    print {*STDERR} 'in RPerl::filter(), have %INC = ' . Dumper( \%INC ) . "\n";
#    print {*STDERR} 'in RPerl::filter(), have [sort keys %{$dependencies_rperl}] = ' . Dumper(     [ sort keys %{$dependencies_rperl} ] ) . "\n";
#    print {*STDERR} 'in RPerl::filter(), have [sort keys %{$dependencies_nonsystem}] = ' . Dumper( [ sort keys %{$dependencies_nonsystem} ] ) . "\n";

#    print {*STDERR} 'in RPerl::filter(), have $dependencies_rperl = ' . Dumper($dependencies_rperl) . "\n";
#    print {*STDERR} 'in RPerl::filter(), have $dependencies_nonsystem = ' . Dumper($dependencies_nonsystem) . "\n";





=DISABLE

    # generate $dependencies_rperl_package_names
    foreach my $dependency_rperl_filename_short ( sort keys %{$dependencies_rperl} ) {

#        print {*STDERR} 'in RPerl::filter(), have $dependency_rperl_filename_short = ' . $dependency_rperl_filename_short . "\n";
        ( my $dependency_rperl_filename_prefix, my $dependency_rperl_filename_path, my $dependency_rperl_filename_suffix ) = fileparse( $dependency_rperl_filename_short, qr/[.][^.]*/xms );
        if ( $dependency_rperl_filename_suffix ne '.pm' ) {
            next;
        }
 
        my $dependency_rperl_filename_path_split;
        if ( $OSNAME eq 'MSWin32' ) {
            $dependency_rperl_filename_path_split = [split /\\/, $dependency_rperl_filename_path];
            shift @{$dependency_rperl_filename_path_split};  # discard leading drive letter
        }
        else
        {
            $dependency_rperl_filename_path_split = [split /\//, $dependency_rperl_filename_path];
        }
        my $dependency_rperl_package_name = join '::', (@{$dependency_rperl_filename_path_split}, $dependency_rperl_filename_prefix);
        
        # force pre-loading so they make it into %INC 
        eval 'use ' . $dependency_rperl_package_name . ';';

        my $dependency_rperl_filename_long = $INC{$dependency_rperl_filename_short};

        print {*STDERR} 'in RPerl::filter(), have $dependency_rperl_filename_long = ' . $dependency_rperl_filename_long . "\n";

        open my $DEPENDENCY_RPERL_FILE, '<', $dependency_rperl_filename_long or croak $OS_ERROR;
        my $dependency_rperl_file_line;
        $dependency_rperl_package_name = q{};
        while ( $dependency_rperl_file_line = <$DEPENDENCY_RPERL_FILE> ) {
            chomp $dependency_rperl_file_line;

            # NEED FIX: add two-line package declaration support???
            if ( $dependency_rperl_file_line =~ /^\s*package\s+(.*)\s*;/xms ) {
                $dependency_rperl_package_name = $1;
            }
            elsif ( ( $dependency_rperl_file_line =~ /^\s*use\s+parent/xms ) and ( $dependency_rperl_package_name ne q{} ) ) {
                push @{$dependencies_rperl_package_names}, $dependency_rperl_package_name;
                $dependency_rperl_package_name = q{};    # don't double-activate a class if it erroneously have multiple 'use parent' statements
            }
        }
        close $DEPENDENCY_RPERL_FILE or croak $OS_ERROR;
    }

    print {*STDERR} 'in RPerl::filter(), have $dependencies_rperl_package_names = ' . Dumper($dependencies_rperl_package_names) . "\n";
    print {*STDERR} 'in RPerl::filter(), have $dependencies_nonsystem_package_names = ' . Dumper($dependencies_nonsystem_package_names) . "\n";

=cut

#    print {*STDERR} "\n" . 'in RPerl::filter(), have pre-modification $input = ' . "\n" . '<<<<<<<<<<<<<<<<================ BEGIN INPUT FILE ================>>>>>>>>>>>>>>' . "\n" . $input . '<<<<<<<<<<<<<<<<================ END INPUT FILE ================>>>>>>>>>>>>>>' . "\n\n";

    foreach my $input_line ( split /\n/, $input ) {
        if ( $input_line =~ /^\s*package\s+(.*)\s*;/xms ) {
            my $package_split = [ ( split /::/, $1 ) ];
            my $namespace_guess = $package_split->[0];
            $namespace_guess .= '::';

#            print {*STDERR} q{in RPerl::filter(), have $namespace_guess = '} . $namespace_guess . "'\n";
#            print {*STDERR} 'in RPerl::filter(), have $rperlnamespaces_generated::CORE = ' . Dumper($rperlnamespaces_generated::CORE) . "\n";
#            print {*STDERR} 'in RPerl::filter(), have $rperlnamespaces_generated::RPERL_DEPS = ' . Dumper($rperlnamespaces_generated::RPERL_DEPS) . "\n";
#            print {*STDERR} 'in RPerl::filter(), have $rperlnamespaces_generated::RPERL = ' . Dumper($rperlnamespaces_generated::RPERL) . "\n";
#            print {*STDERR} 'in RPerl::filter(), have $rperlnamespaces_generated::CORE->{' . $namespace_guess . '} = ' . Dumper($rperlnamespaces_generated::CORE->{$namespace_guess}) . "\n";
#            print {*STDERR} 'in RPerl::filter(), have $rperlnamespaces_generated::RPERL_DEPS->{' . $namespace_guess . '} = ' . Dumper($rperlnamespaces_generated::RPERL_DEPS->{$namespace_guess}) . "\n";
#            print {*STDERR} 'in RPerl::filter(), have $rperlnamespaces_generated::RPERL->{' . $namespace_guess . '} = ' . Dumper($rperlnamespaces_generated::RPERL->{$namespace_guess}) . "\n";

            if (    ( not exists $rperlnamespaces_generated::CORE->{$namespace_guess} )
                and ( not exists $rperlnamespaces_generated::RPERL_DEPS->{$namespace_guess} )
                and ( not exists $rperlnamespaces_generated::RPERL->{$namespace_guess} ) )
            {
                #                print {*STDERR} 'in RPerl::filter(), enabling subclasses for package ' . $1 . "\n";

                my $input_line_prepend = $input_line . "\n";
                $input_line_prepend .= 'use RPerl::Config;' . "\n";
                $input_line_prepend .= 'use RPerl::AfterFilter;' . "\n";
                $input_line_prepend .= '1;' . "\n";
                my $subclasses = {
                    '_arrayref'         => [ 'RPerl::DataStructure::Array',          'arrayref' ],
                    '_hashref'          => [ 'RPerl::DataStructure::Hash',           'hashref' ],
                    '::method'          => [ 'RPerl::CodeBlock::Subroutine::Method', 'method' ],
                    '_arrayref::method' => [ 'RPerl::CodeBlock::Subroutine::Method', 'method' ],
                    '_hashref::method'  => [ 'RPerl::CodeBlock::Subroutine::Method', 'method' ],
                };
                foreach my $subclass_key ( sort keys %{$subclasses} ) {
                    $input_line_prepend .= 'package ' . $1 . $subclass_key . ';' . "\n";

                    #                    $input_line_prepend .= 'use strict;' . "\n";
                    #                    $input_line_prepend .= 'use warnings;' . "\n";
                    #                    $input_line_prepend .= 'use RPerl::AfterFilter;' . "\n";
                    $input_line_prepend .= 'use ' . $subclasses->{$subclass_key}->[0] . ';' . "\n";
                    $input_line_prepend .= 'use parent -norequire, qw(' . $subclasses->{$subclass_key}->[1] . ');' . "\n";
                    $input_line_prepend .= '1;' . "\n";
                }
                $input_line = $input_line_prepend . $input_line . "\n";

                # DEV NOTE: perl calls filter() but perlcritic does not, '## no critic...' & 'use strict' can be passed to perl but not perlcritic,
                # so we must still put critics & strict in every RPerl file;
                # 'use warnings' is checked by perl but not perlcritic, so it can be passed to perl and not put in every RPerl file;
                #                $input_line .= 'use strict;' . "\n";
                #                $input_line .= 'use warnings;' . "\n";
                $input_line .= 'use RPerl::Config;' . "\n";
                $input_line .= 'use RPerl::AfterFilter;';

                #                print 'in RPerl::filter(), have modified $input_line = ' . "\n" . $input_line . "\n";
            }
=DISABLE
            elsif ( exists $rperlnamespaces_generated::RPERL->{$namespace_guess} ) {

                #                print {*STDERR} 'in RPerl::filter(), enabling RPerl::AfterFilter ONLY for package ' . $1 . "\n";

                #                $input_line .= 'use strict;' . "\n";
                #                $input_line .= 'use warnings;' . "\n";
                $input_line .= "\n" . 'use RPerl::Config;';
                $input_line .= "\n" . 'use RPerl::AfterFilter;';

                #                print 'in RPerl::filter(), have modified $input_line = ' . "\n" . $input_line . "\n";
            }
=cut

            #            else { print {*STDERR} 'in RPerl::filter(), NOT enabling subclasses or RPerl::AfterFilter for package ' . $1 . "\n"; }
        }
        $output .= $input_line . "\n";
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
