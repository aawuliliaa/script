#!/bin/bash
##############################################################
# File Name: install-lnmp.sh
# Version: V1.0
# Author: vita
# Organization: 
# Created Time : 2019-04-04 22:02:03
# Description:
##############################################################
###判断输入是否为空
isNull() {
    [ -z "$1" ]&&{
    echo "you must input something!" 
    exit
    } 
}
###判断输入是否为数字
isNotNum() {
    expr $1 + 2 &>/dev/null
    [ $? -ne 0 ]&&{
        echo "you can just input one number!"
        exit
    }
}

installMysql() {
    ##解压安装包
    cd /server/tools/
    tar xf mysql-5.6.34-linux-glibc2.5-x86_64.tar.gz
    mv mysql-5.6.34-linux-glibc2.5-x86_64 /application/mysql-5.6.34
    ##创建软连接
    ln -sf /application/mysql-5.6.34/ /application/mysql
    ##创建用户并授权
    useradd mysql -M -s /sbin/nologin 
    chown -R mysql.mysql /application/mysql/data/
    ##对数据库服务进行初始化
    /application/mysql/scripts/mysql_install_db --basedir=/application/mysql --datadir=/application/mysql/data/ --user=mysql
    ##启动MySQL
    cp /application/mysql/support-files/mysql.server /etc/init.d/mysqld
    sed -ri 's#/usr/local#/application#g' /etc/init.d/mysqld /application/mysql/bin/mysqld_safe
    cp /application/mysql/support-files/my-default.cnf /etc/my.cnf
    /etc/init.d/mysqld start
    ##设置root用户密码
    /application/mysql/bin/mysqladmin -uroot password "oldboy123"
}
installPhp() {
##第一里程：解决PHP软件的依赖关系 
yum install -y zlib-devel libxml2-devel libjpeg-devel libjpeg-turbo-devel libiconv-devel freetype-devel libpng-devel gd-devel libcurl-devel libxslt-devel
##安装libiconv-1.14
cd /server/tools

tar zxf libiconv-1.14.tar.gz
cd libiconv-1.14
./configure --prefix=/usr/local/libiconv
make
make install
cd ../

yum -y install libmcrypt-devel mhash mcrypt
cd /server/tools
tar xf php-5.5.32.tar.gz

cd php-5.5.32
./configure \
--prefix=/application/php-5.5.32 \
--with-mysql=/application/mysql-5.6.34 \
--with-pdo-mysql=mysqlnd \
--with-iconv-dir=/usr/local/libiconv \
--with-freetype-dir \
--with-jpeg-dir \
--with-png-dir \
--with-zlib \
--with-libxml-dir=/usr \
--enable-xml \
--disable-rpath \
--enable-bcmath \
--enable-shmop \
--enable-sysvsem \
--enable-inline-optimization \
--with-curl \
--enable-mbregex \
--enable-fpm \
--enable-mbstring \
--with-mcrypt \
--with-gd \
--enable-gd-native-ttf \
--with-openssl \
--with-mhash \
--enable-pcntl \
--enable-sockets \
--with-xmlrpc \
--enable-soap \
--enable-short-tags \
--enable-static \
--with-xsl \
--with-fpm-user=www \
--with-fpm-group=www \
--enable-ftp \
--enable-opcache=no


##防错(以下信息可以不进行配置，不过后面也会有报错信息提示进行如下操作，这里操作了可以防止报错)
ln -s /application/mysql/lib/libmysqlclient.so.18  /usr/lib64/
touch ext/phar/phar.phar
make
make install
ln -s /application/php-5.5.32/ /application/php


##第三个里程：设置PHP程序配置文件
cp php.ini-production /application/php-5.5.32/lib/
cd /application/php/etc/
cp php-fpm.conf.default php-fpm.conf

##第四个里程：启动php程序服务
/application/php/sbin/php-fpm

}
installNginx(){
    ##第一个里程：软件依赖包安装**
    yum install -y pcre-devel openssl-devel
    
    ##第二个里程：创建一个管理nginx进程的虚拟用户**
    useradd www -s /sbin/nologin/ -M
    
    ##第三个里程：下载并解压nginx软件**
    cd /server/tools
    tar xf nginx-1.12.2.tar.gz 
    cd nginx-1.12.2
    ##第四个里程：进行软件编译安装**
    ./configure --prefix=/application/nginx1.12.2 --user=www --group=www --with-http_ssl_module --with-http_stub_status_module
    make&&make install
    ##第五个里程：为nginx程序软件创建链接目录**
    ln -sf /application/nginx1.12.2/ /application/nginx	
    cp /server/scripts/script/nginx.conf /application/nginx/conf/
    cp -r /server/scripts/script/shop /application/nginx/html/
    ###第六个里程：启动nginx程序服务**
    /application/nginx/sbin/nginx
}
beforeInstall() {
    serverName=$1
    appDir=$2
    [ -d $appDir ]&&{
        echo "$serverName has already installed!"
        exit
    }
}
install() {
    case $1 in 
        1)
            beforeInstall mysql /application/mysql
            installMysql
            ;;
        2)
            beforeInstall php /application/php
            installPhp
            ;;
        3)
            beforeInstall nginx /application/nginx
            installNginx
            ;;
        4)
            exit
            ;;
        *)
            echo  "you can just input [1-4]!"
            exit
    esac
}
main() {
cat <<EOF
1.install Mysql
2.install Php
3.install nginx
4.exit
EOF
    read -p "please input your chose:" yourChose
    isNull "$yourChose"
    isNotNum "$yourChose"
    install   $yourChose
}

main $*
