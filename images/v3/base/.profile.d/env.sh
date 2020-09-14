# Export .env variables
if [ -f /mnt/project/.env ]; then
    while read -r line; do
        if [[ $line == *"="* ]]; then
            export ${line%%=*}="${line##*=}"
        fi
    done < /mnt/project/.env
fi
