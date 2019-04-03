#!/bin/bash
#description:show the space of root directory
#author:root
#version:v1.0
leftSpace=$(df -m|grep -E '/$'|awk '{print $(NF-2) }')
if [ $leftSpace -lt 1000 ];then
    echo "the space of root directory is less than 1000M">/server/scripts/log/lefspace.log
    mail -s "the space of root directory" linuxengineerofwu@163.com</server/scripts/log/lefspace.log
    exit 1
else
    echo "the space of root directory is greater than 1000M">/server/scripts/log/lefspace.log
    mail -s "the space of root directory" linuxengineerofwu@163.com</server/scripts/log/lefspace.log
    exit 2
    
fi
