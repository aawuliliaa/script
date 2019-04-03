#!/bin/bash
##############################################################
# File Name: scp.sh
# Version: V1.0
# Author: vita
# Organization: 
# Created Time : 2019-04-02 17:00:11
# Description:
##############################################################
judgePath() {
    path=$1
    validNum=$(echo "$path" |egrep '^/.*'|wc -l) 
    [ $validNum -eq 0 ]&&{
        echo "the path you input must begin with /!"
        exit
    }
}
remotePathExistOrNot() {
    remotePath=$1
    result=$(ssh 172.16.1.7 [ -d $remotePath ]&&echo 1||echo 0) 
    [ $result -eq 0 ]&&{
        echo " remotePath $remotePath is not exist"
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
main () {
    localPath=$1
    remotePath=$2
    [ $# -ne 2 ]&&{
        echo "Usage$0 localPath remotePath"
    }
    judgePath $localPath
    judgePath $remotePath
    remotePathExistOrNot $remotePath
    localPathExistOrNot $localPath
    scp -r $localPath root@172.16.1.7:$remotePath
}
main $*
