## no critic qw(ProhibitExcessMainComplexity)  # SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1
# [[[ HEADER ]]]
package RPerl::Generator;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.005_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitStringyEval)  # SYSTEM DEFAULT 1: allow eval()

# [[[ INCLUDES ]]]
use RPerl::Grammar;
use RPerl::Compiler;  # for post_processor_cpp_*()
use rperltypesconv;
use IPC::Cmd qw(can_run);          # to check for `astyle`
use File::Temp qw(tempfile);
use File::Basename;
use Alien::astyle;
use Env qw(@PATH);
unshift @PATH, Alien::astyle->bin_dir();

#use RPerl::Parser;
#require RPerl::Parser;
#eval 'require RPerl::Parser;';
eval { require RPerl::Parser; };
if ( $EVAL_ERROR and ( $EVAL_ERROR =~ /attempt to reload/i ) ) {
    delete $INC{'RPerl::Parser'};
    require RPerl::Parser;
}
elsif ( $EVAL_ERROR ne q{} ) { die $EVAL_ERROR; }

use English qw(-no_match_vars);    # for $OSNAME; NEED ANSWER: why isn't this included from 'require RPerl::Config', which is included from 'use RPerl' above?

# [[[ CONSTANTS ]]]
# NEED UPGRADE, CORRELATION #rp035: allow multi-line subroutines where it would be less than 160 chars if on a single line
use constant PERLTIDY_LINE_WIDTH  => my number $TYPED_PERLTIDY_LINE_WIDTH  = 160;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ PROCEDURAL SUBROUTINES ]]]

# convert array max index to array size (difference of 1)
our object $arrayref_convert_index_max_to_size = sub {
    ( my object $subexpression ) = @_;

#    RPerl::diag( 'in Generator->arrayref_convert_index_max_to_size(), received $subexpression = ' . "\n" . RPerl::Parser::rperl_ast__dump($subexpression) . "\n" );

    my object $subexpression_original = $subexpression;
    my boolean $is_modified = 0;
    my integer $nested_parenthesis = 0;
    
    # look inside nested parenthesis-as-subexpressions, always length 1 so no need to check length
    while ((ref $subexpression) eq 'SubExpression_144') {  # RPerl::Operation::Expression::SubExpression::Parenthesis
        $subexpression = $subexpression->{children}->[1];
        $nested_parenthesis++;
    }
 
#    RPerl::diag( 'in Generator->arrayref_convert_index_max_to_size(), have post-nested-parens $subexpression = ' . "\n" . RPerl::Parser::rperl_ast__dump($subexpression) . "\n" );

    if ( $subexpression->{children}->[0]->isa('RPerl::Operation::Expression::Operator') ) {
        if ( $subexpression->{children}->[0]->{children}->[0]->isa('RPerl::Operation::Expression::Operator::Arithmetic::AddSubtract') ) {
            if (    ( exists $subexpression->{children}->[0]->{children}->[0]->{children}->[1] )
                and ( $subexpression->{children}->[0]->{children}->[0]->{children}->[1] =~ /^-\s*$/xms ) )
            {
                if ( $subexpression->{children}->[0]->{children}->[0]->{children}->[2]->isa('RPerl::Operation::Expression::SubExpression::Literal') ) {
                    if ( $subexpression->{children}->[0]->{children}->[0]->{children}->[2]->{children}->[0]
                        ->isa('RPerl::Operation::Expression::SubExpression::Literal::Number') )
                    {
                        if ( $subexpression->{children}->[0]->{children}->[0]->{children}->[2]->{children}->[0]->{children}->[0] eq q{1} ) {
                            # '$foo - 1' becomes '$foo'
#                            RPerl::diag( 'in Generator->arrayref_convert_index_max_to_size(), setting ($foo - 1) to ($foo)' . "\n");
                            $subexpression = $subexpression->{children}->[0]->{children}->[0]->{children}->[0];
                            $is_modified = 1;
                            $nested_parenthesis = 0;  # discard parens if present
                        }
                        else {
                            # '$foo - 10' becomes '$foo - 9'
                            my number $tmp_number
                                = string_to_number( $subexpression->{children}->[0]->{children}->[0]->{children}->[2]->{children}->[0]->{children}->[0] );
#                            RPerl::diag( 'in Generator->arrayref_convert_index_max_to_size(), setting ($foo - ' . $tmp_number . ') to ($foo - ' . ($tmp_number - 1)  .')' . "\n");
                            $tmp_number--;
                            $subexpression->{children}->[0]->{children}->[0]->{children}->[2]->{children}->[0]->{children}->[0]
                                = number_to_string($tmp_number);
                            $is_modified = 1;
                            if ($nested_parenthesis) { $nested_parenthesis = 1; }  # keep 1 set of parens if 1 or more is present
                        }
                    }
                }
            }
        }
    }
#    else { RPerl::diag( 'in Generator->arrayref_convert_index_max_to_size(), have non-Operator $subexpression, not modifying' . "\n"); }

    if ($is_modified) {
        if ($nested_parenthesis) {
            # create new-but-equivalent object to alert caller of modification
            my object $subexpression_modified = RPerl::CompileUnit::Module::Class::new('SubExpression_144');
            $subexpression_modified->{children}->[0] = '(';
            $subexpression_modified->{children}->[1] = $subexpression;
            $subexpression_modified->{children}->[2] = ')';
            $subexpression = $subexpression_modified;
        }
        else {
            # create new-but-equivalent object to alert caller of modification
            my object $subexpression_modified = RPerl::CompileUnit::Module::Class::new(ref $subexpression);
            $subexpression_modified->{children} = $subexpression->{children};
            $subexpression = $subexpression_modified;
        }
    }
    return $subexpression;
};

