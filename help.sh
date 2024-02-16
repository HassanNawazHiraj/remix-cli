#!/bin/bash
DIR="$(dirname "$0")"
# list all the files in the directory except functions.sh
echo -e "\nAvailable commands:\n"
ls -A | grep -v "${DIR}functions.sh" | grep -oP '.*(?=\.sh)'
