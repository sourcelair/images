set -ex

GOREMAN_BASE="goreman_v${GOREMAN_VERSION}_linux_amd64"
GOREMAN_TARBALL="${GOREMAN_BASE}.tar.gz"

wget https://github.com/mattn/goreman/releases/download/v${GOREMAN_VERSION}/${GOREMAN_TARBALL}
tar -xzvf $GOREMAN_TARBALL
mkdir -p ${TOOL_PREFIX}/bin
mv $GOREMAN_BASE/goreman ${TOOL_PREFIX}/bin/goreman
