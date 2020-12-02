ARG BASE_IMAGE=images/v3/base

FROM ${BASE_IMAGE}

# Add Python installer
COPY installers/python.sh ${INSTALLERS_DIR}

# Export common Python environment variables
ARG PYTHON_PIP_VERSION=20.2.4
ARG PYTHON_VIRTUALENV_VERSION=20.2.1
ENV PYTHON_VIRTUALENV_VERSION=${PYTHON_VIRTUALENV_VERSION}

# Install Python 3
ARG PYTHON_VERSION=3.8.6
ARG PYTHON_GPG_KEY="E3FF2839C048B25C084DEBE9B26995E310250568"
RUN bash ${INSTALLERS_DIR}/python.sh

# Install Obiwan
COPY installers/obiwan.sh ${INSTALLERS_DIR}
ARG OBIWAN_VERSION=0.6.0
RUN bash ${INSTALLERS_DIR}/obiwan.sh

# Add needed configuration files
COPY pylintrc /etc/pylintrc