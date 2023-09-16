set -ex

export GNUPGHOME="$(mktemp -d)";

for key in $NODE_GPG_KEYS; do
    gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys "$key" || \
    gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$key"
done

export NPM_CONFIG_LOGLEVEL=info
[ -d /usr/local/lib/node_modules/ ] && rm -rf /usr/local/lib/node_modules/
curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz"
curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc"

gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc
pkill -9 gpg-agent
pkill -9 dirmngr

grep " node-v$NODE_VERSION-linux-x64.tar.xz\$" SHASUMS256.txt | sha256sum -c -
tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C ${TOOL_PREFIX} --strip-components=1
rm "node-v$NODE_VERSION-linux-x64.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt

rm -r "$GNUPGHOME"
