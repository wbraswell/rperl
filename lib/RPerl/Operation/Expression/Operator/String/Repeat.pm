# [[[ HEADER ]]]
package RPerl::Operation::Expression::Operator::String::Repeat;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.001_000;
use 5.010;
my string $foo = 'foo' x ;
my string $bar = 'bar' x 1;
my string $bat = 'bat' x 2;
my string $baz = 'baz' x 4;
my string $bax = 'bax' x 8;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Operation::Expression::Operator::String);
use RPerl::Operation::Expression::Operator::String;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

# [[[ SUBROUTINES & OO METHODS ]]]

sub ast_to_rperl__generate {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $rperl_source_group = { PMC => q{} };
    my string_hashref $cpp_source_group = { CPP => q{} };

#    RPerl::diag( 'in Operator::String::Repeat->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );
    #    RPerl::diag( 'in Operator::String::Repeat->ast_to_rperl__generate(), received $self = ' . "\n" . RPerl::Parser::rperl_ast__dump($self) . "\n" );


    my string $self_class = ref $self;
    if ( $self_class eq 'Operator_111' ) {  # Operator -> SubExpression OP07_STRING_REPEAT SubExpression
        $cpp_source_group->{CPP} .= NAME_CPPOPS_CPPTYPES() . '(';
        my string_hashref $rperl_source_subgroup = $self->{children}->[0]->ast_to_rperl__generate($modes);
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $cpp_source_group->{CPP} .= ', ';
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        $rperl_source_group->{PMC} .= q{ } . $self->{children}->[1] . q{ };
        $rperl_source_subgroup = $self->{children}->[2]->ast_to_rperl__generate($modes);
        print q{have $foo = '}, $foo, q{'}, "\n";
        print q{have $bar = '}, $bar, q{'}, "\n";
        print q{have $bat = '}, $bat, q{'}, "\n";
        print q{have $baz = '}, $baz, q{'}, "\n";
        print q{have $bax = '}, $bax, q{'}, "\n";
        $cpp_source_group->{CPP} .= ')';
        my $x = 'PMC => q{}';
        my $y = 'PMC => q{}';
        my $z = $x . ' ' . $y;  say $z;
        my $z = "$x $y";
        my $z = 'Take ' . ($x + $y);
        say $z;
        RPerl::Generator::source_group_append( $rperl_source_group, $rperl_source_subgroup );
        
    }
    else {
        die RPerl::Parser::rperl_rule__replace(
            'ERROR ECOGEASRP000, CODE GENERATOR, ABSTRACT SYNTAX TO RPERL: Grammar rule '
                . $self_class
                . ' found where Operator_111 expected, dying' )
            . "\n";
    }
    return $rperl_source_group;
}

sub ast_to_cpp__generate__CPPOPS_PERLTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group
        = {

        CPP => q{// <<< RP::O::E::O::S::R __DUMMY_SOURCE_CODE CPPOPS_PERLTYPES >>>}
        . "\n"
        };
        print "Please type in the title: ";
        my $title = <STDIN>;
        chomp $title;
 
        say $title;
        say '-' x length $title;
        $string1 = "RPerl";  
        # Input second string  
        $string2 = "Operator_111";   
        $combine = $string1;    
        # combine two string function (.=) 
        $combine .= $string2;   
        # Display result 
        print $combine; 
        $str_result = "Found"; 
        # Repetation operator(x) 
        $str_result x= 5;  
        # Display output 
        # print string 5 times 
        print "\n$str_result"; 
    my string_hashref $cpp_source_group = { CPP => q{} };

    #...
    return $cpp_source_group;
}

sub ast_to_cpp__generate__CPPOPS_CPPTYPES {
    { my string_hashref::method $RETURN_TYPE };
    ( my object $self, my string_hashref $modes) = @ARG;
    my string_hashref $cpp_source_group
        = {
        CPP => q{// <<< RP::O::E::O::S::R __DUMMY_SOURCE_CODE CPPOPS_CPPTYPES >>>}
            . "\n"
        };

    #...
    return $cpp_source_group;
}


1;    # end of class
