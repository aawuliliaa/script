#!/bin/bash
#description:back file to the directory of /backup
#author:vita
#time:2019-03-04
sum=0
for ((i=0;i<101;i++))
do
    sum=$(echo $sum + $i|bc)
done
echo $sum
