FROM tools_base

ARG MONGOSH_VERSION=2.0.0
ENV MONGOSH_VERSION=${MONGOSH_VERSION}

COPY scripts/0-install-mongosh.sh ./
RUN bash ./0-install-mongosh.sh
