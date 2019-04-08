#!/bin/bash
##############################################################
# File Name: monitor.sh
# Version: V1.0
# Author: vita
# Organization: 
# Created Time : 2019-04-02 21:22:30
# Description:
##############################################################
localIp=$(ifconfig eth0|grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}'|head -1)
###判断输入是否为空
isNull() {
    [ -z "$1" ]&&{
    echo "you must input something!" 
    exit
    } 
}
###判断输入是否为数字
isNotNum() {
    expr $1 + 2 &>/dev/null
    [ $? -ne 0 ]&&{
        echo "you can just input one number!"
        exit
    }
}
checkService() {
cat <<EOF
1.php
2.mysql
3.exit
EOF
    read -p "please input your choice:" yourChoice
    isNull "$yourChoice"
    isNotNum "$yourChoice"
    case $yourChoice in
        1)
            curl 127.0.0.1/phpfpm_status
            ;;
        2)
            /application/mysql/bin/mysql -uroot -poldboy123 -e "show status;"
            ;;
        3)
            exit
            ;;
        *)
             echo "invalid input"
             exit
    esac
}
checkUrl() {
    read -p "please input url:" url
    [ -z "$url" ]&&{
        echo "you should input your url!"
        exit
    }
    curl $url -s &>/dev/null
    [ $? -eq 0 ]&&{
        echo "$url is accessable!"
    }||{
        echo "$url is unaccessable!"
    }
}
checkMem() {
    free -m
}
checkIo() {
    iostat
}
checkCpu() {
    top -b -n 1|grep Cpu
}
checkNet() {
    cat /proc/net/dev
}
checkTcp() {
    netstat -antlp|egrep -v 'State|Active'|awk '{state[$6]++}END{for(key in state)print key,state[key]}'
    netstat -antlp|egrep -v 'State|Active'|awk -F '[ :]+' '{state[$6]++}END{for(key in state)print key,state[key]}'|grep  -E '([0-9]{1,3}\.){3}[0-9]{1,3}'
   
}
checkNginx() {
    curl 127.0.0.1/nginx_status
}
monitor() {
    case $1 in
        1)checkService;;
        2)checkUrl;;
        3)checkMem;;
        4)checkIo;;
        5)checkCpu;;
        6)checkNet;;
        7)checkTcp;;
        8)checkNginx;;
        9)exit
    esac
}
main() {
cat <<EOF
1. Check service. ---> 监控进程；MySQL和PHP的监控，通过它来完成。例如 录入mysql，就输出MySQL目前的性能情况；
2. Check url.  ---> 是否有效，url 地址参数化；
3. Check mem.  ---> Mem的使用情况、类似Top；
4. Check io.   ---> IO的负载、类似Top；
5. Check cpu.  ---> CPU的负载、类似Top；
6. Check net.  ---> 网络的监控，输出多个网卡的发送和接收速率；
7. Check tcp.  ---> 半链接数、链接数、来源IP；
8. Check nginx.  ---> 通过nginx的status页面获取对应的信息
9.Exit
EOF
read -p "please input your chose:" yourChose
    isNull "$yourChose"
    isNotNum "$yourChose"
    monitor $yourChose
}
main
