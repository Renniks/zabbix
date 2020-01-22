#!/bin/bash

# Database user password can be changed here
DBPassword="somesequrep4ssw0rd"

# Setup zabbix pre-requisites for php.ini
echo "Starting PHP configuration"
sed -i 's/^post_max_size.*/post_max_size=16M/' /etc/php/7.2/fpm/php.ini
sed -i 's/^max_execution_time.*/max_execution_time=300/' /etc/php/7.2/fpm/php.ini
sed -i 's/^max_input_time.*/max_input_time=300/' /etc/php/7.2/fpm/php.ini
sed -i "s/^\;date.timezone.*/date.timezone=\'Europe\/Moscow\'/" /etc/php/7.2/fpm/php.ini
sed -i "s/^\; max_input_vars = 1000/max_input_vars = 10000/" /etc/php/7.2/fpm/php.ini
sed -i 's/^\;opcache.enable=1/opcache.enable=0/' /etc/php/7.2/fpm/php.ini
echo "PHP configuration complete"

# Make sure database is up and running
/etc/init.d/mysql restart
sleep 5

echo "Creating database zabbix"
mysql -v <<SQL
CREATE DATABASE zabbix CHARACTER SET UTF8 COLLATE UTF8_BIN;
CREATE USER zabbix@localhost IDENTIFIED BY '$DBPassword';
GRANT ALL PRIVILEGES ON zabbix.* TO zabbix@localhost;
FLUSH PRIVILEGES;
SQL

echo "Applying database schema"
zcat /usr/share/doc/zabbix-server-mysql/create.sql.gz | mysql -D zabbix

# Setup zabbix server DB Password
sed -i "124 s/# DBPassword=/DBPassword=$DBPassword/" /etc/zabbix/zabbix_server.conf

# Setup nginx configuration
cat ./nginx_config > /etc/nginx/sites-available/default

# Start services
echo "Starting Services"
/etc/init.d/php7.2-fpm restart
/etc/init.d/mysql restart
/etc/init.d/nginx restart
/etc/init.d/zabbix-agent restart
/etc/init.d/zabbix-server restart

# Tail logs
echo "Tailing logs"
tail -f \
    /var/log/zabbix/*.log \
    /var/log/mysql/error.log \
    /var/log/nginx/error.log