FROM php:7.4-fpm

COPY composer.lock composer.json /var/www/

COPY database /var/www/database
COPY development/php.ini /usr/local/etc/php/php.ini
WORKDIR /var/www

RUN apt-get update && apt-get -y install git && apt-get -y install wget git unzip \
    && pecl install xdebug-2.9.6 \
    && docker-php-ext-enable xdebug

RUN wget https://getcomposer.org/installer -O - -q \
    | php -- --install-dir=/bin --filename=composer --quiet

## Расширения PHP
RUN docker-php-ext-install bcmath pdo_mysql

RUN curl --silent --show-error https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

COPY . /var/www

RUN chown -R www-data:www-data \
        /var/www/storage \
        /var/www/bootstrap/cache


RUN mv .env.prod .env
