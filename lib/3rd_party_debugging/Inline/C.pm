package Inline::C;
$Inline::C::VERSION = '0.53';
$Inline::C::VERSION = eval $Inline::C::VERSION;

use strict;
require Inline;
use Config;
use Data::Dumper;
use Carp;
use Cwd qw(cwd abs_path);
use File::Spec;

@Inline::C::ISA = qw(Inline);

#==============================================================================
# Register this module as an Inline language support module
#==============================================================================
sub register {
    return {
	    language => 'C',
            # XXX Breaking this on purpose; let's see who screams
            # aliases => ['c'],
	    type => 'compiled',
	    suffix => $Config{dlext},
	   };
}

#==============================================================================
# Validate the C config options
#==============================================================================
sub usage_validate {
    my $key = shift;
    return <<END;
The value of config option '$key' must be a string or an array ref

END
}

sub validate {
    my $o = shift;

    RPerl::diag "validate Stage\n" if $o->{CONFIG}{BUILD_NOISY};
    $o->{ILSM} ||= {};
    $o->{ILSM}{XS} ||= {};
    $o->{ILSM}{MAKEFILE} ||= {};
    if (not $o->UNTAINT) {
	require FindBin;
	$o->{ILSM}{MAKEFILE}{INC} = "-I\"$FindBin::Bin\"" if not defined $o->{ILSM}{MAKEFILE}{INC};
    }
    $o->{ILSM}{AUTOWRAP} = 0 if not defined $o->{ILSM}{AUTOWRAP};
    $o->{ILSM}{XSMODE} = 0 if not defined $o->{ILSM}{XSMODE};
    $o->{ILSM}{AUTO_INCLUDE} ||= <<END;
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "INLINE.h"
END
    $o->{ILSM}{FILTERS} ||= [];
    $o->{STRUCT} ||= {
		      '.macros' => '',
		      '.xs' => '',
		      '.any' => 0,
		      '.all' => 0,
		     };

    while (@_) {
	my ($key, $value) = (shift, shift);
      if ($key eq 'PRE_HEAD') {
         unless( -f $value) {
           $o->{ILSM}{AUTO_INCLUDE} = $value . "\n" . $o->{ILSM}{AUTO_INCLUDE};
         }
         else {
           my $insert;
           open RD, '<', $value or die "Couldn't open $value for reading: $!";
           while(<RD>) {$insert .= $_}
           close RD or die "Couldn't close $value after reading: $!";
           $o->{ILSM}{AUTO_INCLUDE} = $insert . "\n" . $o->{ILSM}{AUTO_INCLUDE};
         }
         next;
      }
	if ($key eq 'MAKE' or
	    $key eq 'AUTOWRAP' or
            $key eq 'XSMODE'
	   ) {
	    $o->{ILSM}{$key} = $value;
	    next;
	}
	if ($key eq 'CC' or
	    $key eq 'LD') {
	    $o->{ILSM}{MAKEFILE}{$key} = $value;
	    next;
	}
	if ($key eq 'LIBS') {
	    $o->add_list($o->{ILSM}{MAKEFILE}, $key, $value, []);
	    next;
	}
	if ($key eq 'INC') {
	    $o->add_string($o->{ILSM}{MAKEFILE}, $key, quote_space($value), '');
	    next;
	}
	if ($key eq 'MYEXTLIB' or
	    $key eq 'OPTIMIZE' or
	    $key eq 'CCFLAGS' or
	    $key eq 'LDDLFLAGS') {
	    $o->add_string($o->{ILSM}{MAKEFILE}, $key, $value, '');
	    next;
	}
      if ($key eq 'CCFLAGSEX') {
	    $o->add_string($o->{ILSM}{MAKEFILE}, 'CCFLAGS', $Config{ccflags} . ' ' . $value, '');
          next;
      }
	if ($key eq 'TYPEMAPS') {
          unless(ref($value) eq 'ARRAY') {
	      croak "TYPEMAPS file '$value' not found"
	        unless -f $value;
	      $value = File::Spec->rel2abs($value);
          }
          else {
            for (my $i = 0; $i < scalar(@$value); $i++) {
	      croak "TYPEMAPS file '${$value}[$i]' not found"
	        unless -f ${$value}[$i];
              ${$value}[$i] = File::Spec->rel2abs(${$value}[$i]);
            }
          }
	  $o->add_list($o->{ILSM}{MAKEFILE}, $key, $value, []);
	  next;
	}
	if ($key eq 'AUTO_INCLUDE') {
	    $o->add_text($o->{ILSM}, $key, $value, '');
	    next;
	}
	if ($key eq 'BOOT') {
	    $o->add_text($o->{ILSM}{XS}, $key, $value, '');
	    next;
	}
	if ($key eq 'PREFIX') {
	    croak "Invalid value for 'PREFIX' option"
	      unless ($value =~ /^\w*$/ and
		      $value !~ /\n/);
	    $o->{ILSM}{XS}{PREFIX} = $value;
	    next;
	}
	if ($key eq 'FILTERS') {
	    next if $value eq '1' or $value eq '0'; # ignore ENABLE, DISABLE
	    $value = [$value] unless ref($value) eq 'ARRAY';
	    my %filters;
	    for my $val (@$value) {
		if (ref($val) eq 'CODE') {
		    $o->add_list($o->{ILSM}, $key, $val, []);
	        }
		else {

# [[[ BEGIN MODIFIED CODE, WBRASWELL 20131208 ]]]]
# [[[ BEGIN MODIFIED CODE, WBRASWELL 20131208 ]]]]
# [[[ BEGIN MODIFIED CODE, WBRASWELL 20131208 ]]]]

# DOES NOT SEEM TO BE RESPONSIBLE FOR???
#Warning: Use of "require" without parentheses is ambiguous at (eval 23) line 1.
#syntax error at (eval 23) line 1, near "require Inline::Filters-"

		    eval { require Inline::Filters };

=snip

print "BEGIN INLINE DEBUGGING\n";
print "BEGIN INLINE DEBUGGING\n";
print "BEGIN INLINE DEBUGGING\n";
print "in C.pm, \n"
print "END INLINE DEBUGGING\n";
print "END INLINE DEBUGGING\n";
print "END INLINE DEBUGGING\n";
=cut

#		    eval { require(Inline::Filters); };
#		    eval q{ require Inline::Filters };

# [[[ END MODIFIED CODE, WBRASWELL 20131208 ]]]]
# [[[ END MODIFIED CODE, WBRASWELL 20131208 ]]]]
# [[[ END MODIFIED CODE, WBRASWELL 20131208 ]]]]

		    croak "'FILTERS' option requires Inline::Filters to be installed."
		      if $@;
		    %filters = Inline::Filters::get_filters($o->{API}{language})
		      unless keys %filters;
		    if (defined $filters{$val}) {
			my $filter = Inline::Filters->new($val,
							  $filters{$val});
			$o->add_list($o->{ILSM}, $key, $filter, []);
		    }
		    else {
			croak "Invalid filter $val specified.";
		    }
		}
	    }
	    next;
	}
	if ($key eq 'STRUCTS') {
	    # A list of struct names
	    if (ref($value) eq 'ARRAY') {
		for my $val (@$value) {
		    croak "Invalid value for 'STRUCTS' option"
		      unless ($val =~ /^[_a-z][_0-9a-z]*$/i);
		    $o->{STRUCT}{$val}++;
		}
	    }
	    # Enable or disable
	    elsif ($value =~ /^\d+$/) {
		$o->{STRUCT}{'.any'} = $value;
	    }
	    # A single struct name
	    else {
		croak "Invalid value for 'STRUCTS' option"
		  unless ($value =~ /^[_a-z][_0-9a-z]*$/i);
		$o->{STRUCT}{$value}++;
	    }
	    eval { require Inline::Struct };
	    croak "'STRUCTS' option requires Inline::Struct to be installed."
	      if $@;
	    $o->{STRUCT}{'.any'} = 1;
	    next;
	}
	my $class = ref $o; # handles subclasses correctly.
	croak "'$key' is not a valid config option for $class\n";
    }
}

