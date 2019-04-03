#!/bin/bash
#description:back file to the directory of /backup
#author:vita
#time:2019-03-04
read -p "pleas input like x+y:" num1
read -p "pleas input like x+y:" label
read -p "pleas input like x+y:" num2
if [ "$label" == "+" -o "$label" == "-" ];then
    echo $(echo $num1$label$num2|bc)
    exit
fi
    
echo "your label must in (+ - * / %)"
