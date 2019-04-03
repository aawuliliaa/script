#!/bin/bash
##############################################################
# File Name: checkUrl.sh
# Version: V1.0
# Author: vita
# Organization: 
# Created Time : 2019-03-30 16:54:46
# Description: check whether the url i accessed
##############################################################
usage() {
    echo "Usage:$0 url"
    exit 1
}
checkUrl() {
    /usr/bin/curl -s -t 3  -o /dev/null $1
    [ $? -eq 0 ]&&{
        echo "url $1 is accessed!"
        exit 2
    }||{
        echo "url $1 is not accessed!"
        exit 3
    }
}
main(){
    [ $# -ne 1 ]&&{
        usage
    }
    checkUrl $1
}
main $*
