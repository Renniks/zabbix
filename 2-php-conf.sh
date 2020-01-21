#!/bin/bash

# Setup zabbix pre-requisites for php.ini
sed -i 's/^post_max_size.*/post_max_size=16M/' /etc/php/7.2/fpm/php.ini
sed -i 's/^max_execution_time.*/max_execution_time=300/' /etc/php/7.2/fpm/php.ini
sed -i 's/^max_input_time.*/max_input_time=300/' /etc/php/7.2/fpm/php.ini
sed -i "s/^\;date.timezone.*/date.timezone=\'Europe\/Moscow\'/" /etc/php/7.2/fpm/php.ini
sed -i "s/^\; max_input_vars = 1000/max_input_vars = 10000/" /etc/php/7.2/fpm/php.ini
sed -i 's/^\;opcache.enable=1/opcache.enable=0/' /etc/php/7.2/fpm/php.ini
echo "PHP configuration complete"

# !!! Temp. Setup zabbix server DB Password
sed -i '124 s/# DBPassword=/DBPassword=zabbix/' /etc/zabbix/zabbix_server.conf