# convert RPerl types to C++ types
our string $type_convert_perl_to_cpp = sub {
    ( my string $return_type, my boolean $pointerify_classes ) = @_;

    #    RPerl::diag('in Generator->type_convert_perl_to_cpp(), received $return_type = ' . $return_type . "\n");
    #    RPerl::diag('in Generator->type_convert_perl_to_cpp(), received $pointerify_classes = ' . $pointerify_classes . "\n");

    if ( exists $rperlnamespaces_generated::RPERL->{ $return_type . '::' } ) {    # RPerl types
        $return_type =~ s/^constant_/const\ /gxms;                                # 'constant_foo' becomes 'const foo'
    }
    else {                                                                        # user-defined types AKA classes
        $return_type =~ s/:/_/gxms;                                               # 'Foo::Bar::Baz' becomes 'Foo__Bar__Baz'
        if ($pointerify_classes) {
            if ( $return_type =~ /_raw$/ ) {
                $return_type =~ s/_raw$/_rawptr/xms;                              # 'Foo__Bar__Baz_raw' becomes 'Foo__Bar__Baz_rawptr'
            }
            elsif ( ( $return_type !~ /_arrayref$/ ) and ( $return_type !~ /_hashref$/ ) ) {

                # don't pointerify arrayrefs or hashrefs, they are already pointerified
                $return_type .= '_ptr';                                           # 'Foo__Bar__Baz' becomes 'Foo__Bar__Baz_ptr'
            }
        }
    }
    return $return_type;                                                          # much meta
};

# search for dummy source code
our boolean $dummy_source_code_find = sub {
    ( my string_hashref $source_group ) = @_;
    foreach my string $suffix_key ( sort keys %{$source_group} ) {
        if ( $source_group->{$suffix_key} =~ /__DUMMY_SOURCE_CODE/xms ) {
            return 1;
        }
    }
    return 0;
};

