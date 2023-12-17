FROM alpine

RUN apk update && apk add --no-cache mariadb-server

COPY ./tools/init.sh ./init.sh

CMD ["sh", "/tmp/init.sh"]

ENTRYPOINT ["mariadb"]
