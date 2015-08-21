# [[[ PREPROCESSOR ]]]
# <<< CHANGE_ME: delete unused directives >>>
# <<< TYPE_CHECKING: OFF >>>
# <<< TYPE_CHECKING: ON >>>
# <<< TYPE_CHECKING: TRACE >>>
# <<< PARSE_ERROR: 'FOO' >>>
# <<< GENERATE_ERROR: 'FOO' >>>
# <<< COMPILE_ERROR: 'FOO' >>>
# <<< EXECUTE_ERROR: 'FOO' >>>
# <<< EXECUTE_SUCCESS: 'FOO' >>>

# [[[ HEADER ]]]
# <<< CHANGE_ME: replace with real class name >>>
use RPerl;
package RPerl::CompileUnit::Module::Class::Template;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
# <<< CHANGE_ME: leave as base class for no inheritance, or replace with real parent package name >>>
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
# <<< CHANGE_ME: delete unused directives >>>
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants
## no critic qw(ProhibitExplicitStdin)  # USER DEFAULT 4: allow <STDIN> prompt
## no critic qw(RequireBriefOpen)  # USER DEFAULT 5: allow open() in perltidy-expanded code
## no critic qw(ProhibitCStyleForLoops)  # USER DEFAULT 6: allow C-style for loop headers
## no critic qw(RequireTrailingCommas)  # USER DEFAULT X: no trailing commas in RPerl lists  # NEED ANSWER: RPerl is mostly array refs, do we even need this?

## no critic qw(ProhibitUselessNoCritic PodSpelling) # DEVELOPER DEFAULT 1a: allow unreachable & POD-commented code, must be on line 1
## no critic qw(ProhibitUnreachableCode RequirePodSections RequirePodAtEnd) # DEVELOPER DEFAULT 1b: allow POD & unreachable or POD-commented code, must be after line 1
## no critic qw(ProhibitStringySplit ProhibitInterpolationOfLiterals)  # DEVELOPER DEFAULT 2: allow string test values

## no critic qw(ProhibitStringyEval)  # SYSTEM DEFAULT 1: allow eval()
## no critic qw(ProhibitCascadingIfElse)  # SYSTEM DEFAULT 2: allow argument-handling logic
## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames)  # SYSTEM DEFAULT 3: allow multiple & lower case package names
## no critic qw(RequireCheckingReturnValueOfEval)  # SYSTEM DEFAULT 4: allow eval() test code blocks

## no critic qw(ProhibitBooleanGrep)  # SYSTEM SPECIAL 1: allow grep
## no critic qw(ProhibitAutoloading RequireArgUnpacking)  # SYSTEM SPECIAL 2: allow Autoload & read-only @_
## no critic qw(ProhibitParensWithBuiltins ProhibitNoisyQuotes)  # SYSTEM SPECIAL 3: allow auto-generated code
## no critic qw(ProhibitExcessMainComplexity)  # SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1
## no critic qw(ProhibitExcessComplexity)  # SYSTEM SPECIAL 5: allow complex code inside subroutines, must be after line 1
## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if
## no critic qw(ProhibitDeepNests)  # SYSTEM SPECIAL 7: allow deeply-nested code
## no critic qw(ProhibitNoStrict)  # SYSTEM SPECIAL 8: allow no strict
## no critic qw(RequireUseStrict)  # SYSTEM SPECIAL 9: allow omitted strict
## no critic qw(RequireBriefOpen)  # SYSTEM SPECIAL 10: allow complex processing with open filehandle
## no critic qw(ProhibitBacktickOperators)  # SYSTEM SPECIAL 11: allow system command execution
## no critic qw(ProhibitCascadingIfElse)  # SYSTEM SPECIAL 12: allow complex conditional logic
## no critic qw(RequireCarping)  # SYSTEM SPECIAL 13: allow die instead of croak
## no critic qw(ProhibitAutomaticExportation)  # SYSTEM SPECIAL 14: allow global exports from Config.pm

# COMBO CRITICS
## no critic qw(ProhibitUselessNoCritic PodSpelling ProhibitExcessMainComplexity)  # DEVELOPER DEFAULT 1a: allow unreachable & POD-commented code; SYSTEM SPECIAL 4: allow complex code outside subroutines, must be on line 1

# [[[ INCLUDES ]]]
# <<< CHANGE_ME: delete for no includes, or replace with real include package name(s) >>>
use RPerl::Test::Foo;
use RPerl::Test::Bar;

# [[[ CONSTANTS ]]]
# <<< CHANGE_ME: delete for no constants, or replace with real constant name(s) & data >>>
use constant PI  => my number $TYPED_PI  = 3.141_59;
use constant PIE => my string $TYPED_PIE = 'pecan';

# NEED UPGRADE: constant array & hash refs not read-only as of Perl v5.20
#use constant DAYS => my string_arrayref $TYPED_DAYS
#    = [ 'Sun', 'Mon', 'Tues', 'Weds', 'Thurs', 'Fri', 'Sat' ];
#use constant HYDROGEN => my scalartype_arrayref $TYPED_HYDROGEN = [
#    my integer $TYPED_number = 1,
#    my number $TYPED_weight  = 1.007_94,
#    my string $TYPED_symbol  = 'H'
#];
#use constant TRANSCENDENTALS => my number_hashref $TYPED_TRANSCENDENTALS
#    = { pi => 3.141_59, e => 2.718_28, c => 299_792_458 };
#use constant EINSTEIN => my scalartype_hashref $TYPED_EINSTEIN = {
#    name       => my string $TYPED_name        = 'Albert Einstein',
#    birth_year => my integer $TYPED_birth_year = 1_879,
#    death_year => my integer $TYPED_death_year = 1_955
#};

# [[[ OO PROPERTIES ]]]
# <<< CHANGE_ME: replace with real property name(s) & default data >>>
our hashref $properties = {
    plugh => my integer $TYPED_plugh         = 23,
    xyzzy => my string $TYPED_xyzzy          = 'twenty-three',
    thud  => my integer_arrayref $TYPED_thud = [ 2, 4, 6, 8 ],
    yyz => my number_hashref $TYPED_yyz = { a => 3.1, b => 6.2, c => 9.3 }
};

# [[[ OO METHODS & SUBROUTINES ]]]

# <<< CHANGE_ME: delete for no methods/subroutines, or replace with real method(s)/subroutine(s) >>>
our void::method $quux = sub {
    ( my object $self) = @_;
    $self->{plugh} = $self->{plugh} * 2;
};

our integer::method $quince = sub {
    my string $quince_def
        = '...Cydonia vulgaris ... Cydonia, a city in Crete ... [1913 Webster]';
    print $quince_def;
    return (length $quince_def);
};

our string_hashref::method $qorge = sub {
    ( my object $self, my integer $qorge_input ) = @_;
    return {
        a => $self->{xyzzy} x $qorge_input,
        b => 'howdy',
        c => q{-23.42}
    };
};

our object_arrayref::method $qaft = sub {
    ( my object $self, my integer $foo, my number $bar, my string $bat, my string_hashref $baz ) = @_;
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
    my integer $garply_input_size = scalar @{$garply_array};
    my integer $ungarply_size_typed = scalar @{my integer_arrayref $TYPED_ungarply = [4, 6, 8, 10]};
#    my integer $ungarply_size_untyped = scalar @{[4, 6, 8, 10]};  missing type_inner, not supported in CPPOPS_CPPTYPES
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
