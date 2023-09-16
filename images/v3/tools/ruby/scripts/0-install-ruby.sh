set -ex

buildDeps='bison libgdbm-dev ruby'
apt-get update
apt-get install -y --no-install-recommends $buildDeps

RUBY_MAJOR=${RUBY_VERSION%.*}
wget -O ruby.tar.xz "https://cache.ruby-lang.org/pub/ruby/${RUBY_MAJOR%-rc}/ruby-$RUBY_VERSION.tar.xz"
echo "$RUBY_DOWNLOAD_SHA256 *ruby.tar.xz" | sha256sum --check --strict
mkdir -p /usr/src/ruby
tar -xJf ruby.tar.xz -C /usr/src/ruby --strip-components=1
rm ruby.tar.xz
cd /usr/src/ruby
{ echo '#define ENABLE_PATH_CHECK 0'; echo; cat file.c; } > file.c.new && mv file.c.new file.c
autoconf
./configure --disable-install-doc --prefix=${TOOL_PREFIX}
make -j"$(nproc)"
make install
rm -r /usr/src/ruby
