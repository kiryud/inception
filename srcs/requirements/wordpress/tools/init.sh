#!bin/sh

cd /var/www/html

sed -i "s/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/g" /etc/php81/php-fpm.d/www.conf
#echo "user = www-data" >> /etc/php81/php-fpm.d/www.conf
#echo "gruop = www-data" >> /etc/php81/php-fpm.d/www.conf
#echo "listen.owner = www-data" >> /etc/php81/php-fpm.d/www.conf
#echo "listen.group = www-data" >> /etc/php81/php-fpm.d/www.conf

if [ ! -f "/var/www/html/wp-config.php" ]; then

fi