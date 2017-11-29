# [[[ HEADER ]]]
# use RPerl::AfterSubclass;  # creates infinite include loop for any call to 'use RPerl;', Inline::* should probably not have any other Inline::* as (sub)dependencies
package Inline::RPerl;
use strict;
use warnings;
our $VERSION = 0.003_000;

# [[[ OO INHERITANCE ]]]
use parent qw(Inline);
use Inline;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use Carp;
use File::Spec;

# [[[ OO PROPERTIES ]]]
# our hashref $properties = {};
our $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub register {
    return {
        language => 'RPerl',  # do not alias lowercase 'rperl' to avoid ambiguity or confusion
        type => 'compiled',
        suffix => 'pmc',  # suffix of output files
    };
}

sub usage_config {
    my $key = shift;
    return q{'} . $key . q{'} . 'is not a valid config option for Inline::RPerl' . "\n";
}

sub usage_config_bar {
    "Invalid value for Inline::RPerl config option BAR";
}

sub validate {
    my $o = shift;
    $o->{ILSM}{PATTERN} ||= 'foo-';
    $o->{ILSM}{BAR} ||= 0;
    while (@_) {
        my ($key, $value) = splice @_, 0, 2;
        if ($key eq 'PATTERN') {
            $o->{ILSM}{PATTERN} = $value;
            next;
        }
        if ($key eq 'BAR') {
            croak usage_config_bar
              unless $value =~ /^[01]$/;
            $o->{ILSM}{BAR} = $value;
            next;
        }
        croak usage_config($key);
    }
}

sub build {
    my $o = shift;
    my $code = $o->{API}{code};
    my $pattern = $o->{ILSM}{PATTERN};
    $code =~ s/$pattern//g;
    $code =~ s/bar-//g if $o->{ILSM}{BAR};
    {
        package Foo::Tester::RPerl;
        our $VERSION = 0.001_000;
        eval $code;
    }
    croak "Foo build failed:\n$@" if $@;
    my $path = File::Spec->catdir($o->{API}{install_lib},'auto',$o->{API}{modpname});
    my $obj = $o->{API}{location};
    $o->mkpath($path) unless -d $path;
    open FOO_OBJ, "> $obj"
      or croak "Can't open $obj for output\n$!";
    print FOO_OBJ $code;
    close \*FOO_OBJ;
}

sub load {
    my $o = shift;
    my $obj = $o->{API}{location};
    open FOO_OBJ, "< $obj"
      or croak "Can't open $obj for output\n$!";
    my $code = join '', <FOO_OBJ>;
    close \*FOO_OBJ;
    eval "package $o->{API}{pkg};\n$code";
    croak "Unable to load Foo module $obj:\n$@" if $@;
}

sub info {
    my $o = shift;
}

1;    # end of class
