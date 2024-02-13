read -p "Do you want to setup LEMP (Linux Nginx Mysql PHP) stack? (y/n): " setup_lemp

if [ "$setup_lemp" = "y" ]; then
    # Install Nginx
    ./install-nginx.sh
    
    # Install MySQL
    ./install-mysql.sh
    
    # Install PHP
    ./install-php.sh
    
    echo "LEMP stack setup complete. Recommended to reboot the server."
fi