# line-by-line comparison of file contents vs string contents;
# returns -1 __DUMMY_SOURCE_CODE found, 0 no difference, >0 line number of first difference
our hashref $diff_check_file_vs_string = sub {
    ( my string $file_name_reference, my string_hashref $source_group, my string $suffix_key, my string_hashref $file_name_group, my string_hashref $modes ) = @_;
#    RPerl::diag('in Generator->diff_check_file_vs_string(), TOP OF SUBROUTINE ' . "\n");
#    RPerl::diag('in Generator->diff_check_file_vs_string(), received $file_name_reference = ' . $file_name_reference . "\n");
#    RPerl::diag('in Generator->diff_check_file_vs_string(), contents of file = ' . "\n");
#    system 'cat', $file_name_reference;
#    RPerl::diag('in Generator->diff_check_file_vs_string(), received $source_group = ' . "\n" . Dumper($source_group) . "\n\n");
#    RPerl::diag('in Generator->diff_check_file_vs_string(), received $suffix_key = ' . $suffix_key . "\n");
#    RPerl::diag('in Generator->diff_check_file_vs_string(), received $file_name_group = ' . "\n" . Dumper($file_name_group) . "\n\n");
#    RPerl::diag('in Generator->diff_check_file_vs_string(), received $modes = ' . "\n" . Dumper($modes) . "\n\n");

    my string $string_generated = $source_group->{$suffix_key};
#    RPerl::diag('in Generator->diff_check_file_vs_string(), have $string_generated = $source_group->{$suffix_key} = ' . "\n" . $string_generated . "\n\n");

    if (( not -e $file_name_reference ) or ( not -f $file_name_reference ) or ( not -T $file_name_reference )) {
        die 'ERROR ECOGEDI00, RPERL GENERATOR, DIFF CHECK: Missing or invalid file, ' . q{'} . $file_name_reference . q{'} . "\n" . ', dying' . "\n";
    }

    open my filehandleref $FILE_HANDLE_REFERENCE, '<', $file_name_reference
        or die 'ERROR ECOGEDI01, RPERL GENERATOR, DIFF CHECK: Cannot open file ' . q{'} . $file_name_reference . q{'} . ' for reading,' . $OS_ERROR . ', dying' . "\n";

    # read in file, strip blank lines
    my string $file_line;
    my string $string_reference = q{};
    while ( $file_line = <$FILE_HANDLE_REFERENCE> ) {
        $file_line =~ s/^\s+//xms;    # strip leading whitespace

        # discard blank & all-whitespace lines
        if ( $file_line =~ /^\s*$/xms ) {
            next;
        }

        # strip trailing whitespace, if present
        $file_line =~ s/[ \t]+$//;
        $string_reference .= $file_line;
    }

    close $FILE_HANDLE_REFERENCE
        or die 'ERROR ECOGEDI02, RPERL GENERATOR, DIFF CHECK: Cannot close file ' . q{'} . $file_name_reference . q{'} . ' after reading, ' . $OS_ERROR . ', dying' . "\n";

    # remove extra blank lines inserted by RPerl generators
    $string_generated =~ s/\n\n/\n/gxms;

#    RPerl::diag( 'in Generator->diff_check_file_vs_string(), have $string_reference = ' . "\n" . ( q{=} x 60 ) . "\n" . $string_reference . "\n" . ( q{=} x 60 ) . "\n\n" );
#    RPerl::diag( 'in Generator->diff_check_file_vs_string(), have $string_generated = ' . "\n" . ( q{=} x 60 ) . "\n" . $string_generated . "\n" . ( q{=} x 60 ) . "\n\n" );
 
    # [ TIDY/FORMAT ALL CODE ]
    my string $string_reference_tidied = q{};
    my string $string_generated_tidied = q{};
    if (( $suffix_key eq 'PMC' ) or (($modes->{ops} eq 'PERL') and ($suffix_key eq 'EXE'))) {

        # TIDY REFERENCE PERL SOURCE CODE
        my string $perltidy_stderr_string = undef;
        my scalartype $perltidy_errored   = Perl::Tidy::perltidy(

            # same as Compiler::save_source_files() except '-se' to redirect STDERR
#            argv        => q{-pbp --ignore-side-comment-lengths --converge -l=160 -b -nst -bext='/' -q -se},
            argv        => q{-pbp --ignore-side-comment-lengths --converge -l=} . PERLTIDY_LINE_WIDTH() . q{ -b -nst -bext='/' -q -se},
            source      => \$string_reference,
            destination => \$string_reference_tidied,
            stderr      => \$perltidy_stderr_string,
        );
        if ($perltidy_errored) {    # serious error in input parameters, no tidied output
            die 'ERROR ECOGEDI03: Perl::Tidy major failure in file ' . q{'} . $file_name_reference . q{'} . ' with the following STDERR output, dying' . "\n" . $perltidy_stderr_string . "\n";
        }
        elsif ($perltidy_stderr_string) {
            die 'ERROR ECOGEDI04: Perl::Tidy minor failure in file ' . q{'} . $file_name_reference . q{'} . ' with the following STDERR output, dying' . "\n" . $perltidy_stderr_string . "\n";
        }

        # TIDY GENERATED PERL SOURCE CODE
        $perltidy_errored = Perl::Tidy::perltidy(
#            argv        => q{-pbp --ignore-side-comment-lengths --converge -l=160 -b -nst -bext='/' -q -se},
            argv        => q{-pbp --ignore-side-comment-lengths --converge -l=} . PERLTIDY_LINE_WIDTH() . q{ -b -nst -bext='/' -q -se},
            source      => \$string_generated,
            destination => \$string_generated_tidied,
            stderr      => \$perltidy_stderr_string,
        );
        if ($perltidy_errored) {
            die 'ERROR ECOGEDI05: Perl::Tidy major failure in generated source code string with the following STDERR output, dying' . "\n" . $perltidy_stderr_string . "\n";
        }
        elsif ($perltidy_stderr_string) {
            die 'ERROR ECOGEDI06: Perl::Tidy minor failure in generated source code string with the following STDERR output, dying' . "\n" . $perltidy_stderr_string . "\n";
        }

        # POST-PROCESS PERL SOURCE CODE     
        $string_reference_tidied = RPerl::Compiler::post_processor_perl__comments_whitespace_delete($string_reference_tidied);
        $string_generated_tidied = RPerl::Compiler::post_processor_perl__comments_whitespace_delete($string_generated_tidied);
    }
    elsif (($suffix_key eq 'H') or ($suffix_key eq 'CPP') or (($modes->{ops} eq 'CPP') and ($suffix_key eq 'EXE'))) {
        # FORMAT REFERENCE C++ SOURCE CODE
        my filehandleref $FILE_HANDLE_REFERENCE_TMP;
        (my string $file_name_reference_tmp, my string $file_name_reference_tmp_dirs, my string $file_name_reference_tmp_suffix) = fileparse($file_name_reference);
#        RPerl::diag( 'in Generator->diff_check_file_vs_string(), have $file_name_reference_tmp = ' . q{'} . $file_name_reference_tmp . q{'} . "\n" );
#        RPerl::diag( 'in Generator->diff_check_file_vs_string(), have $file_name_reference_tmp_dirs = ' . q{'} . $file_name_reference_tmp_dirs . q{'} . "\n" );
#        RPerl::diag( 'in Generator->diff_check_file_vs_string(), have $file_name_reference_tmp_suffix = ' . q{'} . $file_name_reference_tmp_suffix . q{'} . "\n" );
 
        ( $FILE_HANDLE_REFERENCE_TMP, $file_name_reference_tmp ) = tempfile( $file_name_reference_tmp . '.reference.tempfileXXXX', UNLINK => 1, TMPDIR => 1 );
#        RPerl::diag( 'in Generator->diff_check_file_vs_string(), have modified $file_name_reference_tmp = ' . q{'} . $file_name_reference_tmp . q{'} . "\n" );
 
        print {$FILE_HANDLE_REFERENCE_TMP} $string_reference or croak("\nERROR ECOGEFI00, GENERATOR, FILE SYSTEM: Attempting to save new file '$file_name_reference_tmp', cannot write to file,\ncroaking: $OS_ERROR");
        close $FILE_HANDLE_REFERENCE_TMP or croak("\nERROR ECOGEFI01, GENERATOR, FILE SYSTEM: Attempting to save new file '$file_name_reference_tmp', cannot close file,\ncroaking: $OS_ERROR");

        my string $astyle_path = can_run('astyle');
        if ( defined $astyle_path ) {
            # don't insert extra newlines, which causes accessors, mutators, and ops_types reporting subroutines to be broken into multiple lines
            my string $astyle_command = join q{ }, ($astyle_path, '-q', '--keep-one-line-blocks', '--keep-one-line-statements', $file_name_reference_tmp);
#            RPerl::diag( 'in Generator->diff_check_file_vs_string(), about to call system, have $astyle_command = ' . "\n" . $astyle_command . "\n" );
            system $astyle_command;
#            RPerl::diag( 'in Generator->diff_check_file_vs_string(), returned from call to system' . "\n" );

            if (( -e $file_name_reference_tmp . '.orig' ) and ( -f $file_name_reference_tmp . '.orig' )) {
                unlink( $file_name_reference_tmp . '.orig' ) or croak( "\n" . 'ERROR ECOGEFI02, GENERATOR, FILE SYSTEM: Cannot delete Artistic Style original file ' . q{'} . $file_name_reference_tmp . '.orig' . q{'} . ',' . "\n" . 'croaking:' . $OS_ERROR);
            }
            # DEV NOTE: astyle does not create a .orig file if there are no formatting changes made, so it is not actually a warning
#            else { RPerl::warning( 'WARNING WCOGEFI01, COMPILER, C++ CODE FORMATTING: Artistic Style command `astyle` did not create the file' . q{'} . $file_name_reference_tmp . '.orig' . q{'} . ', did something go wrong?' . "\n" ); }
        }
        else {
            RPerl::warning( 'WARNING WCOGEFI00, COMPILER, C++ CODE FORMATTING: Artistic Style command `astyle` not found, abandoning formatting' . "\n" );
        }

        if (( not -e $file_name_reference_tmp ) or ( not -f $file_name_reference_tmp ) or ( not -T $file_name_reference_tmp )) {
            die 'ERROR ECOGEDI07, RPERL GENERATOR, DIFF CHECK: Missing or invalid temporary AStyle-tidied file, ' . q{'} . $file_name_reference_tmp . q{'} . "\n" . ', dying' . "\n";
        }
    
        open $FILE_HANDLE_REFERENCE_TMP, '<', $file_name_reference_tmp
            or die 'ERROR ECOGEDI08, RPERL GENERATOR, DIFF CHECK: Cannot open temporary AStyle-tidied file ' . q{'} . $file_name_reference_tmp . q{'} . ' for reading,' . $OS_ERROR . ', dying' . "\n";
    
        # read in tidied file
        my string $file_line_reference_tmp;
        while ( $file_line_reference_tmp = <$FILE_HANDLE_REFERENCE_TMP> ) {
            $string_reference_tidied .= $file_line_reference_tmp . "\n";
        }

        close $FILE_HANDLE_REFERENCE_TMP
            or die 'ERROR ECOGEDI09, RPERL GENERATOR, DIFF CHECK: Cannot close temporary AStyle-tidied file ' . q{'} . $file_name_reference_tmp . q{'} . ' after reading, ' . $OS_ERROR . ', dying' . "\n";

        # FORMAT GENERATED C++ SOURCE CODE
        my filehandleref $FILE_HANDLE_GENERATED_TMP;
        (my string $file_name_generated_tmp, my string $file_name_generated_tmp_dirs, my string $file_name_generated_tmp_suffix) = fileparse($file_name_reference);
#        RPerl::diag( 'in Generator->diff_check_file_vs_string(), have $file_name_generated_tmp = ' . q{'} . $file_name_generated_tmp . q{'} . "\n" );
#        RPerl::diag( 'in Generator->diff_check_file_vs_string(), have $file_name_generated_tmp_dirs = ' . q{'} . $file_name_generated_tmp_dirs . q{'} . "\n" );
#        RPerl::diag( 'in Generator->diff_check_file_vs_string(), have $file_name_generated_tmp_suffix = ' . q{'} . $file_name_generated_tmp_suffix . q{'} . "\n" );

        ( $FILE_HANDLE_GENERATED_TMP, $file_name_generated_tmp ) = tempfile( $file_name_generated_tmp . '.generated.tempfileXXXX', UNLINK => 1, TMPDIR => 1 );
#        RPerl::diag( 'in Generator->diff_check_file_vs_string(), have modified $file_name_generated_tmp = ' . q{'} . $file_name_generated_tmp . q{'} . "\n" );
#        RPerl::diag( 'in Generator->diff_check_file_vs_string(), about to save content $string_generated = $source_group->{' . $suffix_key . '} = ' . "\n" . $string_generated . "\n\n");

        print {$FILE_HANDLE_GENERATED_TMP} $string_generated or croak("\nERROR ECOGEFI00, GENERATOR, FILE SYSTEM: Attempting to save new file '$file_name_generated_tmp', cannot write to file,\ncroaking: $OS_ERROR");
        close $FILE_HANDLE_GENERATED_TMP or croak("\nERROR ECOGEFI01, GENERATOR, FILE SYSTEM: Attempting to save new file '$file_name_generated_tmp', cannot close file,\ncroaking: $OS_ERROR");

#        my string $astyle_path = can_run('astyle');
        if ( defined $astyle_path ) {
            # don't insert extra newlines, which causes accessors, mutators, and ops_types reporting subroutines to be broken into multiple lines
            my string $astyle_command = join q{ }, ($astyle_path, '-q', '--keep-one-line-blocks', '--keep-one-line-statements', $file_name_generated_tmp);
#            RPerl::diag( 'in Generator->diff_check_file_vs_string(), about to call system, have $astyle_command = ' . "\n" . $astyle_command . "\n" );
            system $astyle_command;
#            RPerl::diag( 'in Generator->diff_check_file_vs_string(), returned from call to system' . "\n" );

            if (( -e $file_name_generated_tmp . '.orig' ) and ( -f $file_name_generated_tmp . '.orig' )) {
                unlink( $file_name_generated_tmp . '.orig' ) or croak( "\n" . 'ERROR ECOGEFI02, GENERATOR, FILE SYSTEM: Cannot delete Artistic Style original file ' . q{'} . $file_name_generated_tmp . '.orig' . q{'} . ',' . "\n" . 'croaking:' . $OS_ERROR);
            }
            # DEV NOTE: astyle does not create a .orig file if there are no formatting changes made, so it is not actually a warning
#            else { RPerl::warning( 'WARNING WCOGEFI01, COMPILER, C++ CODE FORMATTING: Artistic Style command `astyle` did not create the file' . q{'} . $file_name_generated_tmp . '.orig' . q{'} . ', did something go wrong?' . "\n" ); }
        }
        else {
            RPerl::warning( 'WARNING WCOGEFI00, COMPILER, C++ CODE FORMATTING: Artistic Style command `astyle` not found, abandoning formatting' . "\n" );
        }

        if (( not -e $file_name_generated_tmp ) or ( not -f $file_name_generated_tmp ) or ( not -T $file_name_generated_tmp )) {
            die 'ERROR ECOGEDI07, RPERL GENERATOR, DIFF CHECK: Missing or invalid temporary AStyle-tidied file, ' . q{'} . $file_name_generated_tmp . q{'} . "\n" . ', dying' . "\n";
        }
    
        open $FILE_HANDLE_GENERATED_TMP, '<', $file_name_generated_tmp
            or die 'ERROR ECOGEDI08, RPERL GENERATOR, DIFF CHECK: Cannot open temporary AStyle-tidied file ' . q{'} . $file_name_generated_tmp . q{'} . ' for reading,' . $OS_ERROR . ', dying' . "\n";
    
        # read in tidied file
        my string $file_line_generated_tmp;
        while ( $file_line_generated_tmp = <$FILE_HANDLE_GENERATED_TMP> ) {
            $string_generated_tidied .= $file_line_generated_tmp . "\n";
        }

        close $FILE_HANDLE_GENERATED_TMP
            or die 'ERROR ECOGEDI09, RPERL GENERATOR, DIFF CHECK: Cannot close temporary AStyle-tidied file ' . q{'} . $file_name_generated_tmp . q{'} . ' after reading, ' . $OS_ERROR . ', dying' . "\n";
        
        # POST-PROCESS C++ SOURCE CODE     
        $string_generated_tidied = RPerl::Compiler::post_processor_cpp__header_or_cpp_path($string_generated_tidied, $file_name_group->{H});

        # discard code we are not currently checking, no extra work performed by post-processor
        my string_hashref $source_group_tmp = RPerl::Compiler::post_processor_cpp__types_change({$suffix_key => $string_generated_tidied}, $modes);
        $string_generated_tidied = $source_group_tmp->{$suffix_key};

        $string_reference_tidied = RPerl::Compiler::post_processor_cpp__comments_whitespace_delete($string_reference_tidied);
        $string_generated_tidied = RPerl::Compiler::post_processor_cpp__comments_whitespace_delete($string_generated_tidied);
    }

    # ACTUALLY START COMPARING REFERENCE VS GENERATED CODE STRINGS IN MEMORY

#    RPerl::diag( 'in Generator->diff_check_file_vs_string(), have $string_reference_tidied = ' . "\n" . ( q{=} x 60 ) . "\n" . $string_reference_tidied . "\n" . ( q{=} x 60 ) . "\n\n" );
#    RPerl::diag( 'in Generator->diff_check_file_vs_string(), have $string_generated_tidied = ' . "\n" . ( q{=} x 60 ) . "\n" . $string_generated_tidied . "\n" . ( q{=} x 60 ) . "\n\n" );

    my string_arrayref $string_reference_split   = [ ( split /\n/xms, $string_reference_tidied ) ];
    my string_arrayref $string_generated_split = [ ( split /\n/xms, $string_generated_tidied ) ];
    my string $line_generated;

    my hashref $return_value = {};
    $return_value->{diff_line} = 0;    # default return value, files do not differ

    for my integer $i ( 0 .. ( ( scalar @{$string_reference_split} ) - 1 ) ) {
        my string $line_reference = $string_reference_split->[$i];
        $line_generated = $string_generated_split->[$i];
        if ( $line_generated =~ /__DUMMY_SOURCE_CODE/xms ) {
            RPerl::warning( 'WARNING WCOGEDI00, RPERL GENERATOR, DIFF CHECK: Dummy source code found, attempt to utilize incomplete RPerl feature, abandoning check' . "\n" );
            $return_value->{diff_line} = -1;
            last;
        }
        
        # trim trailing whitespace
        $line_reference =~ s/\s+$//gxms;
        $line_generated =~ s/\s+$//gxms;

        if ( $line_reference ne $line_generated ) {
            #            RPerl::diag( 'in Generator->diff_check_file_vs_string(), have non-matching $line_reference =' . "\n" . $line_reference . "\n" );
            #            RPerl::diag( 'in Generator->diff_check_file_vs_string(), have non-matching $line_generated =' . "\n" . $line_generated . "\n" );
            $return_value->{diff_line} = $i + 1;    # arrays indexed from 0, file lines indexed from 1
            $return_value->{line_reference} = $line_reference;
            $return_value->{line_generated} = $line_generated;
            last;
        }
    }

#    RPerl::diag( 'in Generator->diff_check_file_vs_string(), about to return $return_value =' . "\n" . $return_value . "\n" );
    return $return_value;
};

