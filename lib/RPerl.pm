use rperltypesconv;  # DEV NOTE, CORRELATION #rp008: import from Exporter for code outside of a package or class

# [[[ HEADER SPECIAL ]]]
package RPerl;
use strict;
use warnings;

# DEV NOTE, CORRELATION #rp016: CPAN's underscore-is-beta (NOT RPerl's underscore-is-comma) numbering scheme utilized here, to preserve trailing zeros
our $VERSION = '7.000000';

#our $VERSION = 20200704;    # NON-RELEASE VERSION NUMBER, OFFICIAL LONGDATE
#our $VERSION = 2020.186;    # NON-RELEASE VERSION NUMBER, OFFICIAL STARDATE

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
#use re 'strict';  # doesn't work in all versions of Perl
use re 'taint';  # hopefully doesn't actually do anything!

# actually used in this file
use Data::Dumper;

use Filter::Simple;

$Data::Dumper::Sortkeys = 1;    # Dumper() output must be sorted for lib/RPerl/Tests/Type_Types/* etc.

FILTER { $_ = filter($_) };

use rperlnamespaces;

# DEV NOTE: causes circular (or other weird) dependencies, error "Subroutine import redefined...",
# so we can't use RPerl::diag, RPerl types, or subroutines in this files;
# UPDATE: and yet now it works (and in fact seems required) after further development, gotta love unpredictable high-magic code!  :-/
use RPerl::AfterSubclass;

use Module::ScanDeps;

our $INC_SCANNED = {};    # global variable to avoid repeated calls to scan_deps()

