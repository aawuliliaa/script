#!/bin/bash
##############################################################
# File Name: 10-Dos.sh
# Version: V1.0
# Author: vita
# Organization: 
# Created Time : 2019-04-01 17:58:54
# Description:
##############################################################
awk '{IP[$1]++}END{for (key in IP) print key,IP[key]}' ./log/access_2010-12-8.log>./log/dosResult.log
exec < ./log/dosResult.log
while read line;do
    times=$(echo "$line"|awk '{print $2}')
    ip=$(echo "$line"|awk '{print $1}')
    if [ $times -gt 10 ];then
        iptables -A INPUT -s $ip -j DROP
    fi
done
