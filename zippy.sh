#!/bin/bash

CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'
ZIP_ARGS=""

function ask() {
    read -r -p "$1 (Y/n): " response
    [ -z "$response" ] || [ "$response" = "y" ] || [ "$response" = "Y" ]
}

if [ "$1" = "-h" ]; then
    clear
    echo -e "${CYAN}NAME${NC}"
    echo -e "${YELLOW}Zippy - Zip, encrypt and unzip directories${NC}"
    echo -e "${CYAN}SYNOPSIS${NC}"
    echo -e "${YELLOW}bash ./zippy.sh [OPTION]${NC}"
    echo -e "${CYAN}DESCRIPTION${NC}"
    echo -e "${YELLOW}Zippy is a shell script to zip, encrypt and unzip directories${NC}"
    echo -e "${CYAN}OPTIONS${NC}"
    echo -e "${YELLOW}-a: Zips all files/directories in PWD${NC}"
    echo -e "${YELLOW}-e: Zips & encrypts files/directories in PWD${NC}"
    echo -e "${YELLOW}-h: Prints help message${NC}"
    echo -e "${YELLOW}-u [target]: Unzips zipped directory${NC}"
    exit 1
fi

if [ "$1" = "-u" ]; then
    if [ -z "$2" ]; then
        echo -e "${CYAN}TargetError:${NC} Missing required target(s)"
        exit 1
    fi
    unzip -q "$2"
fi

for file in "$(pwd)"/*; do
    if [ "$1" = "-a" ]; then
        ZIP_ARGS+="$(basename "$file") "
    else
        if ! file "$file" | grep -q zip && [ "$file" != "$(pwd)/zippy.sh" ] && ask "Include $(basename "$file")?"; then
            ZIP_ARGS+="$(basename "$file") "
        fi
    fi
done

if [ -z "$ZIP_ARGS" ]; then
    echo -e "${CYAN}TargetError:${NC} Missing required target(s)"
    exit 1
fi

if [ "$1" ]; then
    if [ "$1" = "-e" ]; then
        pv $ZIP_ARGS | zip -e "$(date +"%Y-%m-%d %H:%M:%S")" $ZIP_ARGS
        echo -e "${GREEN}${ZIP_ARGS} has been successfully zipped and encrypted!${NC}"
    fi
else
    pv "$ZIP_ARGS" | zip "$(date +"%Y-%m-%d %H:%M:%S")" $ZIP_ARGS
    echo -e "${GREEN}${ZIP_ARGS} has been successfully zipped and encrypted!${NC}"
fi
