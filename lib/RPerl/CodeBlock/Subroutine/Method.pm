# [[[ HEADER ]]]
package RPerl::CodeBlock::Subroutine::Method;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.008_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CodeBlock::Subroutine);
use RPerl::CodeBlock::Subroutine;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# [[[ INCLUDES ]]]
use Storable qw(dclone);
use perlapinames_generated;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub ast_to_rperl__generate {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $rperl_source_group = { PMC => q{} };
    my string_hashref $rperl_source_subgroup;

    #    RPerl::diag( 'in Method->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    # unwrap Method_82 from SubroutineOrMethod_88
    if ( ( ref $self ) eq 'SubroutineOrMethod_88' ) {
        $self = $self->{children}->[0];
    }

#    RPerl::diag( 'in Method->ast_to_rperl__generate(), have possibly-unwrapped $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    if ( ( ref $self ) ne 'Method_82' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP00, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule ' . ( ref $self ) . ' found where Method_82 expected, dying' )
            . "\n";
    }

    my string $sub                     = $self->{children}->[0];
    my string $name                    = $self->{children}->[1];
    my string $left_brace              = $self->{children}->[2];
    my string $return_type_left_brace  = $self->{children}->[3];
    my string $return_type_my          = $self->{children}->[4];
    my string $return_type             = $self->{children}->[5];
    my string $return_type_var         = $self->{children}->[6];
    my string $return_type_right_brace = $self->{children}->[7];
    my string $return_type_semicolon   = $self->{children}->[8];
    my object $arguments_optional      = $self->{children}->[9];
    my object $operations_star         = $self->{children}->[10];
    my string $right_brace             = $self->{children}->[11];

    if ((substr $name, 0, 1) eq '_') {
        die 'ERROR ECOGEASRP09, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: method name ' . ($name)
                . ' must not start with underscore, dying' . "\n";
    }

    if ((exists $perlapinames_generated::FUNCTIONS_DOCUMENTED->{$name}) or
        (exists $perlapinames_generated::FUNCTIONS_UNDOCUMENTED->{$name}) or
        (exists $perlapinames_generated::VARIABLES_DOCUMENTED->{$name}) or
        (exists $perlapinames_generated::VARIABLES_UNDOCUMENTED->{$name})) {
        die 'ERROR ECOGEASRP45, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Perl API name conflict, method name ' . q{'}
            . $name . q{'}
            . ' is the same as a protected function or variable name in the Perl API, please choose a different name, dying' . "\n";
    }

    # CREATE SYMBOL TABLE ENTRY
    $modes->{_symbol_table}->{_subroutine} = $name;  # set current subroutine/method
    $modes->{_symbol_table}->{$modes->{_symbol_table}->{_namespace}}->{_global}->{$name} = {isa => 'RPerl::CodeBlock::Subroutine::Method', type => $return_type};  # create individual symtab entry
 
    $rperl_source_group->{PMC} .= 
        $sub . q{ } . $name . q{ } . $left_brace . q{ } . 
        $return_type_left_brace . q{ } . $return_type_my . q{ } . $return_type . q{ } . $return_type_var . q{ } . 
        $return_type_right_brace . q{ } . $return_type_semicolon;

    if ( exists $arguments_optional->{children}->[0] ) {
        $rperl_source_subgroup = $arguments_optional->{children}->[0]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }

    foreach my object $operation ( @{ $operations_star->{children} } ) {
        $rperl_source_subgroup = $operation->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }

    $rperl_source_group->{PMC} .= $right_brace . "\n\n";
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::CB::S::M __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
#    RPerl::diag( 'in Method->ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES(), received $modes->{_symbol_table} = ' . "\n" . Dumper($modes->{_symbol_table}) . "\n");

    my string_hashref $cpp_source_group = { H => q{} };

#    RPerl::diag( 'in Method->ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    # unwrap Method_82 from SubroutineOrMethod_88
    if ( ( ref $self ) eq 'SubroutineOrMethod_88' ) {
        $self = $self->{children}->[0];
    }

#    RPerl::diag( 'in Method->ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES(), have possibly-unwrapped $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    if ( ( ref $self ) ne 'Method_82' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule ' . ( ref $self ) . ' found where Method_82 expected, dying' )
            . "\n";
    }

    my string $name                    = $self->{children}->[1];
    my string $return_type             = $self->{children}->[5];
    my object $arguments_optional      = $self->{children}->[9];

    substr $return_type, -8, 8, '';                      # strip trailing '::method'
 
#    RPerl::diag( 'in Method->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $name = ' . $name . "\n" );
#    RPerl::diag( 'in Method->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $arguments_optional = ' . "\n" . RPerl::Parser::rperl_ast__dump($arguments_optional) . "\n" );

    if ((substr $name, 0, 1) eq '_') {
        die 'ERROR ECOGEASCP09, CODE GENERATOR, ABSTRACT SYNTAX TO C++: method name ' . ($name)
                . ' must not start with underscore, dying' . "\n";
    }

    if ((exists $perlapinames_generated::FUNCTIONS_DOCUMENTED->{$name}) or
        (exists $perlapinames_generated::FUNCTIONS_UNDOCUMENTED->{$name}) or
        (exists $perlapinames_generated::VARIABLES_DOCUMENTED->{$name}) or
        (exists $perlapinames_generated::VARIABLES_UNDOCUMENTED->{$name})) {
        die 'ERROR ECOGEASCP45, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Perl API name conflict, method name ' . q{'}
            . $name . q{'}
            . ' is the same as a protected function or variable name in the Perl API, please choose a different name, dying' . "\n";
    }

    # CREATE SYMBOL TABLE ENTRY
    $modes->{_symbol_table}->{_subroutine} = $name;  # set current subroutine/method
    $modes->{_symbol_table}->{$modes->{_symbol_table}->{_namespace}}->{_global}->{$name} = {isa => 'RPerl::CodeBlock::Subroutine::Method', type => $return_type};  # create individual symtab entry

    $return_type = RPerl::Generator::type_convert_perl_to_cpp($return_type, 1);  # $pointerify_classes = 1
    $modes->{_symbol_table}->{$modes->{_symbol_table}->{_namespace}}->{_global}->{$name}->{type_cpp} = $return_type;  # add converted C++ type to symtab entry

    $cpp_source_group->{H} .= q{    } . $return_type . q{ } . $name . '(';
    if ( exists $arguments_optional->{children}->[0] ) {
        my object $arguments = $arguments_optional->{children}->[0];
        my string_hashref $cpp_source_subgroup = $arguments->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        $cpp_source_group->{H} .= $cpp_source_subgroup->{CPP};
    }
    $cpp_source_group->{H} .= ');';
    return $cpp_source_group;
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string $package_name_underscores, my string_hashref $modes) = @ARG;
#    RPerl::diag( 'in Method->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $modes->{_symbol_table} = ' . "\n" . Dumper($modes->{_symbol_table}) . "\n");

    my string_hashref $cpp_source_group = { CPP => q{} };
    my string_hashref $cpp_source_subgroup;

    #    RPerl::diag( 'in Method->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    # unwrap Method_82 from SubroutineOrMethod_88
    if ( ( ref $self ) eq 'SubroutineOrMethod_88' ) {
        $self = $self->{children}->[0];
    }

#    RPerl::diag( 'in Method->ast_to_cpp__generate_declaration__CPPOPS_CPPTYPES(), have possibly-unwrapped $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    if ( ( ref $self ) ne 'Method_82' ) {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASCP00, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule ' . ( ref $self ) . ' found where Method_82 expected, dying' )
            . "\n";
    }

    my string $name                    = $self->{children}->[1];
    my string $return_type             = $self->{children}->[5];
    my object $arguments_optional      = $self->{children}->[9];
    my object $operations_star         = $self->{children}->[10];

    substr $return_type, -8, 8, '';                      # strip trailing '::method'

    $return_type = RPerl::Generator::type_convert_perl_to_cpp($return_type, 1);  # $pointerify_classes = 1
    $cpp_source_group->{CPP} .= $return_type . q{ } . $package_name_underscores . '::' . $name . '(';

    if ( exists $arguments_optional->{children}->[0] ) {
        $cpp_source_subgroup = $arguments_optional->{children}->[0]->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
    }

    $cpp_source_group->{CPP} .= ') {' . "\n";
    my string $CPP_saved = $cpp_source_group->{CPP};
    $cpp_source_group->{CPP} = q{};

    foreach my object $operation ( @{ $operations_star->{children} } ) {
        $cpp_source_subgroup = $operation->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
        RPerl::Generator::source_group_append( $cpp_source_group, $cpp_source_subgroup );
    }

    # COMPILE-TIME OPTIMIZATION #02: declare all loop iterators at top of subroutine/method to avoid re-declarations in nested loops
    if ((exists $modes->{_loop_iterators}) and (defined $modes->{_loop_iterators})) {
        foreach my string $loop_iterator_symbol (sort keys %{$modes->{_loop_iterators}}) {
            $CPP_saved .= $modes->{_loop_iterators}->{$loop_iterator_symbol} . q{ } . $loop_iterator_symbol . ';' . "\n";
        }
        delete $modes->{_loop_iterators};
    }
    
    $CPP_saved .= $cpp_source_group->{CPP};
    $cpp_source_group->{CPP} = $CPP_saved;

    $cpp_source_group->{CPP} .= '}';
    return $cpp_source_group;
}

