#!/bin/bash

# Ask user for the name of the key
read -p "Enter the name of the key to remove: " key_name

# Remove the key from authorized_keys file
sed -i "/$key_name/d" ~/.ssh/authorized_keys

echo "Key '$key_name' has been removed from authorized_keys file."