# Generate from RPerl AST back to RPerl Source Code
our string_hashref $ast_to_rperl__generate = sub {
    ( my object $node, my string_hashref $modes) = @_;

    #    RPerl::diag("in Generator::ast_to_rperl__generate(), received \$node =\n" . RPerl::Parser::rperl_ast__dump($node) . "\n");
    #    RPerl::diag("in Generator::ast_to_rperl__generate(), received \$modes =\n" . Dumper($modes) . "\n");

    RPerl::verbose('GENERATE:           Generate RPerl syntax...       ');

    if ( not( defined $modes->{types} ) ) {
        die 'ERROR ECOGEMO00, RPERL GENERATOR, RPERL TYPES MODE: ' . q{'PERL'} . ' types mode expected in PERL ops mode, but undefined/null value found, dying' . "\n";
    }
    if ( not( $modes->{types} eq 'PERL' ) ) {
        die 'ERROR ECOGEMO01, RPERL GENERATOR, RPERL TYPES MODE: ' . q{'PERL'} . ' types mode expected in PERL ops mode, but non-matching value ' . q{'} . $modes->{types} . q{'} . ' found, dying' . "\n";
    }

    grammar_rules__map();

    # NEED FIX: check to ensure we are generating a valid return object
    my string_hashref $rperl_source_group = $node->ast_to_rperl__generate($modes);

    RPerl::verbose( ' done.' . "\n" );
    return $rperl_source_group;
};

