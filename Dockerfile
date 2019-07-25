FROM debian:9.7

MAINTAINER proWIN International <web@prowin.net>

# Init
RUN export DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y zip unzip git wget

RUN apt-get install -y software-properties-common curl apt-transport-https lsb-release ca-certificates gnupg

# Install PPAs
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
	&& echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list

RUN curl -sL https://deb.nodesource.com/setup_11.x -o ~/setup_11.x \
	&& chmod +x ~/setup_11.x \
	&& ~/setup_11.x

RUN apt-get update

# PHP 7.3
RUN apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
	php7.3-fpm php7.3-cli php7.3-xml php7.3-mysql php7.3-zip php7.3-curl php7.3-gd \
	php7.3-mbstring php7.3-soap php7.3-sqlite php7.3-gmp

RUN sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.2/cli/php.ini

RUN update-alternatives --set php /usr/bin/php7.3

# Deployer	
RUN curl -LsS https://deployer.org/deployer.phar -o /usr/local/bin/dep \
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
