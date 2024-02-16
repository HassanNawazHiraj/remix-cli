read -p "Do you want to setup LEMP (Linux Nginx Mysql PHP) stack? (Y/n): " setup_lemp
setup_lemp=${setup_lemp:-y}

if [ "$setup_lemp" = "y" ]; then
    DIR="$(dirname "$0")"
    
    # Install Nginx
    bash "${DIR}/install-nginx.sh"
    
    # Install MySQL
    bash "${DIR}/install-mysql.sh"
    
    # Install PHP
    bash "${DIR}/install-php.sh"
    
    # install composer
    bash "${DIR}/install-composer.sh"
    
    echo "LEMP stack setup complete. Recommended to reboot the server."
fi