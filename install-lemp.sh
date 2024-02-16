read -p "Do you want to setup LEMP (Linux Nginx Mysql PHP) stack? (Y/n): " setup_lemp
setup_lemp=${setup_lemp:-y}

if [ "$setup_lemp" = "y" ]; then
    # Install Nginx
    ./install-nginx.sh
    
    # Install MySQL
    ./install-mysql.sh
    
    # Install PHP
    ./install-php.sh

    # install composer
    ./install-composer.sh
    
    echo "LEMP stack setup complete. Recommended to reboot the server."
fi