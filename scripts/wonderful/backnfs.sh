#!/bin/bash
#description:back file to the directory of /backup
#author:vita
#time:2019-04-02
IP=$(/sbin/ifconfig eth1|egrep -o "([0-9]+.){3}[0-9]+"|head -n 1)
DIR="/var/www/html /server/scripts /app/logs /etc/rc.d/rc.local /var/spool/cron/root"
TIME=$(date +%F-%w)
BACDIR=/backup/$IP/$IP-$TIME
MD5LOG=/backup/$IP/md5log
[ -d $BACDIR ]||mkdir -p $BACDIR
[ -d $MD5LOG ]||mkdir -p $MD5LOG
cd /backup/$IP
for dir in $DIR
do 
    cp -r $dir $BACDIR
done
tar -zcf $IP-$TIME.tar.gz $BACDIR 
md5sum $IP-$TIME.tar.gz >$MD5LOG/md5${TIME}.log
rm -rf $BACDIR
/usr/bin/rsync -avz /backup/ rsync_backup@172.16.1.41::backup --password-file=/etc/rsync.password
####store files those within 7 days
for file in $(find /backup -mtime +7)
do
    rm -rf $file
done
