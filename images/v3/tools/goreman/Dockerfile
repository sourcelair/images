FROM tools_base

ARG GOREMAN_VERSION=0.3.15
ENV GOREMAN_VERSION=${GOREMAN_VERSION}

COPY scripts/0-install-goreman.sh ./
RUN bash ./0-install-goreman.sh
