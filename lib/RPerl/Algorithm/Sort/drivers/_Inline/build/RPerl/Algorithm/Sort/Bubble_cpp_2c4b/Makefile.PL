use ExtUtils::MakeMaker;
my %options = %{
{
  'TYPEMAPS' => [
    '/usr/share/perl/5.10/ExtUtils/typemap'
  ],
  'NAME' => 'RPerl::Algorithm::Sort::Bubble_cpp_2c4b',
  'CC' => 'g++',
  'CCFLAGS' => ' -Wno-deprecated',
  'LIBS' => [
    '-lstdc++'
  ],
  'INC' => '-I"/home/wbraswell/austin_perl_mongers/compiler/RPerl/RPerl-latest/lib/RPerl/Algorithm/Sort/drivers"',
  'VERSION' => '0.00'
}
};
WriteMakefile(%options);

# Remove the Makefile dependency. Causes problems on a few systems.
sub MY::makefile { '' }
