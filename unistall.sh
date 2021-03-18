#!/bin/bash

#============================================================
# Удаление установленных программ
#============================================================

if [ "$EUID" -ne 0 ]
then
    echo "Нужны повыщенные привелегии, используйте sudo"
    exit
fi

echo "Удалить Apache? (Y/n)"
read answer
if [ $answer != "n" ]
    then 
    echo "Удаляем Apache"
    systemctl stop httpd
    yum remove httpd php php-cli php-mysqlnd php-json php-gd php-ldap php-odbc php-pdo php-opcache php-pear php-xml php-xmlrpc php-mbstring php-snmp php-soap php-zip -y
    rm -rf /var/log/httpd

    echo "Удаляем WordPress"
    rm -r /var/www/wordpress
    rm /etc/httpd/conf.d/wordpress.conf   
fi

echo "Удалить MySql? (Y/n)"
read answer
if [ $answer != "n" ]
    then
    echo "Удаляем MySql"
    systemctl stop mysqld
    yum remove mysql-server -y
    rm -f /etc/my.cnf
    rm -rf /etc/mysql/
    rm -rf /var/log/mysql
    rm -rf /var/lib/mysql
    rm -rf /etc/cron.daily/mysql-backup.sh
    rm -rf /var/backups
fi

echo "Удалить Nginx? (Y/n)"
read answer
if [ $answer != "n" ]
    then
    echo "Удаляем Nginx"
    systemctl stop nginx
    yum remove nginx -y
    rm -rf /etc/nginx/
    rm -rf /var/log/nginx/
fi

echo "Удалить систему мониторинга? (Y/n)"
read answer
if [ $answer != "n" ]
    then
    echo "Удаляем систему мониторинга"
    systemctl stop prometheus
    systemctl disable prometheus
    userdel prometheus
    rm -rf /etc/prometheus
    rm -rf /var/lib/prometheus
    rm -rf /usr/local/bin/prometheus
    rm -r prometheus-*
    
    systemctl stop node_exporter
    systemctl disable node_exporter
    userdel node_exporter
    rm -r node_exporter-*
    rm -rf /usr/local/bin/node_exporter

    systemctl disable grafana-server
    systemctl stop grafana-server
    yum remove -y grafana
    rm -r grafana*
    rm -r /etc/grafana/
    rm -r /var/lib/grafana/
fi

echo "Удалить iptables? (Y/n)"
read answer
if [ $answer != "n" ]
    then
    yum remove -y iptables
fi