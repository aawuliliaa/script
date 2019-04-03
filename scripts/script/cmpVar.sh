#!/bin/bash
#description:compare two variable
#author:vita
#version:v1.0
read -p "please input two number:"  a b
#判断是否输入了第一个参数
if [ -z "$a" ];then
    echo "you must input first number"
    exit 6
fi
#当用户输入三个参数的时候，第一个空格后的内容都当做第二个参数，由于第二个参数中是含有空格的，可以去除空格比较长度
if [ $(echo "$b"|sed -r 's# ##g'|wc -L) -eq $(echo "$b"|wc -L) ];then
####不输入第二个参数的时候，长度也是相同的，所以要对此情况做判断
    if [ -z "$b" ];then
        echo "you must input second number"
        exit 8
    fi
#长度不相同，说明输入了多个参数
elif [ $(echo "$b"|sed -r 's# ##g'|wc -L) -ne $(echo "$b"|wc -L) ];then
    echo "you can just input two number"
    exit 9
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
