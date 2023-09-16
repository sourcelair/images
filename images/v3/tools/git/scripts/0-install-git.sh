set -ex

GIT_TARBALL="v${GIT_VERSION}.tar.gz"
wget https://github.com/git/git/archive/refs/tags/${GIT_TARBALL}

tar -zxf ${GIT_TARBALL}
cd git-${GIT_VERSION}
make configure
./configure --prefix=${TOOL_PREFIX}
make all doc info
make install install-doc install-html install-info