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

ln -s Algorithm.h.CPPOPS_PERLTYPES Algorithm.h
ln -s Algorithm.cpp.CPPOPS_PERLTYPES Algorithm.cpp
ln -s Algorithm.pmc.CPPOPS_DUALTYPES Algorithm.pmc

cd Algorithm

rm Sort.h 2> /dev/null
rm Sort.cpp 2> /dev/null
rm Sort.pmc 2> /dev/null

rm Inefficient.h 2> /dev/null
rm Inefficient.cpp 2> /dev/null
rm Inefficient.pmc 2> /dev/null

ln -s Sort.h.CPPOPS_PERLTYPES Sort.h
ln -s Sort.cpp.CPPOPS_PERLTYPES Sort.cpp
ln -s Sort.pmc.CPPOPS_DUALTYPES Sort.pmc

ln -s Inefficient.h.CPPOPS_CPPTYPES Inefficient.h
ln -s Inefficient.cpp.CPPOPS_CPPTYPES Inefficient.cpp
ln -s Inefficient.pmc.CPPOPS_DUALTYPES Inefficient.pmc

cd Sort

rm Bubble.h 2> /dev/null
rm Bubble.cpp 2> /dev/null
rm Bubble.pmc 2> /dev/null

ln -s Bubble.h.CPPOPS_PERLTYPES Bubble.h
ln -s Bubble.cpp.CPPOPS_PERLTYPES Bubble.cpp
ln -s Bubble.pmc.CPPOPS_DUALTYPES Bubble.pmc
