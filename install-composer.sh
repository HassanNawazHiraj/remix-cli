#!/bin/bash

source functions.sh

# Check if the /etc/php directory exists and is not empty
if [ ! -d "/etc/php" ] || [ -z "$(ls -A /etc/php)" ]; then
    echo "The /etc/php directory doesn't exist or is empty. Please install PHP before running this script."
    exit 1
fi

# ask user to enter php version to use
read -p "Do you want to change the PHP version? (y/N): " change_version
changeVersion=${change_version:-n}

if [ "$change_version" == "y" ]; then
    # Add code here to handle changing PHP version
    php_version=$(select_php_version)
    update_cli_php_version $php_version
else
    #print the PHP version
    echo "Current PHP version is: "
    php -v
fi


sudo apt update -y

sudo apt install unzip -y

cd ~

curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php

HASH=`curl -sS https://composer.github.io/installer.sig`

php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"

sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer