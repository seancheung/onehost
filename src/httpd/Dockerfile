FROM httpd:2-alpine
MAINTAINER Sean Cheung <theoxuanx@gmail.com>

# set user
RUN echo http://dl-2.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories && \
    apk --update --no-cache add shadow && \
    usermod -u 1000 www-data && \
    apk del shadow

VOLUME ["/var/log/httpd"]