    # Install MySQL
    sudo apt install mysql-server -y

    echo -e "\n\n\nPlease answer the following questions to secure your mysql installation: \n\n\n"
    
    # Secure MySQL
    sudo mysql_secure_installation

    echo -e "\n\n\nMySQL installed and secured."