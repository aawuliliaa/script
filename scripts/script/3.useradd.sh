#!/bin/bash
##############################################################
# File Name: 3.useradd.sh
# Version: V1.0
# Author: vita
# Organization: 
# Created Time : 2019-04-01 13:41:32
# Description:
##############################################################
source /etc/init.d/functions
if [ $UID -ne 0];then
    echo "you can only use root to add new user!"
    exit 1
fi
for i in {12..17};do
    username=oldboy$i
    if [ $(grep $username /etc/passwd|wc -l) -eq 1 ];then
        action "oldboy$i has already exist!" /bin/false
    else
        useradd $username
        passwd=$(mkpasswd -l 15 -d 2 -c 3)
        echo "$passwd"|passwd --stdin $username
        echo "$username---$passwd">>./log/passwd.log
        action "$username has been added succesfully!" /bin/true
    fi
done
