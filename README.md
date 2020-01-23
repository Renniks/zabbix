# Docker-zabbix
[![Build Status](https://travis-ci.org/Renniks/zabbix.svg?branch=master)](https://travis-ci.org/Renniks/zabbix)
This project provides self-contained instance of Zabbix for development and testing purposes.
The Docker file is based on Ubuntu 18.04, which will be used to build an image consisting of: 
- Nginx
- MariaDB
- PHP
- Zabbix-Server-MySQL
- Zabbix-Frontend-PHP
- Zabbix-Agent
- SNMP (as a Zabbix dependency)

A Docker container launched from this image will not contain any data or configurations between runs.
### Prerequisites
- Linux kernel version 3.10 or higher
- Docker Engine version 1.10 or higher. (Lear how to install https://docs.docker.com/install/)
- 1.00 GB of RAM
- 2.00 GB of available disk space

### Deployment

##### You can simply run the latest version of the image with:
```sh
docker run –it –p 8080:80 renniks/zabbix:latest
```
In this example, we simply map port 80 of the Docker container to the host's 8080 port.
So Zabbix will be accessible via a web browser at your host IP address on port 8080. 
 > http://127.0.0.1:8080

##### Or build your own with:
```sh
git clone https://github.com/Renniks/zabbix
cd zabbix/
docker build –t your_image_name .
and run it with:
docker run –it –p 8080:80 your_image_name
```
Again, it will be accessible via a web browser at your host IP address on port 8080. 
 > http://127.0.0.1:8080

>  The repository is implemented with TravisCI .travis.yml
So any commit to master branch causes the image to be automatically built and updated on DockerHub.