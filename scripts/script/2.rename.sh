#!/bin/bash
##############################################################
# File Name: 2.rename.sh
# Version: V1.0
# Author: vita
# Organization: 
# Created Time : 2019-04-01 13:31:50
# Description:
##############################################################
randomDir=/opt/randomFile
files=$(ls $randomDir)
cd $randomDir
for file in $files;do
    newName=$(echo $file |sed 's#oldboy#oldgirl#g')
    mv $file $newName
    echo "$file change name to $newName!"
done
