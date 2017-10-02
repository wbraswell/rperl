# [[[ HEADER ]]]
package              # hide from PAUSE indexing
    rperloptions;    ## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names
use strict;
use warnings;
#use RPerl::Config;
our $VERSION = 0.003_000;

# [[[ PRE-DECLARED TYPES ]]]
package    # hide from PAUSE indexing
    boolean;
package    # hide from PAUSE indexing
    unsigned_integer;
package    # hide from PAUSE indexing
    integer;
package    # hide from PAUSE indexing
    number;
package    # hide from PAUSE indexing
    character;
package    # hide from PAUSE indexing
    string;
package    # hide from PAUSE indexing
    string_arrayref;
package    # hide from PAUSE indexing
    string_hashref;
package    # hide from PAUSE indexing
    hashref;
package    # hide from PAUSE indexing
    arrayref_hashref;
package    # hide from PAUSE indexing
    hashref_arrayref;

package main;

# this array must be instantiated here, because GetOptions' diamond '<>' operator does not allow passing arguments or receiving return values
our $input_file_names_unlabeled = my string_arrayref $TYPED_input_file_names_unlabeled = [];

our $help_flag                           = my integer $TYPED_help_flag                           = 0;
our $version_flag                        = my integer $TYPED_version_flag                        = 0;
our $vversions_flag                      = my integer $TYPED_vversions_flag                      = 0;
our $dependencies_flag                   = my integer $TYPED_dependencies_flag                   = undef;
our $magic_low_flag                      = my integer $TYPED_magic_low_flag                      = undef;
our $magic_medium_flag                   = my integer $TYPED_magic_medium_flag                   = undef;
our $magic_high_flag                     = my integer $TYPED_magic_high_flag                     = undef;
our $uncompile_flag                      = my integer $TYPED_uncompile_flag                      = undef;
our $uncompile_source_flag               = my integer $TYPED_uncompile_source_flag               = undef;
our $uncompile_source_binary_flag        = my integer $TYPED_uncompile_source_binary_flag        = undef;
our $uncompile_source_binary_inline_flag = my integer $TYPED_uncompile_source_binary_inline_flag = undef;
our $compile_flag                        = my integer $TYPED_compile_flag                        = undef;
our $subcompile_assemble_flag            = my integer $TYPED_subcompile_assemble_flag            = undef;
our $subcompile_archive_flag             = my integer $TYPED_subcompile_archive_flag             = undef;
our $subcompile_shared_flag              = my integer $TYPED_subcompile_shared_flag              = undef;
our $subcompile_static_flag              = my integer $TYPED_subcompile_static_flag              = undef;
our $subcompile_CXX                      = my string  $TYPED_subcompile_CXX                      = undef;
our $parallel_flag                       = my integer $TYPED_parallel_flag                       = undef;
our $num_cores                           = my integer $TYPED_num_cores                           = undef;
our $execute_flag                        = my integer $TYPED_execute_flag                        = undef;
our $test_flag                           = my integer $TYPED_test_flag                           = undef;
our $input_file_names                    = my string_arrayref $TYPED_input_file_names            = [];
our $output_file_name_prefixes           = my string_arrayref $TYPED_output_file_name_prefixes   = [];
our $output_file_name_groups             = my hashref_arrayref $TYPED_output_file_name_groups    = [];

