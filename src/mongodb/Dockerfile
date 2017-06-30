FROM alpine:latest
MAINTAINER Sean Cheung <theoxuanx@gmail.com>

COPY ./entrypoint.sh /entrypoint.sh

RUN echo http://dl-4.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    apk add --update --no-cache mongodb dos2unix && \
    rm /usr/bin/mongosniff /usr/bin/mongoperf && \
    dos2unix /entrypoint.sh && \
    chmod +x /entrypoint.sh && \
    apk del dos2unix

VOLUME ["/data/db"]

EXPOSE 27017 28017

ENTRYPOINT ["/entrypoint.sh"]
CMD ["mongod"]