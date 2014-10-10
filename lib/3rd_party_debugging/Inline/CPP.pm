package Inline::CPP;

use strict;
use warnings;
use 5.008001;
use Fcntl qw( :DEFAULT :flock );

require Inline::C;
require Inline::CPP::Grammar;
require Inline::CPP::Config;

# Note: Parse::RecDescent 'require'd within get_parser().

use Carp;
use Data::Dumper;

# use base doesn't work because Inline::C cannot be "use"d directly.
our @ISA = qw( Inline::C );    ## no critic (ISA)

# Development releases will have a _0xx version suffix.
# We eval the version number to accommodate dev. version numbering, as
# described in perldoc perlmodstyle.
our $VERSION = '0.58';

# $VERSION = eval $VERSION; ## no critic (eval)

my $TYPEMAP_KIND;
{
  no warnings 'once';          ## no critic (warnings)
  $TYPEMAP_KIND = $Inline::CPP::Grammar::TYPEMAP_KIND;
}

#============================================================================
# Register Inline::CPP as an Inline language module
#============================================================================
sub register {
  use Config;
  return {
    language => 'CPP',
    aliases  => ['cpp', 'C++', 'c++', 'Cplusplus', 'cplusplus', 'CXX', 'cxx'],
    type     => 'compiled',
    suffix   => $Config{dlext},
  };
}    ### Tested.

#============================================================================
# Validate the C++ config options: Now mostly done in Inline::C
#============================================================================
sub validate {
  my ($o, @config_options) = @_;
  my ($flavor_defs, $iostream);

  {    # "used only once" warning. We know it's ok.
    no warnings 'once';    ## no critic (warnings)
    ## no critic (package variable)

    # Set default compiler and libraries.
    $o->{ILSM}{MAKEFILE}{CC}   ||= $Inline::CPP::Config::compiler;
    $o->{ILSM}{MAKEFILE}{LIBS} ||= _make_arrayref($Inline::CPP::Config::libs);

    $flavor_defs = $Inline::CPP::Config::cpp_flavor_defs;  # "Standard"?
    $iostream    = $Inline::CPP::Config::iostream_fn;      # iostream filename.
  }

  # I haven't traced it out yet, but $o->{STRUCT} gets set before getting
  # properly set from Inline::C's validate().
  $o->{STRUCT} ||= {'.macros' => q{}, '.any' => 0, '.xs' => q{}, '.all' => 0,};

  _build_auto_include($o, $flavor_defs, $iostream);

  $o->{ILSM}{PRESERVE_ELLIPSIS} = 0
    unless defined $o->{ILSM}{PRESERVE_ELLIPSIS};

  # Filter out the parameters we treat differently than Inline::C,
  # forwarding unknown requests back up to Inline::C.
  my @propagate = _handle_config_options($o, @config_options);
  $o->SUPER::validate(@propagate) if @propagate;

  return;
}


sub _build_auto_include {
  my ($o, $flavor_defs, $iostream) = @_;
  my $auto_include = <<'END';
#define __INLINE_CPP 1
#ifndef bool
#include <%iostream%>
#endif
extern "C" {
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "INLINE.h"
}
#ifdef bool
#undef bool
#include <%iostream%>
#endif

END

  $o->{ILSM}{AUTO_INCLUDE} ||= $auto_include;
  $o->{ILSM}{AUTO_INCLUDE} = $flavor_defs . $o->{ILSM}{AUTO_INCLUDE};

  # Replace %iostream% with the correct iostream library
  $o->{ILSM}{AUTO_INCLUDE} =~ s{%iostream%}{$iostream}xg;
  return;
}


