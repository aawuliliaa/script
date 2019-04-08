#!/bin/bash
##############################################################
# File Name: test.sh
# Version: V1.0
# Author: vita
# Organization: 
# Created Time : 2019-04-04 08:38:09
# Description:
##############################################################

identifyIp() {
   remoteIp=$1
   ipOrNot=$(echo "$remoteIp"|egrep '^([0-9]{1,3}\.){3}([0-9]{1,3})$'|wc -l)
   [ $ipOrNot -eq 0 ]&&{
       echo "$remoteIp is invalid!"
       exit
   }
   ping -c 1 -t 1 $remoteIp &>/dev/null
   [ $? -ne 0 ]&&{
       echo "$remoteIp is unreachable!"
       exit
   }
}
judgePath() {
    path=$1
    validNum=$(echo "$path" |egrep '^/.*'|wc -l) 
    [ $validNum -eq 0 ]&&{
        echo "the path you input must begin with /!"
        exit
    }
}
localPathExistOrNot() {
    localpath=$1
    [ -d $localPath ]||{
        echo "localPath $localPath is not exsit!"
        exit
    }
}
remotePathExistOrNot() {
    remotePath=$1
    remoteHost=$2
    result=$(ssh $remoteHost [ -d $remotePath ]&&echo 1||echo 0) 
    [ $result -eq 0 ]&&{
        echo " remotePath $remotePath is not exist"
        exit
    }
}
identifyArg() {
    if [ -z $port ]||[ -z "$localPath" ]||[ -z "$user" ]||[ -z $remoteHost ]||[ -z $remotePath ];then
        echo "Usage $0:-p port -l localPath -u remoteUser -h remoteHost -r remotePath"
        exit
    else
        identifyUser
        remotePathExistOrNot $remotePath $remoteHost
       
    fi
}
identifyUser() {
    ssh $remoteHost id $user &> /dev/null
    [ $? -ne 0 ]&&{
        echo "remoteUser $user is not exist!"
        exit
    }
}
main() {
    while getopts l:u:h:r:p: name
    do
    case $name in
        l)
            localPath=$OPTARG
            judgePath $localPath
            localPathExistOrNot $localPath
            ;;
        u)
            user=$OPTARG
            ;;
        h)
            remoteHost=$OPTARG
            identifyIp $remoteHost
            ;;
        r)
            remotePath=$OPTARG
            judgePath $remotePath
 #           remotePathExistOrNot $remotePath
            ;;
        p)
            port=$OPTARG
            ;;
        :)
            echo "the option $OPTARG require an argument!"
            exit
            ;;
        *)
            echo "invalid iption: $OPTARG"
            exit
    esac
    done
    identifyArg
    scp -r -P $port $localPath $user@$remoteHost:$remotePath
}
main $*
