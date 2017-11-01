# [[[ HEADER ]]]
package RPerl::DataStructure::GSLMatrix_cpp;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitStringyEval)  # SYSTEM DEFAULT 1: allow eval()

# [[[ INCLUDES ]]]
use RPerl::Inline;

# [[[ SUBROUTINES ]]]
sub cpp_load {
    { my void::method $RETURN_TYPE };
    my $need_load_cpp = 0;
    if (    ( exists $main::{'RPerl__DataStructure__GSLMatrix__MODE_ID'} )
        and ( defined &{ $main::{'RPerl__DataStructure__GSLMatrix__MODE_ID'} } ) )
    {
#        RPerl::diag("in GSLMatrix_cpp::cpp_load, RPerl__DataStructure__GSLMatrix__MODE_ID() exists & defined\n");
#        RPerl::diag(q{in GSLMatrix_cpp::cpp_load, have RPerl__DataStructure__GSLMatrix__MODE_ID() retval = '} . main::RPerl__DataStructure__GSLMatrix__MODE_ID() . "'\n");
        if ( $RPerl::MODES->{main::RPerl__DataStructure__GSLMatrix__MODE_ID()}->{ops} ne 'CPP' ) {
            $need_load_cpp = 1;
        }
    }
    else {
#        RPerl::diag("in GSLMatrix_cpp::cpp_load, RPerl__DataStructure__GSLMatrix__MODE_ID() does not exist or undefined\n");
        $need_load_cpp = 1;
    }

    if ($need_load_cpp) {

        #        RPerl::diag("in GSLMatrix_cpp::cpp_load, need load CPP code\n");

        my $eval_string = <<"EOF";
package main;
use RPerl::Inline;
BEGIN { RPerl::diag("[[[ BEGIN 'use Inline' STAGE for 'RPerl/DataStructure/GSLMatrix.cpp' ]]]\n" x 1); }
use Inline (CPP => '$RPerl::INCLUDE_PATH' . '/RPerl/DataStructure/GSLMatrix.cpp', \%RPerl::Inline::ARGS);
RPerl::diag("[[[ END   'use Inline' STAGE for 'RPerl/DataStructure/GSLMatrix.cpp' ]]]\n" x 1);
1;
EOF

        $RPerl::Inline::ARGS{ccflagsex} = $RPerl::Inline::CCFLAGSEX . $RPerl::TYPES_CCFLAG . rperltypessizes::type_integer_native_ccflag() . rperltypessizes::type_number_native_ccflag();
        $RPerl::Inline::ARGS{cppflags} = $RPerl::TYPES_CCFLAG . rperltypessizes::type_integer_native_ccflag() . rperltypessizes::type_number_native_ccflag();
        $RPerl::Inline::ARGS{libs}         = '-lgsl';                                                                   # enable GSL support
        $RPerl::Inline::ARGS{inc}         .= ' -I' . $RPerl::Inline::gsl_include_dir;                                   # enable GSL support
        $RPerl::Inline::ARGS{auto_include} = [ @{ $RPerl::Inline::ARGS{auto_include} }, '#include <gsl_matrix.h>' ];    # enable GSL support
        
#        RPerl::diag("in GSLMatrix_cpp::cpp_load(), CPP not yet loaded, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n");
#        RPerl::diag("in GSLMatrix_cpp::cpp_load(), CPP not yet loaded, have \%RPerl::Inline::ARGS =\n" . Dumper(\%RPerl::Inline::ARGS) . "\n");
#        RPerl::diag("in GSLMatrix_cpp::cpp_load(), CPP not yet loaded, have \$RPerl::TYPES_CCFLAG = '" . $RPerl::TYPES_CCFLAG . "'\n");

        eval $eval_string or croak( $OS_ERROR . "\n" . $EVAL_ERROR );
        if ($EVAL_ERROR) { croak($EVAL_ERROR); }
    }

#    else { RPerl::diag("in GSLMatrix_cpp::cpp_load(), CPP already loaded, DOING NOTHING\n"); }
    return;
}

1;  # end of package