sub _handle_config_options {
  my ($o, @config_options) = @_;
  my @propagate;
#  warn "in Inline::CPP::_handle_config_options(), top of subroutine, received \$o = \n" . Dumper($o) . "\n";
#  warn "in Inline::CPP::_handle_config_options(), top of subroutine, received \@config_options = \n" . Dumper(\@config_options) . "\n";

  while (@config_options) {
    my ($key, $value) = (shift @config_options, shift @config_options);
    $key = uc $key;
    if ($key eq 'NAMESPACE') {
      _handle_namespace_cfg_option($o, $value);
    }
    elsif ($key eq 'CLASSES') {
      _handle_classes_cfg_option($o, $value);
    }
    elsif ($key eq 'LIBS') {
      _handle_libs_cfg_option($o, $value);
    }
    elsif ($key eq 'ALTLIBS') {
      _handle_altlibs_cfg_option($o, $value);
    }
    elsif ($key eq 'PRESERVE_ELLIPSIS' or $key eq 'STD_IOSTREAM') {
      croak "Argument to $key must be 0 or 1"
        unless $value == 0 or $value == 1;
      $o->{ILSM}{$key} = $value;
    }
    else {
      push @propagate, $key, $value;
    }
  }
  warn "in Inline::CPP::_handle_config_options(), bottom of subroutine, returning \@propagate = \n" . Dumper(\@propagate) . "\n";
  return @propagate;
}

sub _handle_namespace_cfg_option {
  my ($o, $value) = @_;
  warn "in Inline::CPP::_handle_namespace_cfg_option(), top of subroutine, received \$value = '$value'\n";
  $value =~ s/^::|::$//g;
  croak "$value is an invalid package name."
    unless length $value == 0
    || $value =~ m/
                   \A
                   [\p{XID_Start}_][\p{XID_Continue}_]+
                   (?:::[\p{XID_Start}_][\p{XID_Continue}_]+)*
                   \z
                 /x;
  $value ||= 'main';
  $o->{API}{pkg} = $value;
  warn "in Inline::CPP::_handle_namespace_cfg_option(), bottom of subroutine, set \$o->{API}{pkg} = '" . $o->{API}{pkg} . "'\n";
  return;
}


sub _handle_classes_cfg_option {
  my ($o, $value) = @_;
  warn "in Inline::CPP::_handle_classes_cfg_option(), top of subroutine, received \$value = '$value'\n";
  my $ref_value = ref($value);
  croak 'CLASSES config option is not a valid code reference or hash '
    . 'reference of class mappings.'
    unless (($ref_value eq 'CODE') or ($ref_value eq 'HASH'));

  if ($ref_value eq 'HASH') {
    foreach my $cpp_class (keys %{$value}) {
      croak "$cpp_class is not a supported C++ class."
        unless defined $value->{$cpp_class}
        && length $cpp_class != 0
        && $cpp_class =~ m/[a-zA-Z]\w*/x;
      my $perl_class = $value->{$cpp_class};
      croak "$perl_class is not a supported Perl class."
        unless length $perl_class != 0 && $perl_class =~ m/[a-zA-Z]\w*/x;
    }
  }

  $o->{API}{classes_override} = $value;
  warn "in Inline::CPP::_handle_classes_cfg_option(), bottom of subroutine, set \$o->{API}{classes_override} = '" . $o->{API}{classes_override} . "'\n";
  return;
}


sub _handle_libs_cfg_option {
  my ($o, $value) = @_;
  $value = _make_arrayref($value);
  _add_libs($o, $value);
  return;
}


sub _handle_altlibs_cfg_option {
  my ($o, $value) = @_;
  $value = _make_arrayref($value);
  push @{$o->{ILSM}{MAKEFILE}{LIBS}}, q{};
  _add_libs($o, $value);
  return;
}


sub _make_arrayref {
  my $value = shift;
  $value = [$value] unless ref $value eq 'ARRAY';
  return $value;
}

sub _add_libs {
  my ($o, $libs) = @_;
  my $num = scalar @{$o->{ILSM}{MAKEFILE}{LIBS}} - 1;
  $o->{ILSM}{MAKEFILE}{LIBS}[$num] .= q{ } . $_ for @{$libs};
  return;
}


