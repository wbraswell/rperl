# [[[ HEADER ]]]
package RPerl::Algorithm::Sort::Bubble_cpp;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.004_010;

# [[[ CRITICS ]]]
# SYSTEM DEFAULT 1: allow eval() for Inline::CPP
## no critic qw(ProhibitStringyEval RequireCheckingReturnValueOfEval ProhibitPunctuationVars)

# [[[ SUBROUTINES ]]]
our void $cpp_load = sub {
    my $need_load_cpp = 0;
    if (    ( exists $main::{'RPerl__Algorithm__Sort__Bubble__ops'} )
        and ( defined &{ $main::{'RPerl__Algorithm__Sort__Bubble__ops'} } ) )
    {
#        RPerl::diag "in Bubble_cpp::cpp_load, RPerl__Algorithm__Sort__Bubble__ops() exists & defined\n";
#        RPerl::diag q{in Bubble_cpp::cpp_load, have RPerl__Algorithm__Sort__Bubble__ops() retval = '} . main::RPerl__Algorithm__Sort__Bubble__ops() . "'\n";
        if ( main::RPerl__Algorithm__Sort__Bubble__ops() ne 'CPP' ) {
            $need_load_cpp = 1;
        }
    }
    else {
#        RPerl::diag "in Bubble_cpp::cpp_load, RPerl__Algorithm__Sort__Bubble__ops() does not exist or undefined\n";
        $need_load_cpp = 1;
    }

    if ($need_load_cpp) {
#        RPerl::diag "in Bubble_cpp::cpp_load, need load CPP code\n";

        my $eval_string = <<"EOF";
package main;
use RPerl::Inline;
BEGIN { RPerl::diag "[[[ BEGIN 'use Inline' STAGE for 'RPerl/Algorithm/Sort/Bubble.cpp' ]]]\n"x3; }
use Inline (CPP => "$RPerl::INCLUDE_PATH/RPerl/Algorithm/Sort/Bubble.cpp", \@RPerl::Inline::ARGS);
RPerl::diag "[[[ END 'use Inline' STAGE for 'RPerl/Algorithm/Sort/Bubble.cpp' ]]]\n"x3;
1;
EOF

#        RPerl::diag "in Bubble_cpp::cpp_load(), CPP not yet loaded, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n";

        eval $eval_string;
        if ($@) { croak($@); }
    }

#    else { RPerl::diag "in Bubble_cpp::cpp_load(), CPP already loaded, DOING NOTHING\n"; }
};

1;
1;
