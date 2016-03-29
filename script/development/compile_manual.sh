#!/bin/bash

INPUT_FILE_CPP=$1

if [[ "$INPUT_FILE_CPP" != *".cpp" ]]
then
    echo "ERROR: File $INPUT_FILE_CPP does not end with .cpp, dying"
    exit
fi

OUTPUT_FILE_LENGTH=`expr ${#INPUT_FILE_CPP} - 4`
OUTPUT_FILE=${INPUT_FILE_CPP:0:$OUTPUT_FILE_LENGTH}

#rm -Rf _Inline
rm -f /tmp/gcc.out
rm -f $OUTPUT_FILE


# [[[ ASSEMBLE, OUTPUT OBJECT FILE ]]]
# 2.1M $OUTPUT_FILE.o: ELF 64-bit LSB  relocatable, x86-64, version 1 (SYSV), not stripped
#g++ -c          -D_REENTRANT -D_GNU_SOURCE -DDEBIAN -fstack-protector -fno-strict-aliasing -pipe -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -xc++ -I"/home/wbraswell/austin_perl_mongers/rperl/rperl-latest" -I"/home/wbraswell/austin_perl_mongers/rperl/rperl-latest/lib" -Ilib -Wno-unused-variable -DNO_XSLOCKS -Wno-deprecated -std=c++11 -Wno-reserved-user-defined-literal -Wno-literal-suffix -D__CPP__TYPES -O3 -fomit-frame-pointer -march=native -g -DVERSION=\"0.00\" -DXS_VERSION=\"0.00\" -fPIC "-I/usr/lib/perl/5.18/CORE" $INPUT_FILE_CPP -o $OUTPUT_FILE.o                         #> /tmp/gcc.out 2>&1

# [[[ ARCHIVE, OUTPUT ARCHIVE FILE ]]]
# 2.1M $OUTPUT_FILE.a: current ar archive
#ar -cvq $OUTPUT_FILE.a $OUTPUT_FILE.o

# [[[ SHARED, OUTPUT SHARED OBJECT FILE ]]]
# 996K $OUTPUT_FILE.so: ELF 64-bit LSB  shared object, x86-64, version 1 (SYSV), dynamically linked, BuildID[sha1]=FOO, not stripped
#g++             -D_REENTRANT -D_GNU_SOURCE -DDEBIAN -fstack-protector -fno-strict-aliasing -pipe -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -xc++ -I"/home/wbraswell/austin_perl_mongers/rperl/rperl-latest" -I"/home/wbraswell/austin_perl_mongers/rperl/rperl-latest/lib" -Ilib -Wno-unused-variable -DNO_XSLOCKS -Wno-deprecated -std=c++11 -Wno-reserved-user-defined-literal -Wno-literal-suffix -D__CPP__TYPES -O3 -fomit-frame-pointer -march=native -g -DVERSION=\"0.00\" -DXS_VERSION=\"0.00\" -fPIC "-I/usr/lib/perl/5.18/CORE" $INPUT_FILE_CPP -o $OUTPUT_FILE.so -shared                #> /tmp/gcc.out 2>&1
#chmod a-x $OUTPUT_FILE.so

# [[[ STATIC,  OUTPUT EXECUTABLE FILE, LINK TO libperl.a,  REQUIRES libperl-dev & libcrypt ]]]
# 9.6M $OUTPUT_FILE: ELF 64-bit LSB  executable, x86-64, version 1 (GNU/Linux), statically linked, for GNU/Linux 2.6.24, BuildID[sha1]=FOO, not stripped
#  13M    libperl.a: current ar archive
# DEV NOTE: NSS gethostbyname() etc cannot be statically linked, will emit warnings
# http://stackoverflow.com/questions/15165306/compile-a-static-binary-which-code-there-a-function-gethostbyname
#g++    -pthread -D_REENTRANT -D_GNU_SOURCE -DDEBIAN -fstack-protector -fno-strict-aliasing -pipe -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -xc++ -I"/home/wbraswell/austin_perl_mongers/rperl/rperl-latest" -I"/home/wbraswell/austin_perl_mongers/rperl/rperl-latest/lib" -Ilib -Wno-unused-variable -DNO_XSLOCKS -Wno-deprecated -std=c++11 -Wno-reserved-user-defined-literal -Wno-literal-suffix -D__CPP__TYPES -O3 -fomit-frame-pointer -march=native -g -DVERSION=\"0.00\" -DXS_VERSION=\"0.00\" -fPIC "-I/usr/lib/perl/5.18/CORE" $INPUT_FILE_CPP -o $OUTPUT_FILE    -static -lperl -lcrypt #> /tmp/gcc.out 2>&1

# [[[ DYNAMIC, OUTPUT EXECUTABLE FILE, LINK TO libperl.so, REQUIRES libperl-dev ]]]
# 984K $OUTPUT_FILE: ELF 64-bit LSB  executable,    x86-64, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.24, BuildID[sha1]=FOO, not stripped
# 1.6M   libperl.so: ELF 64-bit LSB  shared object, x86-64, version 1 (SYSV), dynamically linked,                                          BuildID[sha1]=FOO, stripped
 g++    -pthread -D_REENTRANT -D_GNU_SOURCE -DDEBIAN -fstack-protector -fno-strict-aliasing -pipe -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -xc++ -I"/home/wbraswell/austin_perl_mongers/rperl/rperl-latest" -I"/home/wbraswell/austin_perl_mongers/rperl/rperl-latest/lib" -Ilib -Wno-unused-variable -DNO_XSLOCKS -Wno-deprecated -std=c++11 -Wno-reserved-user-defined-literal -Wno-literal-suffix -D__CPP__TYPES -O3 -fomit-frame-pointer -march=native -g -DVERSION=\"0.00\" -DXS_VERSION=\"0.00\" -fPIC "-I/usr/lib/perl/5.18/CORE" $INPUT_FILE_CPP -o $OUTPUT_FILE            -lperl         #> /tmp/gcc.out 2>&1
