FROM tools_base

ARG MYSQLSH_VERSION=8.1.1
ENV MYSQLSH_VERSION=${MYSQLSH_VERSION}

COPY scripts/0-install-mysqlsh.sh ./
RUN bash ./0-install-mysqlsh.sh
