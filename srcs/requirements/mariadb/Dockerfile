FROM alpine:3.18

RUN apk update && apk add --no-cache mariadb mariadb-client openrc

RUN mkdir /var/run/mysqld; \
    chmod 777 /var/run/mysqld;

COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

RUN rc default \
  /etc/init.d/mariadb setup \
  rc-service mysql start \
  mysql -e "CREATE DATABASE IF NOT EXISTS $MARIADB_DATABASE_NAME; \
    CREATE USER IF NOT EXISTS $MARIADB_USER@localhost IDENTIFIED BY '$MARIADB_PASS'; \
  	GRANT ALL PRIVILEGES ON $MARIADB_DATABASE_NAME.* TO $MARIADB_USER@'%' IDENTIFIED BY '$MARIADB_PASS'; \
	  ALTER USER root@localhost IDENTIFIED BY '$MARIADB_ADMIN_PASS'; FLUSH PRIVILEGES;" \
   rc-service mysql stop

# COPY ./tools/init.sh ./init.sh

# RUN sh init.sh && rm init.sh

VOLUME ["/var/lib/mysql"]

CMD ["/usr/bin/mysqld", "--skip-log-error"]
