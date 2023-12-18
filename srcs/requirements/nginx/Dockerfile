FROM alpine

RUN apk update && apk add --no-cache nginx

COPY ./tools/init.sh ./init.

RUN mkdir -p /run/nginx

WORKDIR /var/www/html

ENTRYPOINT ["nginx", "", ""]