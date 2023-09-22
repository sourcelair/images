set -ex

PSQL_TARBALL="postgresql-${PSQL_VERSION}.tar.gz"
wget https://ftp.postgresql.org/pub/source/v${PSQL_VERSION}/${PSQL_TARBALL}

tar -zxf ${PSQL_TARBALL}
cd postgresql-${PSQL_VERSION}
./configure --prefix=${TOOL_PREFIX}
make
make -C src/bin install
make -C src/include install
make -C src/interfaces install
make -C doc install
