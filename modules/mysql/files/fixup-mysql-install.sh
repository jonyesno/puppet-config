#!/bin/sh -e

PASSWORD=$( openssl rand -base64 16 )
CONF=/root/.my.cnf

trace() {
  echo "[fixup-mysql-install] $*" >&2
}

if [ -f ${CONF} ] ; then
  echo "[fixup-mysql-install] ${CONF} exists, exiting"
  exit 0
fi

trace "setting MySQL root password"
mysqladmin password --host 127.0.0.1 ${PASSWORD}

trace "writing ${CONF}"
touch ${CONF}
chmod 600 ${CONF}
chown root:root ${CONF}
cat > ${CONF} <<EOC
[client]
password = ${PASSWORD}
host     = 127.0.0.1
EOC

trace "dropping test database and unwanted GRANTs"
HOME=/root mysql -Bs << EOQ
# no remote root, anonymous users or test db
DELETE FROM mysql.user WHERE User = 'root' AND Host != '127.0.0.1';
DELETE FROM mysql.user WHERE User = '';
DELETE FROM mysql.db   WHERE Db = 'test';
DELETE FROM mysql.db   WHERE Db = 'test\_%';
DROP DATABASE IF EXISTS test;
FLUSH PRIVILEGES;
EOQ
