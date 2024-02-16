#!/bin/bash


if [[ $setup_user == "y" ]]; then
    read -p "Enter the username to create (default: ubuntu): " username
    username=${username:-ubuntu}

    echo -e "\n"
    
    # Check if user already exists
    if id "$username" &>/dev/null; then
        echo "User '$username' already exists."
    else
        echo "Creating user '$username'..."
        # Add user
        sudo adduser "$username"
        echo "User '$username' created."
        
        echo -e "\n"
        echo "Adding user to the sudo group..."
        # Add user to the sudo group
        sudo usermod -aG sudo "$username"
        echo -e "User '$username' added to the sudo group.\n"

        # Now we will copy the public key to the new user's home directory using rsync
        rsync --archive --chown="$username":"$username" ~/.ssh /home/"$username"
    fi
fi