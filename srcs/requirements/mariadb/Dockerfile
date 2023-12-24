FROM alpine:3.18

RUN apk update && apk add --no-cache mariadb mariadb-client

RUN mkdir /var/run/mysqld; \
    chmod 777 /var/run/mysqld;

COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

COPY ./tools/init.sh ./init.sh

RUN sh init.sh && rm init.sh

CMD ["/usr/bin/mysqld", "--skip-log-error"]
