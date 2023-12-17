FROM alpine

RUN apk update && apk add --no-cache mariadb mariadb-server

COPY ./tools/init.sh ./init.sh

CMD [ "mariadb". "", "" ]
