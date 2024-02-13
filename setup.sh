#!/bin/bash

echo "Starting setup..."

# Update and upgrade packages
sudo apt update && sudo apt upgrade -y

# Ask user for the username to create
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

# Install ufw if not already installed
sudo apt install ufw -y

# Allow OpenSSH
sudo ufw allow OpenSSH

# Enable ufw
sudo ufw enable

# Ask user if they want to add a public SSH key
read -p "Do you want to add a public SSH key? (y/n): " add_ssh_key

if [ "$add_ssh_key" = "y" ]; then
    add_another_key="y"

    while [ "$add_another_key" = "y" ]; do
        # Ask user to paste the public SSH key
        echo "Paste the public SSH key below (press ctrl + d when done):"
        ssh_key_content=$(cat)

        # Print the SSH key to verify
        echo "The following SSH key will be added:"
        echo "$ssh_key_content"

        # Ask user to confirm or re-enter the SSH key
        read -p "Do you want to proceed with adding this SSH key? (y/n/skip): " confirm_ssh_key

        if [ "$confirm_ssh_key" = "y" ]; then
            # Add SSH key to authorized_keys
            mkdir -p ~/.ssh
            echo "$ssh_key_content" >> ~/.ssh/authorized_keys
            echo "SSH key added to authorized_keys successfully."
        elif [ "$confirm_ssh_key" = "n" ]; then
            # Ask user to re-enter the SSH key
            echo "Please re-enter the SSH key:"
            ssh_key_content=$(cat)
            echo "The following SSH key will be added:"
            echo "$ssh_key_content"
            read -p "Do you want to proceed with adding this SSH key? (y/n/skip): " confirm_ssh_key

            if [ "$confirm_ssh_key" = "y" ]; then
                # Add SSH key to authorized_keys
                echo "$ssh_key_content" >> ~/.ssh/authorized_keys
                echo "SSH key added to authorized_keys successfully."
            else
                echo "Skipping adding SSH key."
            fi
        else
            echo "Skipping adding SSH key."
        fi

        # Ask user if they want to add another key
        read -p "Do you want to add another SSH key? (y/n): " add_another_key
    done
fi

# all done
echo "All done!"