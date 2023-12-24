#! /bin/sh

# rc pid 실행을 수행한다.
rc default

# datadir에 기본 셋업을 진행한다.
/etc/init.d/mariadb setup

# SQL 쿼리문을 넣기위해 잠시 실행한다.
rc-service mariadb start

service mysql start;

mysql -e "CREATE DATABASE IF NOT EXISTS \`${MARIADB_DATABASE_NAME}\`;"

mysql -e "CREATE USER IF NOT EXISTS \`${MARIADB_USER}\`@'localhost' IDENTIFIED BY '${MARIADB_PASS}';"

mysql -e "GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE_NAME}\`.* TO \`${MARIADB_USER}\`@'%' IDENTIFIED BY '${MARIADB_PASS}';"

mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ADMIN_PASS}';"

mysql -e "FLUSH PRIVILEGES;"

rc-service mariadb stop
