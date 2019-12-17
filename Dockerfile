FROM debian:10

MAINTAINER proWIN International <web@prowin.net>

# Init
RUN export DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y zip unzip git wget rsync

RUN apt-get install -y software-properties-common curl apt-transport-https lsb-release ca-certificates gnupg

# Install PPAs
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
	&& echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list

RUN curl -sL https://deb.nodesource.com/setup_10.x -o ~/setup_10.x \
	&& chmod +x ~/setup_10.x \
	&& ~/setup_10.x

RUN apt-get update

# PHP 7.4
RUN apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
	php7.4-fpm php7.4-cli php7.4-xml php7.4-mysql php7.4-zip php7.4-curl php7.4-gd \
	php7.4-mbstring php7.4-soap php7.4-sqlite php7.4-gmp php7.4-memcached php7.4-ldap

RUN sed -i "s/memory_limit = .*/memory_limit = 2048M/" /etc/php/7.4/cli/php.ini

RUN update-alternatives --set php /usr/bin/php7.4

# Deployer	
RUN curl -LsS https://deployer.org/releases/v6.6.0/deployer.phar -o /usr/local/bin/dep \
    && chmod +x /usr/local/bin/dep

# Composer
RUN curl -sS https://getcomposer.org/installer | php \
	&& mv composer.phar /usr/local/bin/composer \
	&& chmod +x /usr/local/bin/dep 
	
# Node.js
RUN apt-get install -y nodejs

RUN npm install -g npm

#
# Clean Up
#

RUN apt-get -y upgrade

RUN apt-get -y autoremove

RUN apt-get -y clean
