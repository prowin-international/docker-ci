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

RUN curl -sL https://deb.nodesource.com/setup_lts.x -o ~/setup_lts.x \
	&& chmod +x ~/setup_lts.x \
	&& ~/setup_lts.x

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367

RUN apt-get update

# PHP 8.0
RUN apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
	php8.0-fpm php8.0-cli php8.0-xml php8.0-mysql php8.0-zip php8.0-curl php8.0-gd \
	php8.0-mbstring php8.0-soap php8.0-sqlite php8.0-gmp php8.0-memcached php8.0-ldap \
	php8.0-intl

RUN sed -i "s/memory_limit = .*/memory_limit = 2048M/" /etc/php/8.0/cli/php.ini

RUN update-alternatives --set php /usr/bin/php8.0

# Deployer	
RUN curl -LO https://deployer.org/deployer.phar \
    && mv deployer.phar /usr/local/bin/dep \
    && chmod +x /usr/local/bin/dep

# Composer
RUN curl -sS https://getcomposer.org/installer | php \
	&& mv composer.phar /usr/local/bin/composer \
	&& chmod +x /usr/local/bin/dep 
	
# PHPunit
RUN curl --location --output /usr/local/bin/phpunit "https://phar.phpunit.de/phpunit.phar"
RUN chmod +x /usr/local/bin/phpunit

# Symyfony
RUN wget https://get.symfony.com/cli/installer -O - | bash
RUN mv /root/.symfony/bin/symfony /usr/local/bin/symfony

# Node.js
RUN apt-get install -y nodejs

RUN npm install -g npm

# Piral / Pilet CLI
RUN npm install -g piral-cli

RUN npm install -g cloc

# Ansible
RUN apt install -y ansible

# Ansistrano
RUN ansible-galaxy install ansistrano.deploy ansistrano.rollback

#
# Clean Up
#

RUN apt-get -y upgrade

RUN apt-get -y autoremove

RUN apt-get -y clean
