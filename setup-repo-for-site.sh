#!/bin/bash
DIR="$(dirname "$0")"

echo -e "WARNING: This script will clone a git repository into /var/www/site_name. user will be prompted for site_name \n"
echo -e "If this directory is not empty, then its content will be lost. \n"

# ask user if they want to continue
read -p "Do you want to continue? (Y/n): " continue_script
continue_script=${continue_script:-y}

# ask user if they want to generate ssh key
# echo -e "Please make sure you have a git repository created and the ssh key added to your git account. \n"
# echo -e "You can generate new key for each git respository and add it to deploy keys of that git \n"
# read -p "Do you want to generate an SSH key now? (Y/n): " generate_ssh
# generate_ssh=${generate_ssh:-y}

# if [ "$generate_ssh" = "y" ]; then
#     # generate ssh key
#     ${DIR}/generate-ssh-key.sh
# fi

echo -e "\n\nEnter the git repository URL. \nThis will be used to clone the repository to the server.\n"

while true; do
    read -p "Enter the git repository URL: " git_repo
    echo "You entered: $git_repo"
    read -p "Is this correct? (Y/n): " verify_url
    verify_url=${verify_url:-y}
    if [ "$verify_url" = "y" ]; then
        break
    fi
done

# Ask user for the site name
read -p "Enter the site name from /var/www/site_name (e.g., example.com): " site_name

# clear /var/www/site_name folder
sudo rm -rf /var/www/$site_name

# clone the repository into /var/www/$site_name
sudo git clone $git_repo /var/www/$site_name
