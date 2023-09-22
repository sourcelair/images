set -ex

PYTHON_BINARY=python${PYTHON_VERSION%%.*}
PYTHON=${TOOL_PREFIX}/bin/${PYTHON_BINARY}

PIP_BINARY=pip${PYTHON_VERSION%%.*}
PIP=${TOOL_PREFIX}/bin/${PIP_BINARY}


# make some useful symlinks that are expected to exist
cd ${TOOL_PREFIX}/bin
ln -fs pydoc${PYTHON_VERSION%%.*} pydoc
ln -fs $PYTHON_BINARY python
ln -fs $PYTHON_BINARY-config python-config
ln -fs $PIP_BINARY pip