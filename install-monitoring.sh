#!/bin/bash
if [ "$EUID" -ne 0 ]
then
    echo "Нужны повыщенные привелегии, используйте sudo"
    exit
fi

echo "Устанавливаю Node exporter"
useradd --no-create-home --shell /bin/false node_exporter
wget https://github.com/prometheus/node_exporter/releases/download/v1.1.1/node_exporter-1.1.1.linux-amd64.tar.gz
tar -xzvf node_exporter-1.1.1.linux-amd64.tar.gz
cp node_exporter-1.1.1.linux-amd64/node_exporter /usr/local/bin
chown node_exporter: /usr/local/bin/node_exporter
cp node_exporter.service /etc/systemd/system
systemctl daemon-reload
systemctl enable node_exporter
systemctl start node_exporter


echo "Установить prometheus? (y/N)"
read answer
if [ $answer = "y" ]
    then
    echo "Устанавливаю prometheus"
    useradd --no-create-home --shell /bin/false prometheus
    mkdir /etc/prometheus
    mkdir /var/lib/prometheus
    
    chown -R prometheus: /var/lib/prometheus
    wget https://github.com/prometheus/prometheus/releases/download/v2.25.0/prometheus-2.25.0.linux-amd64.tar.gz
    tar -xzvf prometheus-2.25.0.linux-amd64.tar.gz
    cp -rv prometheus-2.25.0.linux-amd64/{console{_libraries,s},prometheus.yml} /etc/prometheus/
    chown -R prometheus:prometheus /etc/prometheus
    cp prometheus.yml /etc/prometheus
    cp -v prometheus-2.25.0.linux-amd64/prom{etheus,tool} /usr/local/bin/
    chown -R prometheus:prometheus /etc/prometheus /usr/local/bin/prom{etheus,tool} /var/lib/prometheus    
    cp prometheus.service /etc/systemd/system
    systemctl daemon-reload
    systemctl enable prometheus
    systemctl start prometheus

    echo "Устанавливаю grafana"
    wget https://dl.grafana.com/oss/release/grafana-7.4.3-1.x86_64.rpm
    yum install -y grafana-7.4.3-1.x86_64.rpm
    systemctl daemon-reload
    systemctl enable --now grafana-server
    # 11074
fi



