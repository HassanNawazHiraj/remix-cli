#!/bin/bash

# Check if the /etc/php directory exists and is not empty
if [ ! -d "/etc/php" ] || [ -z "$(ls -A /etc/php)" ]; then
    echo "The /etc/php directory doesn't exist or is empty. Please install PHP before running this script."
    exit 1
fi

# check if mysql is installed
if ! [ -x "$(command -v mysql)" ]; then
    echo "MySQL is not installed. Please install MySQL before running this script."
    exit 1
fi

# ask user if they want to generate ssh key
echo -e "Currently we only support deploying laravel using git. \n"
echo -e "Please make sure you have a git repository created and the ssh key added to your git account. \n"
echo -e "You can generate new key for each git respository and add it to deploy keys of that git \n"
read -p "Do you want to generate an SSH key now? (Y/n): " generate_ssh
generate_ssh=${generate_ssh:-y}

if [ "$generate_ssh" = "y" ]; then
    # generate ssh key
    ./generate-ssh-key.sh
fi

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

echo -e "\n\n Please follow the following prompts to create a php website. Then we will continue with laravel setup.\n"

./setup-php-site.sh

echo -e "\n\n Now continuing with laravel setup.\n"

# clone the repository into /var/www/$site_name
cd /var/www
sudo git clone $git_repo $site_name
