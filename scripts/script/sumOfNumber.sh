#!/bin/bash
#description
#author:vita
#version:v1.0
sum=0
for ((i=0;i<101;i++));do
    sum=$(($sum+$i))
done
echo "sum is $sum"
