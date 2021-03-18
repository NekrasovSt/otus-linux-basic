#!/bin/bash

#============================================================
# Установка Apache и развертывание WordPress
#============================================================

if [ "$EUID" -ne 0 ]
then
    echo "Нужны повыщенные привелегии, используйте sudo"
    exit
fi
setenforce 0
sed -i -e 's/SELINUX=enforcing/SELINUX=disabled/; s/SELINUX=permissive/SELINUX=disabled/' /etc/selinux/config

yum install wget curl -y

echo "Устанавливаем Apache"
yum install httpd -y

echo "Скачиваем и распаковываем WordPress"
wget https://ru.wordpress.org/latest-ru_RU.tar.gz
mkdir /var/www/wordpress
tar -xzvf latest-ru_RU.tar.gz -C /var/www/
cp -f wordpress.conf /etc/httpd/conf.d/
sudo yum install php php-cli php-mysqlnd php-json php-gd php-ldap php-odbc php-pdo php-opcache php-pear php-xml php-xmlrpc php-mbstring php-snmp php-soap php-zip -y
cp wp-config.php /var/www/wordpress
systemctl enable httpd
systemctl start httpd