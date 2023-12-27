FROM alpine:3.18

RUN apk update && apk upgrade && apk add --no-cache \
	php81 \
	php81-fpm \
	php81-iconv \
	php81-tokenizer \
	php81-curl \
 	php81-phar \
	php81-mysqli \
	mariadb-client \
	fcgi \
	curl \
	wget && \
	mkdir -p /var/www/html && \
	mkdir -p /var/log/php-fpm && \
	chmod -R 777 /var/log/php-fpm; \
	adduser nginx;

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp && \
	chmod +x /usr/local/bin/wp
RUN sed -i "s/;phar.readonly = On/phar.readonly = On/g" /etc/php81/php.ini

RUN	wp core download \
	--path=/var/www/html/ \
	--allow-root

COPY ./tools/init.sh /var/www/html/init_wp_config_file.sh
RUN	chmod +x /var/www/html/init_wp_config_file.sh

WORKDIR /var/www/html


CMD ["sh", "/var/www/html/init_wp_config_file.sh"]
#CMD ["/usr/sbin/php-fpm81", "-F"]
