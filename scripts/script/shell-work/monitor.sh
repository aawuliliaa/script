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
loadMonitor() {
#    localIp=$(ifconfig eth0|grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}'|head -1)
    cpuNum=$(grep -c 'model name' /proc/cpuinfo)
    loadFifteen=$(uptime|awk '{print $NF}')
    avgLoad=$(echo "$loadFifteen $cpuNum "|awk '{print $1/$2}')
    loadWarnNum=0.75
    [ $(echo "$avgLoad>$loadWarnNum"|bc) -eq 1 ]&&{
    echo "$localIp-----the avgload wthin 15 minutes is bigger than 75% ">>./log/monitor.log
    }
}
cpuIdle() {
    cpuIdle=$(top -b -n 1 | grep Cpu|awk -F '[ %]+' '{print $8}')
    cpuIdleWarnNum=20
    [ $(echo "$cpuIdle<$cpuIdleWarnNum"|bc) -eq 1 ]&&{
    echo "$localIp-----the cpu idle is less than 20%">>./log/monitor.log
    }
}
memUsed() {
    memUsed=$(free -m|awk 'NR==3{print $0}'|awk '{print $3/($4+$3)}')
    memWarnNum=0.75
    [ $(echo "$memUsed>$memWarnNum"|bc) -eq 1 ]&&{
    echo "$localIp------the memFree is less than 25%">>./log/monitor.log
    }
}
swampUsed() {
    swampUsed=$(free -m|awk 'NR==4{print $0}'|awk '{print $3/$2}')
    swampWarnNum=0.50
    [ $(echo "$swampUsed>$swampWarnNum"|bc) -eq 1 ]&&{
    echo "$localIp-------the swampUsed has bigger than 50%">>./log/monitor.log
    }
}
monitorProcess() {
    serverName=$1
    processNum=$(ps -ef|grep $serverName|grep -v "grep"|wc -l)
    [ $processNum -eq 0 ]&&{
         echo "$localIp-----the $serverName process is not exist!">>./log/monitor.log
    }
}
monitorPort() {
    
    serverName=$1
    port=$2
    portNum=$(lsof -i:$port|wc -l)
    [ $portNum -lt 2 ]&&{
        echo "$localIp------the port $serverName--$port not exist!">>./log/monitor.log
    }
}
checkNginx() {
    monitorProcess nginx
    monitorPort nginx 80
}
checkMysql() {
    monitorProcess mysql
    monitorPort mysql 3306
}
checkPhp() {
    monitorProcess php
    monitorPort php 9000
}
sendMail() {
    if test -s ./log/monitor.log;then
        mail -s "warning of $localIp" linuxengineerofwu@163.com <./log/monitor.log
        cat /dev/null>./log/monitor.log
    fi
}
main() {
    loadMonitor
    cpuIdle
    memUsed
    swampUsed
    checkNginx
    checkMysql
    checkPhp
    sendMail
}
main
