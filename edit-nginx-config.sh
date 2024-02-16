#!/bin/bash

# get path to current directory
project_name=$(basename "$(pwd)")

# see if a nginx config exist with the same name as the project
if [ ! -f /etc/nginx/sites-available/$project_name ]; then
    echo "Not in project folder"
    # ask user to enter site name
    read -p "Enter the nginx site name. " site_name
    else
    site_name=$project_name
fi


nano /etc/nginx/sites-available/$site_name