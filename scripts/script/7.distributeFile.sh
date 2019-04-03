#!/bin/bash
##############################################################
# File Name: 7.distributeFile.sh
# Version: V1.0
# Author: vita
# Organization: 
# Created Time : 2019-04-01 15:57:04
# Description:
##############################################################
source /etc/init.d/functions
[ $# -ne 2 ]&&{
echo "Usage $0 localpath remotepath"
exit 1
}
for ip in 7;do
    scp -r $1 root@10.0.0.$ip:$2
    [ $? -eq 0 ]&&{
    action "10.0.0.$ip has recevied file" /bin/true
    }||{
    action "10.0.0.$ip has not received file" /bin/false
    }
done
