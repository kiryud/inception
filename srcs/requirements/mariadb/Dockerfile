FROM alpine

RUN apk update && apk add --no-cache mariadb mariadb-server

COPY ./tools/init.sh dest
COPY source dest

CMD [ "mariadb". "", "" ]