# Generate from RPerl AST to C++ Source Code
our string_hashref $ast_to_cpp__generate = sub {
    ( my object $node, my string_hashref $modes) = @_;

    #    RPerl::diag("in Generator::ast_to_cpp__generate(), received \$node =\n" . RPerl::Parser::rperl_ast__dump($node) . "\n");
    #    RPerl::diag("in Generator::ast_to_cpp__generate(), received \$modes =\n" . Dumper($modes) . "\n");
    #    RPerl::diag( 'in Generator::ast_to_cpp__generate(), received $modes->{_symbol_table} = ' . "\n" . Dumper($modes->{_symbol_table}) . "\n" );

    RPerl::verbose('GENERATE:           Generate   C++ syntax...       ');

    if ( not( defined $modes->{types} ) ) {
        die 'ERROR ECOGEMO02, C++ GENERATOR, RPERL TYPES MODE: ' . q{'PERL' or 'CPP'} . ' types mode expected in CPP ops mode, but undefined/null value found, dying' . "\n";
    }
    if ( not( ( $modes->{types} eq 'PERL' ) or ( $modes->{types} eq 'CPP' ) ) ) {
        die 'ERROR ECOGEMO03, C++ GENERATOR, RPERL TYPES MODE: ' . q{'PERL' or 'CPP'} . ' types mode expected in CPP ops mode, but non-matching value ' . q{'} . $modes->{types} . q{'} . ' found, dying' . "\n";
    }

    grammar_rules__map();

    # NEED FIX: check to ensure we are generating a valid return object
    my string_hashref $cpp_source_group;

    if ( $modes->{types} eq 'PERL' ) {
        $cpp_source_group = $node->ast_to_cpp__generate__CPPOPS_PERLTYPES($modes);
    }
    else {
        $cpp_source_group = $node->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
    }

    RPerl::verbose( ' done.' . "\n" );
    return $cpp_source_group;
};

