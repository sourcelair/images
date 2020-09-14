export GEM_HOME=/mnt/data/.ruby-${RUBY_VERSION%.*}
export BUNDLE_PATH="$GEM_HOME"
export BUNDLE_BIN="$GEM_HOME/bin"
export BUNDLE_APP_CONFIG="$GEM_HOME"
export PATH=$BUNDLE_BIN:$PATH
for dir in "$GEM_HOME" "$BUNDLE_BIN"; do
    if [ ! -d "$dir" ]; then
        mkdir -p $dir
        chmod 777 $dir
    fi
done