sub add_list {
    my $o = shift;
    my ($ref, $key, $value, $default) = @_;
    $value = [$value] unless ref $value eq 'ARRAY';
    for (@$value) {
	if (defined $_) {
	    push @{$ref->{$key}}, $_;
	}
	else {
	    $ref->{$key} = $default;
	}
    }
}

sub add_string {
    my $o = shift;
    my ($ref, $key, $value, $default) = @_;
    $value = [$value] unless ref $value;
    croak usage_validate($key) unless ref($value) eq 'ARRAY';
    for (@$value) {
	if (defined $_) {
	    $ref->{$key} .= ' ' . $_;
	}
	else {
	    $ref->{$key} = $default;
	}
    }
}

sub add_text {
    my $o = shift;
    my ($ref, $key, $value, $default) = @_;
    $value = [$value] unless ref $value;
    croak usage_validate($key) unless ref($value) eq 'ARRAY';
    for (@$value) {
	if (defined $_) {
	    chomp;
	    $ref->{$key} .= $_ . "\n";
	}
	else {
	    $ref->{$key} = $default;
	}
    }
}

#==============================================================================
# Return a small report about the C code..
#==============================================================================
sub info {
    my $o = shift;
    return <<END if $o->{ILSM}{XSMODE};
No information is currently generated when using XSMODE.

END
    my $text = '';
    $o->preprocess;
    $o->parse;
    if (defined $o->{ILSM}{parser}{data}{functions}) {
	$text .= "The following Inline $o->{API}{language} function(s) have been successfully bound to Perl:\n";
	my $parser = $o->{ILSM}{parser};
	my $data = $parser->{data};
	for my $function (sort @{$data->{functions}}) {
	    my $return_type = $data->{function}{$function}{return_type};
	    my @arg_names = @{$data->{function}{$function}{arg_names}};
	    my @arg_types = @{$data->{function}{$function}{arg_types}};
	    my @args = map {$_ . ' ' . shift @arg_names} @arg_types;
	    $text .= "\t$return_type $function(" . join(', ', @args) . ")\n";
	}
    }
    else {
	$text .= "No $o->{API}{language} functions have been successfully bound to Perl.\n\n";
    }
    $text .= Inline::Struct::info($o) if $o->{STRUCT}{'.any'};
    return $text;
}

