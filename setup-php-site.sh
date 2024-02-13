#!/bin/bash
# Check if the /etc/php directory exists and is not empty
if [ ! -d "/etc/php" ] || [ -z "$(ls -A /etc/php)" ]; then
    echo "The /etc/php directory doesn't exist or is empty. Please install PHP before running this script."
    exit 1
fi

# ask user to enter php version to use
echo "Following are php versions installed on your server:"
ls /etc/php | grep -E '^[0-9]'
echo -e "\n"
php_version=$(ls /etc/php | grep -E '^[0-9]' | head -1)
read -p "Enter the PHP version you want to use (leave empty to use $php_version): " php_version

# If php_version is empty, set it to the first directory in /etc/php
if [ -z "$php_version" ]; then
    php_version=$(ls /etc/php | grep -E '^[0-9]' | head -1)
fi

# Ask the user for the site name
echo -e "\n\nEnter the nginx site name. \nThis will create folder in /var/www/site_name. \nBest practice to keep it same as domain\n"
read -p "Enter site name: " site_name

# Ask the user for the server name
echo -e "\n\nEnter the nginx server name. \nThis will be the domain name(s) that will point to this site. \nYou can enter multiple domains separated by space. \nBest practice to keep it same as site name\n"
read -p "Enter server name (leave empty to use site name '$site_name'): " server_name

# If server_name is empty, set it to the same value as site_name
if [ -z "$server_name" ]; then
    server_name="$site_name"
fi

# Ask the user if they want to enable SSL
echo -e "\n"
read -p "Do you want to enable SSL (listen to 443 port)? (Y/n): " enable_ssl
enable_ssl=${enable_ssl:-y}

# remove default nginx site
if [ -f /etc/nginx/sites-available/default ]; then
    sudo rm /etc/nginx/sites-available/default
fi

if [ -f /etc/nginx/sites-enabled/default ]; then
    sudo rm /etc/nginx/sites-enabled/default
fi

# Replace the placeholders with the actual values
sed "s/{{SITE_NAME}}/$site_name/g; s/{{SERVER_NAME}}/$server_name/g; s/{{PHP_VERSION}}/$php_version/g" ./templates/nginx_new_php_site > $site_name

# Move the generated file to the sites-available directory
sudo mv $site_name /etc/nginx/sites-available/

# Enable the site
if [ ! -e /etc/nginx/sites-enabled/$site_name ]; then
    sudo ln -s /etc/nginx/sites-available/$site_name /etc/nginx/sites-enabled/
fi

# If the user wants to enable SSL, we will issue a cert using certbot
if [ "$enable_ssl" = "y" ]; then
    # Install Certbot
    sudo apt-get install certbot -y

    # Obtain SSL certificate
    sudo certbot certonly --nginx -d $server_name

    # Configure SSL in Nginx site configuration
    # sudo sed -i "s/#ssl_certificate/ssl_certificate/g" /etc/nginx/sites-available/$site_name
    # sudo sed -i "s/#ssl_certificate_key/ssl_certificate_key/g" /etc/nginx/sites-available/$site_name

fi

# Restart Nginx
sudo systemctl restart nginx

# add a placeholder php file to the site
if [ ! -d "/var/www/$site_name" ]; then
    sudo mkdir -p "/var/www/$site_name"
fi
sudo cp ./templates/new_php_site.php /var/www/$site_name/index.php

echo -e "\n\nNginx site for $site_name has been created and enabled."
first_domain=$(echo "$server_name" | cut -d' ' -f1)
if [ "$enable_ssl" = "y" ]; then
    echo "You can access it at https://$first_domain"
else
    echo "You can access it at http://$first_domain"
fi
