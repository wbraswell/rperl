#!/usr/bin/perl

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.012_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use App::Pod2CpanHtml;
use File::Temp qw(tempfile);

# [[[ SUBROUTINES ]]]

our string_arrayref $pod2cpanhtml_preprocess = sub {
    ( my string_arrayref $command_line_arguments ) = @_;

    my string $input_file = $command_line_arguments->[0];
    if ( not( -e $input_file ) ) {
        croak 'ERROR: File ' . $input_file . ' does not exist, croaking';
    }
    if ( not( -r $input_file ) ) {
        croak 'ERROR: File ' . $input_file . ' is not readable, croaking';
    }
    if ( not( -f $input_file ) ) {
        croak 'ERROR: File ' . $input_file . ' is not a regular file, croaking';
    }
    if ( not( -T $input_file ) ) {
        croak 'ERROR: File ' . $input_file . ' is (probably) not text, croaking';
    }

    my integer $open_success = open my filehandleref $INPUT_FILEHANDLE, '<', $input_file;
    if ( not $open_success ) {
        croak 'ERROR: Failed to open file ' . $input_file . ' for reading, croaking';
    }

    my string_arrayref $file_lines = [];

    while ( my string $file_line = <$INPUT_FILEHANDLE> ) {

        # enable HTML newline <br> from null POD X<br>
        if ($file_line =~ s/X<br>/<br>/gxms) {
            my string $blank_line = <$INPUT_FILEHANDLE>;
            if ($blank_line ne "\n") {
                croak 'ERROR: X<br> tag followed by non-blank line ' . q{'} . $blank_line . q{'} . ', croaking';
            }
        }

        # enable HTML underline <u>...</u> from null POD X<u>...X</u>
        $file_line =~ s/X<u>/<u>/gxms;
        $file_line =~ s/X<\/u>/<\/u>/gxms;

        push @{$file_lines}, $file_line;
    }

    if ( not close $INPUT_FILEHANDLE ) {
        croak 'ERROR: Failed to close file ' . $input_file . ' after reading, croaking';
    }

    #    print 'in pod2cpanhtml_preprocess(), about to return $file_lines = ' . "\n" . (join q{}, @{$file_lines});
    return $file_lines;
};

our string_arrayref $pod2cpanhtml_process = sub {
    ( my string_arrayref $file_lines ) = @_;

    my filehandleref $TEMP_FILE_HANDLE;
    my string $temp_file_name;

#    ( $TEMP_FILE_HANDLE, $temp_file_name ) = tempfile( 'tempfileXXXX', SUFFIX => '.tmp' );
    ( $TEMP_FILE_HANDLE, $temp_file_name ) = tempfile( 'tempfileXXXX', SUFFIX => '.tmp', UNLINK => 1 );

    my string $file_lines_joined = join q{}, @{$file_lines};
    print {$TEMP_FILE_HANDLE} $file_lines_joined
        or croak( 'Attempting to save new file ' . $temp_file_name . ', cannot write to file, croaking:' . $OS_ERROR );

    close $TEMP_FILE_HANDLE
        or croak( 'Attempting to save new file ' . $temp_file_name . ', cannot close file, croaking:' . $OS_ERROR );
 
#    print 'in pod2cpanhtml_process(), have $temp_file_name  = ' . $temp_file_name . "\n";

    my App::Pod2CpanHtml $parser = App::Pod2CpanHtml->new();

    my string $file_lines_modified;
    $parser->output_string( \$file_lines_modified );
    $parser->parse_file($temp_file_name);

    $file_lines = [ ( split /\n/xms, $file_lines_modified ) ];

#    print 'in pod2cpanhtml_process(), about to return $file_lines = ' . "\n" . ( join "\n", @{$file_lines} );
    return $file_lines;
};

our string_arrayref $pod2cpanhtml_postprocess = sub {
    ( my string_arrayref $file_lines ) = @_;
    my string_arrayref $file_lines_modified = [];
    push @{$file_lines_modified}, '<!DOCTYPE html>';  # why isn't there already a DOCTYPE tag added by one of the other HTML generators?  :P
    foreach my string $file_line ( @{$file_lines} ) {
        # help inline code tags stand out more, not only monospace font but also highlighted background matching the block-indented code
        if ($file_line eq '</head>') { push @{$file_lines_modified}, '<style> code { background: #eeeeee; } </style>'; }  # no outline
#        if ($file_line eq '</head>') { push @{$file_lines_modified}, '<style> code { background: #eeeeee; border: 1px solid #888888; } </style>'; }  # yes outline

        # enable HTML newline <br> from mangled HTML literals
        #        $file_line =~ s/&lt;br&gt;/<br>/gxms;        # pod2html
        $file_line =~ s/&\#60;br&\#62;/<br>/gxms;    # pod2cpanhtml

        # enable HTML underline <u>...</u> from mangled HTML literals
        #        $file_line =~ s/&lt;u&gt;/<u>/gxms;            # pod2html
        #        $file_line =~ s/&lt;\/u&gt;/<\/u>/gxms;        # pod2html
        $file_line =~ s/&\#60;u&\#62;/<u>/gxms;        # pod2cpanhtml
        $file_line =~ s/&\#60;\/u&\#62;/<\/u>/gxms;    # pod2cpanhtml

        # disable HTML underline tags in page title
        $file_line =~ s/<title><u>(.*)<\/u><\/title>/<title>$1<\/title>/gxms;

        # strip extra newline between list items
        $file_line =~ s/<li><p>(.*)<\/p>/<li>$1/gxms;

        push @{$file_lines_modified}, $file_line;
    }
    return $file_lines_modified;
};

# [[[ OPERATIONS ]]]

my string_arrayref $file_lines;

$file_lines = pod2cpanhtml_preprocess( [@ARGV] );
$file_lines = pod2cpanhtml_process($file_lines);
$file_lines = pod2cpanhtml_postprocess($file_lines);

print join "\n", @{$file_lines};