# [[[ HEADER ]]]
package RPerl::Exporter; 
use strict;
use warnings;
use RPerl::Config;
our $VERSION = 0.004_000;

# [[[ OO INHERITANCE ]]]
#use parent qw(RPerl::CompileUnit::Module::Class);
#use RPerl::CompileUnit::Module::Class;

# [[[ EXPORTS ]]]
#use RPerl::Exporter qw(import);  # hey that's me!
#our @EXPORT_OK = qw(import);  # so meta  ;-)

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use rperltypes;

# [[[ OO PROPERTIES ]]]
#our hashref $properties = {};

# DEV NOTE, CORRELATION #rp051: hard-coded list of RPerl data types and data structures
# NOT MISSING: boolean, unsigned_integer, character
# MISSING: *_arrayref, *_hashref
#our string_arrayref $SUPPORTED = [
our $SUPPORTED_ALL = [
    qw(
        void
        boolean
        unsigned_integer
        integer
        number
        character
        string
        integer_arrayref
        number_arrayref
        string_arrayref
        integer_hashref
        number_hashref
        string_hashref
        )
];
#our string_arrayref $SUPPORTED_SPECIAL = [
our $SUPPORTED_SPECIAL = [
    qw(
        sse_number_pair
        gmp_integer
        gsl_matrix
        )
];

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
#                RPerl::diag('in Exporter::import(), received requested $subroutine = ', $subroutine, '()', "\n");   # DEV NOTE: causes false errors in t/12_parse.t???

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
                    # enable args type checking except for non-RPerl or type-checking or type-conversion subs below
                    my $args_type_checking = 1;
            
                    # non-RPerl subs
                    # DEV NOTE, CORRELATION #rp051: hard-coded list of non-RPerl subroutines
                    # DEV NOTE, CORRELATION #rp052: gsl_matrix_to_*() and gsl_matrix_rows() and gsl_matrix_cols() are RPerl subroutines
                    if (($subroutine =~ m/^gsl_/) and
                        ($subroutine !~ m/^gsl_matrix_to/) and
                        ($subroutine ne 'gsl_matrix_rows') and
                        ($subroutine ne 'gsl_matrix_cols')) {
                        $args_type_checking = 0;
                    }
                    # type-checking subs
                    elsif (($subroutine =~ m/_CHECK$/) or
                        ($subroutine =~ m/_CHECKTRACE$/)) {
                        $args_type_checking = 0;
                    }

=DISABLED_NO_ARGS
                    # DEV NOTE, CORRELATION #rp053: even with the upgrade to normal Perl subroutine headers, we must still activate subroutines w/out args or when type-checking is explicitly disabled with CHECK OFF, in order for RPerl::Exporter to work properly, presumably because Exporter.pm runs before Class.pm and thus we can not test for the existence of __CHECKED_*() subroutines in RPerl::Exporter::import()
                    # subs with no args (and thus no arg type checking)
                    elsif (not defined *{ $package_exporter . '::__CHECK_CODE_' . $subroutine }) {
                        $args_type_checking = 0;
                    }
=cut
                    
            #        RPerl::diag('in Exporter::import(), have $SUPPORTED_ALL etc = ' . Dumper([@{$SUPPORTED_ALL}, @{$SUPPORTED_SPECIAL}]) . "\n");
            
                    # type-conversion subs
                    foreach my $rperl_type (sort @{[@{$SUPPORTED_ALL}, @{$SUPPORTED_SPECIAL}]}) {
                        my $subroutine_start = $rperl_type . '_to_';
                        my $subroutine_start_length = length $subroutine_start;
                        if ((substr $subroutine, 0, $subroutine_start_length) eq $subroutine_start) {
                            $args_type_checking = 0;
                        }
                    }
             
                    # do NOT enable argument type-checking for these subs
                    if (not $args_type_checking) {
                        RPerl::diag('in Exporter::import(), @EXPORT_OK, NO CHECKING for non-RPerl or no-args or type-checking or type-conversion subroutine ' . $package_exporter . '::' . $subroutine . '()' . "\n");
            
                        # define actual exported subroutine
                        no strict;
                        *{ $package_importer . '::' . $subroutine } = \&{ $package_exporter . '::' . $subroutine };  # short form, symbol table direct, not strict, no type checking
                        next;
                    }
#                    else { RPerl::diag('in Exporter::import(), YES CHECKING for RPerl subroutine ' . $subroutine . '()' . "\n"); }

                    # form arguments check code name & call for repeated use
                    my $subroutine_arguments_check_code_name = $package_exporter . '::__CHECK_CODE_' . $subroutine;
#                    my $subroutine_arguments_check_code_call = 'eval "$' . $package_exporter . '::__CHECK_CODE_' . $subroutine . '";';  # DOES NOT WORK
#                    my $subroutine_arguments_check_code_call = 'eval qq{$' . $package_exporter . '::__CHECK_CODE_' . $subroutine . '};';  # DOES NOT WORK
#                    my $subroutine_arguments_check_code_call = '&{ ' . $subroutine_arguments_check_code_name . ' };';  # DOES NOT WORK
#                    my $subroutine_arguments_check_code_call = $subroutine_arguments_check_code_name . '();';  # DOES NOT WORK
#                    my $subroutine_arguments_check_code_call = 'eval ' . $subroutine_arguments_check_code_name . '();';  # DOES NOT WORK
#                    my $subroutine_arguments_check_code_call = 'eval ' . $subroutine_arguments_check_code_name . '() or die($EVAL_ERROR);';  # DOES NOT WORK, gives false die() on debug output
#                    my $subroutine_arguments_check_code_call = 'eval ' . $subroutine_arguments_check_code_name . '() or croak($EVAL_ERROR);';  # DOES NOT WORK, gives false die() on debug output, gives unnecessary eval() traces
                    my $subroutine_arguments_check_code_call = 'eval ' . $subroutine_arguments_check_code_name . '(); if ($EVAL_ERROR) { die($EVAL_ERROR); }';  # does work!
#                    my $subroutine_arguments_check_code_call = 'eval q{eval ' . $subroutine_arguments_check_code_name . '();};';  # DOES NOT WORK

                    # DEBUG OUTPUT
#                    $subroutine_arguments_check_code_call .= 'print ' . $subroutine_arguments_check_code_name . '(), "\n\n";';
#                    $subroutine_arguments_check_code_call .= 'print eval ' . $subroutine_arguments_check_code_name . '(), "\n\n";';
#                    $subroutine_arguments_check_code_call .= q{::integer_CHECKTRACE( $_[0], '$hard_coded', 'hard_coded()' );};
#                    $subroutine_arguments_check_code_call .= q{::integer_CHECKTRACE( 21, '$hard_coded', 'hard_coded()' );};
                    $subroutine_arguments_check_code_call = 'print qq{BEFORE ARGS CHECK CODE EVAL1\n};' . $subroutine_arguments_check_code_call;
                    $subroutine_arguments_check_code_call .= 'print qq{AFTER ARGS CHECK CODE EVAL1\n};';

                    # define actual exported subroutine
                    my $subroutine_definition_code = q{};
                    if (not defined &{$package_importer . '::' . $subroutine}) {
                        $subroutine_definition_code .=
                            '*' . $package_importer . '::' . $subroutine . ' = sub {' . "\n" . 
                            '    print q{in subroutine Exported by request!}, "\n";' . "\n" .
                            '    ' . $subroutine_arguments_check_code_call . "\n" . 
                            '    return ' . $package_exporter . '::__UNCHECKED_' . $subroutine . '(@ARG);' . "\n" . ' };';
                    }

                    # pass on each exported subroutine's associated __UNCHECKED & __CHECK_CODE & __CHECKED subroutine to the importing package 
#                    $subroutine_definition_code .= "\n" . '*' . $package_importer . '::__CHECK_CODE_' . $subroutine . q{ = \\} . $subroutine_arguments_check_code_call;  # DOES NOT WORK
#                    $subroutine_definition_code .= "\n" . '*' . $package_importer . '::__CHECK_CODE_' . $subroutine . ' = sub { return ' . $subroutine_arguments_check_code_name . '(); };';  # DOES NOT WORK
                    if (not defined &{$package_importer . '::__CHECK_CODE_' . $subroutine}) {
                        $subroutine_definition_code .= "\n" . 'sub ' . $package_importer . '::__CHECK_CODE_' . $subroutine . ' { return ' . $subroutine_arguments_check_code_name . '(); }';
                    }
                    if (not defined &{$package_importer . '::__UNCHECKED_' . $subroutine}) {
                        $subroutine_definition_code .= "\n" . 'sub ' . $package_importer . '::__UNCHECKED_' . $subroutine . ' { return ' . $package_exporter . '::__UNCHECKED_' . $subroutine . '(@ARG); }';
                    }
                    if (not defined &{$package_importer . '::__CHECKED_' . $subroutine}) {
                        $subroutine_definition_code .= "\n" . 'sub ' . $package_importer . '::__CHECKED_' . $subroutine . ' { return ' . $package_exporter . '::__CHECKED_' . $subroutine . '(@ARG); }';
                    }

#                    RPerl::diag('in Exporter::import(), about to call eval() on requested $subroutine_definition_code = ' . "\n" . $subroutine_definition_code . "\n");
#                    eval($subroutine_definition_code) or (RPerl::diag('WARNING WSUXPxx, Subroutine Exporter: Possible failure to export type-checking subroutine ' . $package_exporter . '::' . $subroutine . '(),' . "\n" . $EVAL_ERROR . "\n" . 'not croaking'));
                    eval($subroutine_definition_code);
