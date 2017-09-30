# [[[ HEADER ]]]
package RPerl::Exporter; 
use strict;
use warnings;
use RPerl::Config;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
#use parent qw(RPerl::CompileUnit::Module::Class);
#use RPerl::CompileUnit::Module::Class;

# [[[ EXPORTS ]]]
#use RPerl::Exporter qw(import);  # hey that's me!
#our @EXPORT_OK = qw(import);  # so meta  ;-)

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
#our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub import {
    no strict;
    my $package_exporter = shift @ARG;  # variable number of args, must use shift
    my $package_importer = caller(0);

    # USAGE OPTION A, OPTIONAL @EXPORT_OK, NON-INHERITED, EXPORTER;
    #   package Foo;
    #   use RPerl::Exporter qw(import);
    #   our @EXPORT_OK = (howdy);
    # USAGE OPTION A, OPTIONAL @EXPORT_OK, NON-INHERITED, IMPORTER;
    #   use Foo qw(howdy);  # importer must request howdy()
    #   howdy();

    # USAGE OPTION B, OPTIONAL @EXPORT_OK,     INHERITED, EXPORTER;        NEED UPGRADE: REQUIRES MULTIPLE INHERITANCE, WILL NOT CURRENTLY PARSE
    #   package Foo;
    #   use parent qw(... RPerl::Exporter ...);  # or set @ISA directly, etc.
    #   use RPerl::Exporter;
    #   our @EXPORT_OK = (howdy);
    # USAGE OPTION B, OPTIONAL @EXPORT_OK,     INHERITED, IMPORTER;
    #   use Foo qw(howdy);  # importer must request howdy()
    #   howdy();

    # USAGE OPTION C,   FORCED @EXPORT   , NON-INHERITED, EXPORTER;
    #   package Foo;
    #   use RPerl::Exporter qw(import);
    #   our @EXPORT = (howdy);
    # USAGE OPTION C,   FORCED @EXPORT   , NON-INHERITED, IMPORTER;
    #   use Foo;  # importer may optionally request howdy(), or other subroutines
    #   howdy();

    # USAGE OPTION D,   FORCED @EXPORT   ,     INHERITED, EXPORTER;        NEED UPGRADE: REQUIRES MULTIPLE INHERITANCE, WILL NOT CURRENTLY PARSE
    #   package Foo;
    #   use parent qw(... RPerl::Exporter ...);  # or set @ISA directly, etc.
    #   use RPerl::Exporter;
    #   our @EXPORT = (howdy);
    # USAGE OPTION D,   FORCED @EXPORT   ,     INHERITED, IMPORTER;
    #   use Foo;  # importer may optionally request howdy(), or other subroutines
    #   howdy();

    # there are still arguments remaining to be received
    if (scalar @ARG) {
        # USAGE OPTIONS A & C ONLY: give non-inherited access to import()
        if ($package_exporter eq 'RPerl::Exporter') {
            if ($ARG[0] eq 'import') {
                # this is RPerl::Exporter::import() explicitly exporting itself into the importing package's namespace as import()
                *{$package_importer . '::import'} = \&import;  # short form, symbol table direct, not strict
                return;
            }
            else {
                croak 'ERROR ESUXP00, Subroutine Exporter: Failed to give inheritance of subroutine ' . $ARG[0] . q{(), only the import() subroutine is available to be inherited from package RPerl::Exporter, croaking};
            }
        }
        # USAGE OPTIONS A & B REQUIRED, C & D OPTIONAL: receive requests for subroutines to be exported
        else {




            # START HERE: add type checking code from Class.pm, remove unneeded type checking code from Class.pm, fix eval error and/or redefined errors in Class.pm, ensure AllTypes.pm tests pass
            # START HERE: add type checking code from Class.pm, remove unneeded type checking code from Class.pm, fix eval error and/or redefined errors in Class.pm, ensure AllTypes.pm tests pass
            # START HERE: add type checking code from Class.pm, remove unneeded type checking code from Class.pm, fix eval error and/or redefined errors in Class.pm, ensure AllTypes.pm tests pass

            # THERE HERE: need add type checking code to all created subroutines?!?
            # THERE HERE: need add type checking code to all created subroutines?!?
            # THERE HERE: need add type checking code to all created subroutines?!?


            my $subroutines_export = {};
            my $subroutines_export_ok = {};
            
            # populate quick-lookup hash tables from @EXPORT & @EXPORT_OK
            foreach my $subroutine_export (@{$package_exporter . '::EXPORT'}) {
                $subroutines_export->{$subroutine_export} = 1;
            }
            foreach my $subroutine_export_ok (@{$package_exporter . '::EXPORT_OK'}) {
                $subroutines_export_ok->{$subroutine_export_ok} = 1;
            }

            # process all requested subroutines
            foreach my $subroutine (@ARG) {
                print 'in import(), received requested $subroutine = ', $subroutine, '()', "\n";

                if (not defined *{ $package_exporter . '::' . $subroutine }) {
                    croak 'ERROR ESUXP01, Subroutine Exporter: Failed to export requested subroutine ' . $subroutine . '() from package ' . q{'} . $package_exporter . q{' into requesting package '} . $package_importer . q{', subroutine does not exist, croaking};
                }
                # requested subroutine is already in @EXPORT, skip it
                if (exists $subroutines_export->{$subroutine}) {
                    RPerl::warning('WARNING WSUXP00, Subroutine Exporter: Redundant request to export subroutine ' . $subroutine . '() from package ' . q{'} . $package_exporter . q{' into requesting package '} . $package_importer . q{', subroutine already exists in exporting package's @EXPORT variable} . "\n");
                    next;
                }
                # requested subroutine is in @EXPORT_OK, export it
                elsif (exists $subroutines_export_ok->{$subroutine}) {
                    *{ $package_importer . '::' . $subroutine } = \&{ $package_exporter . '::' . $subroutine };  # short form, symbol table direct, not strict
                }
                # requested subroutine is not in @EXPORT or @EXPORT_OK, error
                else {
                    croak 'ERROR ESUXP02, Subroutine Exporter: Failed to export requested subroutine ' . $subroutine . '() from package ' . q{'} . $package_exporter . q{' into requesting package '} . $package_importer . q{', subroutine not found in exporting package's @EXPORT or @EXPORT_OK variables, croaking};
                }
            }
        }
    }

    # USAGE OPTIONS C & D: force export of all subroutines in @EXPORT
    if (not scalar @{$package_exporter . '::EXPORT'}) { return; }
    foreach my $subroutine (@{$package_exporter . '::EXPORT'}) {
        *{ $package_importer . '::' . $subroutine } = \&{ $package_exporter . '::' . $subroutine };  # short form, symbol table direct, not strict
    }

=DISABLED_LONG_FORM_EVAL_ANON_SUB_STRICT
#    my @subroutines = (eval '@' . $package_exporter . '::EXPORT')
#        or (die 'ERROR Exxx: Failed to read @EXPORT variable for package ' . q{'} . $package_exporter . q{', did you forget to define @} . $package_exporter . q{::EXPORT in your code?} . "\n" . $EVAL_ERROR . "\n" . 'dying');
#    print 'in import(), have @subroutines = ' . Dumper(\@subroutines) . "\n";

#    foreach my $subroutine (@subroutines) {
#        my $eval_string = '*' . $package_importer . '::' . $subroutine . ' = sub { return ' . $package_exporter . '::' . $subroutine . '(@_); };'; 
#        print 'have $eval_string = ' . "\n" . $eval_string . "\n";
#        eval $eval_string
#            or (die q{ERROR Exxx: Failed to export subroutine } . $subroutine . q{() from package '} . $package_exporter . q{' to package '} . $package_importer . q{'} . "\n" . $EVAL_ERROR . "\n" . 'dying');
#    }
=cut
}

1;
