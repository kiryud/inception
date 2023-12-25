#! /bin/sh

rc default

/etc/init.d/mariadb setup

rc-service mariadb start

mysql -e "CREATE DATABASE IF NOT EXISTS $MARIADB_DATABASE_NAME;"

mysql -e "CREATE USER IF NOT EXISTS '$MARIADB_USER'@'localhost' IDENTIFIED BY '$MARIADB_PASS';"

mysql -e "GRANT ALL PRIVILEGES ON '$MARIADB_DATABASE_NAME'.* TO '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASS';"

mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ADMIN_PASS'; FLUSH PRIVILEGES;"


rc-service mariadb stop