# Append All Source Code Entries From Group 2 Onto The Respective Entries In Group 1
#our string_hashref $source_group_append = sub {
our void $source_group_append = sub {
    ( my string_hashref $rperl_source_group_1, my string_hashref $rperl_source_group_2) = @_;

#    RPerl::diag('in Generator::source_group_append(), received $rperl_source_group_1 =' . "\n" . Dumper($rperl_source_group_1) . "\n");
#    RPerl::diag('in Generator::source_group_append(), received $rperl_source_group_2 =' . "\n" . Dumper($rperl_source_group_2) . "\n");

    my string $type_1;
    my string $type_2;
    foreach my string $suffix_key ( sort keys %{$rperl_source_group_2} ) {
        if ( defined $rperl_source_group_2->{$suffix_key} ) {
            $type_2 = ref $rperl_source_group_2->{$suffix_key};
            if ($type_2 eq q{}) { $type_2 = 'SCALAR'; }
            if (   ( exists $rperl_source_group_1->{$suffix_key} )
                and ( defined $rperl_source_group_1->{$suffix_key} ) ) {
                $type_1 = ref $rperl_source_group_1->{$suffix_key};
                if ($type_1 eq q{}) { $type_1 = 'SCALAR'; }
                if ($type_1 ne $type_2) {
                    die 'ERROR ECOGE00, GENERATOR: Source group entries type mismatch, ' . q{'} . $type_1 . q{'} . ' is different than ' . q{'} . $type_2 . q{'} . ', dying' . "\n";
                }
            }
            else { $type_1 = undef; }

#    RPerl::diag('in Generator::source_group_append(), have $type_1 =' .  $type_1 . "\n");
#    RPerl::diag('in Generator::source_group_append(), have $type_2 =' .  $type_2 . "\n");

            # init to empty thing if not already defined
            if ( not defined $type_1 ) {
                if ($type_2 eq 'ARRAY') {
                    $rperl_source_group_1->{$suffix_key} = [];
                }
                elsif ($type_2 eq 'HASH') {
                    $rperl_source_group_1->{$suffix_key} = {};
                }
                else {
                    $rperl_source_group_1->{$suffix_key} = q{};
                }
            }
            if ($type_2 eq 'ARRAY') {
                $rperl_source_group_1->{$suffix_key} = [@{$rperl_source_group_1->{$suffix_key}}, @{$rperl_source_group_2->{$suffix_key}}];
            }
            elsif ($type_2 eq 'HASH') {
                $rperl_source_group_1->{$suffix_key} = {%{$rperl_source_group_1->{$suffix_key}}, %{$rperl_source_group_2->{$suffix_key}}};
            }
            else {
                if (($suffix_key eq '_package_name') or ($suffix_key eq '_package_name_underscores')) {
                    # replace (don't append) special system data items
                    $rperl_source_group_1->{$suffix_key} = $rperl_source_group_2->{$suffix_key};
                }
                else {
                    $rperl_source_group_1->{$suffix_key} .= $rperl_source_group_2->{$suffix_key};
                }
            }
        }
    }
};

