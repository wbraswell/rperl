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

# [[[ OO METHODS & SUBROUTINES ]]]

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
            'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule ' . ($self_class) . ' found where Program_18 expected, dying' )
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
    my string_hashref $cpp_source_group = {
        CPP => q{// <<< RP::CU::P __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>} . "\n",
        H   => q{// <<< RP::CU::P __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>} . "\n",
        PMC => q{# <<< RP::CU::P __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>} . "\n",
        EXE => q{// <<< RP::CU::P __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>} . "\n"
    };

    #...
    return $cpp_source_group;
};

1;    # end of class
