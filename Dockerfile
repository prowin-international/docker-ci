FROM tetraweb/php:7.1-fpm

MAINTAINER proWIN International <web@prowin.net>

RUN apt-get update && apt-get install -y zip unzip

RUN sudo curl -LsS https://deployer.org/deployer.phar -o /usr/local/bin/dep \
    && sudo chmod +x /usr/local/bin/dep
