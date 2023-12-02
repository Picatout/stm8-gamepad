#!/bin/bash 

# usage:
# ./build.sh  [flash]

if [ ! -d "build" ] 
then 
    mkdir "build"
fi 
if [[ ! -z $1 && ($1 == "flash") ]]; then 
    make -fstm8s103.mk && make -fstm8s103.mk flash 
else 
    make -fstm8s103.mk
fi 
