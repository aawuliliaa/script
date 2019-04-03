#!/bin/bash
##############################################################
# File Name: logAnalyse.sh
# Version: V1.0
# Author: vita
# Organization: 
# Created Time : 2019-04-02 16:09:23
# Description:
##############################################################
setIptables() {
    awk '{IP[$1]++}END{for (key in IP) print key,IP[key]}' ./log/access.log>./log/dosResult.log
    exec < ./log/dosResult.log
    while read line;do
        times=$(echo "$line"|awk '{print $2}')
        ip=$(echo "$line"|awk '{print $1}')
        if [ $times -gt 10 ];then
            iptables -A INPUT -s $ip -j DROP
            echo -e "=============iptables set is===============\niptables -A INPUT -s $ip -j DROP">>./log/mail.log
        fi
    done
}

calculateRate() {
    sum=0
    exec <./log/access.log
    while read line;do
        rate=$(echo "$line"|awk '{print $10}')
        expr $rate + 2 &>/dev/null
        [ $? -eq 0 ]&&sum=$(($sum+$rate))
    done
    echo -e "===========the sum rate of today is===========:\n $sum">>./log/mail.log
}
calculatePv() {
    echo "===========Pv number is===========">>./log/mail.log
    awk '{PV[$7]++}END{for (pv in PV)print pv,PV[pv]}' ./log/access.log>>./log/mail.log
}
main() {
    setIptables
    calculateRate
    calculatePv
    mail -s "the result of log analyse" linuxengineerofwu@163.com<./log/mail.log
    cat /dev/null>./log/mail.log
}
main
