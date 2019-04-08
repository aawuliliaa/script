#!/bin/bash
#description:backup
#author:vita
#time:2019-0402
##store the file which is at satuday,and for other files,store 180days
delete() {
    for file in $(find /backup -type f -mtime +180)
    do
        week=$(echo "$file"|awk -F '[-.]' '{print $8}')
        if [ $week -ne 6 ];then
            rm -rf $file
        fi
    done
}
main() {
    [ -d "/opt/md5log" ]||mkdir -p /opt/md5log
    TIME=$(date +%F-%w)
    for dir in $(ls /backup);do
        cd /backup/$dir
        echo "=========identify result of $dir===========">>/opt/md5log/result$TIME.log
    ###identify the file 
        md5sum -c md5log/md5$dir-$TIME.log>>/opt/md5log/result$TIME.log
    done
    ##发送邮件
    mail -s "the result of back" linuxengineerofwu@163.com </opt/md5log/result$TIME.log
    rm -rf /opt/md5log/result$TIME.log
    delete
}
main
