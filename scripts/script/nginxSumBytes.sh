#!/bin/bash
#description:sum of access byte
#author:vita
#version:v1.0
exec < access.log
sum=0
while read line
do
    byte=$(echo "$line"|awk '{print $10}')
    sum=$(($sum+$byte))
done
echo "sum byte is $sum"
