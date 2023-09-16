set -ex

MONGOSH_BASE=mongosh-${MONGOSH_VERSION}-linux-x64
MONGOSH_TARBALL=${MONGOSH_BASE}.tgz

wget https://downloads.mongodb.com/compass/${MONGOSH_TARBALL}
tar -xzvf ${MONGOSH_TARBALL}

mkdir -p ${TOOL_PREFIX}/bin
mv ${MONGOSH_BASE}/bin/* ${TOOL_PREFIX}/bin
