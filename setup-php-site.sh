#!/bin/bash

# ask user to enter php version to use
echo "Following are php versions installed on your server:"
ls /etc/php | grep -E '^[0-9]'
read -p "Enter the PHP version you want to install (e.g., 8.1): " php_version

# Ask the user for the site name
read -p "Enter the site name (/var/www/site_name) i.e, 'test.byteremix.com' : " site_name

# Ask the user for the server name
read -p "Enter the server name (domains separated by space) i.e, 'byteremix.com www.byteremix.com': " server_name

# Ask the user if they want to enable SSL
read -p "Do you want to enable SSL (listen to 443 port)? (y/n): " enable_ssl

# If the user wants to enable SSL, remove the comment from the SSL configuration lines
if [ "$enable_ssl" = "y" ]; then
    ssl_comment=""
else
    ssl_comment="#"
fi

# remove default nginx site
sudo rm /etc/nginx/sites-available/default

# Replace the placeholders with the actual values
sed "s/{{SITE_NAME}}/$site_name/g; s/{{SERVER_NAME}}/$server_name/g; s/{{PHP_VERSION}}/$php_version/g; s/{{SSL_COMMENT}}/$ssl_comment/g" ./templates/nginx_new_php_site > $site_name

# Move the generated file to the sites-available directory
sudo mv $site_name /etc/nginx/sites-available/

# Enable the site
sudo ln -s /etc/nginx/sites-available/$site_name /etc/nginx/sites-enabled/

# Restart Nginx
sudo systemctl restart nginx

# add a placeholder php file to the site
sudo cp ./templates/new_php_site.php /var/www/$site_name/index.php

echo "Nginx site for $site_name has been created and enabled."