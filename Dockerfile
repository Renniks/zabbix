FROM ubuntu:18.04
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /tmp
COPY . .

# Fixing:
# 1 invoke-rc.d: https://forums.docker.com/t/880
# 2 missing mysql scheme: https://support.zabbix.com/browse/ZBX-14820
# Assigning execution attribute for entrypoint script
RUN echo exit 0 > /usr/sbin/policy-rc.d \
    && rm /etc/dpkg/dpkg.cfg.d/excludes \
    && chmod -R +x ./*.sh
    
RUN \
    apt update -y && apt install -y wget
    wget https://repo.zabbix.com/zabbix/4.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_4.2-2+bionic_all.deb \
    && dpkg -i zabbix-release_4.2-2+bionic_all.deb \
    && apt update -y \
    && apt install -y \
        snmp \
        nginx \
        php-fpm \
        php-mysql \
        mariadb-server \
        mariadb-client \
        zabbix-server-mysql \
        zabbix-frontend-php \
        zabbix-agent \
    && apt remove apache2 -y && apt autoremove -y

EXPOSE 80

ENTRYPOINT ["./entrypoint.sh"]