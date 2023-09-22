FROM tools_base

ARG REDIS_CLI_VERSION=7.2.1
ENV REDIS_CLI_VERSION=${REDIS_CLI_VERSION}

COPY scripts/0-install-redis-cli.sh ./
RUN bash ./0-install-redis-cli.sh
