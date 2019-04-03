#!/bin/bash
#description:back file to the directory of /backup
#author:vita
#time:2019-03-04
[ -d /data/luffy ]||mkdir -p /data/luffy
touch /data/luffy/oldboy.txt
echo "net addr:10.0.0.8 Bcast:10.0.0.255 Mask:255.255.255.0">/data/luffy/luffy.txt
