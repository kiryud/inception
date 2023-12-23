FROM alpine:3.18

RUN apk update && apk add --no-cache mariadb mariadb-client

COPY ./tools/50-server.cnf /etc/mysql/mariadb.conf.d/

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

COPY ./tools/init.sh ./init.sh

RUN sh init.sh && rm init.sh

CMD ["/usr/bin/mysqld", "--skip-log-error"]
