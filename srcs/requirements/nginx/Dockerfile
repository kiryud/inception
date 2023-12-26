FROM alpine:3.18

RUN apk update && apk add --no-cache nginx openssl && \
	mkdir -p /etc/nginx/ssl && \
	openssl req -x509 -nodes \
	-out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=FR/ST=IDF/L=Korea/O=42/OU=42/CN=jijeong.42.fr/UID=jijeong" && \
	mkdir -p /run/nginx && \
	mkdir -p /var/www/html && \
	chmod 755 /var/www/html && \
	chown -R www-data:www-data /var/www/html

COPY conf/nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["nginx", "-g", "daemon off"]