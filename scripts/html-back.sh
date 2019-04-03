#!/bin/bash
#description:back /var/www/html to /backup/ip
#author:vita
#time:20190304
ip=$(/sbin/ifconfig|egrep -o '([0-9]+\.){3}[0-9]+'|sed -n '1p')
[ -d /backup/$ip ]||mkdir -p /backup/$ip
cp -r /var/www/html /backup/$ip
