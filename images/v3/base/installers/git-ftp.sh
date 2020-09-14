#! /bin/bash

set -ex

add-apt-repository -y ppa:git-ftp/ppa
apt-get update
apt-get install -y git-ftp=$GIT_FTP_VERSION
