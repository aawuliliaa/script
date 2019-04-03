#!/bin/bash
#description:back file to the directory of /backup
#author:vita
#time:2019-03-04
rm -rf /root/.ssh/id_dsa
ssh-keygen -f /root/.ssh/id_dsa -N ""
for ip in 8 7 5 6 9 31 41 51
do
    sshpass -p123456 ssh-copy-id -i /root/.ssh/id_dsa.pub "-o StrictHostKeyChecking=no 172.16.1.$ip"
done
