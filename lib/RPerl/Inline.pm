package RPerl::Inline;

our @ARGS = (
  TYPEMAPS => "$RPerl::INCLUDE_PATH/typemap.rperl",
  # TODO: strip C++ incompat CFLAGS
  CCFLAGS => '-Wno-deprecated -std=c++0x -Wno-reserved-user-defined-literal -Wno-literal-suffix',
  INC => "-I$RPerl::INCLUDE_PATH",
  BUILD_NOISY => 1,
  CLEAN_AFTER_BUILD => 0,
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
