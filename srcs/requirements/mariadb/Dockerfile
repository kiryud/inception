FROM alpine:3.18

RUN apk update && apk add --no-cache mariadb mariadb-client openrc

RUN mkdir /var/run/mysqld; \
    chmod 777 /var/run/mysqld;

COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

COPY ./tools/init.sh ./init.sh

RUN chmod 777 ./init.sh

ENTRYPOINT [ "/init.sh" ]

CMD ["/usr/bin/mysqld", "--skip-log-error"]
