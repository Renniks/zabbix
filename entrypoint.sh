#!/bin/bash

# restarting services
echo "==> Starting Services..."
/etc/init.d/apache2 stop
/etc/init.d/php7.2-fpm restart
/etc/init.d/mysql restart
/etc/init.d/nginx restart
/etc/init.d/zabbix-server restart
/etc/init.d/zabbix-agent start


# tail logs
echo "==> Tailing logs..."
tail -f \
    /var/log/zabbix/*.log \
    /var/log/mysql/error.log \
    /var/log/nginx/error.log
