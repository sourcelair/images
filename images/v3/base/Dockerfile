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
