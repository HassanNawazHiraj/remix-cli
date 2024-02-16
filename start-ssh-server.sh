#!/bin/bash

if ! pgrep -q ssh-agent; then
    eval "$(ssh-agent -s)"
fi

# add all the keys to the agent
for key in ~/.ssh/*; do
    ssh-add $key > /dev/null
done