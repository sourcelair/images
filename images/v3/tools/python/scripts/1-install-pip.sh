set -ex

PYTHON_BINARY=python${PYTHON_VERSION%%.*}
PYTHON=${TOOL_PREFIX}/bin/${PYTHON_BINARY}

PIP_BINARY=pip${PYTHON_VERSION%%.*}
PIP=${TOOL_PREFIX}/bin/${PIP_BINARY}


curl -fSL 'https://bootstrap.pypa.io/get-pip.py' > get-pip.py
$PYTHON get-pip.py "pip == ${PYTHON_PIP_VERSION}"
find ${TOOL_PREFIX} -depth \
		\( \
		    \( -type d -a -name test -o -name tests \) \
		    -o \
		    \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
		\) -exec rm -rf '{}' +;
