#! /bin/sh

openrc default

/etc/init.d/mariadb setup

rc-service mariadb start


cat << EOF > init.sql
FLUSH PRIVILEGES;
CREATE DATABASE $MARIADB_DATABASE_NAME;
CREATE USER '$MARIADB_USER'@'%' IDENTIFIED by '$MARIADB_PASS';
SET PASSWORD FOR $MARIADB_USER@'%' = PASSWORD('$MARIADB_PASS');
GRANT ALL PRIVILEGES ON $MARIADB_DATABASE_NAME.* TO '$MARIADB_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ADMIN_PASS';
FLUSH PRIVILEGES;
EOF

mysql -u root < init.sql

rc-service mariadb stop 

exec /usr/bin/mysqld 