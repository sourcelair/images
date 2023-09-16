set -ex

PYTHON_BINARY=python${PYTHON_VERSION%%.*}
PYTHON=${TOOL_PREFIX}/bin/${PYTHON_BINARY}

PIP_BINARY=pip${PYTHON_VERSION%%.*}
PIP=${TOOL_PREFIX}/bin/${PIP_BINARY}

# Common Python packages
$PIP install --upgrade pipenv==${PYTHON_PIPENV_VERSION} poetry==${PYTHON_POETRY_VERSION}


