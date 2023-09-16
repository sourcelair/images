FROM base

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

COPY --from=tools_git /usr/local/share/tool/bin/ /usr/local/bin/
COPY --from=tools_git /usr/local/share/tool/libexec/ /usr/local/libexec/
COPY --from=tools_git /usr/local/share/tool/share/doc/git/ /usr/local/share/doc/git/
COPY --from=tools_git /usr/local/share/tool/share/git-core/ /usr/local/share/git-core/
COPY --from=tools_git /usr/local/share/tool/share/git-gui/ /usr/local/share/git-gui/
COPY --from=tools_git /usr/local/share/tool/share/gitk/ /usr/local/share/gitk/
COPY --from=tools_git /usr/local/share/tool/share/gitweb/ /usr/local/share/gitweb/
COPY --from=tools_git /usr/local/share/tool/share/info/ /usr/local/share/info/
COPY --from=tools_git /usr/local/share/tool/share/locale/ /usr/local/share/locale/
COPY --from=tools_git /usr/local/share/tool/share/man/man1/ /usr/local/share/man/man1/
COPY --from=tools_git /usr/local/share/tool/share/man/man3/ /usr/local/share/man/man3/
COPY --from=tools_git /usr/local/share/tool/share/man/man5/ /usr/local/share/man/man5/
COPY --from=tools_git /usr/local/share/tool/share/man/man7/ /usr/local/share/man/man7/
COPY --from=tools_git /usr/local/share/tool/share/perl5/ /usr/local/share/perl5/

COPY --from=tools_python /usr/local/share/tool/bin/ /usr/local/bin/
COPY --from=tools_python /usr/local/share/tool/include/ /usr/local/include/
COPY --from=tools_python /usr/local/share/tool/lib/ /usr/lib/
COPY --from=tools_python /usr/local/share/tool/share/man/man1/ /usr/local/share/man/man1/

COPY --from=tools_ruby /usr/local/share/tool/bin/ /usr/local/bin/
COPY --from=tools_ruby /usr/local/share/tool/include/ /usr/local/include/
COPY --from=tools_ruby /usr/local/share/tool/lib/ /usr/lib/
COPY --from=tools_ruby /usr/local/share/tool/share/man/man1/ /usr/local/share/man/man1/

COPY --from=tools_node /usr/local/share/tool/bin/ /usr/local/bin/
COPY --from=tools_node /usr/local/share/tool/include/ /usr/local/include/
COPY --from=tools_node /usr/local/share/tool/lib/ /usr/local/lib/
COPY --from=tools_node /usr/local/share/tool/share/man/man1/ /usr/local/share/man/man1/

COPY --from=tools_psql /usr/local/share/tool/bin/ /usr/local/bin/
COPY --from=tools_psql /usr/local/share/tool/include/ /usr/local/include/
COPY --from=tools_psql /usr/local/share/tool/lib/ /usr/lib/
COPY --from=tools_psql /usr/local/share/tool/share/doc/ /usr/local/share/doc/
COPY --from=tools_psql /usr/local/share/tool/share/man/man1/ /usr/local/share/man/man1/
COPY --from=tools_psql /usr/local/share/tool/share/man/man3/ /usr/local/share/man/man3/
COPY --from=tools_psql /usr/local/share/tool/share/man/man7/ /usr/local/share/man/man7/
COPY --from=tools_psql /usr/local/share/tool/share/postgresql/ /usr/local/share/postgresql/

COPY --from=tools_mysqlsh /usr/local/share/tool/bin/ /usr/local/bin/
COPY --from=tools_mysqlsh /usr/local/share/tool/lib/ /usr/local/lib
COPY --from=tools_mysqlsh /usr/local/share/tool/libexec/ /usr/local/libexec
COPY --from=tools_mysqlsh /usr/local/share/tool/share/ /usr/local/share

COPY --from=tools_gh /usr/local/share/tool/bin/ /usr/local/bin/
COPY --from=tools_gh /usr/local/share/tool/share/man/man1/ /usr/local/share/man/man1/

COPY --from=tools_goreman /usr/local/share/tool/bin/ /usr/local/bin/
COPY --from=tools_mongosh /usr/local/share/tool/bin/ /usr/local/bin/
COPY --from=tools_redis_cli /usr/local/share/tool/bin/ /usr/local/bin/

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

ARG ROOT_DIR=/mnt
ARG PROJECT_DIR=${ROOT_DIR}/project
ARG DATA_DIR=${ROOT_DIR}/data
ARG USER_HOME_DIR=${ROOT_DIR}/user
ARG OS_USER=www-data
ARG OS_GROUP=www-data

RUN mkdir -p ${PROJECT_DIR} ${DATA_DIR} ${USER_HOME_DIR} && \
    chown -R ${OS_USER}:${OS_GROUP} ${PROJECT_DIR} ${DATA_DIR} ${USER_HOME_DIR}

# Set up OS user defaults
ARG DEFAULT_SHELL=/usr/bin/zsh
RUN chsh -s ${DEFAULT_SHELL} ${OS_USER} && \
    usermod --home ${USER_HOME_DIR} ${OS_USER}
ENV HOME /mnt/user
ENV HISTFILE /mnt/data/.zsh_history

ENTRYPOINT ["entrypoint.sh"]
WORKDIR /mnt/project
CMD ["/usr/bin/zsh"]