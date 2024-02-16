#!/bin/bash

if ! pgrep -x "ssh-agent" > /dev/null; then
    eval "$(ssh-agent -s)"
fi

# add all the keys to the agent
for key in ~/.ssh/*; do
    chmod 600 $key > /dev/null
    ssh-add $key > /dev/null
done

echo "SSH agent started and all keys added."