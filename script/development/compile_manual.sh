#!/bin/bash

rm -Rf _Inline
rm -f /tmp/gcc.out

#g++ -I/usr/lib/perl/5.18.2/CORE -I./lib/ -Wno-unused-variable -DNO_XSLOCKS -Wno-deprecated -std=c++11 -Wno-reserved-user-defined-literal -Wno-literal-suffix lib/RPerl/Learning/Chapter1/exercise_1-hello_world.cpp > /tmp/gcc.out 2>&1

# OBJECT FILE
#g++ -c -D_REENTRANT -D_GNU_SOURCE -DDEBIAN -fstack-protector -fno-strict-aliasing -pipe -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64  -xc++ -I"/home/wbraswell/austin_perl_mongers/rperl/rperl-latest" -I/home/wbraswell/austin_perl_mongers/rperl/rperl-latest/lib -Ilib -Wno-unused-variable -DNO_XSLOCKS -Wno-deprecated -std=c++11 -Wno-reserved-user-defined-literal -Wno-literal-suffix -D__CPP__TYPES -O3 -fomit-frame-pointer -march=native -g -DVERSION=\"0.00\" -DXS_VERSION=\"0.00\" -fPIC "-I/usr/lib/perl/5.18/CORE" lib/RPerl/Learning/Chapter1/exercise_1-hello_world.cpp #> /tmp/gcc.out 2>&1

# EXECUTABLE FILE, STATIC LINK TO libperl.a
g++ -pthread -D_REENTRANT -D_GNU_SOURCE -DDEBIAN -fstack-protector -fno-strict-aliasing -pipe -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64  -xc++ -I"/home/wbraswell/austin_perl_mongers/rperl/rperl-latest" -I/home/wbraswell/austin_perl_mongers/rperl/rperl-latest/lib -Ilib -Wno-unused-variable -DNO_XSLOCKS -Wno-deprecated -std=c++11 -Wno-reserved-user-defined-literal -Wno-literal-suffix -D__CPP__TYPES -O3 -fomit-frame-pointer -march=native -g -DVERSION=\"0.00\" -DXS_VERSION=\"0.00\" -fPIC "-I/usr/lib/perl/5.18/CORE" lib/RPerl/Learning/Chapter1/exercise_1-hello_world.cpp -lperl #> /tmp/gcc.out 2>&1

# EXECUTABLE FILE, DYNAMIC LINK TO libperl.so
#g++ -lperl -D_REENTRANT -D_GNU_SOURCE -DDEBIAN -fstack-protector -fno-strict-aliasing -pipe -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64  -xc++ -I"/home/wbraswell/austin_perl_mongers/rperl/rperl-latest" -I/home/wbraswell/austin_perl_mongers/rperl/rperl-latest/lib -Ilib -Wno-unused-variable -DNO_XSLOCKS -Wno-deprecated -std=c++11 -Wno-reserved-user-defined-literal -Wno-literal-suffix -D__CPP__TYPES -O3 -fomit-frame-pointer -march=native -g -DVERSION=\"0.00\" -DXS_VERSION=\"0.00\" -fPIC "-I/usr/lib/perl/5.18/CORE" lib/RPerl/Learning/Chapter1/exercise_1-hello_world.cpp #> /tmp/gcc.out 2>&1
