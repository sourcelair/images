VIRTUAL_ENV_DIR=/mnt/data/.python-${PYTHON_VERSION%.*}
if [ ! -d "$VIRTUAL_ENV_DIR" ]; then
  virtualenv "$VIRTUAL_ENV_DIR" &> /dev/null
fi
VIRTUAL_ENV_DISABLE_PROMPT=1 source "$VIRTUAL_ENV_DIR"/bin/activate
