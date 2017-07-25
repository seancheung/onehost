FROM alpine:latest
MAINTAINER Sean Cheung <theoxuanx@gmail.com>

RUN apk add --update --no-cache mysql mysql-client pwgen

COPY entrypoint.sh /entrypoint.sh
# COPY conf/my.cnf /etc/mysql/my.cnf

RUN echo http://dl-2.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    apk add --update --no-cache dos2unix && \
    dos2unix /entrypoint.sh && \
    chmod +x /entrypoint.sh && \
    apk del dos2unix

VOLUME ["/var/mysql/data", "/var/mysql/conf", "/var/log/mysql"]

EXPOSE 3306

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/bin/mysqld", "--defaults-file=/var/mysql/conf/my.cnf", "--user=root", "--console", "--character-set-server=utf8"]