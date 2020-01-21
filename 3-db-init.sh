#!/bin/bash

/etc/init.d/mysql restart
sleep 5

echo "Creating database zabbix"
mysql -v <<SQL
CREATE DATABASE zabbix CHARACTER SET UTF8 COLLATE UTF8_BIN;
CREATE USER zabbix@localhost IDENTIFIED BY 'zabbix';
GRANT ALL PRIVILEGES ON zabbix.* TO zabbix@localhost;
FLUSH PRIVILEGES;
SQL

echo "Applying scheme"
zcat /usr/share/doc/zabbix-server-mysql/create.sql.gz | mysql -D zabbix

#setup zabbix server DB Password
sed -i '124 s/# DBPassword=/DBPassword=zabbix/' /etc/zabbix/zabbix_server.conf