sub config {
    my $o = shift;
}

#==============================================================================
# Parse and compile C code
#==============================================================================
my $total_build_time;
sub build {
    my $o = shift;

    if ($o->{CONFIG}{BUILD_TIMERS}) {
        eval {require Time::HiRes};
        croak "You need Time::HiRes for BUILD_TIMERS option:\n$@" if $@;
        $total_build_time = Time::HiRes::time();
    }
    $o->call('preprocess', 'Build Preprocess');
    $o->call('parse', 'Build Parse');
    $o->call('write_XS', 'Build Glue 1');
    $o->call('write_Inline_headers', 'Build Glue 2');
    $o->call('write_Makefile_PL', 'Build Glue 3');
    $o->call('compile', 'Build Compile');
    if ($o->{CONFIG}{BUILD_TIMERS}) {
        $total_build_time = Time::HiRes::time() - $total_build_time;
        printf STDERR "Total Build Time: %5.4f secs\n", $total_build_time;
    }
}

sub call {
    my ($o, $method, $header, $indent) = (@_, 0);
    my $time;
    my $i = ' ' x $indent;
    RPerl::diag "${i}Starting $header Stage\n" if $o->{CONFIG}{BUILD_NOISY};
    $time = Time::HiRes::time()
      if $o->{CONFIG}{BUILD_TIMERS};

    $o->$method();

    $time = Time::HiRes::time() - $time
      if $o->{CONFIG}{BUILD_TIMERS};
    RPerl::diag "${i}Finished $header Stage\n" if $o->{CONFIG}{BUILD_NOISY};
    printf STDERR "${i}Time for $header Stage: %5.4f secs\n", $time
      if $o->{CONFIG}{BUILD_TIMERS};
    RPerl::diag "\n" if $o->{CONFIG}{BUILD_NOISY};
}

#==============================================================================
# Apply any
#==============================================================================
sub preprocess {
    my $o = shift;
    return if $o->{ILSM}{parser};
    $o->get_maps;
    $o->get_types;
    $o->{ILSM}{code} = $o->filter(@{$o->{ILSM}{FILTERS}});
}

#==============================================================================
# Parse the function definition information out of the C code
#==============================================================================
sub parse {
    my $o = shift;
    return if $o->{ILSM}{parser};
    return if $o->{ILSM}{XSMODE};
    my $parser = $o->{ILSM}{parser} = $o->get_parser;
    $parser->{data}{typeconv} = $o->{ILSM}{typeconv};
    $parser->{data}{AUTOWRAP} = $o->{ILSM}{AUTOWRAP};
    Inline::Struct::parse($o) if $o->{STRUCT}{'.any'};
    $parser->code($o->{ILSM}{code})
      or croak <<END;
Bad $o->{API}{language} code passed to Inline at @{[caller(2)]}
END
}

