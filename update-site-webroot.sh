#!/bin/bash

# get path to current directory
project_name=$(basename "$(pwd)")

# see if a nginx config exist with the same name as the project
if [ ! -f /etc/nginx/sites-available/$project_name ]; then
    echo "Not in project folder"
    # ask user to enter site name
    read -p "Enter the nginx site name. " site_name
fi

# enter new webroot path
read -p "Enter the new webroot path (/public): " webroot_path
webroot_path=${webroot_path:-/public}

# verify to user the changes that will be made
echo -e "The webroot path will be changed to /var/www/$site_name$webroot_path \n"

#confim from user
read -p "Do you want to continue? (Y/n): " continue_script
continue_script=${continue_script:-y}

if [ "$continue_script" != "Y" ]; then
    echo "Exiting..."
    exit 1
fi

# replace the webroot path in the nginx config
sed -i "s#root /var/www/$project_name;#root /var/www/$site_name$webroot_path;#" /etc/nginx/sites-available/$project_name