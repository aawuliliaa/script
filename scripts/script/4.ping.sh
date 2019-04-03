#!/bin/bash
##############################################################
# File Name: 4.ping.sh
# Version: V1.0
# Author: vita
# Organization: 
# Created Time : 2019-04-01 14:33:53
# Description:
##############################################################
source /etc/init.d/functions
for ip in {1..254};do
{
    ping -c 1 -w 3 10.0.0.$ip > /dev/null 2>&1
    [ $? -eq 0 ]&&{
    action "10.0.0.$ip can be accessed!" /bin/true
    }||{
    action "10.0.0.$ip can not be accessed" /bin/false
    }
} &
done
