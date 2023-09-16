set -ex

PYTHON_BINARY=python${PYTHON_VERSION%%.*}
PYTHON=${TOOL_PREFIX}/bin/${PYTHON_BINARY}

PIP_BINARY=pip${PYTHON_VERSION%%.*}
PIP=${TOOL_PREFIX}/bin/${PIP_BINARY}

export GNUPGHOME="$(mktemp -d)"

gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys "$PYTHON_GPG_KEY";

curl -fSL "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz" -o python.tar.xz
curl -fSL "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz.asc" -o python.tar.xz.asc

gpg --batch --verify python.tar.xz.asc python.tar.xz
pkill -9 gpg-agent
pkill -9 dirmngr

rm -r python.tar.xz.asc
mkdir -p /usr/src/python
tar -xJC /usr/src/python --strip-components=1 -f python.tar.xz
rm python.tar.xz
cd /usr/src/python
./configure --enable-shared --enable-unicode=ucs4 --prefix=$TOOL_PREFIX
make -j$(nproc)
make install
ldconfig
rm -r "$GNUPGHOME"
unset GNUPGHOME
