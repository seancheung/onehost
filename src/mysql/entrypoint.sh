#!/bin/sh

if [ ! -f /var/mysql/conf/my.cnf ]; then
  echo "[i] MySQL config file not found, copy from /etc/mysql"
  mkdir -p /var/mysql/conf
  cp /etc/mysql/my.cnf /var/mysql/conf
fi

if [ -f /var/mysql/data/.init ]; then
  echo "[i] MySQL data already present, skipping creation"
else
  echo "[i] MySQL data not found, creating initial DBs"

  mysql_install_db --user=root > /dev/null

  if [ "$MYSQL_ROOT_PASSWORD" = "" ]; then
    MYSQL_ROOT_PASSWORD=`pwgen 16 1`
    echo "[i] MySQL root Password: $MYSQL_ROOT_PASSWORD"
    echo $MYSQL_ROOT_PASSWORD > /var/mysql/conf/root_password
    echo $MYSQL_ROOT_PASSWORD > /var/mysql/data/root_password
  fi

  MYSQL_DATABASE=${MYSQL_DATABASE:-""}
  MYSQL_USER=${MYSQL_USER:-""}
  MYSQL_PASSWORD=${MYSQL_PASSWORD:-""}

  tfile=`mktemp`
  if [ ! -f "$tfile" ]; then
      return 1
  fi

  cat << EOF > $tfile
USE mysql;
UPDATE user SET password=PASSWORD('') WHERE user='root' AND host='localhost';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

  if [ "$MYSQL_DATABASE" != "" ]; then
    echo "[i] Creating database: $MYSQL_DATABASE"
    echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $tfile

    if [ "$MYSQL_USER" != "" ]; then
      echo "[i] Creating user: $MYSQL_USER with password $MYSQL_PASSWORD"
      echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
    fi
  fi

  # do not use --bootstrap here since we're using init-file
  /usr/bin/mysqld --defaults-file=/var/mysql/conf/my.cnf --user=root --character-set-server=utf8 --verbose=0 --init-file=$tfile
  rm -f $tfile

  touch /var/mysql/data/.init
fi

# run command passed to docker run
exec "$@"