#!/bin/bash
#description:compare two variable
#author:vita
#version:v1.0
#read -p "please input two number:"  a b
a=$1
b=$2
[ $# -ne 2 ]&&{
    echo "you can just input two number"
    exit 6
}
if [ -z "$a" ];then
    echo "you must input first number"
    exit 7
fi


if [ -z "$b" ];then
    echo "you must input second number"
    exit 8
fi

##判断输入是否是整数
expr $a + $b + 2 &>/dev/null
if [ $? -ne 0 ];then
    echo "the two number must be int"
    exit 1
fi
#用户输入终于合法了，可以判断大小了
if [ $a -gt $b ];then
    echo "$a>$b"
    exit 3
elif [ $a -eq $b ];then
    echo "$a==$b"
    exit 4
elif [ $a -lt $b ];then
    echo "$a<$b"
    exit 5
fi