sub filter {
    ( my $input ) = @ARG;

    my $modified_tag = '# [[[<<< AUTOMATICALLY MODIFIED BY RPerl::filter() >>>]]]';
    if ((index $input, $modified_tag) > 0) {
#       print {*STDERR} "\n", 'in RPerl::filter(), file already modified here, SKIPPING', "\n";
       return $input; 
    }

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

#    print {*STDERR} 'in RPerl::filter(), $rand_serial = ' . $rand_serial . ', near top of subroutine', "\n";

    # pre-generate $inc_skip to use in this file and in Module::ScanDeps::scan_deps()
    foreach my $included_filename_short ( sort keys %INC ) {
#        print {*STDERR} 'in RPerl::filter(), $rand_serial = ' . $rand_serial . ', top of $inc_skip loop, have $included_filename_short = ' . $included_filename_short . "\n";

        # skip AutoSplit index files
        if ((substr $included_filename_short, -12, 12) eq 'autosplit.ix') {
#            print {*STDERR} 'in RPerl::filter(),     skipping Autosplit file, have $included_filename_short = ' . $included_filename_short . "\n";
            $inc_skip->{$included_filename_short} = $INC{$included_filename_short};
            next;
        }

        # do NOT skip files which have been explicitly named as "Compilable"
        if ((substr $included_filename_short, -13, 13) eq 'Compilable.pm'){
#            print {*STDERR} 'in RPerl::filter(), not skipping explicitly named Compilable file, have $included_filename_short = ' . $included_filename_short . "\n";
            next;
        }

        $namespace_root = filename_short_to_namespace_root_guess($included_filename_short);
#        print {*STDERR} 'in RPerl::filter(), $rand_serial = ' . $rand_serial . ', in $inc_skip loop, have $namespace_root = ' . $namespace_root . "\n";
        if (( $namespace_root ne q{} )
            and (  ( exists $rperlnamespaces_generated::NONCOMPILED->{$namespace_root} )
                or ( exists $rperlnamespaces_generated::CORE->{$namespace_root} )
                or ( exists $rperlnamespaces_generated::RPERL_DEPS->{$namespace_root} )
                or ( exists $rperlnamespaces_generated::RPERL->{$namespace_root} ) )
            )
        {
            # DEV NOTE, CORRELATION #rp019: need remove hard-coded allowance of RPerl::Test namespace, at least move to rperlnamespaces.pm or friends
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

#    print {*STDERR} "\n" . 'in RPerl::filter(), have pre-modification $input = ' . "\n" . '<<<<<<<<<<<<<<<<================ BEGIN INPUT FILE ================>>>>>>>>>>>>>>' . "\n" . $input . "\n" . '<<<<<<<<<<<<<<<<================ END INPUT FILE ================>>>>>>>>>>>>>>' . "\n\n";

    # 'package' statement may be split across 2 lines
    my $input_line_partial = q{};

    # look for all user-defined classes, create subclasses
    foreach my $input_line ( split /\n/, $input ) {
#        print {*STDERR} 'in RPerl::filter(), have $input_line = ' . $input_line . "\n";
#        print {*STDERR} 'in RPerl::filter(), have $input_line_partial = ' . $input_line_partial . "\n";

        if ($input_line_partial ne q{}) {
            $input_line = $input_line_partial . q{ } . $input_line;
            $input_line_partial = q{};
        }
        
        # partial package line, allow to be split over 2 lines to disable CPAN indexing, discard comments
        if ( $input_line =~ /^\s*(package)\s*(?:\#.*)?\s*$/xms ) {
            $input_line_partial = $1;
        }
        elsif ( $input_line =~ /^\s*package\s+(.*)\s*;/xms ) {
            if ($package ne q{}) {
                # multiple packages in one module file
                $output .= $post_package_lines;
            }

            # not all packages are classes
            $package_line = $input_line;
            $package = $1;
            $post_package_lines = q{};
            $output .= '# [[[ HEADER, PART 1 ]]]' . "\n";
            $output .= $input_line . "\n";
            $output .= 'use rperltypesconv;' . "\n";  # DEV NOTE, CORRELATION #rp008: import from Exporter for code inside of a package or class
            $output .= 'use RPerl::Config;' . "\n";  # DEV NOTE, CORRELATION #rp034: enable @ARG in all packages (class & non-class)

#            print {*STDERR} 'in RPerl::filter(), found $package_line = ' . $package_line . "\n";
#            print {*STDERR} 'in RPerl::filter(), found $package = ' . $package . "\n";
        }
        elsif ( ( $input_line =~ /^\s*use\s+parent/xms ) and ( $package ne q{} ) ) {
            # all classes are packages
            $use_parent_line = $input_line;
            $namespace_root = package_to_namespace_root($package);

#            print {*STDERR} q{in RPerl::filter(), have $package = '} . $package . "'\n";
#            print {*STDERR} q{in RPerl::filter(), have $namespace_root = '} . $namespace_root . "'\n";
#            print {*STDERR} 'in RPerl::filter(), have $rperlnamespaces_generated::CORE = ' . Dumper($rperlnamespaces_generated::CORE) . "\n";
#            print {*STDERR} 'in RPerl::filter(), have $rperlnamespaces_generated::RPERL_DEPS = ' . Dumper($rperlnamespaces_generated::RPERL_DEPS) . "\n";
#            print {*STDERR} 'in RPerl::filter(), have $rperlnamespaces_generated::RPERL = ' . Dumper($rperlnamespaces_generated::RPERL) . "\n";
#            print {*STDERR} 'in RPerl::filter(), have $rperlnamespaces_generated::CORE->{' . $namespace_root . '} = ' . Dumper($rperlnamespaces_generated::CORE->{$namespace_root}) . "\n";
#            print {*STDERR} 'in RPerl::filter(), have $rperlnamespaces_generated::RPERL_DEPS->{' . $namespace_root . '} = ' . Dumper($rperlnamespaces_generated::RPERL_DEPS->{$namespace_root}) . "\n";
#            print {*STDERR} 'in RPerl::filter(), have $rperlnamespaces_generated::RPERL->{' . $namespace_root . '} = ' . Dumper($rperlnamespaces_generated::RPERL->{$namespace_root}) . "\n";

            # DEV NOTE, CORRELATION #rp019: need remove hard-coded allowance of RPerl::Test namespace, at least move to rperlnamespaces.pm or friends
            if (    
                ($package =~ /RPerl::Test/xms) or 
                ($package eq 'RPerl::CompileUnit::Module::Class::Template') or ( 
                    ( not exists $rperlnamespaces_generated::CORE->{$namespace_root} ) and 
                    ( not exists $rperlnamespaces_generated::RPERL_DEPS->{$namespace_root} ) and 
                    ( not exists $rperlnamespaces_generated::RPERL->{$namespace_root} ) ) )
            {
#                print {*STDERR} 'in RPerl::filter(), enabling subclasses for $package = ' . $package . "\n"; 

                my $input_line_prepend = q{};
                $input_line_prepend .= '# <<<=== BEGIN $input_line_prepend ===>>>' . "\n";
#                $input_line_prepend .= 'use RPerl::Config;' . "\n";  # DEV NOTE, CORRELATION #rp034: enable @ARG in all packages (class & non-class)
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

    # final package (not class)
    $output .= $post_package_lines;

    # replace fake SSE infix operators with their actually-overloaded single-character selves
    foreach my $sse_define_pair (['sse_add', '+'], ['sse_sub', '-'], ['sse_mul', '*'], ['sse_div', '/']) {
        $output =~ s/$sse_define_pair->[0]/$sse_define_pair->[1]/gxms;
    }

    # append modified tag at the end, so it will show up in repeated calls to 'use RPerl;' in a multi-package module
    $output .= "\n" . $modified_tag . "\n";

#    print {*STDERR} "\n" . 'in RPerl::filter(), have post-modification $output = ' . "\n" . '<<<<<<<<<<<<<<<<================ BEGIN OUTPUT FILE ================>>>>>>>>>>>>>>' . "\n" . $output . '<<<<<<<<<<<<<<<<================ END OUTPUT FILE ================>>>>>>>>>>>>>>' . "\n\n";

    return $output;
}

1;    # end of class

__END__

=encoding utf8

=for comment DEV NOTE: BEGIN INLINE CSS DIV

=begin html

<div id="scoped-content"><style type="text/css" scoped>

table.rperl {
    border-style: solid;
    border-width: 2px;
}

table.rperl > tbody > tr > th {
    background-color: #e0e0e0;
    text-align: center;
}

table.rperl > tbody > tr:nth-child(odd)  { background-color: #f5f5f5; }
table.rperl > tbody > tr:nth-child(even) { background-color: #ffffff; }

table.rperl > tbody > tr > th, td {
    border-style: solid;
    border-width: 1px;
    border-color: #cccccc;
    padding: 5px;
}

/* disable ".pod p" margins inside tables only */
table.rperl > tbody > tr > th > p { margin: 0px; }
table.rperl > tbody > tr > td > p { margin: 0px; }

/* right alignment for numeric precedence column of operators tables */
table.operators > tbody > tr > td:nth-child(5)  { text-align: right; }

</style>

=end html

=head1 NAME

RPerl L<Quick-Start Checklist|/"QUICK-START CHECKLIST"> & L<Guide|/"QUICK-START GUIDE">

Restricted Perl, The Optimizing Perl 5 Compiler

=head1 DESCRIPTION

B<RPerl> is a compiler.  For general info:

L<https://github.com/wbraswell/rperl/blob/master/README.md>

L<http://rperl.org>

=head1 SYNOPSIS, PERL PROGRAM, INPUT CODE

Filename F<my_program.pl>:

    #!/usr/bin/env perl
    
    # My Program Name
    # My Program Description
    
    # [[[ PREPROCESSOR ]]]
    # <<< TYPE_CHECKING: TRACE >>>
    
    # [[[ HEADER ]]]
    use RPerl;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;
    
    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
    ## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
    ## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants
    
    # [[[ INCLUDES ]]]
    use My::FooPackage qw(foo_exported_ok);
    use My::BarClass;
    
    # [[[ CONSTANTS ]]]
    use constant PI  => my number $TYPED_PI  = 3.141_59;
    use constant PIE => my string $TYPED_PIE = 'pecan';
    
    # [[[ SUBROUTINES ]]]
    sub pies_are_round {
        { my void $RETURN_TYPE };
        print 'in pies_are_round(), having PIE() = ', PIE(), "\n";
        return;
    }
    
    sub pi_r_squared {
        { my number $RETURN_TYPE };
        ( my number $r ) = @ARG;
        my number $area = PI() * $r ** 2;
        print 'in pi_r_squared(), have $area = PI() * $r ** 2 = ', $area, "\n";
        return $area;
    }
    
    # [[[ OPERATIONS ]]]
    pies_are_round();
    my number $area = pi_r_squared(23.456_789);

    foo_exported_ok(42);
    print My::PackageFoo::foo_not_exported(3), "\n";

    my My::BarClass $bar_object = My::BarClass->new(bar_number => 21.12, bar_string => 'howdy');
    $bar_object->bar_method1(3);
    my number $bar_method2_retval = $bar_object->bar_method2(5);

=head1 SYNOPSIS, PERL PROGRAM, COMPILE & EXECUTE

=for rperl X<noncode>

    $ rperl -V my_program.pl
    $ ./my_program

=for rperl X</noncode>

=head1 SYNOPSIS, PERL MODULES, INPUT CODE

Filename F<My/FooPackage.pm>:

    # [[[ HEADER ]]]
    use RPerl;
    package My::FooPackage;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;
    
    # [[[ EXPORTS ]]]
    use RPerl::Exporter qw(import);
    our @EXPORT_OK = qw(foo_exported_ok);
    
    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
    ## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
    ## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants
    
    # [[[ INCLUDES ]]]
    use My::OtherPackage;  # implementation left as an exercise for the user
    use My::OtherClass;    # ditto
    
    # [[[ CONSTANTS ]]]
    use constant FOO_CONSTANT => my string $TYPED_FOO_CONSTANT = 'foo constant data';
    
    # [[[ SUBROUTINES ]]]
    
    sub foo_exported_ok {
        { my void $RETURN_TYPE };
        ( my integer $arg ) = @ARG;
        print 'in My::FooPackage::foo_exported_ok(), received $arg = ', $arg, "\n";
        return;
    }
    
    sub foo_not_exported {
        { my string $RETURN_TYPE };
        ( my integer $arg ) = @ARG;
        print 'in My::FooPackage::foo_exported_ok(), received $arg = ', $arg, "\n";
        return('howdy' x $arg);
    }
    
    1;    # end of class

Filename F<My/BarClass.pm>:

    # [[[ HEADER ]]]
    use RPerl;
    package My::BarClass;
    use strict;
    use warnings;
    our $VERSION = 0.001_000;
    
    # [[[ OO INHERITANCE ]]]
    # RPerl base class, no inheritance; replace with parent class as needed
    use parent qw(RPerl::CompileUnit::Module::Class);
    use RPerl::CompileUnit::Module::Class;
    
    # [[[ CRITICS ]]]
    ## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
    ## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
    ## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants
    
    # [[[ INCLUDES ]]]
    use My::OtherPackage;  # implementation left as an exercise for the user
    use My::OtherClass;    # ditto
    
    # [[[ CONSTANTS ]]]
    use constant BAR_CONSTANT => my string $TYPED_BAR_CONSTANT = 'bar constant data';
    
    # [[[ OO PROPERTIES ]]]
    our hashref $properties = {
        bar_number => my integer $TYPED_bar_number = 42.23,
        bar_string => my string $TYPED_bar_string  = 'default bar string data'
    };
    
    # [[[ SUBROUTINES & OO METHODS ]]]
    
    sub bar_method1 {
        { my void::method $RETURN_TYPE };
        ( my My::BarClass $self, my integer $arg ) = @ARG;
        print 'in My::BarClass->bar_method1(), received $arg = ', $arg, "\n";
        print ($self->{bar_string} x $arg);
    }
    
    sub bar_method2 {
        { my number::method $RETURN_TYPE };
        ( my My::BarClass $self, my integer $arg ) = @ARG;
        print 'in My::BarClass->bar_method2(), received $arg = ', $arg, "\n";
        return($self->{bar_number} * $arg);
    }
    
    1;    # end of class

=head1 SYNOPSIS, PERL MODULES, COMPILE & TEST LOAD

=for rperl X<noncode>

    $ rperl -V My/FooPackage.pm My/BarClass.pm
    $  perl -e 'use My::FooPackage; use My::BarClass;'

=for rperl X</noncode>

=head1 QUICK-START CHECKLIST

=over

=item * B<1. File Formats, Programs & Modules:> Follow Exact Syntax & Order In Synopsis Code Examples Above

=item * B<2. Data Types, Constants & Variables & OO Properties:> X<br> Always C<use constant PI =E<gt> my number $TYPED_PI = 3.141_59;> or C<my integer $foo;> or C<our hashref $properties = { foo =E<gt> my integer $TYPED_foo = 23, ...};> ; X<br> Never C<use constant PI =E<gt> 3.141_59;> or C<my $foo;> or C<our $properties = { foo =E<gt> 23, ...};>


=item * B<3. Return Types, Subroutines & OO Methods:> Always C<sub foo {{ my integer $RETURN_TYPE }; ...}> ; Never C<sub foo ($) {...}> etc.

=item * B<4. Argument Types, Subroutines & OO Methods:> Always C<( my integer $arg1, my string $arg2, ... ) = @ARG;> ; Never C<my $arg1 = shift; my $arg2 = shift;>

=item * B<5. Data Structures By Reference:> Always C<my integer_arrayref $ar = [...];> & C<my integer_hashref $hr = {...};> ; Never C<my @a = (...);> or C<my %h = (...);>

=item * B<6. Lexical Variables:> Always C<my integer $foo> ; Never C<our $foo> or C<state $foo> etc.

=item * B<7. No Punctuation Variables:> Never Use C<$_> or C<@_> or C<$!> etc.

=item * B<8. Perl Critic:> Always C<perlcritic --brutal my_program.pl> or C<perlcritic --brutal MyModule.pm>, Except For Specified & Allowed C<## no critic> Commands

=item * B<9. No External Dependencies:> Always Write Your Own Code & Only Load CPAN Modules From Non-Compiled Code; Never Directly Load Non-Compilable Code or CPAN Modules etc.

=item * B<10. Pure Perl:> Always Low-Magic Perl 5, Never XS or Non-Perl Code

=back

=head1 QUICK-START GUIDE

RPerl currently supports a restricted subset of the Perl 5 programming language.

This B<Quick-Start Guide> is meant to serve as a primer or companion for the much more in-depth textbook B<L<Learning RPerl|RPerl::Learning>>.

Here are the most important things a Perl programmer needs to know to get started using RPerl immediately.

=head2 1. File Formats

All RPerl program and module files must follow specific file formats, as shown in the Synopsis code examples.

L</"SYNOPSIS, PERL PROGRAM, INPUT CODE">

L</"SYNOPSIS, PERL MODULES, INPUT CODE">

The first line of Perl code in any RPerl file must be C<use RPerl;>, after which the files must be organized into the proper format for 1 of 3 file types:

=over

=item 1. Perl Program,        F<.pl> File Name Suffix, Ex. F<foo.pl>

=item 2. Perl Module Package, F<.pm> File Name Suffix, Ex. F<Foo.pm>

=item 3. Perl Module Class,   F<.pm> File Name Suffix, Ex. F<Foo.pm>

=back

You can see above that both packages and classes must use the F<*.pm> file name suffix; they are compiled differently based on the presence a class' OO inheritance C<use parent qw(...);> and OO properties C<our hashref $properties = {...};>. 

If the OO inheritance and properties are not found, a F<*.pm> file name is assumed to be a package and not a class.

The official RPerl file format templates are here:

L<Program Template|https://github.com/wbraswell/rperl/blob/master/script/program_template.pl>

L<Package Template|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/CompileUnit/Module/Package/Template.pm>

L<Class Template|https://github.com/wbraswell/rperl/blob/master/lib/RPerl/CompileUnit/Module/Class/Template.pm>

=head2 2. Data Types & Data Structures

All RPerl constants, variables, subroutine & object method return values, and object properties must have an explicitly-specified scalar data type or non-scalar data structure.

=head3 2a. Scalar Data Types

=for comment DEV NOTE, CORRELATION #rp400: all POD changes must be made in both RPerl.pm & RPerl/Learning.pm

L<RPerl::Learning/"CHAPTER 2: SCALAR VALUES & VARIABLES (NUMBERS & TEXT)">

RPerl provides 7 scalar data types:

=over

=item * C<boolean>

=item * C<unsigned_integer>

=item * C<integer> (core)

=item * C<gmp_integer>

=item * C<number> (core)

=item * C<character>

=item * C<string> (core)

=back

Of the 7 RPerl scalar data types, 3 are directly (natively) supported by the Perl 5 core: C<integer>, C<number>, and C<string>.  This means the Perl 5 core is capable of directly identifying and storing those 3 core types.  The remaining 4 non-core types are indirectly supported by the Perl 5 interpreter: C<boolean> and C<unsigned_integer> can be stored within either an C<integer> or C<number>; C<character> can be stored within a C<string>; and C<gmp_integer> is supported by the C<use bigint;> wrapper around the C<Math::BigInt::GMP> module.

=head3 2b. Array Data Structures

=for comment DEV NOTE, CORRELATION #rp401: all POD changes must be made in both RPerl.pm & RPerl/Learning.pm

L<RPerl::Learning/"CHAPTER 3: ARRAY VALUES & VARIABLES">

For arrays with more than just a few elements, it may be impractical or impossible to pass by value, because a full copy of each array element must be made in the process, which may fill up all your program's available memory or take a prohibitively long time to complete.  Also, Perl allows us to provide explicit data types only when an array is stored by reference, so we can not provide a data type for an array stored by value.  Because of these reasons, all RPerl arrays are stored by reference, and are declared with an explicit RPerl data type ending with C<_arrayref>.

    my                  @foo_by_value           = (2, 4, 6);  # fine in normal Perl, error in RPerl
    my                  $foo_by_reference       = [2, 4, 6];  # fine in normal Perl, error in RPerl
    my integer_arrayref $foo_by_reference_typed = [2, 4, 6];  # fine in normal Perl, fine  in RPerl

In a few special cases, Perl forces us to provide an array by value instead of by reference, in which case we need to I<"dereference"> our array variable, which is the process of converting from the stored-by-reference memory address to the stored-by-data values.  This is achieved by use of Perl's closefix array dereference syntax, comprised of enclosing the scalar array variable within at-sign-curly-braces C<@{ }>.  Because all arrays in RPerl are stored by reference, only necessary uses of the dereference syntax are supported by the RPerl compiler.  (Please see L<RPerl::Learning/"Section 3.8: C<push> & C<pop> Operators"> for more information on C<pop>.)

    my integer_arrayref $foo_by_reference_typed = [10, 20, 30];                    # fine in normal Perl, fine  in RPerl
    my integer          $foo_last_element       = pop @{$foo_by_reference_typed};  # fine in normal Perl, fine  in RPerl,   necessary dereference 
    my                  @foo_by_value           = @{$foo_by_reference_typed};      # fine in normal Perl, error in RPerl, unnecessary dereference

In normal Perl, a single array may contain elements with multiple different data types, such as a three-element array containing one string and one integer and one floating-point number.  In RPerl, a single array must contain elements of all the same data type, so you can have a three-element array with all strings, but you can't store an integer inside an array of strings, and likewise you can't store a string inside an array of integers, etc.

    my integer_arrayref $foo = [5, 10, 15];                 # fine
    my  number_arrayref $bar = [5, 10, 15.5];               # fine
    my  string_arrayref $bat = ['five', 'ten', 'fifteen'];  # fine

    my integer_arrayref $foo = [5, 10, 15.5];               # error in RPerl, compiled modes
    my  number_arrayref $bar = [5, 10, 'fifteen'];          # error in RPerl, compiled modes
    my  string_arrayref $bat = ['five', 'ten', 15];         # error in RPerl, compiled modes

You can create an array with only one element, sometimes called a I<"singleton">; you can even create an empty array with zero elements:

    my integer_arrayref $foo = [];    # zero elements, empty     array
    my integer_arrayref $bar = [23];  # one  element,  singleton array

To display the contents of an array, you may utilize the C<*_arrayref_to_string()> family of stringification subroutines:

    my integer_arrayref $foo;
    $foo = [23, 42, 2_112];
    print '$foo = ', integer_arrayref_to_string($foo), "\n";

Running the code example above generates the following output:

=for rperl X<noncode>

    $foo = [23, 42, 2_112]

=for rperl X</noncode>

RPerl currently supports the following array stringification subroutines, with support for all RPerl array data types coming soon:

=over

=item * C<integer_arrayref_to_string()>

=item * C<number_arrayref_to_string()>

=item * C<string_arrayref_to_string()>

=back

=head3 2c. Hash Data Structures

# NEED ADD CONTENT!

=head2 3. Return Types

# NEED ADD CONTENT!

=head2 4. Argument Types

# NEED ADD CONTENT!

=head2 5. Data Structures By Reference

# NEED ADD CONTENT!

=head2 6. Lexical Variables

# NEED ADD CONTENT!

=head2 7. No Punctuation Variables

# NEED ADD CONTENT!

=head2 8. Perl Critic

# NEED ADD CONTENT!

=head2 9. External Dependencies

# NEED ADD CONTENT!

=head2 10. Pure Perl

# NEED ADD CONTENT!

=head1 SEE ALSO

L<rperl>

L<Learning RPerl e-Book, POD Format|RPerl::Learning>

L<Learning RPerl e-Book, Web Format|http://rperl.org/learning/>

L<The Low-Magic Perl Commandments|http://rperl.org/the_low_magic_perl_commandments.html>

=head1 AUTHOR

B<William N. Braswell, Jr.>

L<mailto:wbraswell@NOSPAM.cpan.org>

=for comment DEV NOTE: END INLINE CSS DIV

=for html </div>

=cut
