use ExtUtils::MakeMaker;
my %options = %{
{
  'CC' => 'g++ -D_REENTRANT -D_GNU_SOURCE -DDEBIAN -fstack-protector -fno-strict-aliasing -pipe -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64  -xc++',
  'CCFLAGS' => ' -D_REENTRANT -D_GNU_SOURCE -DDEBIAN -fstack-protector -fno-strict-aliasing -pipe -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -Wno-unused-variable -DNO_XSLOCKS -Wno-deprecated -std=c++11 -Wno-reserved-user-defined-literal -Wno-literal-suffix -D__CPP__TYPES',
  'INC' => '-I"/home/wbraswell/austin_perl_mongers/rperl/rperl-latest/lib/RPerl/Operation/Expression/Operator" -I/home/wbraswell/austin_perl_mongers/rperl/rperl-latest/lib -Ilib',
  'LIBS' => [
    '-lstdc++'
  ],
  'NAME' => 'eval_14_bb23',
  'OPTIMIZE' => ' -O3 -fomit-frame-pointer -march=native -g',
  'TYPEMAPS' => [
    '/usr/share/perl/5.18/ExtUtils/typemap',
    '/home/wbraswell/austin_perl_mongers/rperl/rperl-latest/lib/typemap.rperl'
  ],
  'VERSION' => '0.00'
}
};
WriteMakefile(%options);

# Remove the Makefile dependency. Causes problems on a few systems.
sub MY::makefile { '' }
