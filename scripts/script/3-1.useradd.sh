#!/bin/bash
##############################################################
# File Name: 3-1.useradd.sh
# Version: V1.0
# Author: vita
# Organization: 
# Created Time : 2019-04-01 13:54:21
# Description:
##############################################################
for i in $(seq -w 11 15);do
    pass=$(openssl rand -base64 10)
    useradd oldboy$i
    echo "oldboy$i:$pass">>./log/chpasswd.log
done
chpasswd <./log/chpasswd.log
