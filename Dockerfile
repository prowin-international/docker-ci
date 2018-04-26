FROM php:7.2-fpm

MAINTAINER proWIN International <web@prowin.net>

RUN apt-get update && apt-get install -y zip unzip git wget

RUN wget -q -O- https://packages.sury.org/php/apt.gpg | apt-key add - \
	&& echo "deb https://packages.sury.org/php/ stretch main" | tee /etc/apt/sources.list.d/php.list

RUN apt-get update && apt-get install -y php7.2-mysql
	
RUN curl -LsS https://deployer.org/deployer.phar -o /usr/local/bin/dep \
    && chmod +x /usr/local/bin/dep
	
RUN curl -sS https://getcomposer.org/installer | php \
	&& mv composer.phar /usr/local/bin/composer \
	&& chmod +x /usr/local/bin/dep 