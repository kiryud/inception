#! /bin/sh

# Check if the /run/mysqld directory exists, and create it if not
if [ ! -d "/run/mysqld" ]
then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

# Check if the /var/lib/mysql/mysql directory exists, and create it if not
if [ ! -d "/var/lib/mysql/mysql" ]
then
	chown -R mysql:mysql /var/lib/mysql
	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

	# Create a temporary file to execute SQL commands
	tmp=`.tmp_init_db.sql`

	if [ ! -f "$tmp" ]
	then
		return 1
	fi

	# Define SQL commands to set up MariaDB user and database
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