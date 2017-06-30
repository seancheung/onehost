FROM node:6-alpine
MAINTAINER Sean Cheung <theoxuanx@gmail.com>

COPY ./entrypoint.sh /entrypoint.sh

RUN echo http://dl-4.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    apk add --no-cache dos2unix && \
    dos2unix /entrypoint.sh && \
    chmod +x /entrypoint.sh && \
    apk del dos2unix

ENTRYPOINT ["/entrypoint.sh"]

CMD ["node"]

