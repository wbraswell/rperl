# [[[ HEADER ]]]
package RPerl::CompileUnit::Module::Package;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.001_100;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module);
use RPerl::CompileUnit::Module;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use RPerl::Parser;
use RPerl::Generator;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub ast_to_rperl__generate {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string $package_name_underscores, my string_hashref $modes ) = @ARG;
    my string_hashref $rperl_source_group = {};

#    RPerl::diag( 'in Package->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    # unwrap Package_36 from Module_24
    if ( ($self_class) eq 'Module_24' ) {
        $self = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( ($self_class) ne 'Package_36' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . ($self_class)
                . ' found where Module_24 or Package_36 expected, dying' )
            . "\n";
    }

    # Package:   Critic* Include* Constant* Subroutine+ LITERAL_NUMBER ';' ;
    # Package -> STAR-10 STAR-11  STAR-12   PLUS-13     LITERAL_NUMBER ';'
    my object $critic_star           = $self->{children}->[0];
    my object $include_star          = $self->{children}->[1];
    my object $constant_star         = $self->{children}->[2];
    my object $subroutine_plus       = $self->{children}->[3];
    my string $retval_literal_number = $self->{children}->[4];
    my string $retval_semicolon      = $self->{children}->[5];

    my string_hashref $rperl_source_subgroup;

    if ( exists $critic_star->{children}->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $rperl_source_group->{PMC} .= '# [[[ CRITICS ]]]' . "\n";
        }
    }
    foreach my object $critic ( @{ $critic_star->{children} } ) {
        $rperl_source_subgroup = $critic->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
    }

    if ( exists $include_star->{children}->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $rperl_source_group->{PMC} .= "\n" . '# [[[ INCLUDES ]]]' . "\n";
        }
    }
    foreach my object $include ( @{ $include_star->{children} } ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        $rperl_source_subgroup = $include->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
    }

    if ( exists $constant_star->{children}->[0] ) {
        if ( $modes->{label} eq 'ON' ) {
            $rperl_source_group->{PMC} .= "\n" . '# [[[ CONSTANTS ]]]' . "\n";
        }
    }
    foreach my object $constant ( @{ $constant_star->{children} } ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        $rperl_source_subgroup = $constant->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
    }

    # always have at least one subroutine, don't need to check if they exist to label
    if ( $modes->{label} eq 'ON' ) {
        $rperl_source_group->{PMC} .= "\n" . '# [[[ SUBROUTINES ]]]' . "\n";
    }
    foreach my object $subroutine ( ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
        @{ $subroutine_plus->{children} }
        )
    {
        $rperl_source_subgroup
            = $subroutine->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group,
            $rperl_source_subgroup );
    }

    if ( $modes->{label} eq 'ON' ) {
        $rperl_source_group->{PMC}
            .= "\n"
            . $retval_literal_number
            . $retval_semicolon
            . '  # end of package' . "\n";
    }
    else {
        $rperl_source_group->{PMC}
            .= $retval_literal_number . $retval_semicolon . "\n";
    }
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string $package_name_underscores, my string_hashref $modes ) = @ARG;
    my string_hashref $cpp_source_group = {
        CPP =>
            q{// <<< RP::CU::M::P __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n",
        H => q{// <<< RP::CU::M::P __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n",
#        PMC => q{# <<< RP::CU::M::P __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n"
    };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string $package_name_underscores, my string_hashref $modes ) = @ARG;
    my string_hashref $cpp_source_group = {
        CPP => q{// <<< RP::CU::M::P __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>}
            . "\n",
        H => q{// <<< RP::CU::M::P __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>}
            . "\n",
#        PMC => q{# <<< RP::CU::M::P __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>} . "\n"
    };

    #...
    return $cpp_source_group;
}

1;    # end of class
