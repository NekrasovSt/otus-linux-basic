#!/bin/bash
if [ "$EUID" -ne 0 ]
then
    echo "Нужны повыщенные привелегии, используйте sudo"
    exit
fi

yum install -y iptables
iptables -F
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
# Apache
iptables -A INPUT -p tcp -m tcp --dport 8000 -j ACCEPT
# Node exporter
iptables -A INPUT -p tcp -m tcp --dport 9100 -j ACCEPT
# Prometheus
iptables -A INPUT -p tcp -m tcp --dport 9090 -j ACCEPT
# Grafana
iptables -A INPUT -p tcp -m tcp --dport 3000 -j ACCEPT
# MySql
iptables -A INPUT -p tcp -m tcp --dport 3306 -j ACCEPT
iptables -P INPUT DROP
iptables-save