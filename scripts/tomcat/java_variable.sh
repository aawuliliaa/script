#!/bin/bash 
#description:reset and set java variable
#autor:vita
#varsion:v1
###用于判断是否配置了JAVA环境变量
num=$(grep 'JAVA_HOME' /etc/profile|wc -l)
###养成备份的好习惯
cp /etc/profile /etc/profile$(date +%F).bak
add_javavariable () {
    ####添加JAVA环境变量
    echo -e 'JAVA_HOME=/application/tomcat/jdk1.7.0_80\nJRE_HOME=/application/tomcat/jdk1.7.0_80/jre\nCLASSPATH=$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib'>>/etc/profile
    ####添加到PATH中
    sed -ir '/^PATH/s#^PATH.*#&:$JAVA_HOME/bin:$JRE_HOME/bin#g' /etc/profile
}
remove_javavariable () {
    ####删除新加的JAVA变量，并恢复PATH
    sed -ir '/^JAVA_HOME/,/CLASSPATH/d' /etc/profile
    sed -rie '/^PATH/s#(^PATH.*)(:\$JAVA_HOME.*)#\1#g' /etc/profile
}
###为0,说明没有配置JAVA环境变量
if [ $num -eq 0 ];then
    add_javavariable
fi
###大于0，说明已经配置了JAVA环境变量
if [ $num -gt 0 ];then
    remove_javavariable
    add_javavariable
fi
###备份的同时，也要记得删除哦
for file in $(find /etc -type f -name profile*.bak -mtime +7)
do
    rm -rf $file
done
###要把环境变量加到启动脚本中才能启动
sed -inr '/^cygwin/i JAVA_HOME=/application/tomcat/jdk1.7.0_80\nJRE_HOME=/application/tomcat/jdk1.7.0_80/jre\nCLASSPATH=$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib' /application/tomcat/tomcat/bin/catalina.sh
