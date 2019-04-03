#!/bin/bash
#description:compare to variable
#author:vita
#version:v1.0
cat <<EOF
1.install lamp
2.install lnmp
3.exit
EOF
read -p "(please input one number :)" num
[ -z "$num" ] && echo "you must input something" ;exit 5
expr $num + 2 &>/dev/null
if [ $? -ne 0 ];then
    echo "you must input one number!"
    exit 1
fi
if [ $num -eq 1 ];then
    echo "start to install lamp"
    exit 2
elif [ $num -eq 2 ];then
    echo "start to install lnmp"
    exit 3
else [ $num -eq 3 ]
    echo "exit now"
    exit 4
fi
