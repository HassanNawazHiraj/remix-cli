#!/bin/bash

# Update and upgrade packages
sudo apt update && sudo apt upgrade -y

# Add user 'ubuntu'
sudo adduser ubuntu

# Add user 'ubuntu' to the sudo group
sudo usermod -aG sudo ubuntu

# Install ufw if not already installed
sudo apt install ufw -y

# Allow OpenSSH
sudo ufw allow OpenSSH

# Enable ufw
sudo ufw enable

# Copy SSH keys
read -p "Specify the path to the SSH key file you want to copy: " ssh_key_file
if [ -f "$ssh_key_file" ]; then
    mkdir -p ~/.ssh
    cat "$ssh_key_file" | sed 's/$/\n/' >> ~/.ssh/authorized_keys
    echo "SSH key content copied and appended to authorized_keys successfully."
else
    echo "Specified SSH key file does not exist or is invalid."
fi