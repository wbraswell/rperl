package RPerl::Test::Print_00_cpp;
use strict;
use warnings;
use Carp;
our $VERSION = 0.001_000;
our $CPP_LOADED = 0;
use parent ('RPerl::CompileUnit::Module::Class');
use RPerl::CompileUnit::Module::Class;
use RPerl;
use RPerl::HelperFunctions_cpp;

our void__method $cpp_load = sub {

#	if (defined($RPerl::Test::Print_00_cpp::CPP_LOADED)) { RPerl::diag "in RPerl::Test::Print_00_cpp::cpp_load(), have \$RPerl::Test::Print_00_cpp::CPP_LOADED = '" . $RPerl::Test::Print_00_cpp::CPP_LOADED . "'\n"; }
#		else { RPerl::diag "in RPerl::Test::Print_00_cpp::cpp_load(), have \$RPerl::Test::Print_00_cpp::CPP_LOADED = 'UNDEF'\n"; }
    if (   not( defined $RPerl::Test::Print_00_cpp::CPP_LOADED )
        or not($RPerl::Test::Print_00_cpp::CPP_LOADED) )
    {
        $RPerl::HelperFunctions_cpp::CPP_LOADED = 1; # HelperFunctions.cpp loaded by C++ #include in RPerl::Test::Print_00.(cpp/h)

        my $eval_string = <<"EOF";
package main;
use RPerl::Inline;
BEGIN { RPerl::diag("[[[ BEGIN 'use Inline' STAGE for 'RPerl::Test::Print_00.cpp' ]]]\n"x3); }
use Inline (CPP => "$RPerl::INCLUDE_PATH/RPerl/Test/Print_00.cpp", \@RPerl::Inline::ARGS);
RPerl::diag("[[[ END 'use Inline' STAGE for 'RPerl::Test::Print_00.cpp' ]]]\n"x3);
1;
EOF

        RPerl::diag(
            "in RPerl::Test::Print_00_cpp::cpp_load(), CPP not yet loaded, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n",
            $eval_string,
            "<<< END EVAL STRING >>>\n");

        eval($eval_string);
        if ($@) {croak($@);}

        $RPerl::Test::Print_00_cpp::CPP_LOADED = 1;
    }

#	else { RPerl::diag "in RPerl::Test::Print_00_cpp::cpp_load(), CPP already loaded, DOING NOTHING\n"; }
};

1;
