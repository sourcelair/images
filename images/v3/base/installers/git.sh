#! /bin/bash

set -ex

add-apt-repository -y ppa:git-core/ppa
apt-get update
apt-get install -y git=$GIT_VERSION
