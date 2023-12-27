#!bin/sh

sed -i "s/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/g" /etc/php81/php-fpm.d/www.conf
#echo "user = nginx" >> /etc/php81/php-fpm.d/www.conf
#echo "group = nginx" >> /etc/php81/php-fpm.d/www.conf

cd /var/www/html

if [ ! -f wp-config.php ]; then
	wp config create --force \
	--skip-check \
	--dbname=$MARIADB_DATABASE_NAME \
	--dbuser=$MARIADB_USER \
	--dbpass=$MARIADB_PASS  \
	--dbhost=mariadb
fi

if ! wp core is-installed; then
	wp core install \
	--url=$DOMAIN_NAME \
	--title=$WORDPRESS_TITLE \
	--admin_user=$WORDPRESS_ADMIN_USER \
	--admin_password=$WORDPRESS_ADMIN_PASS \
	--admin_email=$WORDPRESS_ADMIN_MAIL \
	--allow-root

	wp user create \
	$WORDPRESS_USER \
	$WORDPRESS_MAIL \
	--role=author \
	--user_pass=$WORDPRESS_PASS \
	--allow-root

fi

wp core update-db
wp plugin update --all

/usr/sbin/php-fpm81 -F
