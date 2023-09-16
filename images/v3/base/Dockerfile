ARG UBUNTU_VERSION=jammy
FROM buildpack-deps:${UBUNTU_VERSION}

ARG UBUNTU_VERSION=jammy
ENV DEBIAN_FRONTEND noninteractive

# Install base line packages
RUN apt-get update
RUN apt-get install -y locales gnupg software-properties-common apt-transport-https zsh

# Set up needed local and environment
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV SL_ENV 1
ENV MAX_CONCURRENCY 1
ENV PYTHONUNBUFFERED 1

# remove several traces of system python
RUN apt-get purge -y python.*

# Install tools needed in all images
RUN apt-get install -y bash-completion vim tmux zip unzip man rsync

