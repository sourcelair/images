#! /bin/bash

# Export variables based on SL_USERNAME. This helps use the currnet user's
# username in commands, instead of `www-data`.
export LOGNAME=${SL_USERNAME:-user}
export USER=$LOGNAME
export LNAME=$LOGNAME
export USERNAME=$LOGNAME

# Export .env variables
for SCRIPT in /app/.profile.d/*; do
    source $SCRIPT;
done

cmd=""

# If is server and Procfile exists, run Procfile instead
export SL_FALLBACK_PROCFILE=/usr/src/helpers/webserver/Procfile

if [ "$SL_SERVER" = '1' ]; then
    echo "Starting your Web Server..."
    echo "When it's ready, it will be accessible at:"
    echo "  - HTTPS: ${SL_PUBLIC_URL_HTTPS}"
    echo "  - HTTP: ${SL_PUBLIC_URL_HTTP}"

    for procfile in $SL_PROCFILE Procfile.dev Procfile $SL_FALLBACK_PROCFILE; do
        if [[ "$procfile" = "/*" ]]  # If $procfile starts with slash
        then
            procfile_path=$procfile
        else
            procfile_path=/mnt/project/$procfile
        fi

        if [ -f $procfile_path ]; then
            procfile_real_path=$(realpath $procfile_path)
            echo "Procfile: $procfile_real_path"
            cmd="goreman -f $procfile_real_path start"
            break
        fi
    done
fi

if [ -z "$cmd" ]; then
    "$@"
else
    $cmd
fi

exit $?
