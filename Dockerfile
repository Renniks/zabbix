FROM ubuntu:18.04
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /tmp
COPY . .

RUN echo exit 0 > /usr/sbin/policy-rc.d && chmod -R +x ./*.sh
RUN ./1-apt-install.sh
RUN ./2-php-conf.sh
RUN ./3-db-init.sh

RUN cat ./nginx_config > /etc/nginx/sites-available/default

EXPOSE 80

ENTRYPOINT ["./entrypoint.sh"]
