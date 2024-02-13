#!/bin/bash

# Ask the user for the key name
read -p "Enter the name of the key: " key_name

# Ask the user for the key type
read -p "Enter the type of the key (rsa, ed25519) [ed25519]: " key_type
key_type=${key_type:-ed25519}

# Generate the SSH key if it doesn't exist
if [ ! -f ~/.ssh/$key_name ]; then
    ssh-keygen -t $key_type -f ~/.ssh/$key_name
fi

# Print the public key
cat ~/.ssh/$key_name.pub