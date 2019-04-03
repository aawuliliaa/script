#!/bin/bash
#description:back /etc
#author:vita
#time:2019-03-04
ip=$(/sbin/ifconfig|egrep -o '([0-9]+\.){3}[0-9]+'|sed -n '1p')
[ -d /backup ]||mkdir -p /backup/$ip
cp -r /etc/ /backup/$ip/etc-$(date +%F-%w)
for file in $(find /backup/$ip/ -type d -mtime +7 -maxdepth 1|egrep -v '.*/$')
do
    week=$(echo $file|awk -F "[-]" '{print $NF}')
    if [ $week -ne 1 ];then
        rm -rf $file
    fi
done