our void $grammar_rules__map = sub {

    # do not attempt to re-map grammar rules if already mapped
    if (    ( exists &CompileUnit_5::ast_to_rperl__generate )
        and ( defined &CompileUnit_5::ast_to_rperl__generate ) )
    {
        return;
    }

    #    RPerl::diag("in Generator::grammar_rules__map(), have \$RPerl::Grammar::RULES =\n" . Dumper($RPerl::Grammar::RULES) . "\n");
    foreach my string $rule ( sort keys %{$RPerl::Grammar::RULES} ) {

        # create mapped class/package (namespace) and set up Perl inheritance
        my string $eval_string
            = 'package '
            . $rule
            . q{; use parent qw(}
            . $RPerl::Grammar::RULES->{$rule}
            . q{); use }
            . $RPerl::Grammar::RULES->{$rule}
            . q{; our hashref $properties = {}; 1;};

        #        RPerl::diag('in Generator::grammar_rules_map(), have 1st $eval_string = ' . "\n" . $eval_string . "\n");
        my integer $eval_retval = eval $eval_string;
        if ( ( not defined $eval_retval ) or ( $EVAL_ERROR ne q{} ) ) {
            die 'ERROR ECOGE01, GENERATOR: Grammar rules map, failed to create pre-mapped namespace, dying' . "\n" . $EVAL_ERROR . "\n";
        }

        #        if (not defined $eval_retval) {die $EVAL_ERROR . "\n";}

# copy all subroutines (and thus methods) from original class/package (namespace) into mapped class/package at runtime;
# DEV NOTE: I thought this would be handled automatically by Perl inheritance above, but I guess not, probably due to how Class.pm sets subroutines during INIT compile time
# NEED REMOVE HIGH MAGIC: double-eval'ed short form, long form available in scripts/development/unused/rsubs.pl, possibly replace this entire grammar_rules__map() subroutine with hard-coded *.pm files
        $eval_string
            = q[foreach my $key ( keys %]
            . $RPerl::Grammar::RULES->{$rule}
            . q[:: ) { if (defined &{ $]
            . $RPerl::Grammar::RULES->{$rule}
            . q[::{ $key} } ) { if (not defined eval q<*{]
            . $rule
            . q[::> . $key . q<} = sub { return &{ $]
            . $RPerl::Grammar::RULES->{$rule}
            . q[::{'> . $key . q<'} }(@_); };>) {die $EVAL_ERROR . "\n";} } }];

        #        RPerl::diag('in Generator::grammar_rules_map(), have 2nd $eval_string = ' . "\n" . $eval_string . "\n");
        $eval_retval = eval $eval_string;
        if ( ( not defined $eval_retval ) or ( $EVAL_ERROR ne q{} ) ) {
            die 'ERROR ECOGE02, GENERATOR: Grammar rules map, failed copy subroutines into mapped namespace, dying' . "\n" . $EVAL_ERROR . "\n";
        }
    }
};

1;    # end of class
