FROM nginx:1-alpine
MAINTAINER Sean Cheung <theoxuanx@gmail.com>

# set user
RUN adduser -D -u 1000 www-data

VOLUME ["/etc/nginx/conf", "/var/log/nginx"]

ENTRYPOINT ["nginx", "-c", "/etc/nginx/conf/nginx.conf", "-g", "daemon off;"]
