#!/bin/bash

# Ask the user for the key name
read -p "Enter the name of the key: " key_name

# Ask the user for the key type
read -p "Enter the type of the key (rsa, ed25519) [ed25519]: " key_type
key_type=${key_type:-ed25519}

# Generate the SSH key if it doesn't exist
if [ ! -f ~/.ssh/$key_name ]; then
    ssh-keygen -t $key_type -f ~/.ssh/$key_name
else
    echo "The key $key_name already exists."
fi

# Print the public key
echo -e "\n\n Public key for $key_name:"
cat ~/.ssh/$key_name.pub