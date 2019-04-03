#!/bin/bash
##############################################################
# File Name: 1.randomFileName.sh
# Version: V1.0
# Author: vita
# Organization: 
# Created Time : 2019-04-01 13:18:13
# Description:
##############################################################
randomDir=/opt/randomFile
[ -d $randomDir ]||mkdir -p $randomDir
for ((i=0;i<10;i++));do
    lowerName=$(echo "oldboy$RANDOM" |md5sum|tr '[0-9]' '[a-z]'|cut -c 2-11)
    cd $randomDir
    touch ${lowerName}_oldboy.html
    echo "${lowerName}_oldboy.html has been touched!"
done
