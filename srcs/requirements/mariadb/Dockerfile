FROM alpine

RUN apk update && apk add --no-cache mariadb

COPY ./tools/init.sh ./init.sh

CMD ["sh", "/tmp/init.sh"]

ENTRYPOINT ["mariadb"]
