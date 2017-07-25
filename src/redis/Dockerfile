FROM redis:3-alpine
MAINTAINER Sean Cheung <theoxuanx@gmail.com>

VOLUME ["/etc/redis/redis/conf", "/data", "/var/log/redis"]

ENTRYPOINT ["redis-server", "/etc/redis/redis.conf"]