# Create and initialize a parser
sub get_parser {
    my $o = shift;
    Inline::C::_parser_test("Inline::C::get_parser called\n") if $o->{CONFIG}{_TESTING};
    require Inline::C::ParseRecDescent;
    Inline::C::ParseRecDescent::get_parser($o);
}

#==============================================================================
# Gather the path names of all applicable typemap files.
#==============================================================================
sub get_maps {
    my $o = shift;

    RPerl::diag "get_maps Stage\n" if $o->{CONFIG}{BUILD_NOISY};
    my $typemap = '';
    my $file;
    $file = File::Spec->catfile($Config::Config{installprivlib},"ExtUtils","typemap");
    $typemap = $file if -f $file;
    $file = File::Spec->catfile($Config::Config{privlibexp}    ,"ExtUtils","typemap");
    $typemap = $file
      if (not $typemap and -f $file);
    warn "Can't find the default system typemap file"
      if (not $typemap and $^W);

    unshift(@{$o->{ILSM}{MAKEFILE}{TYPEMAPS}}, $typemap) if $typemap;

    if (not $o->UNTAINT) {
	require FindBin;
	$file = File::Spec->catfile($FindBin::Bin,"typemap");
        if ( -f $file ) {
	   push(@{$o->{ILSM}{MAKEFILE}{TYPEMAPS}}, $file);
        }
    }
}

#==============================================================================
# This routine parses XS typemap files to get a list of valid types to create
# bindings to. This code is mostly hacked out of Larry Wall's xsubpp program.
#==============================================================================
sub get_types {
    my (%type_kind, %proto_letter, %input_expr, %output_expr);
    my $o = shift;
    local $_;
    croak "No typemaps specified for Inline C code"
      unless @{$o->{ILSM}{MAKEFILE}{TYPEMAPS}};

    my $proto_re = "[" . quotemeta('\$%&*@;') . "]";
    foreach my $typemap (@{$o->{ILSM}{MAKEFILE}{TYPEMAPS}}) {
	next unless -e $typemap;
	# skip directories, binary files etc.
	warn("Warning: ignoring non-text typemap file '$typemap'\n"), next
	  unless -T $typemap;
	open(TYPEMAP, $typemap)
	  or warn ("Warning: could not open typemap file '$typemap': $!\n"), next;
	my $mode = 'Typemap';
	my $junk = "";
	my $current = \$junk;
	while (<TYPEMAP>) {
	    next if /^\s*\#/;
	    my $line_no = $. + 1;
	    if (/^INPUT\s*$/)   {$mode = 'Input';   $current = \$junk;  next}
	    if (/^OUTPUT\s*$/)  {$mode = 'Output';  $current = \$junk;  next}
	    if (/^TYPEMAP\s*$/) {$mode = 'Typemap'; $current = \$junk;  next}
	    if ($mode eq 'Typemap') {
		chomp;
		my $line = $_;
		TrimWhitespace($_);
		# skip blank lines and comment lines
		next if /^$/ or /^\#/;
		my ($type,$kind, $proto) =
		  /^\s*(.*?\S)\s+(\S+)\s*($proto_re*)\s*$/ or
		    warn("Warning: File '$typemap' Line $. '$line' TYPEMAP entry needs 2 or 3 columns\n"), next;
		$type = TidyType($type);
		$type_kind{$type} = $kind;
		# prototype defaults to '$'
		$proto = "\$" unless $proto;
		warn("Warning: File '$typemap' Line $. '$line' Invalid prototype '$proto'\n")
		  unless ValidProtoString($proto);
		$proto_letter{$type} = C_string($proto);
	    }
	    elsif (/^\s/) {
		$$current .= $_;
	    }
	    elsif ($mode eq 'Input') {
		s/\s+$//;
		$input_expr{$_} = '';
		$current = \$input_expr{$_};
	    }
	    else {
		s/\s+$//;
		$output_expr{$_} = '';
		$current = \$output_expr{$_};
	    }
	}
	close(TYPEMAP);
    }

    my %valid_types =
      map {($_, 1)}
    grep {defined $input_expr{$type_kind{$_}}}
    keys %type_kind;

    my %valid_rtypes =
      map {($_, 1)}
    (grep {defined $output_expr{$type_kind{$_}}}
    keys %type_kind), 'void';

    $o->{ILSM}{typeconv}{type_kind} = \%type_kind;
    $o->{ILSM}{typeconv}{input_expr} = \%input_expr;
    $o->{ILSM}{typeconv}{output_expr} = \%output_expr;
    $o->{ILSM}{typeconv}{valid_types} = \%valid_types;
    $o->{ILSM}{typeconv}{valid_rtypes} = \%valid_rtypes;
}

