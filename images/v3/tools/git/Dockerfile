FROM tools_base

RUN apt-get -y install gettext asciidoc docbook2x

ARG GIT_VERSION=2.42.0
ENV GIT_VERSION=${GIT_VERSION}

COPY scripts/0-install-git.sh ./
RUN bash ./0-install-git.sh