#============================================================================
# Print a small report if PRINT_INFO option is set
#============================================================================
sub info {
  my $o    = shift;
  my $info = q{};

  $o->parse unless $o->{ILSM}{parser};
  my $data = $o->{ILSM}{parser}{data};

  my (@class, @func);
  if (defined $data->{classes}) {
    for my $class (sort @{$data->{classes}}) {
      my @parents
        = grep { $_->{thing} eq 'inherits' } @{$data->{class}{$class}};
      push @class, "\tclass $class";
      push @class,
        (' : ' . join(', ', map { $_->{scope} . q{ } . $_->{name} } @parents))
        if @parents;
      push @class, " {\n";
      for my $thing (sort { $a->{name} cmp $b->{name} }
        @{$data->{class}{$class}})
      {
        my ($name, $scope, $type) = @{$thing}{qw(name scope thing)};
        next unless $scope eq 'public' and $type eq 'method';
        next
          unless $o->check_type($thing, $name eq $class, $name eq "~$class",);
        my $rtype = $thing->{rtype} || q{};
        push @class, "\t\t$rtype" . ($rtype ? q{ } : q{});
        push @class, $class . "::$name(";
        my @args = grep { $_->{name} ne '...' } @{$thing->{args}};
        my $ellipsis = (scalar @{$thing->{args}} - scalar @args) != 0;
        push @class, join ', ', (map {"$_->{type} $_->{name}"} @args),
          $ellipsis ? '...' : ();
        push @class, ");\n";
      }
      push @class, "\t};\n";
    }
  }
  if (defined $data->{functions}) {
    for my $function (sort @{$data->{functions}}) {
      my $func = $data->{function}{$function};
      next if $function =~ m/::/x;
      next unless $o->check_type($func, 0, 0);
      push @func, "\t" . $func->{rtype} . q{ };
      push @func, $func->{name} . '(';
      my @args = grep { $_->{name} ne '...' } @{$func->{args}};
      my $ellipsis = (scalar @{$func->{args}} - scalar @args) != 0;
      push @func, join ', ', (map {"$_->{type} $_->{name}"} @args),
        $ellipsis ? '...' : ();
      push @func, ");\n";
    }
  }

  # Report:
  {
    local $" = q{};
    $info .= "The following classes have been bound to Perl:\n@class\n"
      if @class;
    $info .= "The following functions have been bound to Perl:\n@func\n"
      if @func;
  }
  $info .= Inline::Struct::info($o) if $o->{STRUCT}{'.any'};
  return $info;
}

#============================================================================
# Generate a C++ parser
#============================================================================
sub get_parser {
  my $o       = shift;
  my $grammar = Inline::CPP::Grammar::grammar()
    or croak "Can't find C++ grammar\n";
  no warnings qw/ once /;    ## no critic (warnings)
  $::RD_HINT = 1;    # Turns on Parse::RecDescent's warnings/diagnostics.
  require Parse::RecDescent;
  my $parser = Parse::RecDescent->new($grammar);
  $parser->{data}{typeconv} = $o->{ILSM}{typeconv};
  $parser->{ILSM} = $o->{ILSM};    # give parser access to config options
  return $parser;
}

#============================================================================
# Intercept xs_generate and create the typemap file
#============================================================================
sub xs_generate {
  my $o = shift;
  $o->write_typemap;
  return $o->SUPER::xs_generate;
}

