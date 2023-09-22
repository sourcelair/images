set -ex

REDIS_CLI_TARBALL="${REDIS_CLI_VERSION}.tar.gz"

wget https://github.com/redis/redis/archive/${REDIS_CLI_TARBALL}
tar -xzvf ${REDIS_CLI_TARBALL}

cd redis-${REDIS_CLI_VERSION}
make redis-cli
make PREFIX=${TOOL_PREFIX} install redis-cli

rm -rf ${TOOL_PREFIX}/redis-benchmark ${TOOL_PREFIX}/redis-check-aof ${TOOL_PREFIX}/redis-check-rdb ${TOOL_PREFIX}/redis-sentinel ${TOOL_PREFIX}/redis-server
