#! /bin/bash

set -ex

wget -qO - https://www.mongodb.org/static/pgp/server-${MONGO_VERSION}.asc | apt-key add -
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/${MONGO_VERSION} multiverse" | \
     tee /etc/apt/sources.list.d/mongodb-org-${MONGO_VERSION}.list

apt-get update
apt-get install mongodb-org-shell mongodb-org-tools