#============================================================================
# Return bindings for functions and classes
#============================================================================
sub xs_bindings {
  my $o = shift;

  # What is modfname, and why are we taking it from a slice but not using it?
  my ($pkg, $module) = @{$o->{API}}{qw(pkg module)};
  my $data = $o->{ILSM}{parser}{data};
  warn "in Inline::CPP::xs_bindings(), top of subroutine, have \$pkg = '$pkg'\n";
  warn "in Inline::CPP::xs_bindings(), top of subroutine, have \$module = '$module'\n";
#  warn "in Inline::CPP::xs_bindings(), top of subroutine, have \$data = \n" . Dumper($data) . "\n";
  my @XS;

  warn "Warning: No Inline C++ functions or classes bound to Perl\n"
    . "Check your C++ for Inline compatibility.\n\n"
    if !defined $data->{classes} && !defined $data->{functions} && $^W;
  for my $class (@{$data->{classes}}) {
    my $proper_pkg;
    my $ref_classes_override = undef;

    # Possibly override package and class names
    if (exists $o->{API}{classes_override}) {
      $ref_classes_override = ref($o->{API}{classes_override});
      if ($ref_classes_override eq 'HASH') {
        if (exists $o->{API}{classes_override}->{$class})
        {    # Override class name only
          $proper_pkg = $pkg . '::' . $o->{API}{classes_override}->{$class};
        }
        else {
          # Do not override package or class names
          $proper_pkg = $pkg . '::' . $class;
        }
      }
      elsif ($ref_classes_override eq 'CODE')
      {
        # Override both package and class names
        $proper_pkg = &{$o->{API}{classes_override}}($class);
        if   ($proper_pkg eq '') { $proper_pkg = 'main'; }
      }
    }
    else {        # Do not override package or class names
      $proper_pkg = $pkg . '::' . $class;
    }

    # Strip main:: from packages.  There cannot be a package main::Foo!
    $proper_pkg =~ s/^main::(.+)/$1/;
    
    warn "in Inline::CPP::xs_bindings(), have final \$proper_pkg = '$proper_pkg'\n\n";

    # Set up the proper namespace
    push @XS, _build_namespace($module, $proper_pkg);
    push @XS, _generate_member_xs_wrappers($o, $pkg, $class, $proper_pkg);
  }

  push @XS, _remove_xs_prefixes($o, $module, $pkg);
  push @XS, _generate_nonmember_xs_wrappers($o);

  for (@{$data->{enums}}) {

    # Global enums.
    $o->{ILSM}{XS}{BOOT} .= make_enum($pkg, @{$_}{qw( name body )});
  }
#  warn "in Inline::CPP::xs_bindings(), bottom of subroutine, returning \@XS = \n" . Dumper(\@XS) . "\n";
  return join q{}, @XS;
}


# Set up the proper namespace.
sub _build_namespace {
  my ($module, $proper_pkg) = @_;
  warn "in Inline::CPP::_build_namespace(), top of subroutine, received \$module = '$module'\n";
  warn "in Inline::CPP::_build_namespace(), top of subroutine, received \$proper_pkg = '$proper_pkg'\n";
  return <<"END";

MODULE = $module        PACKAGE = $proper_pkg

PROTOTYPES: DISABLE

END
}


sub _generate_member_xs_wrappers {
  my ($o, $pkg, $class, $proper_pkg) = @_;
  warn "in Inline::CPP::_generate_member_xs_wrappers(), top of subroutine, received \$pkg = '$pkg'\n";
  warn "in Inline::CPP::_generate_member_xs_wrappers(), top of subroutine, received \$class = '$class'\n";
  warn "in Inline::CPP::_generate_member_xs_wrappers(), top of subroutine, received \$proper_pkg = '$proper_pkg'\n";
  my @XS;
  my $data = $o->{ILSM}{parser}{data};
  my ($ctor, $dtor, $abstract) = (0, 0, 0);    ## no critic (ambiguous)
  for my $thing (@{$data->{class}{$class}}) {
    my ($name, $scope, $type) = @{$thing}{qw| name scope thing |};
    warn "in Inline::CPP::_generate_member_xs_wrappers(), in for() loop, have \$name = '$name'\n";
    warn "in Inline::CPP::_generate_member_xs_wrappers(), in for() loop, have \$scope = '$scope'\n";
    warn "in Inline::CPP::_generate_member_xs_wrappers(), in for() loop, have \$type = '$type'\n";

    _handle_inheritance($o, $type, $scope, $pkg, $class, $name);

    # Get/set methods will go here:
    # Cases we skip:
    $abstract ||= ($type eq 'method' and $thing->{abstract});
    next if ($type eq 'method' and $thing->{abstract});
    next if $scope ne 'public';
    if ($type eq 'enum') {
      $o->{ILSM}{XS}{BOOT} .= make_enum($proper_pkg, $name, $thing->{body});
    }
    elsif ($type eq 'method' and $name !~ m/operator/) {

      # generate an XS wrapper
      $ctor ||= ($name eq $class);
      $dtor ||= ($name eq "~$class");
      push @XS, $o->wrap($thing, $name, $class);
    }
  }

  # Provide default constructor and destructor:
  push @XS, "$class *\n${class}::new()\n\n" unless ($ctor or $abstract);

  push @XS, "void\n${class}::DESTROY()\n\n" unless ($dtor or $abstract);
#  warn "in Inline::CPP::_generate_member_xs_wrappers(), bottom of subroutine, returning \@XS = \n" . Dumper(\@XS) . "\n";
  return @XS;
}

