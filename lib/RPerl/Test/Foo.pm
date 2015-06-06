# [[[ HEADER ]]]
package RPerl::Test::Foo;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants

# DEV NOTE: below this line copied from RPerl::CompileUnit::Module::Class::Template
# [[[ CONSTANTS ]]]
use constant PI  => my number $TYPED_PI  = 3.141_59;
use constant PIE => my string $TYPED_PIE = 'pecan';

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    plugh => my integer $TYPED_plugh         = 23,
    xyzzy => my string $TYPED_xyzzy          = 'twenty-three',
    thud  => my integer_arrayref $TYPED_thud = [ 2, 4, 6, 8 ],
    yyz => my number_hashref $TYPED_yyz = { a => 3.1, b => 6.2, c => 9.3 }
};

# [[[ OO METHODS & SUBROUTINES ]]]

our void_method $quux = sub {
    ( my object $self) = @_;
    $self->{plugh} = $self->{plugh} * 2;
};

our integer_method $quince = sub {
    my string $quince_def
        = '...Cydonia vulgaris ... Cydonia, a city in Crete ... [1913 Webster]';
    print $quince_def;
    return (length $quince_def);
};

our string_hashref_method $qorge = sub {
    ( my object $self, my integer $qorge_input ) = @_;
    return {
        a => $self->{xyzzy} x $qorge_input,
        b => 'howdy',
        c => q{-23.42}
    };
};

our object_arrayref_method $qaft = sub {
    ( my object $self) = @_;
    my object_arrayref $retval = [];
    $retval->[0] = RPerl::CompileUnit::Module::Class::Template->new();
    $retval->[0]->{xyzzy} = 'larry';
    $retval->[1] = RPerl::CompileUnit::Module::Class::Template->new();
    $retval->[1]->{xyzzy} = 'curly';
    $retval->[2] = RPerl::CompileUnit::Module::Class::Template->new();
    $retval->[2]->{xyzzy} = 'moe';
    return $retval;
};

our void $grunt = sub {
    print 'PIE() = ' . PIE() . "\n";
};

our number $grault = sub {
    ( my integer $grault_input ) = @_;
    return $grault_input**PI();
};

our number_arrayref $garply = sub {
    ( my integer $garply_input, my number_arrayref $garply_array ) = @_;
    my number_arrayref $garply_output = [
        $garply_input * $garply_array->[0],
        $garply_input * $garply_array->[1],
        $garply_input * $garply_array->[2]
    ];
    return $garply_output;
};

our string_hashref $gorce = sub {
    ( my integer $al, my number $be, my string $ga, my string_hashref $de)
        = @_;
    return {
        alpha => integer_to_string($al),
        beta  => number_to_string($be),
        gamma => $ga,
        delta => %{$de}
    };
};

1;    # end of class
