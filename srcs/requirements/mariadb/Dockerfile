FROM alpine

RUN apk update && apk add --no-cache mysql mysql-client

COPY ./tools/init.sh ./init.sh

ENTRYPOINT [ "sh", "/tmp/init.sh" ]