# [[[ TYPES & SUBTYPES BELOW THIS LINE ]]]

# a method is a subroutine belonging to a class or object
package  # hide from PAUSE indexing
    method;
use strict;
use warnings;
use parent qw(RPerl::CodeBlock::Subroutine::Method);

# [[[ SCALAR & SCALAR REF METHODS ]]]

# method with void return type
package  # hide from PAUSE indexing
    void::method;
use strict;
use warnings;
use parent -norequire, qw(method);

# method with integer return type
package  # hide from PAUSE indexing
    integer::method;
use strict;
use warnings;
use parent -norequire, qw(method);

# method with number return type
package  # hide from PAUSE indexing
    number::method;
use strict;
use warnings;
use parent -norequire, qw(method);

# method with character return type
package  # hide from PAUSE indexing
    character::method;
use strict;
use warnings;
use parent -norequire, qw(method);

# method with string return type
package  # hide from PAUSE indexing
    string::method;
use strict;
use warnings;
use parent -norequire, qw(method);

# method with scalartype return type
package  # hide from PAUSE indexing
    scalartype::method;
use strict;
use warnings;
use parent -norequire, qw(method);

# method with unknown return type
package  # hide from PAUSE indexing
    unknown::method;
use strict;
use warnings;
use parent -norequire, qw(method);

# [[[ HASH METHODS ]]]

package  # hide from PAUSE indexing
    integer_hashref::method;
use strict;
use warnings;
use parent -norequire, qw(method);

package  # hide from PAUSE indexing
    number_hashref::method;
use strict;
use warnings;
use parent -norequire, qw(method);

package  # hide from PAUSE indexing
    string_hashref::method;
use strict;
use warnings;
use parent -norequire, qw(method);

package  # hide from PAUSE indexing
    object_hashref::method;
use strict;
use warnings;
use parent -norequire, qw(method);

package  # hide from PAUSE indexing
    hashref_hashref::method;
use strict;
use warnings;
use parent -norequire, qw(method);

# [[[ ARRAY METHODS ]]]

package  # hide from PAUSE indexing
    integer_arrayref::method;
use strict;
use warnings;
use parent -norequire, qw(method);

package  # hide from PAUSE indexing
    number_arrayref::method;
use strict;
use warnings;
use parent -norequire, qw(method);

package  # hide from PAUSE indexing
    string_arrayref::method;
use strict;
use warnings;
use parent -norequire, qw(method);

package  # hide from PAUSE indexing
    arrayref_arrayref::method;
use strict;
use warnings;
use parent -norequire, qw(method);

1;
