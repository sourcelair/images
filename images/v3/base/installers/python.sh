set -ex

PIP=pip${PYTHON_VERSION%%.*}
PYTHON=python${PYTHON_VERSION%%.*}

# remove several traces of system python
apt-get purge -y python.*

export GNUPGHOME="$(mktemp -d)"

gpg --batch --keyserver ipv4.pool.sks-keyservers.net --recv-keys "$PYTHON_GPG_KEY"

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
./configure --enable-shared --enable-unicode=ucs4
make -j$(nproc)
make install
ldconfig
curl -fSL 'https://bootstrap.pypa.io/get-pip.py' | $PYTHON
$PIP install --no-cache-dir --upgrade pip==$PYTHON_PIP_VERSION virtualenv==$PYTHON_VIRTUALENV_VERSION
find /usr/local -depth \
		\( \
		    \( -type d -a -name test -o -name tests \) \
		    -o \
		    \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
		\) -exec rm -rf '{}' +;
rm -rf /usr/src/python ~/.cache;

# make some useful symlinks that are expected to exist
cd /usr/local/bin
ln -fs easy_install-${PYTHON_VERSION%.*} easy_install
ln -fs pydoc${PYTHON_VERSION%%.*} pydoc
ln -fs $PYTHON python
ln -fs $PYTHON-config python-config
ln -fs $PIP pip

rm -r "$GNUPGHOME"
unset GNUPGHOME

# Common Python packages
pip install --upgrade pip==$PYTHON_PIP_VERSION pyopenssl==19.1.0 ndg-httpsclient==0.5.1 pyasn1==0.4.8 pipenv==2020.8.13 poetry==1.0.10 honcho==1.0.1
