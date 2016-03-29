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


# [[[ OUTPUT OBJECT FILE, DOES NOT REQUIRE libperl-dev ]]]
#g++ -c -D_REENTRANT -D_GNU_SOURCE -DDEBIAN -fstack-protector -fno-strict-aliasing -pipe -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64  -xc++ -I"/home/wbraswell/austin_perl_mongers/rperl/rperl-latest" -I/home/wbraswell/austin_perl_mongers/rperl/rperl-latest/lib -Ilib -Wno-unused-variable -DNO_XSLOCKS -Wno-deprecated -std=c++11 -Wno-reserved-user-defined-literal -Wno-literal-suffix -D__CPP__TYPES -O3 -fomit-frame-pointer -march=native -g -DVERSION=\"0.00\" -DXS_VERSION=\"0.00\" -fPIC "-I/usr/lib/perl/5.18/CORE" $INPUT_FILE_CPP -o $OUTPUT_FILE.o #> /tmp/gcc.out 2>&1

# [[[ OUTPUT OBJECT FILE, DOES NOT WORK PROPERLY??? DOES NOT STATICALLY LINK TO libperl.a, DOES NOT REQUIRE libperl-dev ]]]
#g++ -c -pthread -D_REENTRANT -D_GNU_SOURCE -DDEBIAN -fstack-protector -fno-strict-aliasing -pipe -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64  -xc++ -I"/home/wbraswell/austin_perl_mongers/rperl/rperl-latest" -I/home/wbraswell/austin_perl_mongers/rperl/rperl-latest/lib -Ilib -Wno-unused-variable -DNO_XSLOCKS -Wno-deprecated -std=c++11 -Wno-reserved-user-defined-literal -Wno-literal-suffix -D__CPP__TYPES -O3 -fomit-frame-pointer -march=native -g -DVERSION=\"0.00\" -DXS_VERSION=\"0.00\" -fPIC "-I/usr/lib/perl/5.18/CORE" $INPUT_FILE_CPP -o $OUTPUT_FILE.o -static -lperl -lcrypt #> /tmp/gcc.out 2>&1

# [[[ OUTPUT OBJECT FILE, DOES NOT WORK PROPERLY??? DOES NOT DYNAMICALLY LINK TO libperl.so, DOES NOT REQUIRE libperl-dev ]]]
#g++ -c -pthread -D_REENTRANT -D_GNU_SOURCE -DDEBIAN -fstack-protector -fno-strict-aliasing -pipe -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64  -xc++ -I"/home/wbraswell/austin_perl_mongers/rperl/rperl-latest" -I/home/wbraswell/austin_perl_mongers/rperl/rperl-latest/lib -Ilib -Wno-unused-variable -DNO_XSLOCKS -Wno-deprecated -std=c++11 -Wno-reserved-user-defined-literal -Wno-literal-suffix -D__CPP__TYPES -O3 -fomit-frame-pointer -march=native -g -DVERSION=\"0.00\" -DXS_VERSION=\"0.00\" -fPIC "-I/usr/lib/perl/5.18/CORE" $INPUT_FILE_CPP -o $OUTPUT_FILE.o -lperl -lcrypt #> /tmp/gcc.out 2>&1

# [[[ OUTPUT EXECUTABLE FILE, STATICALLY LINK TO libperl.a, REQUIRES libperl-dev & libcrypt ]]]
# DEV NOTE: NSS gethostbyname() etc cannot be statically linked, will emit warnings
# http://stackoverflow.com/questions/15165306/compile-a-static-binary-which-code-there-a-function-gethostbyname
#g++ -pthread -D_REENTRANT -D_GNU_SOURCE -DDEBIAN -fstack-protector -fno-strict-aliasing -pipe -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64  -xc++ -I"/home/wbraswell/austin_perl_mongers/rperl/rperl-latest" -I/home/wbraswell/austin_perl_mongers/rperl/rperl-latest/lib -Ilib -Wno-unused-variable -DNO_XSLOCKS -Wno-deprecated -std=c++11 -Wno-reserved-user-defined-literal -Wno-literal-suffix -D__CPP__TYPES -O3 -fomit-frame-pointer -march=native -g -DVERSION=\"0.00\" -DXS_VERSION=\"0.00\" -fPIC "-I/usr/lib/perl/5.18/CORE" $INPUT_FILE_CPP -o $OUTPUT_FILE -static -lperl -lcrypt #> /tmp/gcc.out 2>&1

# [[[ OUTPUT EXECUTABLE FILE, DYNAMICALLY LINK TO libperl.so, REQUIRES libperl-dev ]]]
g++ -pthread -D_REENTRANT -D_GNU_SOURCE -DDEBIAN -fstack-protector -fno-strict-aliasing -pipe -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64  -xc++ -I"/home/wbraswell/austin_perl_mongers/rperl/rperl-latest" -I/home/wbraswell/austin_perl_mongers/rperl/rperl-latest/lib -Ilib -Wno-unused-variable -DNO_XSLOCKS -Wno-deprecated -std=c++11 -Wno-reserved-user-defined-literal -Wno-literal-suffix -D__CPP__TYPES -O3 -fomit-frame-pointer -march=native -g -DVERSION=\"0.00\" -DXS_VERSION=\"0.00\" -fPIC "-I/usr/lib/perl/5.18/CORE" $INPUT_FILE_CPP -o $OUTPUT_FILE -lperl #> /tmp/gcc.out 2>&1
