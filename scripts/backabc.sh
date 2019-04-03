#!/bin/bash
#description:find the first line of the file start of abc
#author:vita
#time:2019-03-05
FILE=$(find /tmp/ -type f -name "abc*"|head -n 10)
for file in $FILE
do
    head -n 1 $file >>/oldboy/test.txt
done
