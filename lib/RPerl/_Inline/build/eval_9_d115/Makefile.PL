use ExtUtils::MakeMaker;
my %options = %{
{
  'NAME' => 'eval_9_d115',
  'CCFLAGS' => ' -D_REENTRANT -D_GNU_SOURCE -DDEBIAN -fstack-protector -fno-strict-aliasing -pipe -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -DNO_XSLOCKS -Wno-deprecated -std=c++0x -Wno-reserved-user-defined-literal -Wno-literal-suffix',
  'VERSION' => '0.00',
  'LIBS' => [
    '-lstdc++'
  ],
  'INC' => '-I"/home/wbraswell/austin_perl_mongers/rperl/rperl-latest/lib/RPerl" -I/home/wbraswell/austin_perl_mongers/rperl/rperl-latest/lib',
  'TYPEMAPS' => [
    '/usr/share/perl/5.18/ExtUtils/typemap',
    '/home/wbraswell/austin_perl_mongers/rperl/rperl-latest/lib/typemap.rperl'
  ],
  'CC' => 'g++ -xc++  -D_FILE_OFFSET_BITS=64'
}
};
WriteMakefile(%options);

# Remove the Makefile dependency. Causes problems on a few systems.
sub MY::makefile { '' }
