#!/bin/bash

echo "Starting setup..."

# Update and upgrade packages
sudo apt update && sudo apt upgrade -y

# Ask user for the username to create
read -p "Do you want to set up a user? (y/n): " setup_user

if [[ $setup_user == "y" ]]; then
    read -p "Enter the username to create (default: ubuntu): " username
    username=${username:-ubuntu}

    # Check if user already exists
    if id "$username" &>/dev/null; then
        echo "User '$username' already exists."
    else
        # Add user
        sudo adduser "$username"
        
        # Add user to the sudo group
        sudo usermod -aG sudo "$username"
    fi
fi

# Install ufw if not already installed
sudo apt install ufw -y

# Allow OpenSSH
sudo ufw allow OpenSSH

# Enable ufw
sudo ufw enable

# Ask user if they want to add a public SSH key
./add-ssh-key.sh

# ask user if they want to do LEMP setup
./install-lemp.sh

echo "Setup complete."

# show user's ip address
echo "Your public IP address is: $(curl -s http://ipv4.icanhazip.com)"
