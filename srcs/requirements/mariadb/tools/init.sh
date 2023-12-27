#! /bin/sh

if [ ! -d "/var/lib/mysql/mysql" ]
then
	chown -R mysql:mysql /var/lib/mysql
	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

	tmp=".tmp_init_db.sql"

	touch $tmp

	if [ ! -f "$tmp" ]
	then
		return 1
	fi

cat << EOF > $tmp
	USE mysql;
	FLUSH PRIVILEGES;
	ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ADMIN_PASS';
	CREATE DATABASE $MARIADB_DATABASE_NAME;
	CREATE USER '$MARIADB_USER'@'%' IDENTIFIED by '$MARIADB_PASS';
	GRANT ALL PRIVILEGES ON $MARIADB_DATABASE_NAME.* TO '$MARIADB_USER'@'%';
	FLUSH PRIVILEGES;
EOF

	/usr/bin/mysqld --user=mysql --bootstrap < $tmp
	rm -f $tmp
fi

exec /usr/bin/mysqld --user=mysql --console