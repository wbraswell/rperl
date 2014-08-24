package RPerl::Algorithm::Sort::Bubble_cpp;
use strict;
use warnings;
use Carp;
our $VERSION = 0.001_100;
#our $CPP_LOADED = 0;
use parent ('RPerl::CompileUnit::Module::Class');
use RPerl::CompileUnit::Module::Class;
use RPerl;
#use RPerl::HelperFunctions_cpp;
#use RPerl::Algorithm::Sort_cpp;
#use RPerl::Algorithm::Inefficient_cpp;  # MULTIPLE INHERITANCE NOT SUPPORTED BY Inline::CPP

# START HERE: clean up this file, use as template for other *_cpp.pm files
# START HERE: clean up this file, use as template for other *_cpp.pm files
# START HERE: clean up this file, use as template for other *_cpp.pm files

our void__method $cpp_load = sub {
 
my $need_load_cpp = 0;
if (exists &{(\%main::)->{'RPerl__Algorithm__Sort__Bubble__ops'}} and defined &{(\%main::)->{'RPerl__Algorithm__Sort__Bubble__ops'}}) {
    print "in Bubble_cpp.pm, RPerl__Algorithm__Sort__Bubble__ops() exists & defined\n";
    print q{in Bubble_cpp.pm, have RPerl__Algorithm__Sort__Bubble__ops() retval = '} . main::RPerl__Algorithm__Sort__Bubble__ops() . "'\n";
    if (main::RPerl__Algorithm__Sort__Bubble__ops() ne 'CPP') {
        $need_load_cpp = 1;
    }
}
else { 
    print "in Bubble_cpp.pm, RPerl__Algorithm__Sort__Bubble__ops() does not exist or undefined\n"; 
    $need_load_cpp = 1;
}

    if ($need_load_cpp)
#	if (defined($RPerl::Algorithm::Sort::Bubble_cpp::CPP_LOADED)) { RPerl::diag "in Bubble_cpp::cpp_load(), have \$RPerl::Algorithm::Sort::Bubble_cpp::CPP_LOADED = '" . $RPerl::Algorithm::Sort::Bubble_cpp::CPP_LOADED . "'\n"; }
#		else { RPerl::diag "in Bubble_cpp::cpp_load(), have \$RPerl::Algorithm::Sort::Bubble_cpp::CPP_LOADED = 'UNDEF'\n"; }
#    if (   not( defined $RPerl::Algorithm::Sort::Bubble_cpp::CPP_LOADED )
#        or not($RPerl::Algorithm::Sort::Bubble_cpp::CPP_LOADED) )
    {
#        $RPerl::HelperFunctions_cpp::CPP_LOADED = 1; # HelperFunctions.cpp loaded by C++ #include in Bubble.h

        ####use RPerl::Algorithm::Sort;
#        $RPerl::Algorithm::Sort_cpp::CPP_LOADED = 1; # Sort.cpp loaded by C++ #include in Bubble.h

        ####use RPerl::Algorithm::Inefficient;
#        $RPerl::Algorithm::Inefficient_cpp::CPP_LOADED = 1; # Inefficient.cpp NOT loaded by C++ #include in Bubble.h (MULTIPLE INHERITANCE NOT SUPPORTED BY Inline::CPP)

        my $eval_string = <<"EOF";
package main;
use RPerl::Inline;
BEGIN { RPerl::diag "[[[ BEGIN 'use Inline' STAGE for 'RPerl/Algorithm/Sort/Bubble.cpp' ]]]\n"x3; }
use Inline (CPP => "$RPerl::INCLUDE_PATH/RPerl/Algorithm/Sort/Bubble.cpp", \@RPerl::Inline::ARGS);
RPerl::diag "[[[ END 'use Inline' STAGE for 'RPerl/Algorithm/Sort/Bubble.cpp' ]]]\n"x3;
1;
EOF
        RPerl::diag
            "in Bubble_cpp::cpp_load(), CPP not yet loaded, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n"
            . $eval_string
            . "<<< END EVAL STRING >>>\n"
            or croak();

        eval($eval_string);
        if ($@) {croak($@);}

#        $RPerl::Algorithm::Sort::Bubble_cpp::CPP_LOADED = 1;
    }

#	else { RPerl::diag "in Bubble_cpp::cpp_load(), CPP already loaded, DOING NOTHING\n"; }
};

1;
