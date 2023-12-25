#! /bin/sh

rc default

/etc/init.d/mariadb setup

rc-service mariadb start

mysql --skip-networking=false -e "CREATE DATABASE IF NOT EXISTS $MARIADB_DATABASE_NAME;"
mysql --skip-networking=false -e "CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'localhost' IDENTIFIED BY '${MARIADB_PASS}';"
mysql --skip-networking=false -e "GRANT ALL PRIVILEGES ON $MARIADB_DATABASE_NAME.* TO '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASS}';"
mysql --skip-networking=false -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ADMIN_PASS}';"


rc-service mariadb stop

/usr/bin/mysqld_safe