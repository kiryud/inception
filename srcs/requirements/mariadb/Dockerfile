FROM alpine:3.18

RUN apk update && apk add --no-cache mariadb mariadb-client openrc

COPY ./tools/init.sh ./init.sh

RUN sh init.sh && rm init.sh

COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf/

CMD ["/usr/bin/mysqld", "--skip-log-error"]
