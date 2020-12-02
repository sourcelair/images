set -ex \

bash ${INSTALLERS_DIR}/node-engine.sh

# Update npm to the latest version
npm install -g npm@7.0.14

# Install Yarn
# Based on https://github.com/nodejs/docker-node/blob/6b8d86d6ad59e0d1e7a94cec2e909cad137a028f/8/Dockerfile#L25
export YARN_VERSION=1.22.10

gpg --keyserver ipv4.pool.sks-keyservers.net --recv-keys "6A010C5166006599AA17F08146C2130DFD2497F5"

curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" \
&& curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz.asc" \
&& gpg --batch --verify yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz \
&& mkdir -p /opt/yarn \
&& tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/yarn --strip-components=1 \
&& rm -f /usr/local/bin/yarn /usr/local/bin/yarnpkg \
&& ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn \
&& ln -s /opt/yarn/bin/yarn /usr/local/bin/yarnpkg \
&& rm yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz
