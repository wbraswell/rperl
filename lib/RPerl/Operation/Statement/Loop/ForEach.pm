# [[[ HEADER ]]]
package RPerl::Operation::Statement::Loop::ForEach;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.003_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Statement::Loop);
use RPerl::Operation::Statement::Loop;

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

#    RPerl::diag( 'in Loop::ForEach->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );

    my string $self_class = ref $self;

    # unwrap LoopForEach_190 from Loop_186
    if ( $self_class eq 'Loop_186' ) {    # Loop -> LoopForEach
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

    # LoopForEach -> 'foreach' MY Type VARIABLE_SYMBOL LPAREN ListElements ')' CodeBlock
    if ( $self_class eq 'LoopForEach_190' ) {
        my string $foreach         = $self->{children}->[0];
        my string $my              = $self->{children}->[1];
        my string $type            = $self->{children}->[2]->{children}->[0];
        my string $variable_symbol = $self->{children}->[3];
        my string $left_paren      = $self->{children}->[4];
        my object $list_elements   = $self->{children}->[5];
        my string $right_paren     = $self->{children}->[6];
        my object $codeblock       = $self->{children}->[7];

        # START HERE: add error checking for PERLOPS_PERLTYPES, then utilize for CPPOPS_CPPTYPES
        # START HERE: add error checking for PERLOPS_PERLTYPES, then utilize for CPPOPS_CPPTYPES
        # START HERE: add error checking for PERLOPS_PERLTYPES, then utilize for CPPOPS_CPPTYPES

#        RPerl::diag( 'in Loop::ForEach->ast_to_rperl__generate(), have $list_elements = ' . "\n" . RPerl::Parser::rperl_ast__dump($list_elements) . "\n" );
#        die 'TMP DEBUG';
#        if ((scalar @{$list_elements->{children}->[1]->{children}}) > 0) {  # non-empty _STAR_LIST, meaning 2 or more total elements in ListElements
#        }

        $rperl_source_group->{PMC} .= $foreach . q{ } . $my . q{ } . $type . q{ } . $variable_symbol . q{ } . $left_paren . q{ };
        my object $rperl_source_subgroup = $list_elements->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $right_paren . q{ };
        $rperl_source_subgroup = $codeblock->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASRP000, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule ' . $self_class . ' found where LoopForEach_190 expected, dying' ) . "\n";
    }
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string $loop_label, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group = { CPP => q{// <<< RP::O::S::L::FE __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>} . "\n" };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string $loop_label, my string_hashref $modes) = @ARG;

    my string_hashref $cpp_source_group = { CPP => q{} };

#    RPerl::diag( 'in Loop::ForEach->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
#    RPerl::diag( 'in Loop::ForEach->ast_to_cpp__generate__CPPOPS_CPPTYPES(), received $modes = ' . "\n" . Dumper($modes) . "\n" );

    my string $self_class = ref $self;

    # unwrap LoopForEach_190 from Loop_186
    if ( $self_class eq 'Loop_186' ) {    # Loop -> LoopForEach
        $self       = $self->{children}->[0];
        $self_class = ref $self;
    }

    # LoopForEach -> 'foreach' MY Type VARIABLE_SYMBOL LPAREN ListElements ')' CodeBlock
    if ( $self_class eq 'LoopForEach_190' ) {
        my string $foreach         = $self->{children}->[0];
        my string $my              = $self->{children}->[1];
        my string $type            = $self->{children}->[2]->{children}->[0];
        my string $variable_symbol = $self->{children}->[3];
        my string $left_paren      = $self->{children}->[4];
        my object $list_elements   = $self->{children}->[5];
        my string $right_paren     = $self->{children}->[6];
        my object $codeblock       = $self->{children}->[7];

        # strip leading '$'
        substr $variable_symbol, 0, 1, q{};

#        RPerl::diag( 'in Loop::ForEach->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $codeblock = ' . "\n" . RPerl::Parser::rperl_ast__dump($codeblock) . "\n" );
#        RPerl::diag( 'in Loop::ForEach->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $list_elements = ' . "\n" . RPerl::Parser::rperl_ast__dump($list_elements) . "\n" );
#        die 'TMP DEBUG';

        # THEN START HERE: add error checking from PERLOPS_PERLTYPES; determine how to utilize $loop_label
        # THEN START HERE: add error checking from PERLOPS_PERLTYPES; determine how to utilize $loop_label
        # THEN START HERE: add error checking from PERLOPS_PERLTYPES; determine how to utilize $loop_label

#        if ((scalar @{$list_elements->{children}->[1]->{children}}) > 0) {  # non-empty _STAR_LIST, meaning 2 or more total elements in ListElements
#        }

        # COMPILE-TIME OPTIMIZATION #04: detect Perl foreach() loop over hash entries, implement as C++17 range-based for() loop
    my $HARD_CODED_EXAMPLES = sub {

        package SOMETYPE;
        my %hash = ();
        my $hashref = {};

        # Perl, hash (non-reference)
        foreach my string $key (keys %hash) {
            my SOMETYPE $key_value = $hash{$key};  # $hash instead of %hash, assumes SOMETYPE is scalar
            # use $key and $key_value
        }

        # Perl, hashref
        foreach my string $key (keys %{$hashref}) {
            my SOMETYPE $key_value = $hashref->{$key};
            # use $key and $key_value
        }

=C++
        // C++, hash (non-reference)
        for (auto& key_value_pair : hash) {
            auto key = key_value_pair.first;
            auto key_value = key_value_pair.second;
            // use key and key_value
        }

        // C++, hash (non-reference), structured bindings, requires C++17 in GCC v7 (__cpp_structured_bindings >= 201606)    https://gcc.gnu.org/projects/cxx-status.html
        for (auto&& [key, key_value] : hash) {
            // use key and key_value
        }
=cut        
    };

        my boolean $is_keys = 0;
        my object $keys_args = undef;
        if (    (exists  $list_elements->{children}) and
                (defined $list_elements->{children}) and
                (defined $list_elements->{children}->[0]) and
                (exists  $list_elements->{children}->[0]->{children}) and
                (defined $list_elements->{children}->[0]->{children}) and
                (defined $list_elements->{children}->[0]->{children}->[0]) and
                (exists  $list_elements->{children}->[0]->{children}->[0]->{children}) and
                (defined $list_elements->{children}->[0]->{children}->[0]->{children}) and
                (defined $list_elements->{children}->[0]->{children}->[0]->{children}->[0]) and
                (exists  $list_elements->{children}->[0]->{children}->[0]->{children}->[0]->{children}) and
                (defined $list_elements->{children}->[0]->{children}->[0]->{children}->[0]->{children}) and
                (defined $list_elements->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[0])) {
            my object $possible_operator_named = $list_elements->{children}->[0]->{children}->[0]->{children}->[0]->{children}->[0];
#            RPerl::diag( 'in Loop::ForEach->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $possible_operator_named = ' . "\n" . RPerl::Parser::rperl_ast__dump($possible_operator_named) . "\n" );

            # Operator -> OP01_NAMED SubExpression
            my string $possible_operator_named_class = ref $possible_operator_named;
            if ($possible_operator_named_class eq 'Operator_100') {  # Operator -> OP01_NAMED SubExpression
                if (    (exists  $possible_operator_named->{children}) and
                        (defined $possible_operator_named->{children}) and
                        (defined $possible_operator_named->{children}->[0]) and
                        (defined $possible_operator_named->{children}->[1])) {
                    if (    ($possible_operator_named->{children}->[0] eq 'keys') or
                            ($possible_operator_named->{children}->[0] eq 'keys ')) {
                        $is_keys = 1;
                        $keys_args = $possible_operator_named->{children}->[1];
#                        RPerl::diag( 'in Loop::ForEach->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $is_keys = 1, $keys_args = ' . "\n" . RPerl::Parser::rperl_ast__dump($keys_args) . "\n" );
                    }
                }
            }
        }

        if ($is_keys) {
            my string $key_value_pair_symbol = $variable_symbol . '_value_pair';
            my string $key_value_symbol = $variable_symbol . '_value';

            # // C++, hash (non-reference)
            # for (auto& key_value_pair : hash) {
            #     auto key = key_value_pair.first;
            #     auto key_value = key_value_pair.second;

            $cpp_source_group->{CPP} .= q{for (auto& } . $key_value_pair_symbol . q{ : };
            my object $rperl_source_subgroup = $keys_args->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            RPerl::Generator::source_group_append( $cpp_source_group, $rperl_source_subgroup );
            $cpp_source_group->{CPP} .= q{) };

=DISABLE_C++17
            # // C++, hash (non-reference), structured bindings, requires C++17 in GCC v7 (__cpp_structured_bindings >= 201606)    https://gcc.gnu.org/projects/cxx-status.html
            # for (auto&& [key, key_value] : hash) {

            $cpp_source_group->{CPP} .= q{for (auto&& [} . $variable_symbol . q{, } . $key_value_symbol . q{] : };
            my object $rperl_source_subgroup = $keys_args->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            RPerl::Generator::source_group_append( $cpp_source_group, $rperl_source_subgroup );
            $cpp_source_group->{CPP} .= q{) };
=cut

            $rperl_source_subgroup = $codeblock->ast_to_cpp__generate__CPPOPS_CPPTYPES($loop_label, $modes);
#            RPerl::diag( 'in Loop::ForEach->ast_to_cpp__generate__CPPOPS_CPPTYPES(), have $is_keys = 1, $rperl_source_subgroup = ' . "\n" . RPerl::Parser::rperl_ast__dump($rperl_source_subgroup) . "\n" );
            if ((not exists $rperl_source_subgroup->{CPP}) or
                (not defined $rperl_source_subgroup->{CPP}) or
                ((substr $rperl_source_subgroup->{CPP}, 0, 2) ne "{\n")) {
                die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP880, CODE GENERATOR, ABSTRACT SYNTAX TO C++, COMPILE-TIME OPTIMIZATION #04: Grammar rule ' . $self_class . 
                    ' qualified for "foreach-loop-over-hash-keys" optimization, but following codeblock did not generate a code string beginning with required left-curly-brace-newline characters, dying' ) . "\n";
            }

            # must create 1 additional var, the key_value_pair; a 2nd additional var, the key_value var, may be utilized for further optimization
            my string $optimized_var_declarations = q{};
            $optimized_var_declarations .= '{' . "\n";
            $optimized_var_declarations .= 'auto ' . $variable_symbol . ' = ' . $key_value_pair_symbol . '.first;' . "\n";
#            $optimized_var_declarations .= 'auto ' . $key_value_symbol . ' = ' . $key_value_pair_symbol . '.second;' . "\n";  # NEED RE-ENABLE FOR OPTIMIZATION
            substr $rperl_source_subgroup->{CPP}, 0, 2, $optimized_var_declarations;

            # THEN THEN START HERE: optimize further by replacing $hash{$key} and $hashref->{$key} with key_value
            # THEN THEN START HERE: optimize further by replacing $hash{$key} and $hashref->{$key} with key_value
            # THEN THEN START HERE: optimize further by replacing $hash{$key} and $hashref->{$key} with key_value

            RPerl::Generator::source_group_append( $cpp_source_group, $rperl_source_subgroup );
        }
        else {
            # THEN THEN START HERE: enable other forms of foreach() loop
            # THEN THEN START HERE: enable other forms of foreach() loop
            # THEN THEN START HERE: enable other forms of foreach() loop

            $cpp_source_group->{CPP} .= q{// <<< RP::O::S::L::FE __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>};

=DISABLE_NEED_UPGRADE
            $cpp_source_group->{CPP} .= $foreach . q{ } . $my . q{ } . $type . q{ } . $variable_symbol . q{ } . $left_paren . q{ };
            my object $rperl_source_subgroup = $list_elements->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            RPerl::Generator::source_group_append( $cpp_source_group, $rperl_source_subgroup );
            $cpp_source_group->{CPP} .= q{ } . $right_paren . q{ };
            $rperl_source_subgroup = $codeblock->ast_to_cpp__generate__CPPOPS_CPPTYPES($modes);
            RPerl::Generator::source_group_append( $cpp_source_group, $rperl_source_subgroup );
=cut
        }
    }
    else {
        die RPerl::Parser::rperl_rule__replace( 'ERROR ECOGEASCP000, CODE GENERATOR, ABSTRACT SYNTAX TO C++: Grammar rule ' . $self_class . ' found where LoopForEach_190 expected, dying' ) . "\n";
    }

    return $cpp_source_group;
}

1;    # end of class
