set -ex

GH_BASE="gh_${GH_VERSION}_linux_amd64"
GH_TARBALL="${GH_BASE}.tar.gz"

wget https://github.com/cli/cli/releases/download/v${GH_VERSION}/${GH_TARBALL}
tar -xzvf ${GH_TARBALL}

mv ${GH_BASE}/* ${TOOL_PREFIX}
