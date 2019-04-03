#!/bin/bash
#description:back file to the directory of /backup
#author:vita
#time:2019-03-04
[ $# -ne 1 ]&&echo "you should use this script like sh fenfa_check.sh pwd"&&exit
for ip in 31 41 7 61
do
    echo "start to excute 172.16.1.$ip"
    ssh 172.16.1.$ip $1
    echo "172.16.1.$ip end"
done