# Let Perl handle inheritance.
sub _handle_inheritance {
  my ($o, $type, $scope, $pkg, $class, $name) = @_;
  warn "in Inline::CPP::_handle_inheritance(), top of subroutine, received \$type = '$type'\n";
  warn "in Inline::CPP::_handle_inheritance(), top of subroutine, received \$scope = '$scope'\n";
  warn "in Inline::CPP::_handle_inheritance(), top of subroutine, received \$pkg = '$pkg'\n";
  warn "in Inline::CPP::_handle_inheritance(), top of subroutine, received \$class = '$class'\n";
  warn "in Inline::CPP::_handle_inheritance(), top of subroutine, received \$name = '$name'\n";
  if ($type eq 'inherits' and $scope eq 'public') {
    $o->{ILSM}{XS}{BOOT} ||= q{};
    my $ISA_name = "${pkg}::${class}::ISA";
    my $parent   = "${pkg}::${name}";
  warn "in Inline::CPP::_handle_inheritance(), have \$ISA_name = '$ISA_name'\n";
  warn "in Inline::CPP::_handle_inheritance(), have \$parent = '$parent'\n";
    $o->{ILSM}{XS}{BOOT} .= <<"END";
{
#ifndef get_av
    AV *isa = perl_get_av("$ISA_name", 1);
#else
    AV *isa = get_av("$ISA_name", 1);
#endif
    av_push(isa, newSVpv("$parent", 0));
}
END
  }
  return;
}


sub _generate_nonmember_xs_wrappers {
  my $o    = shift;
  my $data = $o->{ILSM}{parser}{data};
  warn "in Inline::CPP::_generate_nonmember_xs_wrappers(), top of subroutine, have \$data = '$data'\n";
  my @XS;
  for my $function (@{$data->{functions}}) {

    # lose constructor defs outside class decls (and "implicit int")
    next if $data->{function}{$function}{rtype} eq q{};
    next if $data->{function}{$function}{rtype} =~ m/static/;    #specl case
    next if $function =~ m/::/x;         # skip member functions.
    next if $function =~ m/operator/;    # and operators.
    push @XS, $o->wrap($data->{function}{$function}, $function);
  }
#  warn "in Inline::CPP::_generate_nonmember_xs_wrappers(), bottom of subroutine, returning \@XS = \n" . Dumper(\@XS) . "\n";
  return @XS;
}


# Generate XS code to remove prefixes from function names.
sub _remove_xs_prefixes {
  my ($o, $module, $pkg) = @_;
  warn "in Inline::CPP::_remove_xs_prefixes(), top of subroutine, received \$module = '$module'\n";
  warn "in Inline::CPP::_remove_xs_prefixes(), top of subroutine, received \$pkg = '$pkg'\n";
  my $prefix
    = ($o->{ILSM}{XS}{PREFIX} ? "PREFIX = $o->{ILSM}{XS}{PREFIX}" : q{});
  warn "in Inline::CPP::_remove_xs_prefixes(), have \$prefix = '$prefix'\n";
  return <<"END";

MODULE = $module        PACKAGE = $pkg  $prefix

PROTOTYPES: DISABLE

END

}


