set -ex

MYSQLSH_BASE=mysql-shell-${MYSQLSH_VERSION}-linux-glibc2.28-x86-64bit
MYSQLSH_TARBALL=${MYSQLSH_BASE}.tar.gz

wget https://dev.mysql.com/get/Downloads/MySQL-Shell/${MYSQLSH_TARBALL}
tar -xzvf ${MYSQLSH_TARBALL}

mv ${MYSQLSH_BASE}/* ${TOOL_PREFIX}/
