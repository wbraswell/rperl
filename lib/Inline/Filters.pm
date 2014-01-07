package Inline::Filters;
use strict;
use Config;
$Inline::Filters::VERSION = "0.12_02";

#============================================================================
# Object Interface
#============================================================================
sub new {
    my $class = shift;
    return bless { filter => shift, coderef => shift }, $class;
}

sub filter {
    my ($self, $o, $code) = @_;
    return $self->{coderef}->($o, $code);
}

#============================================================================
# Strip POD
#============================================================================
sub Strip_POD {
    my $ilsm = shift;
    my $code = shift;
    $code =~ s/^=\w+[^\n]*\n\n(.*?)(^=cut\n\n|\Z)//gsm;
    return $code;
}

#============================================================================
# Strip comments in various languages
#============================================================================
sub skip_quoted {
    my ($text, $index, $closer) = @_;
    for (my $i=$index+1; $i<length $text; $i++) {
        my $p = substr($text, $i-1, 1);
        my $c = substr($text, $i, length($closer));
        return $i if ($c eq $closer and ($p ne '\\' or length($closer)>1));
    }
    return $index; # must not have been a string
}

sub strip_comments {
    my ($txt, $opn, $cls, @quotes) = @_;
    my $i = -1;
    while (++$i < length $txt) {
	my $closer;
        if (grep {my $r=substr($txt,$i,length($_)) eq $_; $closer=$_ if $r; $r}
	    @quotes) {
	    $i = skip_quoted($txt, $i, $closer);
	    next;
        }
        if (substr($txt, $i, length($opn)) eq $opn) {
	    my $e = index($txt, $cls, $i) + length($cls);
	    substr($txt, $i, $e-$i) =~ s/[^\n]/ /g;
	    $i--;
	    next;
        }
    }
    return $txt;
}

# Note: strips both C and C++ comments because so many compilers accept
# both styles for C programs. Perhaps a --strict parameter?
sub Strip_C_Comments {
    my $ilsm = shift;
    my $code = shift;
    $code = strip_comments($code, '//', "\n", '"');
    $code = strip_comments($code, '/*', '*/', '"');
    return $code;
}

sub Strip_CPP_Comments {
    my $ilsm = shift;
    my $code = shift;
    $code = strip_comments($code, '//', "\n", '"');
    $code = strip_comments($code, '/*', '*/', '"');
    return $code;
}

sub Strip_Python_Comments {
    my $ilsm = shift;
    my $code = shift;
    $code = strip_comments($code, '#', "\n", '"', '"""', '\'');
    return $code;
}

sub Strip_TCL_Comments {
    my $ilsm = shift;
    my $code = shift;

    return $code;
}

#============================================================================
# Preprocess C and C++
#============================================================================
sub Preprocess {
    my $ilsm = shift;
    my $code = shift;

    my @inc_array;
    if (defined($ilsm->{ILSM}{MAKEFILE}{INC})) {
      if (ref($ilsm->{ILSM}{MAKEFILE}{INC} eq 'ARRAY')) {
        @inc_array = @{$ilsm->{ILSM}{MAKEFILE}{INC}};
      }
      else {
        @inc_array = ($ilsm->{ILSM}{MAKEFILE}{INC});
      }
    }
    else {
      @inc_array = ();
    }

    my $cpp = join ' ', ($Config{cpprun},
			 $Config{cppflags},
			 "-I$Config{archlibexp}/CORE",
                         @inc_array
			);

    my $tmpfile = $ilsm->{API}{build_dir} . "/Filters.c";
    $ilsm->mkpath($ilsm->{API}{build_dir});
    open CSRC, ">$tmpfile" or die $!;
    print CSRC $code;
    close CSRC;
    open PROCESSED, "$cpp $tmpfile |" or die $!;
    $code = join'', <PROCESSED>;
    close PROCESSED;
    unlink $tmpfile;
    return $code;
}

#============================================================================
# Returns a list of key, value pairs; a filter and its code reference.
#============================================================================
my %filters =
  (
   ALL => [
	   Strip_POD => \&Strip_POD,
	   Preprocess => \&Preprocess,
	  ],
   C => [
	 Strip_Comments => \&Strip_C_Comments,
	],
   CPP => [
	   Strip_Comments => \&Strip_CPP_Comments,
	  ],
   JAVA => [
	    Strip_Comments => \&Strip_CPP_Comments,
	   ],
  );
sub get_filters {
    my $language = shift;
    my ($all, $lang) = @filters{ALL => $language};
    $lang ||= [];
    return (@$all, @$lang);
}

1;
