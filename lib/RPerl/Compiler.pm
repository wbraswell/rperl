## no critic qw(ProhibitExcessMainComplexity)  # SYSTEM SPECIAL 5: allow complex code outside subroutines, must be on line 1
# [[[ PREPROCESSOR ]]]
# <<< TYPE_CHECKING: OFF >>>

# [[[ HEADER ]]]
package RPerl::Compiler;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.003_100;

# [[[ CRITICS ]]]

## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(RequireBriefOpen)  # SYSTEM SPECIAL 10: allow complex processing with open filehandle

# [[[ INCLUDES ]]]

use RPerl::Parser;
use RPerl::Generator;

# [[[ SUBROUTINES ]]]

# [[[ COMPILE RPERL TO RPERL, TEST MODE ]]]
# [[[ COMPILE RPERL TO RPERL, TEST MODE ]]]
# [[[ COMPILE RPERL TO RPERL, TEST MODE ]]]

our void $rperl_to_rperl__parse_generate = sub {
    (   my string $rperl_input_file_name,
        my string $rperl_output_file_name_group,
        my string__hash_ref $modes
    ) = @_;
    my object $rperl_ast;
    my string__hash_ref $rperl_source_group;

    # [[[ PARSE RPERL TO AST ]]]

    if (   ( $modes->{compile} eq 'PARSE' )
        or ( $modes->{compile} eq 'GENERATE' ) )
    {
        $rperl_ast
            = RPerl::Parser::rperl_to_ast__parse($rperl_input_file_name);
    }

    # [[[ GENERATE AST TO RPERL ]]]

    if ( $modes->{compile} eq 'GENERATE' ) {
        $rperl_source_group
            = RPerl::Generator::ast_to_rperl__generate( $rperl_ast, $modes );
        save_source_files( $rperl_source_group,
            $rperl_output_file_name_group );
    }
};

# [[[ COMPILE RPERL TO XS & BINARY ]]]
# [[[ COMPILE RPERL TO XS & BINARY ]]]
# [[[ COMPILE RPERL TO XS & BINARY ]]]

our void $rperl_to_xsbinary__parse_generate_compile = sub {
    (   my string $rperl_input_file_name,
        my string $cpp_output_file_name_group,
        my string__hash_ref $modes
    ) = @_;
    my object $rperl_ast;
    my string__hash_ref $cpp_source_group;

    # [[[ PARSE RPERL TO AST ]]]

    if (   ( $modes->{compile} eq 'PARSE' )
        or ( $modes->{compile} eq 'GENERATE' )
        or ( $modes->{compile} eq 'COMPILE' ) )
    {
        $rperl_ast
            = RPerl::Parser::rperl_to_ast__parse($rperl_input_file_name);
    }

    # [[[ GENERATE AST TO C++ ]]]

    if (   ( $modes->{compile} eq 'GENERATE' )
        or ( $modes->{compile} eq 'COMPILE' ) )
    {
        $cpp_source_group
            = RPerl::Generator::ast_to_cpp__generate( $rperl_ast, $modes );
        save_source_files( $cpp_source_group, $cpp_output_file_name_group );
    }

    # [[[ COMPILE C++ TO XS & BINARY ]]]

    if ( $modes->{compile} eq 'COMPILE' ) {
        cpp_to_xsbinary__compile( $cpp_source_group,
            $cpp_output_file_name_group );
    }
};

# Write Source Code Files To File System
our void $save_source_files = sub {
    (   my string__hash_ref $cpp_source_group,
        my string__hash_ref $cpp_file_name_group
    ) = @_;

    RPerl::diag(
        q{in Compiler::save_source_files(), received $cpp_source_group =},
        "\n", Dumper($cpp_source_group), "\n" );
    RPerl::diag(
        q{in Compiler::save_source_files(), received $cpp_file_name_group =},
        "\n", Dumper($cpp_file_name_group), "\n"
    );

    foreach my string $suffix_key ( sort keys %{$cpp_source_group} ) {
        if (   ( not exists $cpp_file_name_group->{$suffix_key} )
            or ( not defined $cpp_file_name_group->{$suffix_key} )
            or ( $cpp_file_name_group->{$suffix_key} eq q{} ) )
        {
            croak(
                "\nERROR ECVCOFI00, COMPILER, SAVE OUTPUT FILES: Expecting file name for suffix '$suffix_key', but received empty or no value, croaking"
            );
        }
    }

    foreach my string $suffix_key ( sort keys %{$cpp_file_name_group} ) { ## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 7: PERL CRITIC UNFILED ISSUE, not postfix foreach
        if (   ( not exists $cpp_source_group->{$suffix_key} )
            or ( not defined $cpp_source_group->{$suffix_key} )
            or ( $cpp_source_group->{$suffix_key} eq q{} ) )
        {
            croak(
                "\nERROR ECVCOFI01, COMPILER, SAVE OUTPUT FILES: Expecting source code for suffix '$suffix_key', but received empty or no value, croaking"
            );
        }
        my string $cpp_file_name = $cpp_file_name_group->{$suffix_key};
        my string $cpp_source    = $cpp_source_group->{$suffix_key};

        # actually save file(s)
        if ( -f $cpp_file_name ) {
            unlink $cpp_file_name
                or croak(
                "\nERROR ECVCOFI02, C++ COMPILER, FILE SYSTEM: Attempting to save new file '$cpp_file_name', cannot delete existing file,\ncroaking: $OS_ERROR"
                );
        }

        my $CPP_FILEHANDLE;
        open $CPP_FILEHANDLE, '>', $cpp_file_name
            or croak(
            "\nERROR ECVCOFI03, C++ COMPILER, FILE SYSTEM: Attempting to save new file '$cpp_file_name', cannot open file for writing,\ncroaking: $OS_ERROR"
            );

        print {$CPP_FILEHANDLE} $cpp_source
            or croak(
            "\nERROR ECVCOFI04, C++ COMPILER, FILE SYSTEM: Attempting to save new file '$cpp_file_name', cannot write to file,\ncroaking: $OS_ERROR"
            );

        close $CPP_FILEHANDLE
            or croak(
            "\nERROR ECVCOFI05, C++ COMPILER, FILE SYSTEM: Attempting to save new file '$cpp_file_name', cannot close file,\ncroaking: $OS_ERROR"
            );
    }

};

# Compile from C++-Parsable String to Perl-Linkable XS & Machine-Readable Binary
our void $cpp_to_xsbinary__compile = sub {
    ( my string $cpp_file_name_group ) = @_;

    RPerl::diag(
        q{in Compiler::cpp_to_xsbinary__compile(), received $cpp_file_name_group =},
        "\n", Dumper($cpp_file_name_group), "\n"
    );
    
    # ADD CALLS TO TRIGGER Inline::CPP COMPILATION
};

1;    # end of package
