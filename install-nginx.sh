# Install Nginx
sudo apt install nginx -y

# ask user if they want to enable just http firewall rule or both http and https
read -p "Do you want to enable just http firewall rule or both http and https? (http/https): " http_or_https
if [ "$http_or_https" = "http" ]; then
    # Allow Nginx HTTP
    sudo ufw allow 'Nginx HTTP'
    elif [ "$http_or_https" = "https" ]; then
    # Allow Nginx HTTP and HTTPS
    sudo ufw allow 'Nginx Full'
fi