#                    if ($EVAL_ERROR) { croak 'ERROR ESUXPxx, Subroutine Exporter: Failed to export type-checking subroutine ' . $package_exporter . '::' . $subroutine . '(),' . "\n" . $EVAL_ERROR . "\n" . 'croaking'; }  # does work, gives unnecessary eval() traces 
                    if ($EVAL_ERROR) { die 'ERROR ESUXPxx, Subroutine Exporter: Failed to export type-checking subroutine ' . $package_exporter . '::' . $subroutine . '(),' . "\n" . $EVAL_ERROR . "\n" . 'dying' . "\n"; }
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
        # enable args type checking except for non-RPerl or type-checking or type-conversion subs below
        my $args_type_checking = 1;

        # non-RPerl subs
        # DEV NOTE, CORRELATION #rp051: hard-coded list of non-RPerl subroutines
        # DEV NOTE, CORRELATION #rp052: gsl_matrix_to_*() and gsl_matrix_rows() and gsl_matrix_cols() are RPerl subroutines
        if (($subroutine =~ m/^gsl_/) and
            ($subroutine !~ m/^gsl_matrix_to/) and
            ($subroutine ne 'gsl_matrix_rows') and
            ($subroutine ne 'gsl_matrix_cols')) {
            RPerl::diag('in Exporter::import(), @EXPORT, NO CHECKING for non-RPerl subroutine ' . $package_exporter . '::' . $subroutine . '()' . "\n");
            $args_type_checking = 0;
        }
        # type-checking subs
        elsif (($subroutine =~ m/_CHECK$/) or
            ($subroutine =~ m/_CHECKTRACE$/)) {
            RPerl::diag('in Exporter::import(), @EXPORT, NO CHECKING for type-checking subroutine ' . $package_exporter . '::' . $subroutine . '()' . "\n");
            $args_type_checking = 0;
        }

=DISABLED_NO_ARGS
        # DEV NOTE, CORRELATION #rp053: even with the upgrade to normal Perl subroutine headers, we must still activate subroutines w/out args or when type-checking is explicitly disabled with CHECK OFF, in order for RPerl::Exporter to work properly, presumably because Exporter.pm runs before Class.pm and thus we can not test for the existence of __CHECKED_*() subroutines in RPerl::Exporter::import()
        # subs with no args (and thus no arg type checking)
        # none of the below tests work, presumably because Exporter.pm is called before Class.pm
#        elsif (not defined *{ $package_exporter . '::__CHECK_CODE_' . $subroutine }) {
#        elsif (not defined &{ $package_exporter . '::__CHECK_CODE_' . $subroutine }) {
#        elsif (not defined &{ $package_exporter . '::__CHECKED_' . $subroutine }) {
#        elsif (not exists *{ $package_exporter . '::__CHECKED_' . $subroutine }) {
#        elsif (not exists &{ $package_exporter . '::__CHECKED_' . $subroutine }) {
        elsif (0) {
            RPerl::diag('in Exporter::import(), @EXPORT, NO CHECKING for no-args subroutine ' . $package_exporter . '::' . $subroutine . '()' . "\n");
            $args_type_checking = 0;
        }
 
        if ($package_exporter eq 'RPerl::Test::TypeCheckingOn::AllTypes') {
            &{ $package_exporter . '::__CHECKED_' . $subroutine }(0);
            die 'TMP DEBUG';
        }
=cut
        
#        RPerl::diag('in Exporter::import(), have $SUPPORTED_ALL etc = ' . Dumper([@{$SUPPORTED_ALL}, @{$SUPPORTED_SPECIAL}]). "\n");

        # type-conversion subs
        foreach my $rperl_type (sort @{[@{$SUPPORTED_ALL}, @{$SUPPORTED_SPECIAL}]}) {
            my $subroutine_start = $rperl_type . '_to_';
            my $subroutine_start_length = length $subroutine_start;
            if ((substr $subroutine, 0, $subroutine_start_length) eq $subroutine_start) {
                RPerl::diag('in Exporter::import(), @EXPORT, NO CHECKING for type-conversion subroutine ' . $package_exporter . '::' . $subroutine . '()' . "\n");
                $args_type_checking = 0;
            }
        }
 
        # do NOT enable argument type-checking for these subs
        if (not $args_type_checking) {
#            RPerl::diag('in Exporter::import(), @EXPORT, NO CHECKING for non-RPerl or no-args or type-checking or type-conversion subroutine ' . $package_exporter . '::' . $subroutine . '()' . "\n");

            # define actual exported subroutine
            no strict;
            *{ $package_importer . '::' . $subroutine } = \&{ $package_exporter . '::' . $subroutine };  # short form, symbol table direct, not strict, no type checking
            next;
        }
