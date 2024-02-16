#!/bin/bash
DIR="$(dirname "$0")"
# list all the files in the directory except functions.sh
echo -e "\nAvailable commands:"
ls -A "${DIR}" | grep -v "functions.sh" | grep -oP '.*(?=\.sh)'
