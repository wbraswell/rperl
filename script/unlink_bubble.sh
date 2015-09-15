#!/bin/bash

if [ -d "lib/RPerl" ]; then
    cd lib/RPerl
elif [ -d "RPerl" ]; then
    cd RPerl
else
    echo "Can't find lib/RPerl/ or RPerl/ directories, dying"
    exit
fi

rm Algorithm.h 2> /dev/null
rm Algorithm.cpp 2> /dev/null
rm Algorithm.pmc 2> /dev/null

cd Algorithm

rm Sort.h 2> /dev/null
rm Sort.cpp 2> /dev/null
rm Sort.pmc 2> /dev/null

rm Inefficient.h 2> /dev/null
rm Inefficient.cpp 2> /dev/null
rm Inefficient.pmc 2> /dev/null

cd Sort

rm Bubble.h 2> /dev/null
rm Bubble.cpp 2> /dev/null
rm Bubble.pmc 2> /dev/null

