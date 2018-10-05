# [[[ HEADER ]]]
package RPerl::CompileUnit::Program;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.008_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit);
use RPerl::CompileUnit;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub ast_to_rperl__generate {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $rperl_source_group = { PMC => q{} };
    my string_hashref $rperl_source_subgroup;

#    RPerl::diag( 'in Program->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag('in Program->ast_to_rperl__generate(), received $modes = ' . "\n" . Dumper($modes) . "\n");

    # all programs begin in the 'main::' Perl namespace, which is equivalent to an empty C++ namespace
    $modes->{_symbol_table}->{_namespace} = q{};

    # all programs begin in no Perl subroutine, which is equivalent to the C++ 'main()' function
    $modes->{_symbol_table}->{_subroutine} = q{};

    my string $self_class = ref $self;

    # unwrap Program_18 from CompileUnit_4
    if ( ($self_class) eq 'CompileUnit_4' ) {
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( ($self_class) ne 'Program_18' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP000, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule ' . ($self_class) . ' found where Program_18 expected, dying' )
            . "\n";
    }

    # Program -> SHEBANG Critic? USE_RPERL Header Critic* Include* Constant* Subroutine* Operation+
    my string $shebang         = $self->{children}->[0];
    my object $critic_optional = $self->{children}->[1];
    my string $use_rperl       = $self->{children}->[2];    # PERLOPS only

    # Header -> 'use strict;' 'use warnings;' USE_RPERL_AFTER? 'our' VERSION_NUMBER_ASSIGN;
    my object $header                   = $self->{children}->[3];
    my string $use_strict               = $header->{children}->[0];    # PERLOPS only
    my string $use_warnings             = $header->{children}->[1];    # PERLOPS only
    my string $use_rperl_after_optional = $header->{children}->[2];    # PERLOPS only
    my string $our_keyword              = $header->{children}->[3];    # PERLOPS only
    my string $version_number           = $header->{children}->[4];

    my object $critic_star     = $self->{children}->[4];
    my object $include_star    = $self->{children}->[5];
    my object $constant_star   = $self->{children}->[6];
    my object $subroutine_star = $self->{children}->[7];
    my object $operation_plus  = $self->{children}->[8];

    $rperl_source_group->{PMC} = $shebang;
    if ( ( exists $critic_optional->{children}->[0] ) and ( defined $critic_optional->{children}->[0] ) ) {
        $rperl_source_group->{PMC} .= q{ };
        $rperl_source_subgroup = $critic_optional->{children}->[0]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }
    else {
        $rperl_source_group->{PMC} .= "\n";
    }

    if ( $modes->{label} eq 'ON' ) {
        $rperl_source_group->{PMC} .= '# [[[ HEADER ]]]' . "\n";
    }
    # DEV NOTE: now that 'use RPerl;' is a source filter, it is technically not part of the Header grammar rule, instead 'use RPerl::AfterSubclass;' is in Header;
    # nevertheless, we are treating 'use RPerl;' as part of the header in our RPerl application source code, so it appears under the '# [[[ HEADER ]]]' label
    # both here in RPerl::CompileUnit::Program, as well as in RPerl::CompileUnit::Module::Header
    $rperl_source_group->{PMC} .= $use_rperl . "\n";
    $rperl_source_group->{PMC} .= $use_strict . "\n";
    $rperl_source_group->{PMC} .= $use_warnings . "\n";
    if ( ( exists $use_rperl_after_optional->{children}->[0] ) and ( defined $use_rperl_after_optional->{children}->[0] ) ) {
        $rperl_source_group->{PMC} .= $use_rperl_after_optional->{children}->[0]->{attr} . "\n";
    }

    # DEV NOTE, CORRELATION #rp014: the hard-coded ' $VERSION = ' & ';' below are the only discarded tokens in the RPerl grammar,
    # due to the need to differentiate between v-numbers and otherwise-identical normal numbers
    $rperl_source_group->{PMC} .= $our_keyword . ' $VERSION = ' . $version_number . q{;} . "\n";

    if ( exists $critic_star->{children}->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $rperl_source_group->{PMC} .= '# [[[ CRITICS ]]]' . "\n";
        }
    }
    foreach my object $critic ( @{ $critic_star->{children} } ) {
        $rperl_source_subgroup = $critic->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }

    if ( exists $include_star->{children}->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $rperl_source_group->{PMC} .= "\n" . '# [[[ INCLUDES ]]]' . "\n";
        }
    }
    foreach my object $include ( @{ $include_star->{children} } ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        $rperl_source_subgroup = $include->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }

    # after processing includes, all programs return to the 'main::' Perl namespace, which is equivalent to an empty C++ namespace
    $modes->{_symbol_table}->{_namespace} = q{};

    if ( exists $constant_star->{children}->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $rperl_source_group->{PMC} .= "\n" . '# [[[ CONSTANTS ]]]' . "\n";
        }
    }
    foreach my object $constant ( @{ $constant_star->{children} } ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        $rperl_source_subgroup = $constant->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }

    if ( exists $subroutine_star->{children}->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $rperl_source_group->{PMC} .= "\n" . '# [[[ SUBROUTINES ]]]' . "\n";
        }
    }
    foreach my object $subroutine (    ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        @{ $subroutine_star->{children} }
        )
    {
        $rperl_source_subgroup = $subroutine->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }

    # after processing subroutines, all programs return to being in no Perl subroutine, which is equivalent to the C++ 'main()' function
    $modes->{_symbol_table}->{_subroutine} = q{};

    if ( $modes->{label} eq 'ON' ) {
        $rperl_source_group->{PMC} .= "\n" . '# [[[ OPERATIONS ]]]' . "\n";
    }
    foreach my object $operation (     ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        @{ $operation_plus->{children} }
        )
    {
        $rperl_source_subgroup = $operation->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }

    # Programs only generate EXE output, not PMC output
    $rperl_source_group->{EXE} = $rperl_source_group->{PMC};
    delete $rperl_source_group->{PMC};
    return $rperl_source_group;
}


sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = {
        CPP => q{// <<< RP::CU::P __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n",
        H   => q{// <<< RP::CU::P __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n",
        PMC => q{# <<< RP::CU::P __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n",
        EXE => q{// <<< RP::CU::P __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n"
    };

    #...
    return $cpp_source_group;
}


sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{} };
#    my string_hashref $cpp_source_group = { CPP => q{}, H => q{} };  # DEV NOTE, CORRELATION #rp039: programs never have header files
    my string_hashref $cpp_source_subgroup;
    my integer $cpp_source_group_CPP_line_count = 0;

#    RPerl::diag( 'in Program->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag('in Program->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $modes = ' . "\n" . Dumper($modes) . "\n");

    # all programs begin in the 'main::' Perl namespace, which is equivalent to an empty C++ namespace
    $modes->{_symbol_table}->{_namespace} = q{};

    # all programs begin in no Perl subroutine, which is equivalent to the C++ 'main()' function
    $modes->{_symbol_table}->{_subroutine} = q{};

    my string $self_class = ref $self;

    # unwrap Program_18 from CompileUnit_4
    if ( ($self_class) eq 'CompileUnit_4' ) {
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( ($self_class) ne 'Program_18' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP000, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule ' . ($self_class) . ' found where Program_18 expected, dying' )
            . "\n";
    }

    # Program -> SHEBANG Critic? USE_RPERL Header Critic* Include* Constant* Subroutine* Operation+
    my string $shebang         = $self->{children}->[0];
    my object $critic_optional = $self->{children}->[1];
    my string $use_rperl       = $self->{children}->[2];    # PERLOPS only

    # Header -> 'use strict;' 'use warnings;' USE_RPERL_AFTER? 'our' VERSION_NUMBER_ASSIGN;
    my object $header                   = $self->{children}->[3];
    my string $use_strict               = $header->{children}->[0];    # PERLOPS only
    my string $use_warnings             = $header->{children}->[1];    # PERLOPS only
    my string $use_rperl_after_optional = $header->{children}->[2];    # PERLOPS only
    my string $our_keyword              = $header->{children}->[3];    # PERLOPS only
    my string $version_number           = $header->{children}->[4];
    my integer $header_line_number      = $header->{line_number};

    my object $critic_star     = $self->{children}->[4];
    my object $include_star    = $self->{children}->[5];
    my object $constant_star   = $self->{children}->[6];
    my object $subroutine_star = $self->{children}->[7];
    my object $operation_plus  = $self->{children}->[8];

#    RPerl::diag('in Program->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $include_star = ' . "\n" . RPerl::Parser::rperl_ast__dump($include_star) . "\n");
#    RPerl::diag('in Program->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $subroutine_star = ' . "\n" . RPerl::Parser::rperl_ast__dump($subroutine_star) . "\n");

    # NEED ANSWER: should we modify the user-provided shebang as done here, or simply replace it with a hard-coded one pointing to /usr/bin?   //!/usr/bin/rperl
    substr $shebang, 0, 2, '//!';
    substr $shebang, -4, 4, 'rperl';
    $cpp_source_group->{CPP} = $shebang . "\n";

    if ( $modes->{label} eq 'ON' ) {
        if ($header_line_number > 6) {
            $cpp_source_group->{CPP} .= "\n" x ($header_line_number - 6);
        }
        $cpp_source_group->{CPP} .= '// [[[ HEADER ]]]' . "\n";
    }
    $cpp_source_group->{CPP} .= '#include <rperlstandalone.h>' . "\n";

    # DEV NOTE: must have $pl_file_path for support checking below; GMP, GSL, MongoDB 
#    RPerl::diag( 'in Program->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modes->{_enable_mongodb} = ' . Dumper($modes->{_enable_mongodb}) . "\n" );
    my string $pl_file_path = $modes->{_input_file_name};

    RPerl::diag( 'in Program->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $pl_file_path = ' . $pl_file_path . "\n" );
    $pl_file_path = RPerl::Compiler::post_processor__INC_paths_delete($pl_file_path, 1, 0);  # $leading_slash_delete = 1, $leading_lib_delete = 0
    $pl_file_path = RPerl::Compiler::post_processor__absolute_path_delete($pl_file_path);
    $pl_file_path = RPerl::Compiler::post_processor__current_directory_path_delete($pl_file_path);
    RPerl::diag( 'in Program->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have possibly-trimmed $pl_file_path = ' . $pl_file_path . "\n" );







    # START HERE: convert rperl*.h to RPerl/Support/*.h and RPerl/Support/*StandAlone.h, as in RPerl/Support/MongoDB.h
    # START HERE: convert rperl*.h to RPerl/Support/*.h and RPerl/Support/*StandAlone.h, as in RPerl/Support/MongoDB.h
    # START HERE: convert rperl*.h to RPerl/Support/*.h and RPerl/Support/*StandAlone.h, as in RPerl/Support/MongoDB.h


#    RPerl::diag('in Program->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modes->{_enable_sse} = ' . Dumper($modes->{_enable_sse}) . "\n");
    if ( ( exists $modes->{_enable_sse} ) and ( defined $modes->{_enable_sse} ) ) {
        foreach my string $enabled_file_name ( keys %{ $modes->{_enable_sse} } ) {
            if ( ( $enabled_file_name =~ /$pl_file_path$/xms ) and ( $modes->{_enable_sse}->{$enabled_file_name} ) ) {
                $cpp_source_group->{CPP} .= '#include <RPerl/Support/SSEStandAlone.h>' . "\n";  # DEV NOTE, CORRELATION #rp039: programs never have header files, append to CPP instead of H
            }
        }
    }

#    RPerl::diag('in Program->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modes->{_enable_gmp} = ' . Dumper($modes->{_enable_gmp}) . "\n");
    if ( ( exists $modes->{_enable_gmp} ) and ( defined $modes->{_enable_gmp} ) ) {
        foreach my string $enabled_file_name ( keys %{ $modes->{_enable_gmp} } ) {
            if ( ( $enabled_file_name =~ /$pl_file_path$/xms ) and ( $modes->{_enable_gmp}->{$enabled_file_name} ) ) {
                $cpp_source_group->{CPP} .= '#include <RPerl/Support/GMPStandAlone.h>' . "\n";  # DEV NOTE, CORRELATION #rp039: programs never have header files, append to CPP instead of H
            }
        }
    }

#    RPerl::diag('in Program->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modes->{_enable_gsl} = ' . Dumper($modes->{_enable_gsl}) . "\n");
    if ( ( exists $modes->{_enable_gsl} ) and ( defined $modes->{_enable_gsl} ) ) {
        foreach my string $enabled_file_name ( keys %{ $modes->{_enable_gsl} } ) {
            if ( ( $enabled_file_name =~ /$pl_file_path$/xms ) and ( $modes->{_enable_gsl}->{$enabled_file_name} ) ) {
                $cpp_source_group->{CPP} .= '#include <RPerl/Support/GLSStandAlone.h>' . "\n";  # DEV NOTE, CORRELATION #rp039: programs never have header files, append to CPP instead of H
            }
        }
    }

#    RPerl::diag('in Program->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modes->{_enable_mongodb} = ' . Dumper($modes->{_enable_mongodb}) . "\n");
    if ( ( exists $modes->{_enable_mongodb} ) and ( defined $modes->{_enable_mongodb} ) ) {
        foreach my string $enabled_file_name ( keys %{ $modes->{_enable_mongodb} } ) {
            if ( ( $enabled_file_name =~ /$pl_file_path$/xms ) and ( $modes->{_enable_mongodb}->{$enabled_file_name} ) ) {
#                RPerl::diag('in Program->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $modes->{_enable_mongodb}->{' . $enabled_file_name . '} = TRUE' . "\n");
                $cpp_source_group->{CPP} .= '#include <RPerl/Support/MongoDBStandAlone.h>' . "\n";  # DEV NOTE, CORRELATION #rp039: programs never have header files, append to CPP instead of H
            }
        }
    }






    my string $file_name_underscores = $modes->{_input_file_name};
#    $file_name_underscores =~ s/^[\/\\.]*//gxms;  # remove leading forward slashes, back slashes, and dots
    substr $file_name_underscores, -3, 3, q{};  # remove trailing '.pl'

    $file_name_underscores = RPerl::Compiler::post_processor_cpp__header_or_cpp_path('__NEED_CPP_PATH', $file_name_underscores);

    $file_name_underscores =~ s/[\/\\]/__/gxms;  # replace forward slashes and back slashes with double-underscores
    $file_name_underscores =~ s/[.-]/_/gxms;  # replace dots and hyphens with underscores
    $cpp_source_group->{CPP} .= '#ifndef __CPP__INCLUDED__' . $file_name_underscores . '_cpp' . "\n";
    $cpp_source_group->{CPP} .= '#define __CPP__INCLUDED__' . $file_name_underscores . '_cpp ' . $version_number . "\n";
    $cpp_source_group->{CPP} .= '# ifdef __CPP__TYPES' . "\n";
    
    if (( exists $critic_star->{children}->[0] ) and ( $modes->{label} eq 'ON' )) {
        $cpp_source_group->{CPP} .= "\n" x (scalar @{ $critic_star->{children} });  # insert one blank line for each Critic
    }

    if ( exists $include_star->{children}->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $cpp_source_group->{CPP} .= "\n" . '// [[[ INCLUDES ]]]' . "\n";
        }
    }
    foreach my object $include ( @{ $include_star->{children} } ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
#        RPerl::diag('in Program->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $include = ' . "\n" . RPerl::Parser::rperl_ast__dump($include) . "\n");
        $cpp_source_subgroup = $include->ast_to_cpp__generate__CPPOPS_CPPTYPES('main', $modes);

        # DEV NOTE, CORRELATION #rp039: programs never have header files, due to the following reasons:
        # 1.  all Perl subroutines (C++ functions) are declared before the C++ main() function is executed, which serves the dual purpose of defining the C++ functions as well, so no C++ function prototypes are necessary, which would normall be in the header file
        # 2.  programs never contain class definitions, so again there is no class declaration or definition code which needs to go into a header file
#        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
        if (defined $cpp_source_subgroup->{H}) {
            $cpp_source_group->{CPP} .= $cpp_source_subgroup->{H};
        }
    }
#    RPerl::diag('in Program->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $cpp_source_group = ' . "\n" . RPerl::Parser::rperl_ast__dump($cpp_source_group) . "\n");

    # DEV NOTE, CORRELATION #rp039: programs never have header files
#    $cpp_source_group->{CPP} .= '#include "__NEED_HEADER_PATH"' . "\n";  # DEV NOTE, CORRELATION #rp033: defer setting header include path until files are saved in Compiler

    # after processing includes, all programs return to the 'main::' Perl namespace, which is equivalent to an empty C++ namespace
    $modes->{_symbol_table}->{_namespace} = q{};

    if ( exists $constant_star->{children}->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $cpp_source_group->{CPP} .= "\n" . '// [[[ CONSTANTS ]]]' . "\n";
        }
    }
    foreach my object $constant ( @{ $constant_star->{children} } ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        $cpp_source_subgroup = $constant->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
    }

    if ( exists $subroutine_star->{children}->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $cpp_source_group->{CPP} .= "\n" . '// [[[ SUBROUTINES ]]]' . "\n";
        }
    }
    foreach my object $subroutine (    ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        @{ $subroutine_star->{children} }
        )
    {
#        RPerl::diag('in Program->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $subroutine = ' . "\n" . RPerl::Parser::rperl_ast__dump($subroutine) . "\n");

        $cpp_source_subgroup = $subroutine->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
        $cpp_source_group->{CPP} .= "\n\n";
    }

    # after processing subroutines, all programs return to being in no Perl subroutine, which is equivalent to the C++ 'main()' function
    $modes->{_symbol_table}->{_subroutine} = q{};

    # BEGIN C++ main() function wrapper, to contain all operations which are not inside a subroutine
    $cpp_source_group->{CPP} .= 'int main() {';

    if ( $modes->{label} eq 'ON' ) { 
        $cpp_source_group->{CPP} .= "\n" . '  // [[[ OPERATIONS HEADER ]]]' . "\n";
    }

    my string $CPP_saved = $cpp_source_group->{CPP};
    $cpp_source_group->{CPP} = q{};

    if ( $modes->{label} eq 'ON' ) {
        $cpp_source_group->{CPP} .= "\n" . '// [[[ OPERATIONS ]]]' . "\n";
    }

    foreach my object $operation (     ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        @{ $operation_plus->{children} }
        )
    {
        $cpp_source_subgroup = $operation->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
#        RPerl::diag('in Program->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $cpp_source_subgroup = ' . "\n" . RPerl::Parser::rperl_ast__dump($cpp_source_subgroup) . "\n");
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
    }

    my integer $num_loop_iterators = 0;
    if ((exists $modes->{_loop_iterators}) and (defined $modes->{_loop_iterators})) {
        $num_loop_iterators = scalar keys %{$modes->{_loop_iterators}};
    }

    # COMPILE-TIME OPTIMIZATION #02: declare all loop iterators at top of subroutine/method to avoid re-declarations in nested loops
