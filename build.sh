#!/bin/bash 

# usage:
# ./build.sh  [flash||opt]

if [ ! -d "build" ] 
then 
    mkdir "build"
fi 
if [[ ! -z $1 && ($1 == "flash") ]]; then 
# build and flash project 
    make -fstm8s207.mk && make -fstm8s207.mk flash 
elif [[ ! -z $1 && ($1 == "opt") ]]; then
# modify options registers 
    make -fstm8s207.mk alt_func
else
# build project 
    make -fstm8s207.mk
fi 
