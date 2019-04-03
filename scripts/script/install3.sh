#!/bin/bash
##############################################################
# File Name: install3.sh
# Version: V1.0
# Author: vita
# Organization: 
# Created Time : 2019-03-30 17:24:35
# Description:
##############################################################
source ./color.sh
notNum() {
    #echo "you must input one number"
    sh color.sh yellow "you must input one number"
    exit 1
}
install() {
    case "$1" in
        "1")
            #echo "start to install lamp"
            sh color.sh blue "start to install lamp"
            exit 3
            ;;
        "2")
           # echo "start to install lnmp"
           sh color.sh blue "start to install lnmp" 
            exit 4
            ;;
        "3")
           # echo "exit"
           sh  color.sh blue "exit" 
            exit 5
            ;;
        *)
           #echo "you can just input 1|2|3"
           sh color.sh yellow "you can just input 1|2|3" 
            exit 6
    esac
}
main(){
cat <<EOF
1.install lamp
2.install lnmp
3.exit
EOF
    read -p "please input one number:" num
    expr $num + 2 &>/dev/null
    if [ $? -ne 0 ]||[ -z "$num" ];then
        notNum   
    fi
    install $num
}
main $*
