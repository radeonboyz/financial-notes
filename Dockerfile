FROM php:7.1
RUN apt update
#RUN docker-php-ext-install msyqli
RUN docker-php-ext-install pdo_mysql
RUN apt-get install mariadb-client -y
RUN apt-get install -y \
    unzip \
    curl
#RUN mysql -u robi -probi8741. -h 172.17.0.2 db_catatan < db_catatankeuangan.sql
#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
RUN HASH=`curl -sS https://composer.github.io/installer.sig`
RUN echo $HASH
RUN php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

WORKDIR /app
COPY . /app
COPY .env.example .env
RUN composer update
RUN php artisan key:generate

EXPOSE 8000