sub ValidProtoString ($) {
    my $string = shift;
    my $proto_re = "[" . quotemeta('\$%&*@;') . "]";
    return ($string =~ /^$proto_re+$/) ? $string : 0;
}

sub TrimWhitespace {
    $_[0] =~ s/^\s+|\s+$//go;
}

sub TidyType {
    local $_ = shift;
    s|\s*(\*+)\s*|$1|g;
    s|(\*+)| $1 |g;
    s|\s+| |g;
    TrimWhitespace($_);
    $_;
}

sub C_string ($) {
    (my $string = shift) =~ s|\\|\\\\|g;
    $string;
}

#==============================================================================
# Write the XS code
#==============================================================================
sub write_XS {
    my $o = shift;
    my $modfname = $o->{API}{modfname};
    my $module = $o->{API}{module};
    $o->mkpath($o->{API}{build_dir});
    open XS, "> ".File::Spec->catfile($o->{API}{build_dir},"$modfname.xs")
      or croak $!;
    if ($o->{ILSM}{XSMODE}) {
	warn <<END if $^W and  $o->{ILSM}{code} !~ /MODULE\s*=\s*$module\b/;
While using Inline XSMODE, your XS code does not have a line with

  MODULE = $module

You should use the Inline NAME config option, and it should match the
XS MODULE name.

END
	print XS $o->xs_code;
    }
    else {
	print XS $o->xs_generate;
    }
    close XS;
}

#==============================================================================
# Generate the XS glue code (piece together lots of snippets)
#==============================================================================
sub xs_generate {
    my $o = shift;
    return join '', ($o->xs_includes,
		     $o->xs_struct_macros,
		     $o->xs_code,
		     $o->xs_struct_code,
		     $o->xs_bindings,
		     $o->xs_boot,
		    );
}

sub xs_includes {
    my $o = shift;
    return $o->{ILSM}{AUTO_INCLUDE};
}

sub xs_struct_macros {
    my $o = shift;
    return $o->{STRUCT}{'.macros'};
}

sub xs_code {
    my $o = shift;
    return $o->{ILSM}{code};
}

sub xs_struct_code {
    my $o = shift;
    return $o->{STRUCT}{'.xs'};
}

sub xs_boot {
    my $o = shift;
    if (defined $o->{ILSM}{XS}{BOOT} and
	$o->{ILSM}{XS}{BOOT}) {
	return <<END;
BOOT:
$o->{ILSM}{XS}{BOOT}
END
    }
    return '';
}

