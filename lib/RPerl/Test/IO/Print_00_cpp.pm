# [[[ HEADER ]]]
package RPerl::Test::IO::Print_00_cpp;
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_011;

# [[[ CRITICS ]]]
## no critic qw(ProhibitStringyEval) # SYSTEM DEFAULT 1: allow eval()

# [[[ SUBROUTINES ]]]
our void_method $cpp_load = sub {
    my $need_load_cpp = 0;
    if (    ( exists $main::{'RPerl__Test__IO__Print_00__MODE_ID'} )
        and ( defined &{ $main::{'RPerl__Test__IO__Print_00__MODE_ID'} } ) )
    {
#        RPerl::diag("in Print_00_cpp::cpp_load, RPerl__Test__IO__Print_00__MODE_ID() exists & defined\n");
#        RPerl::diag(q{in Print_00_cpp::cpp_load, have RPerl__Test__IO__Print_00__MODE_ID() retval = '} . main::RPerl__Test__IO__Print_00__MODE_ID() . "'\n");
        if ( $RPerl::MODES->{main::RPerl__Test__IO__Print_00__MODE_ID()}->{ops} ne 'CPP' ) {
            $need_load_cpp = 1;
        }
    }
    else {
#        RPerl::diag("in Print_00_cpp::cpp_load, RPerl__Test__IO__Print_00__MODE_ID() does not exist or undefined\n");
        $need_load_cpp = 1;
    }

    if ($need_load_cpp) {

       #        RPerl::diag("in Print_00_cpp::cpp_load, need load CPP code\n");

        my $eval_string = <<"EOF";
package main;
use RPerl::Inline;
BEGIN { RPerl::diag("[[[ BEGIN 'use Inline' STAGE for 'RPerl/Test/IO/Print_00.cpp' ]]]\n" x 0); }
use Inline (CPP => '$RPerl::INCLUDE_PATH/RPerl/Test/IO/Print_00.cpp', \%RPerl::Inline::ARGS);
RPerl::diag("[[[ END 'use Inline' STAGE for 'RPerl/Test/IO/Print_00.cpp' ]]]\n" x 0);
1;
EOF

#        RPerl::diag("in Print_00_cpp::cpp_load(), CPP not yet loaded, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n");

        eval $eval_string or croak( $OS_ERROR . "\n" . $EVAL_ERROR );
        if ($EVAL_ERROR) { croak($EVAL_ERROR); }
    }

#    else { RPerl::diag("in Print_00_cpp::cpp_load(), CPP already loaded, DOING NOTHING\n"); }
};

1;
1;
