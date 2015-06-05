# [[[ HEADER ]]]
package RPerl::CompileUnit::Module::Package;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

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

# [[[ OO METHODS & SUBROUTINES ]]]

our string_hashref_method $ast_to_rperl__generate = sub {
    ( my object $self, my string_hashref $modes ) = @_;
    my string_hashref $rperl_source_group = {};

#    RPerl::diag( 'in Package->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    # unwrap Package_32 from Module_22
    if ( ($self_class) eq 'Module_22' ) {
        $self = $self->{children}->[0];
        $self_class = ref $self;
    }

    if ( ($self_class) ne 'Package_32' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECVGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: grammar rule '
                . ($self_class)
                . ' found where Module_22 or Package_32 expected, dying' )
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
            $rperl_source_group->{PMC}
                .= "\n" . '# [[[ SUBROUTINES ]]]' . "\n";
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
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_PERLTYPES = sub {
    ( my object $self, my string_hashref $modes ) = @_;
    my string_hashref $cpp_source_group = {
        CPP =>
            q{// <<< RP::CU::M::P __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n",
        H => q{// <<< RP::CU::M::P __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n",
        PMC => q{# <<< RP::CU::M::P __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
            . "\n"
    };

    #...
    return $cpp_source_group;
};

our string_hashref_method $ast_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self, my string_hashref $modes ) = @_;
    my string_hashref $cpp_source_group = {
        CPP => q{// <<< RP::CU::M::P __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>}
            . "\n",
        H => q{// <<< RP::CU::M::P __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>}
            . "\n",
        PMC => q{# <<< RP::CU::M::P __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>}
            . "\n"
    };

    #...
    return $cpp_source_group;
};

1;    # end of class

=DISABLED OLD
# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    name => my string $TYPED_name = undef,
    version => my string $TYPED_version = undef, # NEED UPGRADE: convert vstring from string type to number type?
    includes    => my string_arrayref $TYPED_includes    = undef,
    subroutines => my object_arrayref $TYPED_subroutines = undef
};

# GENERATE CPPOPS_CPPTYPES
our string_method $rperl_to_cpp__generate__CPPOPS_CPPTYPES = sub {
    ( my object $self ) = @_;    # object method
    my string $self_generated = q{};

#RPerl::diag "in Package::rperl_to_cpp__generate__CPPOPS_CPPTYPES(), received \$self = \n" . Dumper($self) . "\n";
#$self_generated .= "// <<< PACKAGE RULE, BEGIN CPPOPS_CPPTYPES >>>\n"; # DEBUG TEMP

    $self_generated
        .= q{// namespace }
        . $self->{name}
        . q{;  // NEED UPGRADE: Perl vs C++ namespace compatibility} . "\n";
    $self_generated .= q{using std::cout;} . "\n";
    $self_generated .= q{using std::cerr;} . "\n";
    $self_generated .= q{// VERSION } . $self->{version} . "\n";
    $self_generated
        .= q{#include <rperltypes.h>  // for data types and structures}
        . "\n";
    $self_generated
        .= q{#include <RPerl/HelperFunctions.cpp>  // -> HelperFunctions.h}
        . "\n\n";

    $self_generated
        .= q{// [[[ PROCEDURAL SUBROUTINE DECLARATION(S) ]]]} . "\n";
    foreach my object $subroutine ( @{ $self->{subroutines} } ) {
        $self_generated
            .= $subroutine->rperl_to_cpp__header_generate__CPPOPS_CPPTYPES();
        $self_generated .= q{;} . "\n";
    }
    $self_generated .= "\n";

    $self_generated
        .= q{// [[[ PROCEDURAL SUBROUTINE DEFINITION(S) ]]]} . "\n";
    foreach my object $subroutine ( @{ $self->{subroutines} } ) {
        $self_generated
            .= $subroutine->rperl_to_cpp__generate__CPPOPS_CPPTYPES();
    }
    $self_generated .= "\n";

    my $self_name_underscores = $self->{name};
    $self_name_underscores =~ s/::/_/gxms;

    $self_generated .= q{// [[[ OPERATIONS & DATA TYPES REPORTING ]]]} . "\n";
    $self_generated
        .= q{integer } . $self_name_underscores . q[__MODE_ID() {] . "\n";
    $self_generated .= q{    integer retval = 2;  // CPPOPS_CPPTYPES is 2} . "\n";
    $self_generated .= q{    return (retval);} . "\n";
    $self_generated .= q[}] . "\n";

#$self_generated .= "// <<< PACKAGE RULE, END CPPOPS_CPPTYPES >>>\n"; # DEBUG TEMP
    RPerl::diag
        "in Package::rperl_to_cpp__generate__CPPOPS_CPPTYPES(), about to return \$self_generated = \n\n\n"
        . $self_generated . "\n\n";

    return ($self_generated);
};
=cut
