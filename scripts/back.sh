#!/bin/bash
#description:back file to the directory of /backup
#author:vita
#time:2019-03-04
FILE=$(find /var/log/nginx/ -type f -size +1G )
[ -d /data/$(date -d '-1day' +%F) ]||mkdir -p /data/$(date -d '-1day' +%F)
for file in $FILE
do
    cp $file /data/$(date -d '-1day' +%F)/
done
