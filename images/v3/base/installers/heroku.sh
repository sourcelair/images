#! /bin/bash

set -ex

echo "deb https://cli-assets.heroku.com/apt ./" > /etc/apt/sources.list.d/heroku.list
curl https://cli-assets.heroku.com/apt/release.key | apt-key add -

apt-get update
apt-get install -y heroku
