#! /bin/sh

rc default

/etc/init.d/mariadb setup

rc-service mariadb start

cat << EOF | mysql -e
CREATE DATABASE IF NOT EXISTS '${MARIADB_DATABASE_NAME}';
CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'localhost' IDENTIFIED BY '${MARIADB_PASS}';
GRANT ALL PRIVILEGES ON '${MARIADB_DATABASE_NAME}'.* TO '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASS}';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ADMIN_PASS}';
FLUSH PRIVILEGES;
EOF


rc-service mariadb start

