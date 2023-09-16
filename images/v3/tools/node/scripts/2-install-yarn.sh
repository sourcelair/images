set -ex

# Install Yarn based on
# https://github.com/nodejs/docker-node/blob/849a3e6b4ca2fc18fd80ee7ffcf1684cca48c96a/20/bookworm/Dockerfile#L47-L66

gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys "${YARN_GPG_KEY}" ||
gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "${YARN_GPG_KEY}";

curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz"
curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz.asc"
gpg --batch --verify yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz

tar -xzf yarn-v$YARN_VERSION.tar.gz -C ${TOOL_PREFIX} --strip-components=1

rm yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz
