#!/bin/bash
##############################################################
# File Name: color.sh
# Version: V1.0
# Author: vita
# Organization: 
# Created Time : 2019-03-30 18:32:41
# Description:
##############################################################
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
blue="\033[34m"
tal="\033[0m"
case $1 in 
    red)
        echo -e "${red}${2}${tal}"
        ;;
    green)
        echo -e "${green}${2}${tal}"
        ;;
    yellow)
        echo -e "${yellow}${2}${tal}"
        ;;
    *)
        echo -e "${blue}${2}${tal}"
esac
 

