#!/bin/bash
#description:backup
#author:vita
#time:2019-0402
##store the file which is at satuday,and for other files,store 180days
deleteTar() {
    for file in $(find /backup -name "*.tar.gz" -mtime +180)
    do
        week=$(echo "$file"|awk -F '[-.]' '{print $8}')
        if [ $week -ne 6 ];then
            rm -rf $file
        fi
    done
}
deleteLog() {
##delete md5 log,store the same time with the tar package
    for file in $(find /backup -name "*.log" -mtime +180)
    do
        week=$(echo "$file"|awk -F '[-.]' '{print $4}')
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
        md5sum -c md5log/md5$TIME.log>>/opt/md5log/result$TIME.log
    done
    ##发送邮件
    mail -s "the result of back" linuxengineerofwu@163.com </opt/md5log/result$TIME.log
    deleteTar
    deleteLog
}
main
