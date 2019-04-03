#!/bin/bash
#description:set up zabbix agent
#author:vita
#centos6客户端操作
rpm -ivh https://mirrors.aliyun.com/zabbix/zabbix/3.0/rhel/6/x86_64/zabbix-release-3.0-1.el6.noarch.rpm
yum install zabbix-agent -y
sed -i.ori 's#127.0.0.1#172.16.1.51#' /etc/zabbix/zabbix_agentd.conf

sed -i '$a HostMetadataItem=system.uname' /etc/zabbix/zabbix_agentd.conf
sed -i "s#Zabbix server#$(hostname)#g" /etc/zabbix/zabbix_agentd.conf
sed -i '$a 172.16.1.51 zabbix-proxy' /etc/hosts
service zabbix-agent restart

chkconfig zabbix-agent on
/etc/init.d/zabbix-agent start
