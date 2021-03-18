#!/bin/bash

#============================================================
# Установка nginx и настройка дочерних нод
#============================================================

if [ "$EUID" -ne 0 ]
then
    echo "Нужны повыщенные привелегии, используйте sudo"
    exit
fi

echo "Установка Nginx"
yum install nginx -y
cp upstream.conf /etc/nginx/conf.d/
echo "Укажите IP первой ноды (185.177.92.101)"
read answer
if [ ! $answer ]
then
    answer="185.177.92.101"
fi
sed -i -e "s/ip1/$answer/" /etc/nginx/conf.d/upstream.conf
answer=""

echo "Укажите IP второй ноды (185.177.93.182)"
read answer
if [ ! $answer  ]
then
    answer="185.177.93.182"
fi
sed -i -e "s/ip2/$answer/" /etc/nginx/conf.d/upstream.conf
sed -i "47a\            proxy_pass http://httpd;" /etc/nginx/nginx.conf
sed -i "47a\            proxy_set_header Host \$host;" /etc/nginx/nginx.conf
systemctl enable nginx
systemctl start nginx