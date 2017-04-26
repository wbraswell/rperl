# [[[ HEADER ]]]
package RPerl::HelperFunctions_cpp;
use strict;
use warnings;
use RPerl::Config; # get Carp, English, $RPerl::INCLUDE_PATH without 'use RPerl;'

#use RPerl;  # DEV NOTE: need to use HelperFunctions in RPerl::DataStructure::Array for type checking SvIOKp() etc; remove dependency on RPerl void::method type so HelperFunctions can be loaded by RPerl type system
our $VERSION = 0.004_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitStringyEval)  # SYSTEM DEFAULT 1: allow eval()

# [[[ INCLUDES ]]]
use RPerl::Inline;
use rperltypessizes;  # get type_integer_native_ccflag() & type_number_native_ccflag() w/out loading the entire RPerl type system via 'use rperltypes;'




# [[[ SPECIAL PACKAGE VARIABLES ]]]
our $LOADING = 0;
$ENV{RPERL_HELPERS_LOADING} = 0;



# [[[ SUBROUTINES ]]]
#our void::method $cpp_load = sub {  # DEV NOTE: remove dependency on RPerl
sub cpp_load {
    my $need_load_cpp = 0;
    if (    ( exists $main::{'RPerl__HelperFunctions__MODE_ID'} )
        and ( defined &{ $main::{'RPerl__HelperFunctions__MODE_ID'} } ) )
    {
        RPerl::diag("in HelperFunctions_cpp::cpp_load, RPerl__HelperFunctions__MODE_ID() exists & defined\n");
        RPerl::diag(q{in HelperFunctions_cpp::cpp_load, have RPerl__HelperFunctions__MODE_ID() retval = '} . main::RPerl__HelperFunctions__MODE_ID() . "'\n");
        if ( $RPerl::MODES
            ->{ main::RPerl__HelperFunctions__MODE_ID() }->{ops} ne
            'CPP' )
        {
            $need_load_cpp = 1;
        }
    }
    else {
        RPerl::diag("in HelperFunctions_cpp::cpp_load, RPerl__HelperFunctions__MODE_ID() does not exist or undefined\n");
        $need_load_cpp = 1;
    }

    if ($need_load_cpp) {
        $RPerl::HelperFunctions_cpp::LOADING = 1;
        $ENV{RPERL_HELPERS_LOADING} = 1;

        RPerl::diag("in HelperFunctions_cpp::cpp_load, need load CPP code\n");

#BEGIN { RPerl::diag("[[[ BEGIN 'use Inline' STAGE for 'RPerl/HelperFunctions.cpp' ]]]\n" x 1); }
        my $eval_string = <<"EOF";
package main;

#BEGIN { print '<<< DEBUG HelperFunctions_cpp.pm 0a2x, have \$RPerl::HelperFunctions_cpp::LOADING = ', $RPerl::HelperFunctions_cpp::LOADING, ' >>>', "\\n"; }
BEGIN { print '<<< DEBUG HelperFunctions_cpp.pm 0a2x, have \$ENV{RPERL_HELPERS_LOADING} = ', $ENV{RPERL_HELPERS_LOADING}, ' >>>', "\n"; }


# NEED UNCOMMENT
#use RPerl::Inline;


BEGIN { print '<<< DEBUG HelperFunctions_cpp.pm 0a2a >>>', "\n"; }
BEGIN { RPerl::diag("[[[ BEGIN 'use Inline' STAGE for 'RPerl/HelperFunctions.cpp' ]]]\n" x 1); }
BEGIN { print '<<< DEBUG HelperFunctions_cpp.pm 0a2b >>>', "\n"; }


# START HERE: why is the following 'use Inline' call recursing???
# START HERE: why is the following 'use Inline' call recursing???
# START HERE: why is the following 'use Inline' call recursing???


# NEED UNCOMMENT
#use Inline (CPP => '$RPerl::INCLUDE_PATH' . '/RPerl/HelperFunctions.cpp', \%RPerl::Inline::ARGS);
#BEGIN{ \$DB::single = 1; }
BEGIN{ use Inline (CPP => '$RPerl::INCLUDE_PATH' . '/RPerl/HelperFunctions.cpp', \%RPerl::Inline::ARGS); }



BEGIN { print '<<< DEBUG HelperFunctions_cpp.pm 0a2c >>>', "\n"; }
RPerl::diag("[[[ END   'use Inline' STAGE for 'RPerl/HelperFunctions.cpp' ]]]\n" x 1);
1;
EOF

        $RPerl::Inline::ARGS{ccflagsex} = $RPerl::Inline::CCFLAGSEX . $RPerl::TYPES_CCFLAG . rperltypessizes::type_integer_native_ccflag() . rperltypessizes::type_number_native_ccflag();
        $RPerl::Inline::ARGS{cppflags} = $RPerl::TYPES_CCFLAG . rperltypessizes::type_integer_native_ccflag() . rperltypessizes::type_number_native_ccflag();

        RPerl::diag("in HelperFunctions_cpp::cpp_load(), CPP not yet loaded, have \%RPerl::Inline::ARGS =\n" . Dumper(\%RPerl::Inline::ARGS) . "\n");
        RPerl::diag("in HelperFunctions_cpp::cpp_load(), CPP not yet loaded, about to call eval() on \$eval_string =\n<<< BEGIN EVAL STRING>>>\n" . $eval_string . "<<< END EVAL STRING >>>\n");

        eval $eval_string or croak( $OS_ERROR . "\n" . $EVAL_ERROR );
        if ($EVAL_ERROR) { croak($EVAL_ERROR); }

#RPerl::diag("[[[ END   'use Inline' STAGE for 'RPerl/HelperFunctions.cpp' ]]]\n" x 1);
        $RPerl::HelperFunctions_cpp::LOADING = 0;
    }

	else { RPerl::diag("in HelperFunctions_cpp::cpp_load(), CPP already loaded, DOING NOTHING\n"); }
}

1;
