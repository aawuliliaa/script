#!/bin/bash
##############################################################
# File Name: logAnalyse.sh
# Version: V1.0
# Author: vita
# Organization: 
# Created Time : 2019-04-02 16:09:23
# Description:
##############################################################
identifyVar() {
    [ $# -ne 2 ]&&{
        echo "Usage $0 logfile ipNums"
        exit
    }
    [ -f $logfile ]||{
        echo "$logfile is not exist!"
        exit
    }
    expr $ipNums + 2 &>/dev/null
    [ $? -ne 0 ]&&{
        echo "the second variable must be a number!"
        exit
    }

}
setIptables() {
    logfile=$1
    ipNums=$2
    awk '{IP[$1]++}END{for (key in IP) print key,IP[key]}' $logfile>./log/dosResult.log
    exec < ./log/dosResult.log
    while read line;do
        times=$(echo "$line"|awk '{print $2}')
        ip=$(echo "$line"|awk '{print $1}')
        if [ $times -gt $ipNums ];then
            iptables -A INPUT -s $ip -j DROP
            echo -e "=============iptables set is===============\niptables -A INPUT -s $ip -j DROP">>./log/mail.log
        fi
    done
}

calculateRate() {
    logfile=$1
    sum=0
    exec < $logfile
    while read line;do
        rate=$(echo "$line"|awk '{print $10}')
        expr $rate + 2 &>/dev/null
        [ $? -eq 0 ]&&sum=$(($sum+$rate))
    done
    echo -e "===========the sum rate of today is===========:\n $sum">>./log/mail.log
}
calculatePv() {
    logfile=$1
    echo "===========Pv number is===========">>./log/mail.log
    awk '{PV[$7]++}END{for (pv in PV)print pv,PV[pv]}' $logfile>>./log/mail.log
}
main() {
    logfile=$1
    ipNums=$2
    identifyVar $*
    setIptables $logfile $ipNums 
    calculateRate $logfile
    calculatePv $logfile
    cat ./log/mail.log
    cat /dev/null>./log/mail.log
}
main $*
