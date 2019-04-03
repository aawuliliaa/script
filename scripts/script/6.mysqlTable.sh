#!/bin/bash
##############################################################
# File Name: 6.mysqlTable.sh
# Version: V1.0
# Author: vita
# Organization: 
# Created Time : 2019-04-01 15:39:12
# Description:
##############################################################
mysqlCommand="/application/mysql/bin/mysql  -uroot -poldboy123"
mysqlDump="/application/mysql/bin/mysqldump  -uroot -poldboy123"
databases=$($mysqlCommand  -e "show databases;" 2>/dev/null |grep -Ev 'Database|schema')
for database in $databases;do
    for table in $($mysqlCommand -e "show tables from $database;" 2>/dev/null|sed 1d );do
       
        $mysqlDump  -B $database $table |gzip>./log/${database}_${table}.sql.gz 2>/dev/null
    done
done

