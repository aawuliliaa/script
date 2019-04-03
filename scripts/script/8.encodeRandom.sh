#!/bin/bash
##############################################################
# File Name: 8.encodeRandom.sh
# Version: V1.0
# Author: vita
# Organization: 
# Created Time : 2019-04-01 16:08:14
# Description:
##############################################################
for i in {1..32767};do
    for md5Num in 21029299 00205d1c a3da1677 1f6d12dd 890684b;do
       num=$(echo "$i"|md5sum|grep "$md5Num"|wc -l)
       if [ $num -eq 0 ];then
           continue
       else
           echo "${i}----${md5Num}"
           continue
       fi
    done
done
