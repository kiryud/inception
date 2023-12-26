#!bin/sh

sed -i "s/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/g" /etc/php81/php-fpm.d/www.conf
echo "user = www-data" >> /etc/php81/php-fpm.d/www.conf
echo "gruop = www-data" >> /etc/php81/php-fpm.d/www.conf
echo "listen.owner = www-data" >> /etc/php81/php-fpm.d/www.conf
echo "listen.group = www-data" >> /etc/php81/php-fpm.d/www.conf

if [ ! -f "./wp-config.php" ]; then
cat << EOF > ./wp-config.php
	<?php
	define( 'DB_NAME', '$MARIADB_DATABASE_NAME' );
	define( 'DB_USER', '$MARIADB_USER_' );
	define( 'DB_PASSWORD', '$MARIADB_PASS' );
	define( 'DB_HOST', 'mariadb' );
	define( 'DB_CHARSET', 'utf8' );
	define( 'DB_COLLATE', '' );
	$table_prefix = 'wp_';

	define( 'WP_SITEURL', '$DOMAIN_NAME' );
EOF
fi