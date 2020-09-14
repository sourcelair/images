#! /bin/bash

set -ex

pip install --ignore-installed --upgrade pip==$PYTHON_PIP_VERSION
pip install \
    git+git://github.com/sourcelair/diff-match-patch@python-package#egg=diff-match-patch \
    https://sourcelair.sfo2.cdn.digitaloceanspaces.com/wheels/obiwan-0.6.0-py3-none-any.whl

npm install -g jshint@2.8.0 csslint@0.10.0 tern@0.18.0
