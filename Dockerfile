FROM tetraweb/php:7.1-fpm

MAINTAINER proWIN International <web@prowin.net>

RUN apt-get update && apt-get install -y zip unzip