sub xs_bindings {
    my $o = shift;
    my $dir = '_Inline_test';

    if($o->{CONFIG}{_TESTING}) {
      if(! -d $dir) {
        my $ok = mkdir $dir;
        warn $! if !$ok;
      }

      if(! -f "$dir/void_test") {
        warn $! if !open(TEST_FH, '>', "$dir/void_test");
        warn $! if !close(TEST_FH);
      }
    }

    my ($pkg, $module) = @{$o->{API}}{qw(pkg module)};
    my $prefix = (($o->{ILSM}{XS}{PREFIX}) ?
		  "PREFIX = $o->{ILSM}{XS}{PREFIX}" :
		  '');
    my $XS = <<END;

MODULE = $module	PACKAGE = $pkg	$prefix

PROTOTYPES: DISABLE

END

    my $parser = $o->{ILSM}{parser};
    my $data = $parser->{data};

    warn("Warning. No Inline C functions bound to Perl in ", $o->{API}{script}, "\n" .
	 "Check your C function definition(s) for Inline compatibility\n\n")
      if ((not defined$data->{functions}) and ($^W));

    for my $function (@{$data->{functions}}) {
	my $return_type = $data->{function}->{$function}->{return_type};
	my @arg_names = @{$data->{function}->{$function}->{arg_names}};
	my @arg_types = @{$data->{function}->{$function}->{arg_types}};

	$XS .= join '', ("\n$return_type\n$function (",
		  join(', ', @arg_names), ")\n");

	for my $arg_name (@arg_names) {
	    my $arg_type = shift @arg_types;
	    last if $arg_type eq '...';
	    $XS .= "\t$arg_type\t$arg_name\n";
	}

	my $listargs = '';
	$listargs = pop @arg_names if (@arg_names and
				       $arg_names[-1] eq '...');
	my $arg_name_list = join(', ', @arg_names);

	if ($return_type eq 'void') {
	if($o->{CONFIG}{_TESTING}) {
      $XS .= <<END;
	PREINIT:
	PerlIO* stream;
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	$function($arg_name_list);
      stream = PerlIO_open(\"$dir/void_test\", \"a\");
      if(stream == NULL) warn(\"%s\\n\", \"Unable to open $dir/void_test for appending\");
	if (PL_markstack_ptr != temp) {
	  PerlIO_printf(stream, \"%s\\n\", \"TRULY_VOID\");
	  PerlIO_close(stream);
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
	PerlIO_printf(stream, \"%s\\n\", \"LIST_CONTEXT\");
	PerlIO_close(stream);
	return; /* assume stack size is correct */
END
	  }
	  else {
	    $XS .= <<END;
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	$function($arg_name_list);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */
END
	  }
	}
	elsif ($listargs) {
	    $XS .= <<END;
	PREINIT:
	I32* temp;
	CODE:
	temp = PL_markstack_ptr++;
	RETVAL = $function($arg_name_list);
	PL_markstack_ptr = temp;
	OUTPUT:
        RETVAL
END
	}
    }
    $XS .= "\n";
    return $XS;
}

#==============================================================================
# Generate the INLINE.h file.
#==============================================================================
sub write_Inline_headers {
    my $o = shift;

    open HEADER, "> ".File::Spec->catfile($o->{API}{build_dir},"INLINE.h")
      or croak;

    print HEADER <<'END';
#define Inline_Stack_Vars	dXSARGS
#define Inline_Stack_Items      items
#define Inline_Stack_Item(x)	ST(x)
#define Inline_Stack_Reset      sp = mark
#define Inline_Stack_Push(x)	XPUSHs(x)
#define Inline_Stack_Done	PUTBACK
#define Inline_Stack_Return(x)	XSRETURN(x)
#define Inline_Stack_Void       XSRETURN(0)

#define INLINE_STACK_VARS	Inline_Stack_Vars
#define INLINE_STACK_ITEMS	Inline_Stack_Items
#define INLINE_STACK_ITEM(x)	Inline_Stack_Item(x)
#define INLINE_STACK_RESET	Inline_Stack_Reset
#define INLINE_STACK_PUSH(x)    Inline_Stack_Push(x)
#define INLINE_STACK_DONE	Inline_Stack_Done
#define INLINE_STACK_RETURN(x)	Inline_Stack_Return(x)
#define INLINE_STACK_VOID	Inline_Stack_Void

#define inline_stack_vars	Inline_Stack_Vars
#define inline_stack_items	Inline_Stack_Items
#define inline_stack_item(x)	Inline_Stack_Item(x)
#define inline_stack_reset	Inline_Stack_Reset
#define inline_stack_push(x)    Inline_Stack_Push(x)
#define inline_stack_done	Inline_Stack_Done
#define inline_stack_return(x)	Inline_Stack_Return(x)
#define inline_stack_void	Inline_Stack_Void
END

    close HEADER;
}

#==============================================================================
# Generate the Makefile.PL
#==============================================================================
sub write_Makefile_PL {
    my $o = shift;
    $o->{ILSM}{xsubppargs} = '';
    my $i = 0;
    for (@{$o->{ILSM}{MAKEFILE}{TYPEMAPS}}) {
	$o->{ILSM}{xsubppargs} .= "-typemap \"$_\" ";
        $o->{ILSM}{MAKEFILE}{TYPEMAPS}->[$i++] = fix_space($_);
    }

    my %options = (
		   VERSION => $o->{API}{version} || '0.00',
		   %{$o->{ILSM}{MAKEFILE}},
		   NAME => $o->{API}{module},
		  );

    open MF, "> ".File::Spec->catfile($o->{API}{build_dir},"Makefile.PL")
      or croak;

    print MF <<END;
use ExtUtils::MakeMaker;
my %options = %\{
END

    local $Data::Dumper::Terse = 1;
    local $Data::Dumper::Indent = 1;
    print MF Data::Dumper::Dumper(\ %options);

    print MF <<END;
\};
WriteMakefile(\%options);

# Remove the Makefile dependency. Causes problems on a few systems.
sub MY::makefile { '' }
END
    close MF;
}

#==============================================================================
# Run the build process.
#==============================================================================
sub compile {
    my $o = shift;

    my $build_dir = $o->{API}{build_dir};
    my $cwd = &cwd;
    ($cwd) = $cwd =~ /(.*)/ if $o->UNTAINT;

    chdir $build_dir;
    # Run these in an eval block, so that we get to chdir back to
    # $cwd if there's a failure. (Ticket #81375.)
    eval {
      $o->call('makefile_pl', '"perl Makefile.PL"', 2);
      $o->call('make', '"make"', 2);
      $o->call('make_install', '"make install"', 2);
    };
    chdir $cwd;
    die if $@; #Die now that we've done the chdir back to $cwd. (#81375)
    $o->call('cleanup', 'Cleaning Up', 2);
}

sub makefile_pl {
    my ($o) = @_;
    my $perl;
    -f ($perl = $Config::Config{perlpath})
      or ($perl = $^X)
      or croak "Can't locate your perl binary";
    $o->system_call("$perl Makefile.PL", 'out.Makefile_PL');
    $o->fix_make;
}
sub make {
    my ($o) = @_;
    my $make = $o->{ILSM}{MAKE} || $Config::Config{make}
      or croak "Can't locate your make binary";
    $o->system_call("$make", 'out.make');
}
sub make_install {
    my ($o) = @_;
    my $make = $o->{ILSM}{MAKE} || $Config::Config{make}
      or croak "Can't locate your make binary";
    $o->system_call("$make pure_install", 'out.make_install');
}
sub cleanup {
    my ($o) = @_;
    my ($modpname, $modfname, $install_lib) =
      @{$o->{API}}{qw(modpname modfname install_lib)};
    if ($o->{API}{cleanup}) {
        $o->rmpath(File::Spec->catdir($o->{API}{directory},'build'),
                   $modpname);
        my $autodir = File::Spec->catdir($install_lib,'auto',$modpname);
        unlink (File::Spec->catfile($autodir,'.packlist'),
                File::Spec->catfile($autodir,'$modfname.bs'),
                File::Spec->catfile($autodir,'$modfname.exp'), #MSWin32
                File::Spec->catfile($autodir,'$modfname.lib'), #MSWin32
               );
    }
}

sub system_call {
    my ($o, $cmd, $output_file) = @_;
    my $build_noisy =
      defined $ENV{PERL_INLINE_BUILD_NOISY}
      ? $ENV{PERL_INLINE_BUILD_NOISY}
      : $o->{CONFIG}{BUILD_NOISY};
    if (not $build_noisy) {
        $cmd = "$cmd > $output_file 2>&1";
    }
    ($cmd) = $cmd =~ /(.*)/ if $o->UNTAINT;
    system($cmd) == 0
      or croak($o->build_error_message($cmd, $output_file, $build_noisy));
}

sub build_error_message {
    my ($o, $cmd, $output_file, $build_noisy) = @_;
    my $build_dir = $o->{API}{build_dir};
    my $output = '';
    if (not $build_noisy and
        open(OUTPUT, $output_file)
       ) {
        local $/;
        $output = <OUTPUT>;
        close OUTPUT;
    }

    return $output . <<END;

A problem was encountered while attempting to compile and install your Inline
$o->{API}{language} code. The command that failed was:
  $cmd

The build directory was:
$build_dir

To debug the problem, cd to the build directory, and inspect the output files.

END
}

#==============================================================================
# This routine fixes problems with the MakeMaker Makefile.
#==============================================================================
my %fixes = (
	     INSTALLSITEARCH => 'install_lib',
	     INSTALLDIRS => 'installdirs',
	     XSUBPPARGS => 'xsubppargs',
	     INSTALLSITELIB => 'install_lib',
	    );

sub fix_make {
    use strict;
    my (@lines, $fix);
    my $o = shift;

    $o->{ILSM}{install_lib} = $o->{API}{install_lib};
    $o->{ILSM}{installdirs} = 'site';

    open(MAKEFILE, '< Makefile')
      or croak "Can't open Makefile for input: $!\n";
    @lines = <MAKEFILE>;
    close MAKEFILE;

    open(MAKEFILE, '> Makefile')
      or croak "Can't open Makefile for output: $!\n";
    for (@lines) {
	if (/^(\w+)\s*=\s*\S+.*$/ and
	    $fix = $fixes{$1}
	   ) {
	    my $fixed = $o->{ILSM}{$fix};
	    $fixed = fix_space($fixed) if $fix eq 'install_lib';
	    print MAKEFILE "$1 = $fixed\n";
	}
	else {
	    print MAKEFILE;
	}
    }
    close MAKEFILE;
}

sub quote_space {

  # Do nothing if $ENV{NO_INSANE_DIRNAMES} is set
  return $_[0] if $ENV{NO_INSANE_DIRNAMES};

  # If $_[0] contains one or more doublequote characters, assume
  # that whitespace has already been quoted as required. Hence,
  # do nothing other than immediately return $_[0] as is.
  # We currently don't properly handle tabs either, so we'll
  # do the same if $_[0] =~ /\t/.
  return $_[0] if ($_[0] =~ /"/ || $_[0] =~ /\t/);

  # We want to split on /\s\-I/ not /\-I/
  my @in = split /\s\-I/, $_[0];
  my $s = @in - 1;
  my %s;
  my %q;

  # First up, let's reinstate the ' ' characters that split
  # removed
  for(my $i = 0; $i < $s; $i++) {
    $in[$i] .= ' ';
  }

  # This for{} block dies if it finds that any of the ' -I'
  # occurrences in $_[0] are part of a directory name.
  for(my $i = 1; $i < $s; $i++) {
    my $t = $in[$i + 1];
    while($t =~ /\s$/) {chop $t}
    die "Found a '", $in[$i], "-I", $t, "' directory.",
        " INC Config argument is ambiguous.",
        " Please use doublequotes to signify your intentions"
      if -d ($in[$i] . "-I" . $t);
  }

  $s++; # Now the same as scalar(@in)

  # Remove (but also Keep track of the amount of) whitespace
  # at the end of each element of @in.
  for(my $i = 0; $i < $s; $i++) {
    my $count = 0;
    while($in[$i] =~ /\s$/) {
      chop $in[$i];
      $count++;
    }
    $s{$i} = $count;
  }

  # Note which elements of @in still contain whitespace. These
  # (and only these) elements will be quoted
  for(my $i = 0; $i < $s; $i++) {
    $q{$i} = 1 if $in[$i] =~ /\s/;
  }

  # Reinstate the occurrences of '-I' that were removed by split(),
  # insert any quotes that are needed, reinstate the whitespace
  # that was removed earlier, then join() the array back together
  # again.
  for(my $i = 0; $i < $s; $i++) {
    $in[$i] = '-I' . $in[$i] if $i;
    $in[$i] = '"' . $in[$i] . '"' if $q{$i};
    $in[$i] .= ' ' x $s{$i};
  }

  # Note: If there was no whitespace that needed quoting, the
  # original argument should not have changed in any way.

  my $out = join '', @in;
  $out =~ s/"\-I\s+\//"\-I\//g;
  $_[0] = $out;
}

sub fix_space {
    $_[0] =~ s/ /\\ /g if $_[0] =~ / /;
    $_[0];
}

#==============================================================================
# This routine used by C/t/09parser to test that the expected parser is in use
#==============================================================================

sub _parser_test {
    my $dir = '_Inline_test';
    if(! -d $dir) {
      my $ok = mkdir $dir;
      warn $! if !$ok;
    }

    warn $! if !open(TEST_FH, '>>', "$dir/parser_id");
    print TEST_FH $_[0];
    warn $! if !close(TEST_FH);
}

#=======================================================================
# This routine used to cleanup files created by _TESTING (config option)
#=======================================================================

sub _testing_cleanup {
    my $dir = '_Inline_test';

    if(-f "$dir/parser_id") {
      warn "Failed to unlink C/$dir/parser_id\n" if !unlink("$dir/parser_id");
    }

    if(-f "$dir/void_test") {
      warn "Failed to unlink C/$dir/void_test\n" if !unlink("$dir/void_test");
    }
}

1;

__END__
