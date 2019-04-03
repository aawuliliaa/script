#!/bin/bash
##############################################################
# File Name: random.sh
# Version: V1.0
# Author: vita
# Organization: 
# Created Time : 2019-04-01 08:49:05
# Description:
##############################################################
##生成一个随机数，一定要放在while循环外，否则每次都生成一个
ranNum=$(echo $RANDOM%60|bc)
count=0
while true
do
#    输入数字，如果什么都不输入，重新开始循环
    read -p "please input your num,you can also input [e] to exit:" yourNum
    [ -z "$yourNum" ]&&{
    echo “you must input something!”
    continue
}
###如果输入不是e，判断是否是数字，如果输入是数字，进行比较，否则退出本次循环
    if [ "e" != $yourNum ];then
        expr $yourNum + 2 &>/dev/null
        [ $? -ne 0 ]&&{
        echo "you can just input one num!"
        continue
        }
    else
#######输入是e,可以选择是否退出游戏
        read -p "are you sure you want to exit?[Y/N]:" yourChose
        case $yourChose in
            Y)
                echo "your chose is "Y";you will exit now!"
                exit 2
                ;;
            y)
                echo "your chose is "y";you will exit now!"
                exit 3
                ;;
            N)
                echo "your chose is "N";you can continue!"
                continue
                ;;
            n)
                echo "your chose is "n";you can continue!"
                continue
                ;;
            *)
                echo "you can just input [Y|y|N|n],please input again!"
                continue
            esac
    
    fi
###进行判断
    if [ $ranNum -gt $yourNum ];then
        echo "your num is too small!"
        count=$(echo $(($count+1)))
        continue
    elif [ $ranNum -lt $yourNum ];then
        echo "your num is too big!"
        count=$(echo $(($count+1)))
        continue
    else [ $ranNum -eq $yourNum ]
        count=$(echo $(($count+1)))
        echo "bingo,congratulatons!your num is right!you have used $count chances!"
        exit 1
    fi
done