#============================================================================
# Generate an XS wrapper around anything: a C++ method or function
#============================================================================
sub wrap {
  my ($o, $thing, $name, $class) = @_;
  $class ||= q{};
  
#  warn "in Inline::CPP::wrap(), top of subroutine, received \$thing = \n" . Dumper($thing);
  warn "in Inline::CPP::wrap(), top of subroutine, received \$thing = \n{";
  foreach my $subthing_key (sort keys %{$thing}) { warn "\t$subthing_key => " . $thing->{$subthing_key} . ",\n" } warn "}\n";
  warn "in Inline::CPP::wrap(), top of subroutine, received \$name = '$name'\n";
  warn "in Inline::CPP::wrap(), top of subroutine, received \$class = '$class'\n\n";
  
  my $t = q{ } x 4;    # indents in 4-space increments.
  my (@XS, @PREINIT, @CODE);

  my ($XS, $ctor, $dtor) = _map_subnames_cpp_to_perl($thing, $name, $class);

  push @XS, $XS;

  return q{} unless $o->check_type($thing, $ctor, $dtor);

  # Filter out optional subroutine arguments
  my (@args, @opts, $ellipsis, $void);

  $_->{optional} ? push @opts, $_ : push @args, $_ for @{$thing->{args}};

  $ellipsis = pop @args if (@args and $args[-1]{name} eq '...');

  $void = ($thing->{rtype} and $thing->{rtype} eq 'void');

  push @XS, join q{},
    (
    '(',
    join(', ',
      (map { $_->{name} } @args),
      (scalar @opts or $ellipsis) ? '...' : ()),
    ")\n",
    );

  # Declare the non-optional arguments for XS type-checking
  push @XS, "\t$_->{type}\t$_->{name}\n" for @args;

  # Wrap "complicated" subs in stack-checking code
  if ($void or $ellipsis) {
    push @PREINIT, "\tI32 *\t__temp_markstack_ptr;\n";
    push @CODE,    "\t__temp_markstack_ptr = PL_markstack_ptr++;\n";
  }

  if (@opts) {
    push @PREINIT, "\t$_->{type}\t$_->{name};\n" for @opts;
    push @CODE, 'switch(items' . ($class ? '-1' : q{}) . ") {\n";

    my $offset = scalar @args;             # which is the first optional?
    my $total  = $offset + scalar @opts;
    for my $i ($offset .. $total - 1) {
      push @CODE, 'case ' . ($i + 1) . ":\n";
      my @tmp;
      for my $j ($offset .. $i) {
        my $targ = $opts[$j - $offset]{name};
        my $type = $opts[$j - $offset]{type};
        my $src  = "ST($j)";
        my $conv = $o->typeconv($targ, $src, $type, 'input_expr');
        push @CODE, $conv . ";\n";
        push @tmp,  $targ;
      }
      push @CODE, "\tRETVAL = " unless $void;
      push @CODE,
        call_or_instantiate($name, $ctor, $dtor, $class, $thing->{rconst},
        $thing->{rtype}, (map { $_->{name} } @args), @tmp);
      push @CODE, "\tbreak; /* case " . ($i + 1) . " */\n";
    }
    push @CODE, "default:\n";
    push @CODE, "\tRETVAL = " unless $void;
    push @CODE,
      call_or_instantiate($name, $ctor, $dtor, $class, $thing->{rconst},
      $thing->{rtype}, map { $_->{name} } @args);
    push @CODE, "} /* switch(items) */ \n";
  }
  elsif ($void) {
    push @CODE, "\t";
    push @CODE,
      call_or_instantiate($name, $ctor, $dtor, $class, 0, q{},
      map { $_->{name} } @args);
  }
  elsif ($ellipsis or $thing->{rconst}) {
    push @CODE, "\t";
    push @CODE, 'RETVAL = ';
    push @CODE,
      call_or_instantiate($name, $ctor, $dtor, $class, $thing->{rconst},
      $thing->{rtype}, map { $_->{name} } @args);
  }
  if ($void) {
    push @CODE, <<'END';
        if (PL_markstack_ptr != __temp_markstack_ptr) {
          /* truly void, because dXSARGS not invoked */
          PL_markstack_ptr = __temp_markstack_ptr;
          XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
        return; /* assume stack size is correct */
END
  }
  elsif ($ellipsis) {
    push @CODE, "\tPL_markstack_ptr = __temp_markstack_ptr;\n";
  }

  # The actual function:
  local $" = q{};
  push @XS, "${t}PREINIT:\n@PREINIT" if @PREINIT;
  push @XS, $t;
  push @XS, 'PP' if $void and @CODE;
  push @XS, "CODE:\n@CODE" if @CODE;
  push @XS, "${t}OUTPUT:\nRETVAL\n" if @CODE and not $void;
  push @XS, "\n";
#  warn "in Inline::CPP::wrap(), bottom of subroutine, returning \@XS = \n" . Dumper(\@XS) . "\n";
  return "@XS";
}


sub _map_subnames_cpp_to_perl {
  my ($thing, $name, $class) = @_;
#  warn "in Inline::CPP::_map_subnames_cpp_to_perl(), top of subroutine, received \$thing = \n" . Dumper($thing);
  warn "in Inline::CPP::_map_subnames_cpp_to_perl(), top of subroutine, received \$thing = \n{";
  foreach my $subthing_key (sort keys %{$thing}) { warn "\t$subthing_key => " . $thing->{$subthing_key} . ",\n" } warn "}\n";
  warn "in Inline::CPP::_map_subnames_cpp_to_perl(), top of subroutine, received \$name = '$name'\n";
  warn "in Inline::CPP::_map_subnames_cpp_to_perl(), top of subroutine, received \$class = '$class'\n\n";
  my ($XS, $ctor, $dtor) = (q{}, 0, 0);

  if ($name eq $class) {    # ctor
    $XS   = $class . " *\n" . $class . '::new';
    $ctor = 1;
  }
  elsif ($name eq "~$class") {    # dtor
    $XS   = "void\n$class" . '::DESTROY';
    $dtor = 1;
  }
  elsif ($class) {                # method
    $XS = "$thing->{rtype}\n$class" . "::$thing->{name}";
  }
  else {                          # function
    $XS = "$thing->{rtype}\n$thing->{name}";
  }
  warn "in Inline::CPP::_map_subnames_cpp_to_perl(), bottom of subroutine, returning \$XS = '$XS'\n";
  warn "in Inline::CPP::_map_subnames_cpp_to_perl(), bottom of subroutine, returning \$ctor = '$ctor'\n";
  warn "in Inline::CPP::_map_subnames_cpp_to_perl(), bottom of subroutine, returning \$dtor = '$dtor'\n";
  return ($XS, $ctor, $dtor);
}


sub call_or_instantiate {
  my ($name, $ctor, $dtor, $class, $const, $type, @args) = @_;

  # Create an rvalue (which might be const-casted later).
  my $rval = q{};
  $rval .= 'new '    if $ctor;
  $rval .= 'delete ' if $dtor;
  $rval .= 'THIS->'  if ($class and not($ctor or $dtor));
  $rval .= $name . '(' . join(q{,}, @args) . ')';

  return const_cast($rval, $const, $type) . ";\n";
}    ### Tested.

sub const_cast {
  my ($value, $const, $type) = @_;
  return $value unless $const and $type =~ m/[*&]/x;
  return "const_cast<$type>($value)";
}    ### Tested.

sub write_typemap {
  my $o         = shift;
  my $filename  = "$o->{API}{build_dir}/CPP.map";
  my $type_kind = $o->{ILSM}{typeconv}{type_kind};
  my $typemap   = q{};
  $typemap .= $_ . "\t" x 2 . $TYPEMAP_KIND . "\n"
    for grep { $type_kind->{$_} eq $TYPEMAP_KIND } keys %{$type_kind};
  return unless length $typemap;

  my $tm_output = <<"END";
TYPEMAP
$typemap
OUTPUT
$TYPEMAP_KIND
$o->{ILSM}{typeconv}{output_expr}{$TYPEMAP_KIND}
INPUT
$TYPEMAP_KIND
$o->{ILSM}{typeconv}{input_expr}{$TYPEMAP_KIND}
END


  # Open an output file, create if necessary, then lock, then truncate.
  # This replaces the following, which wasn't lock-safe:

  sysopen(my $TYPEMAP_FH, $filename, O_WRONLY | O_CREAT)
    or croak "Error: Can't write to $filename: $!";

  # Flock and truncate (truncating to zero length to simulate '>' mode).
  flock $TYPEMAP_FH, LOCK_EX
    or croak "Error: Can't obtain lock for $filename: $!";
  truncate $TYPEMAP_FH, 0 or croak "Error: Can't truncate $filename: $!";

  # End of new lock-safe code.

  print {$TYPEMAP_FH} $tm_output;

  close $TYPEMAP_FH or croak "Error: Can't close $filename after write: $!";

  $o->validate(TYPEMAPS => $filename);
  return;
}

# Generate type conversion code: perl2c or c2perl.
sub typeconv {
  my ($o, $var, $arg, $type, $dir, $preproc) = @_;
  my $tkind = $o->{ILSM}{typeconv}{type_kind}{$type};
  my $ret;
  {
    no strict;   ## no critic (strict)
                 # The conditional avoids uninitialized warnings if user passes
                 # a C++ function with 'void' as param.
    if (defined $tkind) {

      # eval of typemap gives "Uninit"
      no warnings 'uninitialized';    ## no critic (warnings)
          # Even without the conditional this line must remain.
      $ret = eval    ## no critic (eval)
        qq{qq{$o->{ILSM}{typeconv}{$dir}{$tkind}}};
    }
    else {
      $ret = q{};
    }
  }
  chomp $ret;
  $ret =~ s/\n/\\\n/xg if $preproc;
  return $ret;
}

# Verify that the return type and all arguments can be bound to Perl.
sub check_type {
  my ($o, $thing, $ctor, $dtor) = @_;
  my $badtype;

  # strip "useless" modifiers so the type is found in typemap:
BADTYPE: while (1) {
    if (!($ctor || $dtor)) {
      my $t = $thing->{rtype};
      $t =~ s/^(\s|const|virtual|static)+//xg;
      if ($t ne 'void' && !$o->typeconv(q{}, q{}, $t, 'output_expr')) {
        $badtype = $t;
        last BADTYPE;
      }
    }
    foreach (map { $_->{type} } @{$thing->{args}}) {
      s/^(?:const|\s)+//xgo;
      if ($_ ne '...' && !$o->typeconv(q{}, q{}, $_, 'input_expr')) {
        $badtype = $_;
        last BADTYPE;
      }
    }
    return 1;
  }

  # I don't really like this verbosity. This is what 'info' is for. Maybe we
  # should ask Brian for an Inline=DEBUG option.
  warn "No typemap for type $badtype. "
    . "Skipping $thing->{rtype} $thing->{name}("
    . join(', ', map { $_->{type} } @{$thing->{args}}) . ")\n"
    if 0;
  return 0;
}

# Generate boot-code for enumeration constants:
sub make_enum {
  my ($class, $name, $body) = @_;
  my @enum;
  push @enum, <<"END";
\t{
\t    HV * pkg = gv_stashpv(\"$class\", 1);
\t    if (pkg == NULL)
\t        croak("Can't find package '$class'\\n");
END
  my $val = 0;
  foreach (@{$body}) {
    my ($k, $v) = @{$_};
    $val = $v if defined $v;
    push @enum, "\tnewCONSTSUB(pkg, \"$k\", newSViv($val));\n";
    ++$val;
  }
  push @enum, "\t}\n";
  return join q{}, @enum;
}


1;

__END__
