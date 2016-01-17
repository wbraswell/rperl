#!/usr/bin/perl

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.022_001;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use RPerl::Learning;
use App::Pod2CpanHtml;
use File::Temp qw(tempfile);
use Date::Format;

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

    my string $file_line_previous = undef;
    my string $file_line_next = undef;
    my integer $file_line_number = 0;
    while ( my string $file_line = <$INPUT_FILEHANDLE> ) {
        $file_line_number++;

        # enable HTML newline <br> from null POD X<br>
        if ($file_line =~ s/X<br>/<br>/gxms) {
            $file_line_next = <$INPUT_FILEHANDLE>;
            $file_line_number++;
            if ($file_line_next ne "\n") { croak 'ERROR: X<br> tag followed by non-blank line ' . q{'} . $file_line_next . q{'} . ' on input file line ' . $file_line_number . ', croaking'; }
            $file_line_next = undef;  # discard extra line after X<br> tag
        }
 
        # disable <code>...</code> tags from null POD X<noncode>...X</noncode>
        if ($file_line =~ s/X<noncode>/<noncode>/gxms) {
            $file_line_next = <$INPUT_FILEHANDLE>;
            $file_line_number++;
            if ($file_line_next ne "\n") { croak 'ERROR: X<noncode> tag followed by non-blank line ' . q{'} . $file_line_next . q{'} . ' on input file line ' . $file_line_number . ', croaking'; }
        }
        if ($file_line =~ s/X<\/noncode>/<\/noncode>/gxms) {
            if ($file_line_previous ne "\n") { croak 'ERROR: X</noncode> tag preceeded by non-blank line ' . q{'} . $file_line_previous . q{'} . ' on input file line ' . $file_line_number . ', croaking'; }
        }

        # enable HTML underline <u>...</u> from null POD X<u>...X</u>; DEPRECATED IN FAVOR OF =for html <u>...</u>
#        $file_line =~ s/X<u>/<u>/gxms;
#        $file_line =~ s/X<\/u>/<\/u>/gxms;

        push @{$file_lines}, $file_line;
        if (defined $file_line_next) {
            push @{$file_lines}, $file_line_next;
            $file_line_next = undef;
        }
        $file_line_previous = $file_line;
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
    my boolean $inside_edition = 0;  # no, not Bill O'Reilly
    my boolean $inside_toc = 0;
    my boolean $need_check_close_ul = 0;
    my string $file_line_saved = undef;
    my boolean $inside_noncode = 0;
    push @{$file_lines_modified}, '<!DOCTYPE html>';  # why isn't there already a DOCTYPE tag added by one of the other HTML generators?  :P
    foreach my string $file_line ( @{$file_lines} ) {
        # CPAN only, not MetaCPAN: help inline code tags stand out more, highlighted background matching the block-indented code
#        if ($file_line eq '</head>') { push @{$file_lines_modified}, '<style> code { background: #eeeeee; } </style>'; }  # no outline
#        if ($file_line eq '</head>') { push @{$file_lines_modified}, '<style> code { background: #eeeeee; border: 1px solid #888888; } </style>'; }  # yes outline
 
        # Edition: insert Learning.pm $VERSION & date
        if ($file_line eq 'name="EDITION"') {
#            print {*STDERR} 'have $file_line = ' . $file_line . "\n";
            $inside_edition = 1;
            push @{$file_lines_modified}, $file_line;
            next;
        }
        elsif ($inside_edition) {
            if ($file_line eq '<p>&#60;br&#62;</p>') {
#                print {*STDERR} 'have $file_line = ' . $file_line . "\n";
                $file_line = '<p><br></p>';
                push @{$file_lines_modified}, ('<p>Automatically Generated From <a href="https://github.com/wbraswell/rperl/blob/master/lib/RPerl/Learning.pm"><i>RPerl/Learning.pm</i></a> v' . number_to_string($RPerl::Learning::VERSION) . '<br>' . "\n");
                push @{$file_lines_modified}, ('Using <a href="https://github.com/wbraswell/rperl/blob/master/script/development/pod2rperlhtml.pl"><i>pod2rperlhtml.pl</i></a> v' . number_to_string($VERSION) . '<br>' . "\n");
                push @{$file_lines_modified}, (time2str('On %A, %B %d, %Y at %l:%M%P %Z', time) . '<br>' . "\n");
#                push @{$file_lines_modified}, (time2str('%Y%m%d %Y.%j %H%M.%S', time) . '</p>' . "\n");  # Longdate & Stardate
                $inside_edition = 0;
            }
            push @{$file_lines_modified}, $file_line;
            next;
        }

        # MetaCPAN & SyntaxHighlighter: enable CSS & Javascript
        if ($file_line eq '<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" >') {
            push @{$file_lines_modified}, '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">';
            next;
        }
        if ($file_line eq '<link rel="stylesheet" type="text/css" title="pod_stylesheet" href="http://search.cpan.org/s/style.css">') {
#            push @{$file_lines_modified}, '<link href="https://metacpan.org/_assets/d9ff6fc28efe349c1ffc17c397bd95ca.css" rel="stylesheet" type="text/css">';  # live remote copy
#            push @{$file_lines_modified}, '<script src="https://metacpan.org/_assets/a869e92bd8b69760f4c3b0a85075f0f9.js" type="text/javascript"></script>';   # live remote copy
#            push @{$file_lines_modified}, '<link href="metacpan.css" rel="stylesheet" type="text/css">';  # 20160101 local copy
#            push @{$file_lines_modified}, '<script src="metacpan.js" type="text/javascript"></script>';   # 20160101 local copy
            push @{$file_lines_modified}, '<link href="stylesheets/metacpan_rperl.css" rel="stylesheet" type="text/css">';  # modified local copy
            push @{$file_lines_modified}, '<script src="javascripts/metacpan_rperl.js" type="text/javascript"></script>';   # modified local copy
            next;
        }

        # MetaCPAN & SyntaxHighlighter: enable syntax highlighting div
        if ($file_line =~ m/<body class='pod'>/) {
            push @{$file_lines_modified}, '<body>';
            push @{$file_lines_modified}, '<div class="pod content anchors">';
            next;
        }
        elsif ($file_line =~ m/<\/body>/) {
            push @{$file_lines_modified}, '</div> <!-- END class="pod content anchors": SyntaxHighlighter applied to code within this div -->';
            push @{$file_lines_modified}, $file_line;
            next;
        }

        if ($file_line =~ m/^\s+generated\sby\sPod::Simple::HTML/) {
            push @{$file_lines_modified}, '  re-generated by pod2rperlhtml.pl v' . number_to_string($VERSION) . ',';
        }

        # MetaCPAN: TOC changes
        if ($file_line eq q{<div class='indexgroup'>}) {
            # delete <div class='indexgroup'> before TOC
            $inside_toc = 1;
            next;
        }
        elsif ($inside_toc) {
            if ($file_line eq q{<ul   class='indexList indexList1'>}) {
                # change <ul   class='indexList indexList1'> to <ul id="index">
                push @{$file_lines_modified}, '<ul id="index">';
                next;
            }
            elsif ($file_line eq '</div>') {
                # delete </div> after TOC
                $inside_toc = 0;
                next;
            }

            # change <li class='FOO'><a href to <li><a href
            $file_line =~ s/<li\s+class\=\'.*\'><a\s+href/<li><a href/gxms;

            # change </ul> to </ul></li>
            $file_line =~ s/<\/ul>/<\/ul><\/li>/gxms;
            
            # change <ul FOO> to <ul>
            $file_line =~ s/<ul.+>/<ul>/gxms;

=NEED FIX
            # change </a> to </a></li> EXCEPT when followed by </ul>
            if ($file_line =~ m/<\/a>/) {
                $need_check_close_ul = 1;
                $file_line_saved = $file_line;
                next;
            }
            elsif ($need_check_close_ul) {
                if ($file_line !~ m/^\s*<\/ul>\s*$/) {
                    $file_line_saved =~ s/<\/a>/<\/a><\/li>/gxms;
                }
                push @{$file_lines_modified}, $file_line_saved;
                $need_check_close_ul = 0;
                $file_line_saved = undef;
            }
=cut
        }

        # enable HTML newline <br> from mangled HTML literals
        #        $file_line =~ s/&lt;br&gt;/<br>/gxms;        # pod2html
        $file_line =~ s/&\#60;br&\#62;/<br>/gxms;    # pod2cpanhtml

        # disable HTML <code>...</code> from mangled HTML <noncode>...</noncode> literals
        if ($file_line eq '<p>&#60;noncode&#62;</p>') {
            $inside_noncode = 1;
            next;
        }
        elsif ($inside_noncode) {
            if ($file_line eq '<p>&#60;/noncode&#62;</p>') {
                $inside_noncode = 0;
                next;
            }
        }
        else {
            # MetaCPAN & SyntaxHighlighter: enable indented block code formatting
            $file_line =~ s/<pre>/<pre><code>/gxms;
            $file_line =~ s/<\/pre>/<\/code><\/pre>/gxms;
        }

        # enable HTML underline <u>...</u> from mangled HTML literals; DEPRECATED IN FAVOR OF =for html <u>...</u>
#        $file_line =~ s/&\#60;u&\#62;/<u>/gxms;        # pod2cpanhtml
#        $file_line =~ s/&\#60;\/u&\#62;/<\/u>/gxms;    # pod2cpanhtml

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