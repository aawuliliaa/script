#!/bin/bash
#description:test arg
#author:vita
#version:v1.0
echo '#####$0#####'
echo $0
echo '#####$n#####'
echo $2
echo '#####$*#####'
for arg in $*
do
    echo $arg
done
echo '#####$@#####'
for arg in $@
do
    echo $arg
done
echo '#####"$*"#####'
for arg in "$*"
do
    echo $arg
done
echo '#####"$@"#####'
for arg in "$@"
do
    echo $arg
done
