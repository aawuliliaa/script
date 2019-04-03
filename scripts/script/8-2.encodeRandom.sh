#!/bin/bash
##############################################################
# File Name: 8.encodeRandom.sh
# Version: V1.0
# Author: vita
# Organization: 
# Created Time : 2019-04-01 16:08:14
# Description:
##############################################################
array=(21029299 00205d1c a3da1677 1f6d12dd 890684b)

for i in {1..32767};do
    echo "$i $(echo "$i"|md5sum)">>log/encode.log
done

for md5Num in ${array[*]};do
    echo "$(grep "$md5Num" log/encode.log)"
done
