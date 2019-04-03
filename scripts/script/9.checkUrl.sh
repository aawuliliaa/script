#!/bin/bash
##############################################################
# File Name: 9.checkUrl.sh
# Version: V1.0
# Author: vita
# Organization: 
# Created Time : 2019-04-01 17:12:15
# Description:
##############################################################
source /etc/init.d/functions
url_list=(
http://blog.oldboyedu.com
http://blog.etiantian.org
http://oldboy.blog.51cto.com
http://10.0.0.7
)
checkUrl() {
    curl -s -t 3 -o /dev/null $1
    [ $? -eq 0 ]&&{
        action "$1 can be accessed!" /bin/true
    }||{
        action "$1 can not be accessed!" /bin/false
    }

}
dealUrl() {
    for url in ${url_list[*]};do
        checkUrl $url
    done
}
main() {
    dealUrl
}
main