#    if ((exists $modes->{_loop_iterators}) and (defined $modes->{_loop_iterators})) {
    if ($num_loop_iterators) {  # shortcut
        foreach my string $loop_iterator_symbol (sort keys %{$modes->{_loop_iterators}}) {
            $CPP_saved .= $modes->{_loop_iterators}->{$loop_iterator_symbol} . q{ } . $loop_iterator_symbol . ';' . "\n";
        }
        delete $modes->{_loop_iterators};
    }

    $cpp_source_group_CPP_line_count = ($cpp_source_group->{CPP} =~ tr/\n//) + 1;  # add 1 to count last line which does not have newline
    my integer $operations_line_number = $operation_plus->{children}->[0]->{line_number};
#    RPerl::diag('in Program->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $cpp_source_group_CPP_line_count = ' . $cpp_source_group_CPP_line_count . "\n");
#    RPerl::diag('in Program->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $operations_line_number = ' . $operations_line_number . "\n");

    if ( $modes->{label} eq 'ON' ) { 
        my integer $newline_count = (($operations_line_number - $cpp_source_group_CPP_line_count) - (2 + $num_loop_iterators));
        if ($newline_count < 0) { $newline_count = 0; }
        $cpp_source_group->{CPP} .= "\n" x $newline_count;
    }

    $CPP_saved .= $cpp_source_group->{CPP};
    $cpp_source_group->{CPP} = $CPP_saved;
        
    if ( $modes->{label} eq 'ON' ) { $cpp_source_group->{CPP} .= "\n" x 3; }
    if ( $modes->{label} eq 'ON' ) { $cpp_source_group->{CPP} .= '    // [[[ OPERATIONS FOOTER ]]]' . "\n"; }

    # END C++ main() function wrapper
    $cpp_source_group->{CPP} .= '    return 0;' . "\n" . '}' . "\n\n";

    if ( $modes->{label} eq 'ON' ) { $cpp_source_group->{CPP} .= '// [[[ FOOTER ]]]' . "\n"; }
    $cpp_source_group->{CPP} .= <<EOF;
# elif defined __PERL__TYPES
Purposefully_die_from_a_compile-time_error,_due_to____PERL__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!
# endif
#endif
EOF

#    RPerl::diag('in Program->ast_to_cpp__generate__CPPOPS_CPPTYPES(), bottom of subroutine, have $modes->{_symbol_table} = ' . "\n" . Dumper($modes->{_symbol_table}) . "\n");
#    RPerl::diag('in Program->ast_to_cpp__generate__CPPOPS_CPPTYPES(), about to return $cpp_source_group = ' . "\n" . RPerl::Parser::rperl_ast__dump($cpp_source_group) . "\n");
    return $cpp_source_group;
}

1;    # end of class
