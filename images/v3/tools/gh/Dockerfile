FROM tools_base

ARG GH_VERSION=2.34.0
ENV GH_VERSION=${GH_VERSION}

COPY scripts/0-install-gh.sh ./
RUN bash ./0-install-gh.sh
