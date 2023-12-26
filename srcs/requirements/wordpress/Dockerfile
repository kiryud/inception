FROM alpine:3.18

RUN apk update && apk upgrade && apk add --no-cache \
		php81 \
		php81-fpm\
    php81-phar\
		php81-mysqli\
		mariadb-client \
		fcgi \
		curl \
		wget

RUN sed -i "s/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/g" /etc/php81/php-fpm.d/www.conf && \
  echo "user = www-data" >> /etc/php81/php-fpm.d/www.conf &&\
  echo "gruop = www-data" >> /etc/php81/php-fpm.d/www.conf &&\
  echo "listen.owner = www-data" >> /etc/php81/php-fpm.d/www.conf &&\
  echo "listen.group = www-data" >> /etc/php81/php-fpm.d/www.conf &&\
  sed -i "s/;phar.readonly = On/phar.readonly = On/g" /etc/php81/php.ini

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp && \
	chmod +x /usr/local/bin/wp

RUN	mkdir -p /var/log/php-fpm && \
	chmod -R 777 /var/log/php-fpm

COPY ./tools/init.sh /init.sh
RUN	chmod +x /init.sh

CMD ["./init.sh"]
