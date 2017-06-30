FROM php:7-fpm-alpine
MAINTAINER Sean Cheung <theoxuanx@gmail.com>

# set user
RUN echo http://dl-2.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories && \
    apk --update --no-cache add shadow && \
    usermod -u 1000 www-data && \
    apk del shadow

# install extensions
RUN apk --update --no-cache add curl libzip-dev libmcrypt-dev libpng-dev libwebp-dev jpeg-dev libxpm-dev freetype-dev gd-dev
RUN docker-php-source extract && \    
    curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/3.1.1.tar.gz && \
    tar -zxf /tmp/redis.tar.gz && \
    rm -r /tmp/redis.tar.gz && \    
    mv phpredis-3.1.1 /usr/src/php/ext/redis && \
    docker-php-ext-install mcrypt gd mysqli pdo_mysql redis zip && \
    docker-php-source delete

# install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php --install-dir=/usr/bin --filename=composer && \
    php -r "unlink('composer-setup.php');" && \
    chmod +x /usr/bin/composer

VOLUME ["/var/run/php", "/var/log/php"]

EXPOSE 9000

ENTRYPOINT ["php-fpm"]