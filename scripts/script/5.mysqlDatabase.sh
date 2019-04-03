#!/bin/bash
##############################################################
# File Name: 5.mysqlDatabase.sh
# Version: V1.0
# Author: vita
# Organization: 
# Created Time : 2019-04-01 15:11:51
# Description:
##############################################################

mysqlCommand=/application/mysql/bin/mysql
mysqlDump=/application/mysql/bin/mysqldump
databases=$($mysqlCommand -uroot -poldboy123 -e "show databases" 2>/dev/null |grep -Ev 'Database|schema')
for database in $databases;do
    $mysqlDump -uroot -poldboy123 -B $database|gzip>${database}.sql.gz
done

