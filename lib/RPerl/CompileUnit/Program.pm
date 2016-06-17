# [[[ HEADER ]]]
package RPerl::CompileUnit::Program;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.001_100;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit);
use RPerl::CompileUnit;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

our string_hashref::method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $rperl_source_group = { PMC => q{} };
    my string_hashref $rperl_source_subgroup;

#    RPerl::diag( 'in Program->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag('in Program->ast_to_rperl__generate(), received $modes = ' . "\n" . Dumper($modes) . "\n");

    my string $self_class = ref $self;

    # unwrap Program_18 from CompileUnit_4
    if ( ($self_class) eq 'CompileUnit_4' ) {
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( ($self_class) ne 'Program_18' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule ' . ($self_class) . ' found where Program_18 expected, dying' )
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

    # DEV NOTE, CORRELATION #rp14: the hard-coded ' $VERSION = ' & ';' below are the only discarded tokens in the RPerl grammar,
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
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = {
        CPP => q{// <<< RP::CU::P __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n",
        H   => q{// <<< RP::CU::P __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n",
        PMC => q{# <<< RP::CU::P __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n",
        EXE => q{// <<< RP::CU::P __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n"
    };

    #...
    return $cpp_source_group;
};

our string_hashref::method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes) = @_;
    my string_hashref $cpp_source_group = { CPP => q{} };
    my string_hashref $cpp_source_subgroup;
    my integer $cpp_source_group_CPP_line_count = 0;

#    RPerl::diag( 'in Program->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag('in Program->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $modes = ' . "\n" . Dumper($modes) . "\n");

    my string $self_class = ref $self;

    # unwrap Program_18 from CompileUnit_4
    if ( ($self_class) eq 'CompileUnit_4' ) {
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( ($self_class) ne 'Program_18' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule ' . ($self_class) . ' found where Program_18 expected, dying' )
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

    # NEED ANSWER: should we modify the user-provided shebang as done here, or simply replace it with a hard-coded one pointing to /usr/bin?   //!/usr/bin/rperl
    substr $shebang, 0, 2, '//!';
    substr $shebang, -4, 4, 'rperl';
    $cpp_source_group->{CPP} = $shebang . "\n";

    if ( $modes->{label} eq 'ON' ) {
        $cpp_source_group->{CPP} .= "\n" x ($header_line_number - 6);
        $cpp_source_group->{CPP} .= '// [[[ HEADER ]]]' . "\n";
    }
    $cpp_source_group->{CPP} .= '#include <rperlstandalone.h>' . "\n";

    my string $file_name_underscores = $modes->{_input_file_name};
    $file_name_underscores =~ s/^[\/\\.]*//gxms;  # remove leading forward slashes, back slashes, and dots
    substr $file_name_underscores, -3, 3, q{};  # remove trailing '.pl'
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
        $cpp_source_subgroup = $include->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
    }

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
        $cpp_source_subgroup = $subroutine->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
    }







    $cpp_source_group->{CPP} .= 'int main() {';

    $cpp_source_group_CPP_line_count = ($cpp_source_group->{CPP} =~ tr/\n//) + 1;  # add 1 to count last line which does not have newline
    my integer $operations_line_number = $operation_plus->{children}->[0]->{line_number};
#    RPerl::diag('in Program->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $cpp_source_group_CPP_line_count = ' . $cpp_source_group_CPP_line_count . "\n");
#    RPerl::diag('in Program->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $operations_line_number = ' . $operations_line_number . "\n");


    if ( $modes->{label} eq 'ON' ) { 
        $cpp_source_group->{CPP} .= '  // [[[ OPERATIONS HEADER ]]]';
        $cpp_source_group->{CPP} .= "\n" x (($operations_line_number - $cpp_source_group_CPP_line_count) - 2);
    }




    if ( $modes->{label} eq 'ON' ) {
        $cpp_source_group->{CPP} .= "\n" . '// [[[ OPERATIONS ]]]' . "\n";
    }
    foreach my object $operation (     ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        @{ $operation_plus->{children} }
        )
    {
        $cpp_source_subgroup = $operation->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
    }




        
    if ( $modes->{label} eq 'ON' ) { $cpp_source_group->{CPP} .= "\n" x 3; }
    if ( $modes->{label} eq 'ON' ) { $cpp_source_group->{CPP} .= '    // [[[ OPERATIONS FOOTER ]]]' . "\n"; }
    $cpp_source_group->{CPP} .= '    return 0;' . "\n" . '}' . "\n\n";

    if ( $modes->{label} eq 'ON' ) { $cpp_source_group->{CPP} .= '// [[[ FOOTER ]]]' . "\n"; }
    $cpp_source_group->{CPP} .= <<EOF;
# elif defined __PERL__TYPES
Purposefully_die_from_a_compile-time_error,_due_to____PERL__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!
# endif
#endif
EOF

    return $cpp_source_group;
};

1;    # end of class
