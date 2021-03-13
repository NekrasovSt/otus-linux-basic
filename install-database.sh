#!/bin/bash
if [ "$EUID" -ne 0 ]
then
    echo "Нужны повыщенные привелегии, используйте sudo"
    exit
fi

echo "Установка MySql"
yum install mysql-server -y
systemctl enable mysqld
systemctl start mysqld

function ask() {
    read answer
    if [ $answer = "y" ]
    then
        $1  
    fi
}
function master() {
    echo "Установка мастер ноды"
    mysql -e "CREATE DATABASE IF NOT EXISTS wordpress;"
    mysql -e "CREATE USER IF NOT EXISTS 'wordpressuser'@'%' IDENTIFIED BY 'P@ssw0rd';"
    mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'%';"
    mysql -e "CREATE USER IF NOT EXISTS 'repl'@'%' IDENTIFIED BY 'P@ssw0rd';"
    mysql -e "GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%';"
}
function slave() {
    echo "Установка славе ноды"
    mysql -e "set global server_id = 2;"
    echo "Укажите IP мастера (185.177.92.101)"
    read master_ip
    if [ ! $master_ip ]
    then
        master_ip="185.177.92.101"
    fi
    mysql -e "CHANGE MASTER TO MASTER_HOST='$master_ip', MASTER_USER='repl', MASTER_PASSWORD='P@ssw0rd', MASTER_LOG_FILE='binlog.000001', MASTER_LOG_POS=1, GET_MASTER_PUBLIC_KEY = 1;"
    #echo "innodb_read_only = 1;" >> /etc/my.cnf
    mysql -e "START SLAVE;"
    mkdir /var/backups
    cp mysql-backup.sh /etc/cron.daily/
    chmod ugo+x /etc/cron.daily/mysql-backup.sh
}
echo "Мастер нода? (y/N)"
read answer
if [ $answer = "y" ]
    then
        master
    else
        slave      
    fi