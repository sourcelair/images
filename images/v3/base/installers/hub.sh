#! /bin/bash

set -ex

HUB_ARCHIVE_FILE_NAME=hub-linux-amd64-${HUB_VERSION}.tgz
HUB_OUTPUT_DIR=hub-linux-amd64-${HUB_VERSION}

wget https://github.com/github/hub/releases/download/v${HUB_VERSION}/${HUB_ARCHIVE_FILE_NAME}
tar xvfz ${HUB_ARCHIVE_FILE_NAME}
./${HUB_OUTPUT_DIR}/install
rm -r ${HUB_OUTPUT_DIR}*
