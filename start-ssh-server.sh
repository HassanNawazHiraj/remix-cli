#!/bin/bash

if ! pgrep -x "ssh-agent" > /dev/null; then
    eval "$(ssh-agent -s)"
fi

# add all the keys to the agent
for key in ~/.ssh/*; do
    if [[ $key != *"authorized_keys"* ]] && [[ $key != *".pub"* ]] && [[ $key != *"known_hosts"* ]]; then
        chmod 600 $key > /dev/null 2>&1
        ssh-add $key > /dev/null 2>&1
    fi
done

echo "SSH agent started and all keys added."