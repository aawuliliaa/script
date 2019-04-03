#!/bin/bash
#description
#author:vita
#version:v1.0
sum=0
i=0
while [ $i -lt 100 ];do
    i=$(($i+1))
    sum=$(($sum+$i))
   
done
echo "sum is $sum"
