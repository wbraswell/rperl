package RPerl::Inline;
use RPerl;
#use Config;

# long form
#use Inline CPP => config => classes => sub {
#    my $class = shift;
#    my @class_split = split('__', $class);
#    my $class_auto = pop(@class_split);
#    my $pkg_auto = join('::', @class_split);
#    return($pkg_auto, $class_auto);
#};

# medium form
#use Inline CPP => config => classes => sub { my @c = split('__', shift); (pop(@c), join('::', @c)); };

# short form
#use Inline CPP => config => classes => sub { @_ = split('__', shift); (pop, join('::', @_)); };

our @ARGS = (
  TYPEMAPS => "$RPerl::INCLUDE_PATH/typemap.rperl",
  # TODO: strip C++ incompat CFLAGS
#  CCFLAGS => $Config{ccflags} . ' -DNO_XSLOCKS -Wno-deprecated -std=c++0x -Wno-reserved-user-defined-literal -Wno-literal-suffix',
  CCFLAGSEX => '-DNO_XSLOCKS -Wno-deprecated -std=c++0x -Wno-reserved-user-defined-literal -Wno-literal-suffix',
  INC => "-I$RPerl::INCLUDE_PATH",
  BUILD_NOISY => $ENV{TEST_VERBOSE},
  CLEAN_AFTER_BUILD => 0, # cache it
  WARNINGS => 1,
  FILTERS => 'Preprocess',
  AUTO_INCLUDE => # DEV NOTE: include non-RPerl files using AUTO_INCLUDE so they are not parsed by the 'Preprocess' filter
  [
   '#include <iostream>',
   '#include <string>',
   '#include <sstream>',
   '#include <limits>',
   '#include <vector>',
   '#include <unordered_map>',  # DEV NOTE: unordered_map may require '-std=c++0x' in CCFLAGS above
  ]
);
1;
