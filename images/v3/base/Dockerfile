FROM buildpack-deps:focal

ENV DEBIAN_FRONTEND noninteractive

ARG ROOT_DIR=/mnt
ARG PROJECT_DIR=${ROOT_DIR}/project
ARG DATA_DIR=${ROOT_DIR}/data
ARG USER_HOME_DIR=${ROOT_DIR}/user
ARG OS_USER=www-data
ARG OS_GROUP=www-data

RUN mkdir -p ${PROJECT_DIR} ${DATA_DIR} ${USER_HOME_DIR} && \
    chown -R ${OS_USER}:${OS_GROUP} ${PROJECT_DIR} ${DATA_DIR} ${USER_HOME_DIR}

# Set up OS user defaults
ARG DEFAULT_SHELL=/bin/bash
RUN chsh -s ${DEFAULT_SHELL} ${OS_USER} && \
    usermod --home ${USER_HOME_DIR} ${OS_USER}

# Install base line packages
RUN apt-get update
RUN apt-get install -y locales gnupg software-properties-common apt-transport-https

# Set up needed local and environment
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV SL_ENV 1
ENV MAX_CONCURRENCY 1
ENV HOME /mnt/user
ENV HISTFILE /mnt/data/.bash_history
ENV PYTHONUNBUFFERED 1

# Install tools needed in all images
RUN apt-get install -y bash-completion vim tmux zip unzip man rsync

ENV INSTALLERS_DIR=/usr/src/installers
RUN mkdir -p ${INSTALLERS_DIR}

# Install Postgres client tools
COPY installers/postgres.sh ${INSTALLERS_DIR}
RUN bash ${INSTALLERS_DIR}/postgres.sh

# Install Redis client tools
COPY installers/redis.sh ${INSTALLERS_DIR}
RUN bash ${INSTALLERS_DIR}/redis.sh

# Install MySQL client tools
COPY installers/mysql.sh ${INSTALLERS_DIR}
RUN bash ${INSTALLERS_DIR}/mysql.sh

# Install MongoDB client tools
COPY installers/mongo.sh ${INSTALLERS_DIR}
ARG MONGO_VERSION=4.2
RUN bash ${INSTALLERS_DIR}/mongo.sh

# Install Git
COPY installers/git.sh ${INSTALLERS_DIR}
ARG GIT_VERSION=1:2.29.2-0ppa1~ubuntu20.04.1
RUN bash ${INSTALLERS_DIR}/git.sh

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

# Install Node
COPY installers/node.sh ${INSTALLERS_DIR}
COPY installers/node-engine.sh ${INSTALLERS_DIR}

# Export needed Node environment
ARG NODE_VERSION=14.15.1
ENV NODE_GPG_KEYS="94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
                   FD3A5288F042B6850C66B31F09FE44734EB7990E \
                   71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
                   DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
                   C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
                   B9AE9905FFD7803F25714661B63B535A4C206CA9 \
                   77984A986EBC2AA786BC0F66B01FBB92821C587A \
                   8FCCA13FEF1D0C2E91008E09770F7A9A5AE15600 \
                   4ED778F539E3634C779C87C6D7062848A1AB005C \
                   A48C2BEE680E841632CD4E44F07496B3EB3C1762 \
                   B9E2F5981AA6E0CD28160D9FF13993A75599653C"
RUN bash ${INSTALLERS_DIR}/node.sh

# Install Ruby
COPY installers/ruby.sh ${INSTALLERS_DIR}
ARG RUBY_VERSION="2.7.0"
ARG RUBY_DOWNLOAD_SHA256="27d350a52a02b53034ca0794efe518667d558f152656c2baaf08f3d0c8b02343"
ARG RUBYGEMS_VERSION="3.1.2"
RUN bash ${INSTALLERS_DIR}/ruby.sh

# Install Heroku CLI
COPY installers/heroku.sh ${INSTALLERS_DIR}
RUN bash ${INSTALLERS_DIR}/heroku.sh

# Install hub CLI
COPY installers/hub.sh ${INSTALLERS_DIR}
ARG HUB_VERSION=2.14.2
RUN bash ${INSTALLERS_DIR}/hub.sh

# Install Obiwan
COPY installers/obiwan.sh ${INSTALLERS_DIR}
COPY .tern-config /etc/obiwan/.tern-config
ARG OBIWAN_VERSION=0.6.0
RUN bash ${INSTALLERS_DIR}/obiwan.sh

# Add needed configuration files
COPY pylintrc /etc/pylintrc

COPY bash.* /etc/
RUN cat /etc/bash.bashrc.append >> /etc/bash.bashrc && rm /etc/bash.bashrc.append

# Add custom binaries
COPY bin/ /usr/local/bin/

# Add profile.d files
COPY .profile.d/* /app/.profile.d/

# Add helpers
COPY helpers /usr/src/helpers


ENTRYPOINT ["entrypoint.sh"]
CMD ["/bin/bash"]
