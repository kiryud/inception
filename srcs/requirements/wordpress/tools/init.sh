#!bin/sh

sed -i "s/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/g" /etc/php81/php-fpm.d/www.conf
echo "user = www-data" >> /etc/php81/php-fpm.d/www.conf
echo "gruop = www-data" >> /etc/php81/php-fpm.d/www.conf
echo "listen.owner = www-data" >> /etc/php81/php-fpm.d/www.conf
echo "listen.group = www-data" >> /etc/php81/php-fpm.d/www.conf

if [ ! -f "/var/www/html/wp-config.php" ]; then
#cat << EOF > /var/www/html /wp-config.php
#	<?php
#	define( 'DB_NAME', '$MARIADB_DATABASE_NAME' );
#	define( 'DB_USER', '$MARIADB_USER_' );
#	define( 'DB_PASSWORD', '$MARIADB_PASS' );
#	define( 'DB_HOST', 'mariadb' );
#	define( 'DB_CHARSET', 'utf8' );
#	define( 'DB_COLLATE', '' );
#	$table_prefix = 'wp_';
#
#	define( 'WP_SITEURL', '$DOMAIN_NAME' );
#EOF

wp core config \
--dbname=TEMP_DATABASE_NAME_FOR_DEL \
--dbuser=TEMP_DATABASE_USER_NAME_FOR_DEL \
--dbpass=TEMP_DATABASE_USER_PW_FOR_DEL \
--dbhost=mariadb \
--dbprefix=wp_

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

/usr/sbin/php-fpm81 -F