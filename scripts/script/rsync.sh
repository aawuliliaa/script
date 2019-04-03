#!/bin/bash
# chkconfig: 2345 13 89
#description: rsync start|stop|restart
##############################################################
# File Name: rsync.sh
# Version: V1.0
# Author: vita
# Organization: 
# Created Time : 2019-03-30 19:46:19
# Description:
##############################################################
###参考系统服务的脚本，创建或删除相应的锁文件
lockfile=/var/lock/subsys/rsyncd
pid_file=/var/run/rsyncd.pid
source /etc/init.d/functions
#用于判断启动或停止或重启是否成功
judge() {
    retval=$?
    if [ $retval -eq 0 ];then
        action "$1 rsync" /bin/true
        if [ "$1" == "start" ];then
###########启动成功创建锁文件
            touch $lockfile      
        else [ "$1" == "stop" ]
###########停止成功删除锁文件
            rm -rf $lockfile
        fi
    else
        action "$1 rsync" /bin/false
    fi
    return $retval
}
start() {
    if test -s "$pid_file";then
        echo "$pid_file has already exist or rsync has already been started"
        return
    else
        rsync --daemon
        judge start
        return
    fi
}
stop() {
####如果pid_file文件存在，且至少含有一个字符
    if test -s "$pid_file";then
        rsyncd_pid=$(cat $pid_file)
########如果该进程号的进程存在
        if (kill -0 $rsyncd_pid);then
            kill $rsyncd_pid
             judge stop
        else
             echo "rsync process is not exist."
             cat /dev/null>$pid_file
             return 2
        fi
    else
#####pid_file文件不存在，则显示进程不存在
        echo "$pid_file is not exist or rsync process is not startup"
        return 3
    fi
}
restart() {
    stop
    sleep 10
    start
}
case $1 in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        restart
        ;;
    *)
        echo "Usage:$0 start|stop|restart"
        exit 1
esac