our $modes                               = my string_hashref $TYPED_modes                        = {};      # can't store defaults here, erased by GetOptions()
our $modes_default = my string_hashref $TYPED_modes_default = {    # default to CPPCODE_CPPOPS_CPPTYPES_CHECKTRACE_SUBCOMPILE_EXECUTE_LABEL in C++ output code
    dependencies => 'ON',
    magic        => 'LOW',
    code         => 'CPP',
    ops          => 'CPP',
    types        => 'CPP',
    type_integer => 'LONG',
    type_number  => 'DOUBLE',
    check        => 'TRACE',
    uncompile    => 'OFF',
    compile      => 'SUBCOMPILE',
    subcompile   => 'DYNAMIC',
    CXX          => 'g++',                                         # default to GNU GCC  http://www.gnu.org/software/make/manual/make.html#Implicit-Variables
    parallel     => 'OFF',
    num_cores    => 4,
    execute      => 'ON',
    label        => 'ON',
};
our $modes_supported = my arrayref_hashref $TYPED_modes_supported = {
    arguments    => undef,                                         # accept any value
    dependencies => [ 'OFF', 'ON' ],
    magic        => [ 'LOW', 'MEDIUM', 'HIGH' ],
    code         => [ 'PERL', 'CPP' ],
    ops          => [ 'PERL', 'CPP' ],
    types        => [ 'PERL', 'CPP', 'DUAL' ],
    type_integer => [ 'LONG',   'LONG__LONG' ],
    type_number  => [ 'DOUBLE', 'LONG__DOUBLE' ],
    check        => [ 'OFF',    'ON', 'TRACE' ],
    uncompile    => [ 'OFF',    'SOURCE', 'BINARY', 'INLINE', 'SOURCE_BINARY', 'SOURCE_BINARY_INLINE' ],
    compile    => [ 'OFF', 'PARSE',    'GENERATE', 'SAVE',   'SUBCOMPILE' ],
    subcompile => [ 'OFF', 'ASSEMBLE', 'ARCHIVE',  'SHARED', 'STATIC', 'DYNAMIC' ],
    CXX       => undef,                                            # accept any value
    parallel  => [ 'OFF', 'OPENMP' ],
    num_cores => undef,                                            # accept any value
    execute   => [ 'OFF', 'ON' ],
    label     => [ 'OFF', 'ON' ],
};

our $rperl_options = my hashref $TYPED_rperl_options = {
    'h'             => \$help_flag,  # allow -h to be unambiguous shorthand for --help (not --high)
    'help|?'        => \$help_flag,
    'v'             => \$version_flag,
    'version'       => \$version_flag,
    'vversion'      => \$vversions_flag,
    'dependencies!' => \$dependencies_flag,
    'low'           => \$magic_low_flag,
    'medium'        => \$magic_medium_flag,
    'high'          => \$magic_high_flag,
    'Verbose!'      => \$RPerl::VERBOSE,
    'Debug!'        => \$RPerl::DEBUG,
    'Warnings!'     => \$RPerl::WARNINGS,
    'u!'            => \$uncompile_source_flag,
    'uncompile!'    => \$uncompile_source_flag,
    'uu!'           => \$uncompile_source_binary_flag,
    'uuncompile!'   => \$uncompile_source_binary_flag,
    'uuuncompile!'  => \$uncompile_source_binary_inline_flag,
    'compile!'      => \$compile_flag,
    'assemble'      => \$subcompile_assemble_flag,
    'archive'       => \$subcompile_archive_flag,
    'shared'        => \$subcompile_shared_flag,
    'static!'       => \$subcompile_static_flag,
    'CXX=s'         => \$subcompile_CXX,
    'parallel!'     => \$parallel_flag,
    'num_cores=i'   => \$num_cores,
    'execute!'      => \$execute_flag,
    'test'          => \$test_flag,
    'infile=s{1,}'  => \@{$input_file_names},
    'outfile=s{1,}' => \@{$output_file_name_prefixes},
    'm=s%'          => \$modes,  # allow -m to be unambiguous shorthand for --mode (not --medium)
    'mode=s%'       => \$modes,
    '<>'            => \&store_unlabeled_arguments  # DEV NOTE: amazingly, this coderef works correctly and calls to the subroutine stored in the file script/rperl
};

use RPerl::Exporter 'import';
#our @ISA = qw(RPerl::Exporter);
our @EXPORT
    = qw( $input_file_names_unlabeled $help_flag $version_flag $vversions_flag $dependencies_flag $magic_low_flag $magic_medium_flag $magic_high_flag $uncompile_flag $uncompile_source_flag $uncompile_source_binary_flag $uncompile_source_binary_inline_flag $compile_flag $subcompile_assemble_flag $subcompile_archive_flag $subcompile_shared_flag $subcompile_static_flag $subcompile_CXX $parallel_flag $num_cores $execute_flag $test_flag $input_file_names $output_file_name_prefixes $output_file_name_groups $modes $modes_default $modes_supported $rperl_options );

1;
