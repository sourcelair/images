FROM tools_base

RUN mkdir -p ${TOOL_PREFIX}

ARG PSQL_VERSION=16.0
ENV PSQL_VERSION=${PSQL_VERSION}

COPY scripts/0-install-psql.sh ./
RUN bash ./0-install-psql.sh
