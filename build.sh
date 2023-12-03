#!/bin/bash 

# usage:
# ./build.sh  [flash]

if [ ! -d "build" ] 
then 
    mkdir "build"
fi 
if [[ ! -z $1 && ($1 == "flash") ]]; then 
# flash application 
    make -fstm8s103.mk flash 
elif [[ ! -z $1 && ($1 == "opt") ]]; then
# modify options registers 
    make -fstm8s103.mk alt_func
else
# build project 
    make -fstm8s103.mk
fi 