#        else { RPerl::diag('in Exporter::import(), YES CHECKING for RPerl subroutine ' . $subroutine . '()' . "\n"); }

        # form arguments check code name & call for repeated use
        my $subroutine_arguments_check_code_name = $package_exporter . '::__CHECK_CODE_' . $subroutine;

#        my $subroutine_arguments_check_code_call = 'eval "$' . $package_exporter . '::__CHECK_CODE_' . $subroutine . '";';  # DOES NOT WORK
#        my $subroutine_arguments_check_code_call = 'eval qq{$' . $package_exporter . '::__CHECK_CODE_' . $subroutine . '};';  # DOES NOT WORK
#        my $subroutine_arguments_check_code_call = '&{ ' . $package_exporter . '::__CHECK_CODE_' . $subroutine . ' };';  # DOES NOT WORK
#        my $subroutine_arguments_check_code_call = $subroutine_arguments_check_code_name . '();';
#        my $subroutine_arguments_check_code_call = 'eval ' . $subroutine_arguments_check_code_name . '();';
#        $subroutine_arguments_check_code_call .= 'print qq{AFTER ARGS CHECK CODE EVAL2\n};';
        my $subroutine_arguments_check_code_call = 'eval ' . $subroutine_arguments_check_code_name . '(); if ($EVAL_ERROR) { die($EVAL_ERROR); }';  # does work!

        # define actual exported subroutine
        my $subroutine_definition_code = q{};
        if (not defined &{$package_importer . '::' . $subroutine}) {
            $subroutine_definition_code .= 
                '*' . $package_importer . '::' . $subroutine . ' = sub {' . "\n" .
                '    print q{in subroutine ' . $package_exporter . '::__CHECKED_' . $subroutine . '() Exported by force!}, "\n";' . "\n" .  # DEBUG USE ONLY!
                '    ' . $subroutine_arguments_check_code_call . "\n" .
                '    return ' . $package_exporter . '::__CHECKED_' . $subroutine . '(@ARG);' . "\n" . ' };';
        }

        # pass on each exported subroutine's associated __UNCHECKED & __CHECK_CODE & __CHECKED subroutine to the importing package 
#        $subroutine_definition_code .= "\n" . '*' . $package_importer . '::__CHECK_CODE_' . $subroutine . q{ = \\} . $subroutine_arguments_check_code_call;
#        $subroutine_definition_code .= "\n" . '*' . $package_importer . '::__CHECK_CODE_' . $subroutine . ' = sub { return ' . $subroutine_arguments_check_code_name . '(); };';
        if (not defined &{$package_importer . '::__CHECK_CODE_' . $subroutine}) {
            $subroutine_definition_code .= "\n" . 'sub ' . $package_importer . '::__CHECK_CODE_' . $subroutine . ' { return ' . $subroutine_arguments_check_code_name . '(); }';
        }
        if (not defined &{$package_importer . '::__UNCHECKED_' . $subroutine}) {
            $subroutine_definition_code .= "\n" . 'sub ' . $package_importer . '::__UNCHECKED_' . $subroutine . ' { return ' . $package_exporter . '::__UNCHECKED_' . $subroutine . '(@ARG); }';
        }
        if (not defined &{$package_importer . '::__CHECKED_' . $subroutine}) {
           $subroutine_definition_code .= "\n" . 'sub ' . $package_importer . '::__CHECKED_' . $subroutine . ' { return ' . $package_exporter . '::__CHECKED_' . $subroutine . '(@ARG); }';
        }

#        RPerl::diag('in Exporter::import(), about to call eval() on forced $subroutine_definition_code = ' . "\n" . $subroutine_definition_code . "\n");
#        eval($subroutine_definition_code) or (RPerl::diag('WARNING WSUXPxx, Subroutine Exporter: Possible failure to export type-checking subroutine ' . $package_exporter . '::' . $subroutine . '(),' . "\n" . $EVAL_ERROR . "\n" . 'not croaking'));
        eval($subroutine_definition_code);
#        if ($EVAL_ERROR) { croak 'ERROR ESUXPxx, Subroutine Exporter: Failed to export type-checking subroutine ' . $package_exporter . '::' . $subroutine . '(),' . "\n" . $EVAL_ERROR . "\n" . 'croaking'; }  # does work, gives unnecessary eval() traces 
        if ($EVAL_ERROR) { die 'ERROR ESUXPxx, Subroutine Exporter: Failed to export type-checking subroutine ' . $package_exporter . '::' . $subroutine . '(),' . "\n" . $EVAL_ERROR . "\n" . 'dying' . "\n"; }
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
