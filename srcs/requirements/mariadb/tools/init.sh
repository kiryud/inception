#! /bin/sh

rc default

/etc/init.d/mariadb setup

rc-service mariadb start

echo "mysql -uroot -e 'CREATE DATABASE IF NOT EXISTS $MARIADB_DATABASE_NAME;'"
echo "mysql -uroot -e 'CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'localhost' IDENTIFIED BY '${MARIADB_PASS}';'"
echo "mysql -uroot -e 'GRANT ALL PRIVILEGES ON $MARIADB_DATABASE_NAME.* TO '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASS}';'"
echo "mysql -uroot -e 'ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ADMIN_PASS}';'"


rc-service mariadb stop

