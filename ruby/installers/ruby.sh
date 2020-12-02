# some of ruby's build scripts are written in ruby
# we purge this later to make sure our final image uses what we just built
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
./configure --disable-install-doc
make -j"$(nproc)"
make install
apt-get purge -y --auto-remove $buildDeps
gem update --system $RUBYGEMS_VERSION
rm -r /usr/src/ruby
cd /

BUNDLER_VERSION=2.0.2
gem install bundler --force --version $BUNDLER_VERSION
