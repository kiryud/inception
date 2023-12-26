#!bin/sh

cd /var/www/html

sed -i "s/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/g" /etc/php81/php-fpm.d/www.conf
#echo "user = www-data" >> /etc/php81/php-fpm.d/www.conf
#echo "gruop = www-data" >> /etc/php81/php-fpm.d/www.conf
#echo "listen.owner = www-data" >> /etc/php81/php-fpm.d/www.conf
#echo "listen.group = www-data" >> /etc/php81/php-fpm.d/www.conf
sed -i "s/;phar.readonly = On/phar.readonly = On/g" /etc/php81/php.ini

if [ ! -f "/var/www/html/wp-config.php" ]; then

	wp config create \
		--dbname=$MARIADB_DATABASE_NAME \
		--dbuser=$MARIADB_USER \
		--dbpass=$MARIADB_PASS \
		--dbhost=$MARIADB_HOST \
		--dbcharset="utf8" \
		--dbcollate="utf8_general_ci" \
		--allow-root

	wp core install \
		--url=$DOMAIN_NAME \
		--title="$WORDPRESS_TITLE" \
		--admin_user=$WORDPRESS_ADMIN_USER \
		--admin_password=$WORDPRESS_ADMIN_PASS \
		--admin_email=$WORDPRESS_ADMIN_MAIL \
		--skip-email \
		--allow-root

	wp user create \
		$WORDPRESS_USER \
		$WORDPRESS_MAIL \
		--role=author \
		--user_pass=$WORDPRESS_PASS \
		--allow-root
fi