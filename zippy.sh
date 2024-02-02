#!/bin/bash

CYAN='\033[0;36m'
NC='\033[0m'
ZIP_ARGS=""

function ask() {
    read -p "$1 (Y/n): " response
    [ -z "$response" ] || [ "$response" = "y" ] || [ "$response" = "Y" ]
}

if [ "$1" = "-u" ]; then
    if [ -z "$2" ]; then
        echo -e "${CYAN}TargetError:${NC} Missing required target(s)"
        exit 1
    fi
    unzip -q $2
fi

for file in "$(pwd)"/*; do
    if [ $1 ]; then
        echo "There is an option"
        if [ $1 = "-a" ]; then
            ZIP_ARGS+="$(basename $file) "
        fi
    else
        if (! file $file | grep -q zip); then
            if ! grep -q "zippy.sh" "$file" && ask "Include $(basename $file)?"; then
                ZIP_ARGS+="$(basename $file) "
            fi
        fi
    fi
done

if [ -z "$ZIP_ARGS" ]; then
    echo -e "${CYAN}TargetError:${NC} Missing required target(s)"
    exit 1
fi

pv $ZIP_ARGS | zip -q "$(date +"%Y-%m-%d %H:%M:%S")" $ZIP_ARGS
