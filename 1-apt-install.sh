#!/bin/bash

echo "Running package installation"

apt update -y && apt install wget -y
wget https://repo.zabbix.com/zabbix/4.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_4.2-2+bionic_all.deb
dpkg -i zabbix-release_4.2-2+bionic_all.deb
dpkg --path-include='/usr/share/doc/*/*' -i zabbix-server-mysql*
apt update
apt install -y mariadb-server mariadb-client zabbix-server-mysql nginx zabbix-frontend-php zabbix-agent php-fpm php-mysql

echo "package installation complete"
