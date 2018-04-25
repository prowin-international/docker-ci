FROM php:7.2-fpm

MAINTAINER proWIN International <web@prowin.net>

RUN apt-get update && apt-get install -y zip unzip
	
RUN curl -LsS https://deployer.org/deployer.phar -o /usr/local/bin/dep \
    && chmod +x /usr/local/bin/dep
	
RUN curl -sS https://getcomposer.org/installer | php \
	&& mv composer.phar /usr/local/bin/composer \
	&& chmod +x /usr/local/bin/dep 