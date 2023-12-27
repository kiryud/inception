#! /bin/sh

openrc default

/etc/init.d/mariadb setup

rc-service mariadb start


cat << EOF > init.sql
CREATE DATABASE $MARIADB_DATABASE_NAME;
CREATE USER '$MARIADB_USER'@'%' IDENTIFIED by '$MARIADB_PASS';
SET PASSWORD FOR $MARIADB_USER@'%' = PASSWORD('$MARIADB_PASS');
GRANT ALL PRIVILEGES ON $MARIADB_DATABASE_NAME.* TO '$MARIADB_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ADMIN_PASS';
FLUSH PRIVILEGES;
EOF

mysql -u root < init.sql

rc-service mariadb stop 

#if [ ! -d "/var/lib/mysql/mysql" ]
#then
#	chown -R /var/lib/mysql
#	mysql_install_db 
#
#	tmp=".tmp_init_db.sql"
#
#	if [ -f "$tmp" ]
#	then
#		return 1
#	fi
#
#cat << EOF > $tmp
#	USE mysql;
#	FLUSH PRIVILEGES;
#	ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ADMIN_PASS';
#	CREATE DATABASE $MARIADB_DATABASE_NAME;
#	CREATE USER '$MARIADB_USER'@'%' IDENTIFIED by '$MARIADB_PASS';
#	GRANT ALL PRIVILEGES ON $MARIADB_DATABASE_NAME.* TO '$MARIADB_USER'@'%';
#	FLUSH PRIVILEGES;
#EOF
#
#	/usr/bin/mysqld --user=mysql --bootstrap < $tmp
#	rm -f $tmp
#fi

exec /usr/bin/mysqld 